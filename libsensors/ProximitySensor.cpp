/*
 * Copyright (C) 2008 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <fcntl.h>
#include <errno.h>
#include <math.h>
#include <poll.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/select.h>

#include <cutils/log.h>

#include "ProximitySensor.h"
#define PROXIMITY_ENABLE "/sys/devices/platform/proximity-sensor/semc/proximity-sensor/enable"
#define PROXIMITY_SENSOR "/sys/devices/platform/proximity-sensor/semc/proximity-sensor/sensor"

/*****************************************************************************/
char input_sysfs_path[1024];
char input_name[1024];
int input_sysfs_path_len;
int thread_running=0;
pthread_mutex_t data_mutex = PTHREAD_MUTEX_INITIALIZER;

ProximitySensor::ProximitySensor()
	: SensorBase(NULL, "proximity"),
	  mEnabled(0),
	  mInputReader(4),
	  mHasPendingEvent(false)
{
	mPendingEvent.version = sizeof(sensors_event_t);
	mPendingEvent.sensor = ID_P;
	mPendingEvent.type = SENSOR_TYPE_PROXIMITY;
	memset(mPendingEvent.data, 0, sizeof(mPendingEvent.data));
	if (data_fd) {
		strcpy(input_sysfs_path, "/sys/devices/platform/proximity-sensor/semc/proximity-sensor/");
		input_sysfs_path_len = strlen(input_sysfs_path);
		enable(0, 1);
	}
}

ProximitySensor::~ProximitySensor() {
	if (mEnabled) {
		enable(0, 0);
	}
}

int ProximitySensor::setInitialState() {
	struct input_absinfo absinfo;
	if (!ioctl(data_fd, EVIOCGABS(EVENT_TYPE_PROXIMITY), &absinfo)) {
		// make sure to report an event immediately
		mHasPendingEvent = true;
		mPendingEvent.distance = indexToValue(absinfo.value);
	}
	return 0;
}

int ProximitySensor::enable(int32_t, int en) {
	//LOGE("ProximitySensor::enable with %d", en);
	int flags = en ? 1 : 0;
	if (flags != mEnabled) {
	FILE * fd;
	strcpy(&input_sysfs_path[input_sysfs_path_len], "enable");
	fd = fopen(input_sysfs_path, "w");
	if (fd >= 0) {
		char buf[2];
		buf[1] = 0;
		if (flags) {
			buf[0] = '1';
		} else {
			buf[0] = '0';
		}
		int ret = fputs(buf, fd);
		//LOGE("ProximitySensor wrote %s to %s, status:%d", buf, input_sysfs_path, ret);
		fclose(fd);
		mEnabled = flags;
		//setInitialState();
		if (en == 1 && thread_running == 0) {
			int rc = pthread_create(&poll_thread, NULL, polling_thread_func, (void *)this);
			if (rc){
				LOGE("ERROR return code from pthread_create() is %d\n", rc);
			}
			else{
				//LOGE("ProximitySensor created new thread");
			}
		}
		return 0;
	}
	LOGE("ProximitySensor couldn't open %s", input_sysfs_path);
	return -1;
	}
	return 0;
}

void * polling_thread_func(void *PS)
{
	thread_running = 1;
	char buf, buf2, prev_value='1';
	// Deliver an initial 'far' event
	ProximitySensor * a = (ProximitySensor*) PS;
	pthread_mutex_lock( &data_mutex );
	a->mPendingEvent.distance = a->indexToValue(0);
	a->mHasPendingEvent = true;
	pthread_mutex_unlock( &data_mutex );
	FILE * fp_enabled;
	FILE * prox_fd;
	if ((fp_enabled = fopen(PROXIMITY_ENABLE, "r")) < 0) {
		LOGE("ProximitySensor thread couldn't find the enable file");
		thread_running = 0;
		if (fp_enabled)
			fclose(fp_enabled);
		if (prox_fd)
			fclose(prox_fd);
		pthread_exit(NULL);
	}
	if ((prox_fd = fopen(PROXIMITY_SENSOR, "r")) < 0) {
		LOGE("ProximitySensor cannot be opened");
		thread_running = 0;
		if (fp_enabled)
			fclose(fp_enabled);
		if (prox_fd)
			fclose(prox_fd);
		pthread_exit(NULL);
	}
	while (1) {
		fp_enabled = freopen(PROXIMITY_ENABLE, "r", fp_enabled);
		prox_fd = freopen(PROXIMITY_SENSOR, "r", prox_fd);
		buf = fgetc(fp_enabled);
		if (buf == EOF) {
			LOGE("ProximitySensor thread EOF");
		}
		//LOGE("ProximitySensor, I read %c", buf);
		if (buf == '0') {
			thread_running = 0;
			if (fp_enabled)
				fclose(fp_enabled);
			if (prox_fd)
				fclose(prox_fd);
			pthread_exit(NULL);
		}
		else if (buf == '1') {
			buf2 = fgetc(prox_fd);
			if (buf2 == EOF) {
				LOGE("ProximitySensor thread EOF");
			}
			//LOGE("ProximitySensor thread says: %c, prev was: %c", buf2, prev_value);
			// Deliver an event only if the proximity value has changed
			if (prev_value != buf2) {
				if (buf2 == '0') {
					pthread_mutex_lock( &data_mutex );
					a->mPendingEvent.distance = a->indexToValue(1);
					a->mHasPendingEvent = true;
					pthread_mutex_unlock( &data_mutex );
					//LOGE("ProximitySensor thread delivering: %f", a->mPendingEvent.distance);
				}
				else {
					pthread_mutex_lock( &data_mutex );
					a->mPendingEvent.distance = a->indexToValue(0);
					a->mHasPendingEvent = true;
					pthread_mutex_unlock( &data_mutex );
					//LOGE("ProximitySensor thread delivering: %f", a->mPendingEvent.distance);
				}
				prev_value = buf2;
			}
		}
		//sleep(1);
		int millisecs, microsecs;
		struct timeval tv;
		millisecs=250;
		microsecs=millisecs*1000;
		tv.tv_sec=microsecs/1000000;
		tv.tv_usec=microsecs%1000000;
		select(0, NULL, NULL, NULL, &tv);
	}
	return 0;
}

bool ProximitySensor::hasPendingEvents() const {
	return mHasPendingEvent;
}

int ProximitySensor::readEvents(sensors_event_t* data, int count)
{
	if (count < 1)
	return -EINVAL;

	if (mHasPendingEvent) {
		pthread_mutex_lock( &data_mutex );
	mHasPendingEvent = false;
	mPendingEvent.timestamp = getTimestamp();
	*data = mPendingEvent;
	int imenabled = mEnabled;
	pthread_mutex_unlock( &data_mutex );
	return imenabled;
	}

	ssize_t n = mInputReader.fill(data_fd);
	if (n < 0)
	return n;

	int numEventReceived = 0;
	input_event const* event;

	while (count && mInputReader.readEvent(&event)) {
	int type = event->type;
	if (type == EV_ABS) {
		if (event->code == EVENT_TYPE_PROXIMITY) {
		if (event->value != -1) {
			mPendingEvent.distance = indexToValue(event->value);
		}
		}
	} else if (type == EV_SYN) {
		mPendingEvent.timestamp = timevalToNano(event->time);
		if (mEnabled) {
		*data++ = mPendingEvent;
		count--;
		numEventReceived++;
		}
	} else {
		LOGE("ProximitySensor: unknown event (type=%d, code=%d)",
			type, event->code);
	}
	mInputReader.next();
	}

	return numEventReceived;
}

float ProximitySensor::indexToValue(size_t index) const
{
	return index * PROXIMITY_THRESHOLD_CM;
}
