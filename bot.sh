#!/bin/bash

#sync with configs
source bot.conf
source build/envsetup.sh

export BUILD_FINISHED=false

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

		BUILD_FINISHED=true
		if [ $BUILD_FINISHED = true  ] ; then

			#since build iz done lets upload
			OUTPUT_FILE=$(grep -o -P '(?<=Package\ Complete).*(?=.zip)' build.log)'.zip'
	#		OUTPUT_FILE=$(grep -o -P '(?<=Zip: ).*(?=.zip)' build.log)'.zip'
			OUTPUT_LOC=$(echo $OUTPUT_FILE | cut -f2 -d":")
			echo $OUTPUT_LOC

			#upload to gdrive
			sendMessage "Uploading to Gdrive..."
			gdrive upload $OUTPUT_LOC | tee upload.log

			#get file id
			sed -e 's/.*Uploaded\(.*\)at.*/\1/' upload.log >> id.txt
			sendMessage "Upload Finished."
			sed -e '1d' id.txt >> final.txt
			FILE_ID=$(cat final.txt)

			#set permission to sharing
			gdrive share $FILE_ID

			#finally output the sharing url
			URL='https://drive.google.com/open?id='$FILE_ID
			SHARE="$(echo -e "${URL}" | tr -d '[:space:]')"
			echo $SHARE >> url.txt

			#MESSAGE=$(cat url.txt)
			echo $SHARE
			sendMessage $SHARE

			BEELD_FINISHED=true
			#clean up
			rm upload.log final.txt id.txt url.txt
		fi
	else
		sendMessage "beeld phel nibba"
		echo "brunch phel"
	fi
else
       	echo "Bringup PHEL..."
	sendMessage "Bringup PHEL... sad"
fi

rm lunch.log

if [ $BUILD_FINISHED = true  ] ; then

# Some Extra Summary to share
MD5=`md5sum ${OUTPUT_LOC} | awk '{ print $1 }'`

read -r -d '' SUMMARY << EOM
ROM: $ZIPNAAM
Build: $BUILD_TAIP
LINK: $SHARE
NOTES: $NOTES
MD5: $MD5
EOM

                curl -s "https://api.telegram.org/bot${BOT_API_KEY}/sendmessage" --data "text=$SUMMARY&chat_id=$CHAT_ID" 1> /dev/null
echo -e;

fi


exit 1
