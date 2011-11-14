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

#include <linux/lightsensor.h>

#include <cutils/log.h>

#include "LightSensor.h"


/*****************************************************************************/
/* The lightsensor for msm7x27 delivers: 0, 4, 16, 64, 250 depending on the ambiebt light */

#define LIGHT_SENSOR "/sys/devices/platform/i2c-adapter/i2c-0/0-0036/als::value"
int thread_running_light=0;

LightSensor::LightSensor()
	: SensorBase(LS_DEVICE_NAME, "lightsensor"),
	  mInputReader(4),
	  mHasPendingEvent(false)
{
	mPendingEvent.version = sizeof(sensors_event_t);
	mPendingEvent.sensor = ID_L;
	mPendingEvent.type = SENSOR_TYPE_LIGHT;
	memset(mPendingEvent.data, 0, sizeof(mPendingEvent.data));

	setInitialState();
}

LightSensor::~LightSensor() {
}

int LightSensor::setInitialState() {
	if (thread_running_light == 0) {
		int rc = pthread_create(&poll_thread, NULL, polling_thread_func_light, (void *)this);
		if (rc){
			LOGE("ERROR return code from pthread_create() is %d\n", rc);
		}
		else{
			//LOGE("LightSensor created new thread");
		}
	}
	return 0;
}

void * polling_thread_func_light(void *PS)
{
	thread_running_light = 1;
	char buf [15]="0";
	char prev_value [15]="0";
	LightSensor * a = (LightSensor*) PS;
	FILE * light_fd;
	if ((light_fd = fopen(LIGHT_SENSOR, "r")) < 0) {
		LOGE("LightSensor cannot be opened");
		thread_running_light = 0;
		if (light_fd)
			fclose(light_fd);
		pthread_exit(NULL);
	}
	while (1) {
		light_fd = freopen(LIGHT_SENSOR, "r", light_fd);
		fgets(buf, 10, light_fd); 
		//LOGE("LightSensor thread says: %s, prev was: %s", buf, prev_value);
		// Deliver an event only if the light sensor value has changed
		if (strcmp(prev_value, buf) !=0) {
			a->mPendingEvent.light = atoi(buf);
			a->mHasPendingEvent = true;
			//LOGE("LightSensor thread delivering: %f", a->mPendingEvent.light);
			strcpy(prev_value,buf);
		}
		sleep(2);
	}
	return 0;
}


int LightSensor::enable(int32_t, int en) {
	if(en) {
		setInitialState();
	}
	return 0;
}

bool LightSensor::hasPendingEvents() const {
	return mHasPendingEvent;
}

int LightSensor::readEvents(sensors_event_t* data, int count)
{
	if (count < 1)
		return -EINVAL;

	if (mHasPendingEvent) {
		mHasPendingEvent = false;
		mPendingEvent.timestamp = getTimestamp();
		*data = mPendingEvent;
		return 1;
	}

	ssize_t n = mInputReader.fill(data_fd);
	if (n < 0)
		return n;

	int numEventReceived = 0;
	input_event const* event;

	while (count && mInputReader.readEvent(&event)) {
		int type = event->type;
		if (type == EV_LED) { // light sensor 1
			if (event->code == EVENT_TYPE_LIGHT) {
				mPendingEvent.light = event->value;
			}
		} else if (type == EV_MSC) { // light sensor 2
			/* Light sensor 2 seems to put out lower lux values than
			 * light sensor 1, and I can't decide which is more "accurate",
			 * so for now just disabling #2

			if (event->code == EVENT_TYPE_LIGHT2) {
				mPendingEvent.light = event->value;
			}

			 */
		} else if (type == EV_SYN) {
			mPendingEvent.timestamp = timevalToNano(event->time);
			*data++ = mPendingEvent;
			count--;
			numEventReceived++;
		} else {
			LOGE("LightSensor: unknown event (type=%d, code=%d)",
					type, event->code);
		}
		mInputReader.next();
	}

	return numEventReceived;
}
