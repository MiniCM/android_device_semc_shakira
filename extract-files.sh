#!/bin/sh

VENDOR=semc
DEVICE=shakira
BASE=../../../vendor/$VENDOR/$DEVICE/proprietary
rm -rf $BASE/*

if [ $# -ne 1 ]
then
    echo "Pulling from device..."
    ACTION="adb pull "
else
    LOCAL_PROPR_DIR=$1
    echo "Copying from $LOCAL_PROPR_DIR ..."
    ACTION="cp -pr $LOCAL_PROPR_DIR"
fi
for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    ${ACTION}/system/$FILE $BASE/$FILE
done
./setup-makefiles.sh

