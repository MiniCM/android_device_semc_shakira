#!/bin/sh

VENDOR=semc
DEVICE=shakira
rm -rf ../../../vendor/$VENDOR/$DEVICE/
mkdir -p ../../../vendor/$VENDOR/$DEVICE/proprietary
if [ $# -ne 1 ]
then
    echo "Pulling from device..."
    ACTION="adb pull "
else
    LOCAL_PROPR_DIR=$1
    echo "Copying from $LOCAL_PROPR_DIR ..."
    ACTION="cp -pr $LOCAL_PROPR_DIR/"
fi
    ${ACTION}/system/bin/akmd2 ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/mm-venc-omx-test ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/01_qcomm_omx.cfg ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/hciattach ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/nvimport ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libZiEngine.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/usr/keylayout/shakira_keypad.kl ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/usr/keychars/shakira_keypad.kcm.bin ../../../vendor/$VENDOR/$DEVICE/proprietary

## RIL related stuff
    ${ACTION}/system/lib/libril.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/port-bridge ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/qmuxd ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libauth.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libcm.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libdiag.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libdll.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libdsm.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libdss.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libgsdi_exp.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libgstk_exp.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libmmgsdilib.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libnv.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/liboem_rapi.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/liboncrpc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libpbmlib.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libqmi.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libqueue.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libuim.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libril-qc-1.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libwms.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libwmsts.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    
## Firmware
    ${ACTION}/system/etc/firmware/yamato_pfp.fw ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/yamato_pm4.fw ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fm_rx_init_1273.1.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fm_rx_init_1273.2.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fm_tx_init_1273.1.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fm_tx_init_1273.2.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fmc_init_1273.1.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/fmc_init_1273.2.bts ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/firmware/TIInit_7.2.31.bts ../../../vendor/$VENDOR/$DEVICE/proprietary

## Offline charging
    ${ACTION}/system/bin/chargemon ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/semc_chargalg ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/bin/updatemiscta ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libmiscta.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/semc/chargemon/anim1.rle ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/semc/chargemon/anim2.rle ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/etc/semc/chargemon/anim3.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim3.rle
    ${ACTION}/system/etc/semc/chargemon/anim4.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim4.rle
    ${ACTION}/system/etc/semc/chargemon/anim5.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim5.rle
    ${ACTION}/system/etc/semc/chargemon/anim6.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim6.rle
    ${ACTION}/system/etc/semc/chargemon/anim7.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim7.rle
    ${ACTION}/system/etc/semc/chargemon/anim8.rle ../../../vendor/$VENDOR/$DEVICE/proprietary/anim8.rle

## FM Radio and ANT
    ${ACTION}/system/etc/permissions/com.sonyericsson.smfmf.xml ../../../vendor/$VENDOR/$DEVICE/proprietary/com.sonyericsson.smfmf.xml
    ${ACTION}/system/etc/permissions/com.sonyericsson.suquashi.xml ../../../vendor/$VENDOR/$DEVICE/proprietary/com.sonyericsson.suquashi.xml
    ${ACTION}/system/etc/permissions/com.ti.fm.fmreceiverif.xml ../../../vendor/$VENDOR/$DEVICE/proprietary/com.ti.fm.fmreceiverif.xml
    ${ACTION}/system/lib/libfm_stack.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libfm_stack.so
    ${ACTION}/system/lib/libfmrx.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libfmrx.so
    ${ACTION}/system/etc/permissions/com.dsi.ant.antradio_library.xml ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/framework/com.dsi.ant.antradio_library.jar ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libanthal.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    
## HW and sensors
    ${ACTION}/system/etc/sensors.conf ../../../vendor/$VENDOR/$DEVICE/proprietary/sensors.conf
    ${ACTION}/system/lib/hw/lights.default.so ../../../vendor/$VENDOR/$DEVICE/proprietary/lights.default.so
    ${ACTION}/system/lib/hw/hal_seport.default.so ../../../vendor/$VENDOR/$DEVICE/proprietary/hal_seport.default.so
    ${ACTION}/system/lib/libsystemconnector/libuinputdevicejni.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libsystemconnector_hal_jni.so ../../../vendor/$VENDOR/$DEVICE/proprietary

## Camera
    ${ACTION}/system/lib/libcamera.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libcamera.so
    ${ACTION}/system/lib/liboemcamera.so ../../../vendor/$VENDOR/$DEVICE/proprietary/liboemcamera.so
    ${ACTION}/system/lib/libmmipl.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libmmipl.so
    ${ACTION}/system/lib/libmmjpeg.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libmmjpeg.so
    ${ACTION}/system/lib/libfacedetect.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libfacedetect.so
    ${ACTION}/system/lib/libvdmfumo.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libvdmfumo.so
    ${ACTION}/system/lib/libfacedetectjnitest.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libfacedetectjnitest.so
    ${ACTION}/system/lib/libcommondefs.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libcommondefs.so
    ${ACTION}/system/lib/libopencore_common.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    
## Audio
    ${ACTION}/system/lib/libaudioeq.so ../../../vendor/$VENDOR/$DEVICE/proprietary/libaudioeq.so

## OMX proprietaries
    ${ACTION}/system/lib/libmm-adspsvc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAacDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAmrRtpDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxH264Dec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxQcelpDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAacEnc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAmrwbDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxMp3Dec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxVidEnc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAmrDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxEvrcDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxMpeg4Dec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxWmaDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxAmrEnc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxEvrcEnc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxQcelp13Enc.so ../../../vendor/$VENDOR/$DEVICE/proprietary
    ${ACTION}/system/lib/libOmxWmvDec.so ../../../vendor/$VENDOR/$DEVICE/proprietary

(cat << EOF) | sed -e s/__DEVICE__/$DEVICE/g -e s/__VENDOR__/$VENDOR/g > ../../../vendor/$VENDOR/$DEVICE/device_$DEVICE-vendor-blobs.mk
# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This file is generated by device/$VENDOR/__DEVICE__/extract-files.sh

PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/akmd2:system/bin/akmd2 \\
    vendor/__VENDOR__/__DEVICE__/proprietary/mm-venc-omx-test:system/bin/mm-venc-omx-test \\
    vendor/__VENDOR__/__DEVICE__/proprietary/hciattach:system/bin/hciattach \\
    vendor/__VENDOR__/__DEVICE__/proprietary/nvimport:system/bin/nvimport \\
    vendor/__VENDOR__/__DEVICE__/proprietary/01_qcomm_omx.cfg:system/etc/01_qcomm_omx.cfg
    
## RIL related stuff 
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril.so:system/lib/libril.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/port-bridge:system/bin/port-bridge \\
    vendor/__VENDOR__/__DEVICE__/proprietary/qmuxd:system/bin/qmuxd \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libauth.so:system/lib/libauth.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcm.so:system/lib/libcm.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdiag.so:system/lib/libdiag.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdll.so:system/lib/libdll.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdsm.so:system/lib/libdsm.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libdss.so:system/lib/libdss.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgsdi_exp.so:system/lib/libgsdi_exp.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libgstk_exp.so:system/lib/libgstk_exp.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmmgsdilib.so:system/lib/libmmgsdilib.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libnv.so:system/lib/libnv.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/liboem_rapi.so:system/lib/liboem_rapi.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/liboncrpc.so:system/lib/liboncrpc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libpbmlib.so:system/lib/libpbmlib.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqmi.so:system/lib/libqmi.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libqueue.so:system/lib/libqueue.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libuim.so:system/lib/libuim.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libril-qc-1.so:system/lib/libril-qc-1.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libwms.so:system/lib/libwms.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libwmsts.so:system/lib/libwmsts.so
    
## Firmware
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \\
    vendor/__VENDOR__/__DEVICE__/proprietary/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fm_rx_init_1273.1.bts:system/etc/firmware/fm_rx_init_1273.1.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fm_rx_init_1273.2.bts:system/etc/firmware/fm_rx_init_1273.2.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fm_tx_init_1273.1.bts:system/etc/firmware/fm_tx_init_1273.1.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fm_tx_init_1273.2.bts:system/etc/firmware/fm_tx_init_1273.2.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fmc_init_1273.1.bts:system/etc/firmware/fmc_init_1273.1.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/fmc_init_1273.2.bts:system/etc/firmware/fmc_init_1273.2.bts \\
    vendor/__VENDOR__/__DEVICE__/proprietary/TIInit_7.2.31.bts:system/etc/firmware/TIInit_7.2.31.bts 

## Offline charging
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/chargemon:system/bin/charger \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmiscta.so:system/lib/libmiscta.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/semc_chargalg:system/bin/semc_chargalg \\
    vendor/__VENDOR__/__DEVICE__/proprietary/updatemiscta:system/bin/updatemiscta \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim1.rle:system/etc/semc/chargemon/anim1.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim2.rle:system/etc/semc/chargemon/anim2.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim3.rle:system/etc/semc/chargemon/anim3.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim4.rle:system/etc/semc/chargemon/anim4.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim5.rle:system/etc/semc/chargemon/anim5.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim6.rle:system/etc/semc/chargemon/anim6.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim7.rle:system/etc/semc/chargemon/anim7.rle \\
    vendor/__VENDOR__/__DEVICE__/proprietary/anim8.rle:system/etc/semc/chargemon/anim8.rle
      
## FM Radio and ANT
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/com.sonyericsson.smfmf.xml:system/etc/permissions/com.sonyericsson.smfmf.xml \\
    vendor/__VENDOR__/__DEVICE__/proprietary/com.sonyericsson.suquashi.xml:system/etc/permissions/com.sonyericsson.suquashi.xml \\
    vendor/__VENDOR__/__DEVICE__/proprietary/com.ti.fm.fmreceiverif.xml:system/etc/permissions/com.ti.fm.fmreceiverif.xml \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libfm_stack.so:system/lib/libfm_stack.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libfmrx.so:system/lib/libfmrx.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/com.dsi.ant.antradio_library.xml:system/etc/permissions/com.dsi.ant.antradio_library.xml \\
    vendor/__VENDOR__/__DEVICE__/proprietary/com.dsi.ant.antradio_library.jar:system/framework/com.dsi.ant.antradio_library.jar \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libanthal.so:system/lib/libanthal.so

## HW and sensors
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/sensors.conf:system/etc/sensors.conf \\
    vendor/__VENDOR__/__DEVICE__/proprietary/lights.default.so:system/lib/hw/lights.default.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/hal_seport.default.so:system/lib/hw/hal_seport.default.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libuinputdevicejni.so:system/lib/libsystemconnector/libuinputdevicejni.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libsystemconnector_hal_jni.so:system/lib/libsystemconnector_hal_jni.so
    
## Camera    
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/liboemcamera.so:system/lib/liboemcamera.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcamera.so:system/lib/libcamera.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmmipl.so:system/lib/libmmipl.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmmjpeg.so:system/lib/libmmjpeg.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libfacedetect.so:system/lib/libfacedetect.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libvdmfumo.so:system/lib/libvdmfumo.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libfacedetectjnitest.so:system/lib/libfacedetectjnitest.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libcommondefs.so:system/lib/libcommondefs.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libopencore_common.so:system/lib/libopencore_common.so

## Audio
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libaudioeq.so:system/lib/libaudioeq.so

## OMX proprietaries
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libmm-adspsvc.so:system/lib/libmm-adspsvc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAacDec.so:system/lib/libOmxAacDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrRtpDec.so:system/lib/libOmxAmrRtpDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxH264Dec.so:system/lib/libOmxH264Dec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxQcelpDec.so:system/lib/libOmxQcelpDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAacEnc.so:system/lib/libOmxAacEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrwbDec.so:system/lib/libOmxAmrwbDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxMp3Dec.so:system/lib/libOmxMp3Dec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxVidEnc.so:system/lib/libOmxVidEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrDec.so:system/lib/libOmxAmrDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxEvrcDec.so:system/lib/libOmxEvrcDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxMpeg4Dec.so:system/lib/libOmxMpeg4Dec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxWmaDec.so:system/lib/libOmxWmaDec.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxAmrEnc.so:system/lib/libOmxAmrEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxEvrcEnc.so:system/lib/libOmxEvrcEnc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxQcelp13Enc.so:system/lib/libOmxQcelp13Enc.so \\
    vendor/__VENDOR__/__DEVICE__/proprietary/libOmxWmvDec.so:system/lib/libOmxWmvDec.so

## Keyboard layouts and T9
PRODUCT_COPY_FILES += \\
    vendor/__VENDOR__/__DEVICE__/proprietary/shakira_keypad.kl:system/usr/keylayout/shakira_keypad.kl \\
    vendor/__VENDOR__/__DEVICE__/proprietary/shakira_keypad.kcm.bin:system/usr/keychars/shakira_keypad.kcm.bin \\

EOF

./setup-makefiles.sh
