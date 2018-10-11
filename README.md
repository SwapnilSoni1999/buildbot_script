# Buildbot Script
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

(PS: in some cases like AEX build command is `mka aex` according to aex build docs, you can change build command from [here](https://github.com/SwapnilSoni1999/buildbot_script/blob/master/bot.sh#L25)`)
