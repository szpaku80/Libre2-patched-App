#!/bin/bash

# Color codes
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'


echo -e "${WHITE}Suche APK Datei 'com.freestylelibre.app.de_2019-04-22.apk' ...${NORMAL}"
if [ -e APK/com.freestylelibre.app.de_2019-04-22.apk ]; then
  echo -e "${GREEN}  gefunden.${NORMAL}"
else
  echo -e "${RED}  nicht gefunden.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte laden Sie die original APK Datei von https://www.apkmonk.com/download-app/com.freestylelibre.app.de/5_com.freestylelibre.app.de_2019-04-22.apk/ herunter und legen Sie sie im Verzeichnis APK/ ab.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Prüfe MD5 Summe der APK Datei ...${NORMAL}"
md5sum -c APK/com.freestylelibre.app.de_2019-04-22.apk.md5 > /dev/null 2>&1
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte laden Sie die korrekte, unverfälschte original APK herunter.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Enpacke original APK Datei ...${NORMAL}"
apktool d -o /tmp/librelink APK/com.freestylelibre.app.de_2019-04-22.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Patche original App ...${NORMAL}"
echo $(pwd) > /tmp/librepatch.pwd
cd /tmp/librelink/
git apply $(cat /tmp/librepatch.pwd)/xdrip2.git.patch
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Verwende neuen Sourcecode für gepatchte App ...${NORMAL}"
cp -Rv $(cat /tmp/librepatch.pwd)/sources/* /tmp/librelink/smali_classes2/com/librelink/app/
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi
chmod 644 /tmp/librelink/smali_classes2/com/librelink/app/*.smali

echo -e "${WHITE}Verwende neue Grafiken für gepatchte App ...${NORMAL}"
cp -Rv $(cat /tmp/librepatch.pwd)/graphics/* /tmp/librelink/
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Kopiere original APK Datei in gepatchte App ...${NORMAL}"
cp $(cat /tmp/librepatch.pwd)/APK/com.freestylelibre.app.de_2019-04-22.apk /tmp/librelink/assets/original.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Baue gepatchte App zusammen ...${NORMAL}"
apktool b -o $(cat /tmp/librepatch.pwd)/APK/librelink_unaligned.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Räume /tmp/ auf ...${NORMAL}"
cd $(cat /tmp/librepatch.pwd)
rm -rf /tmp/librelink/
rm /tmp/librepatch.pwd
echo -e "${GREEN}  okay."

echo -e "${WHITE}Optimiere Ausrichtung der gepatchten APK Datei...${NORMAL}"
zipalign -p 4 APK/librelink_unaligned.apk APK/librelink_aligned.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
  rm APK/librelink_unaligned.apk
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${YELLOW}=> Bitte signieren Sie die fertig gepatchte APK Datei APK/librelink_aligned.apk mittels 'apksigner', bevor Sie versuchen, diese auf dem SmartPhone zu installieren.${NORMAL}"
