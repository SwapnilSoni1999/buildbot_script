#!/bin/bash

#sync with configs
source bot.conf
source build/envsetup.sh

sendMessage() {
MESSAGE=$1

curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$MESSAGE&chat_id=$CHAT_ID" 1> /dev/null

echo -e;
}

sendMessage "Starting build $ROMM for $DEBICE"

#start build
lunch $ROMM\_$DEBICE-userdebug | tee lunch.log
# catch lunch error
if [ $? -eq 0 ]
then
       	echo "Bringup Done... Starting Build\(brunch\)"
	sendMessage "Bringup Done... Starting build."
	brunch $DEBICE | tee build.log
#	mka aex | tee build.log
	#catch brunch error
	if [ $? -eq 0 ]
	then
		echo "build DONEEE"
		sendMessage "build DONE!"

		#since build iz done lets upload
		OUTPUT_FILE=$(grep -o -P '(?<=Package\ Complete).*(?=.zip)' build.log)'.zip'
#		OUTPUT_FILE=$(grep -o -P '(?<=Zip: ).*(?=.zip)' build.log)'.zip'
		OUTPUT_LOC=$(echo $OUTPUT_FILE | cut -f2 -d":")
		echo $OUTPUT_LOC

		#upload to gdrive
		sendMessage "Uploading to Gdrive..."
		URL=$(gdrive upload --share $UPLOAD_LOC | egrep -o 'https?://[^ ]+')

		BEELD_FINISHED=true
	else
		sendMessage "beeld phel nibba"
		echo "brunch phel"
	fi
else
       	echo "Bringup PHEL..."
	sendMessage "Bringup PHEL... sad"
fi

rm lunch.log

	# Some Extra Summary to share
                MD5=`md5sum ${OUTPUT_LOC} | awk '{ print $1 }'`

read -r -d '' SUMMARY << EOM
ROM: $ZIPNAAM
Build: $BUILD_TAIP
LINK: [Download From Gdrive]($URL)
NOTES: $NOTES
MD5: $MD5
EOM

                curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" -d parse_mode="Markdown" --data "text=$SUMMARY&chat_id=$CHAT_ID"  1> /dev/null
echo -e;

#fi


exit 1
