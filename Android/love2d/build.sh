#!/bin/sh
echo 'Поместите проверенную игру game.love в папку ./assets/'
clear
echo '0-start'
cp love-11.5-android-embed.apk mylove.apk

echo '1----'
zip mylove.apk  assets/ assets/game.love

echo '2----Однократно!!!'
echo 'Для СОЗДАНИЯ подписи придется ввести пароль, имя и т. д. — запомни их!'
#keytool -genkey -v -keystore my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key

echo '3----Подписываем'
zipalign -v 4 mylove.apk game-aligned.apk
apksigner sign --ks my-release-key.jks --out game-signed.apk game-aligned.apk

echo '4-end'
echo 'install in Android - game-signed.apk '
rm game-aligned.apk mylove.apk
