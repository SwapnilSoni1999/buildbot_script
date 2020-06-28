#!/bin/bash

# Sync with configs
source bot-mega.conf

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

exit 1

