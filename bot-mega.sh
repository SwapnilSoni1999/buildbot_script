#!/bin/bash

# Sync with configs
source bot-mega.conf
source build/envsetup.sh

sendMessage() {
MESSAGE=$1

curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$MESSAGE&chat_id=$CHAT_ID" 1> /dev/null

echo -e;
}

sendMessage "Starting build $FULL_ROM_NAME for $FULL_DEVICE_NAME"

# Start Build
#lunch $ROM\_$DEVICE-userdebug && mka bacon | tee build.log	# Enable this for standard "mka bacon"
lunch $ROM\_$DEVICE-userdebug && make corvus | tee build.log	# Enable and edit this if ROM has specific "make command" (make corvus, mka aex, etc)
# catch lunch error
if [ $? -eq 0 ]
then

		echo "Build Completed! Uploading to MEGA.."
		sendMessage "Build Completed! Uploading to MEGA.."

		# Grab full file output
		FILE_OUTPUT=$(grep -Po 'Package Complete: \K[^ ]+' build.log)
		echo $FILE_OUTPUT

		ZIP_NAME=$(grep -Po 'Package Complete: \K[^ ]+' build.log | sed 's#.*/##')
		echo $ZIP_NAME

		# Create Dir according to $DEVICE & $ROM (disable this after successfully executing script for first time)
		megadf --reload 2>&1 >/dev/null && megamkdir /Root/$DEVICE_DIR 2>&1 >/dev/null
		megadf --reload 2>&1 >/dev/null && megamkdir /Root/$DEVICE_DIR/$ROM_DIR 2>&1 >/dev/null

		# Upload to MEGA
		megadf -h --reload
		megaput --path /Root/$DEVICE_DIR/$ROM_DIR/ $FILE_OUTPUT

		# Fetch URL
		megals -e /Root/$DEVICE_DIR/$ROM_DIR/$ZIP_NAME >> url.log
		URL=$(grep https url.log | awk '{ print $1 }')
		echo $URL

else
	sendMessage "Build Failed!"
	echo "Build Failed!"
fi

rm url.log

		# Some Extra Summary to share
		MD5=`md5sum $FILE_OUTPUT | awk '{ print $1 }'`
		SIZE=`ls -sh $FILE_OUTPUT | awk '{ print $1 }'`

read -r -d '' SUMMARY << EOM
$FULL_ROM_NAME $A_VERSION for $FULL_DEVICE_NAME

Author: $TG_NAME
Build Date: $BUILD_DATE
Build Type: $BUILD_TYPE
MEGA LINK: $URL
SIZE: $SIZE
MD5: $MD5

NOTES: $NOTES
EOM

		curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendPhoto" -d parse_mode="Markdown" --data "photo=$PHOTO_LINK&caption=$SUMMARY&chat_id=$CHAT_ID"  1> /dev/null

		curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendSticker?chat_id=$CHAT_ID&sticker=$STICKER_ID"  1> /dev/null

echo -e;

#fi


exit 1

