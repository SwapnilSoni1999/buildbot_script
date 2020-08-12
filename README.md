# Buildbot Script(MEGA version)
How to use:

1. Get your bot API key from [Telegram's BotFather](https://t.me/BotFather)
2. Assign BOT API Key in `bot-mega.config`
```bash
        export BOT_API_KEY=ABCD12345:12345AbCDefghIJK
```
3. Create a public group and add your bot there then assign group tag
```bash
        export CHAT_ID=@groupname
```
4. Assign your configs for eg. to build LineageOS for h930(LG v30 h930)
```bash
        # Configs
        ROM=lineage
        DEVICE=h930
```
5. Assign your Manual Configs (info for Telegram post)
```bash
        # Manual Configs 
	A_VERSION="Android 10"
	
	TG_NAME="@N7\_BADA"
	FULL_ROM_NAME="Corvus OS"
	FULL_DEVICE_NAME="LG v30 H930"
	BUILD_DATE=$(date +%Y-%m-%d)
	BUILD_TYPE="Bot Build"
	NOTES="Not Tested!"
```
6. Assign your # Directories to create on MEGA shows up as /Root/$DEVICE_DIR/$ROM_DIR
```bash
        # Directories
	DEVICE_DIR="H930"
	ROM_DIR="Corvus"
```
7. After all the above is set, Here's an example of the Output on Telegram after running the `bot-mega.sh`:

![Output Example](https://i.imgur.com/XSNIoI4.png)

8. Extra 1, `output.sh` posts a test output on Telegram, 
```bash
        # Extra
        bash output.sh        
```
9. Extra 2, `repost.sh` will reupload or fetch the link of the latest build and post it on Telegram.
```bash
        # Extra
        bash repost.sh        
```

(PS: in some cases like AEX,Corvus,Derpfest build command is `mka aex, make corvus, mka kronic` according to aex, corvus, derpfest build docs, you can change build command from line [18](https://github.com/N7-BADA/buildbot_script/blob/master/bot-mega.sh#L18) and [19](https://github.com/N7-BADA/buildbot_script/blob/master/bot-mega.sh#L19)`)

```bash
        ------------------------------------------------
```

# Buildbot Script(GDrive version)
How to use:

1. Get your bot API key from [Telegram's BotFather](https://t.me/BotFather)
2. Assign BOT API Key in `bot.config`
```bash
        export BOT_API_KEY=ABCD12345:12345AbCDefghIJK
```
3. Create a public group and add your bot there then assign group tag
```bash
        export CHAT_ID=@groupname
```
4. Assign your configs for eg. to build LineageOS for mido(Redmi note 4)
```bash
        # Configs
        ROMM=lineage
        DEBICE=mido
        VENDUR=xiaomi
```
5. Misc Changes (these configs will be sent as message and wont affect any change in build)
`ZIPNAM` will send package name to send
`BUILD_TAIP` will set build type for eg. `Test` or `Alpha`
`NOTES` will attach your message or note to send over telegram

(PS: in some cases like AEX build command is `mka aex` according to aex build docs, you can change build command from [here](https://github.com/N7-BADA/buildbot_script/blob/master/bot.sh#L25)`)
