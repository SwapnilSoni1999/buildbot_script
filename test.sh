#!/bin/bash

# Sync with configs 
source bot-mega.conf	# Disable this if not using MEGA
#source bot.sh		# Disable this if not using Gdrive

sendMessage() {
MESSAGE=$1

curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$MESSAGE&chat_id=$CHAT_ID" 1> /dev/null

echo -e;
}

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

                curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" -d parse_mode="Markdown" --data "text=$SUMMARY&chat_id=$CHAT_ID"  1> /dev/null
echo -e;


exit 1

