#!/bin/bash

# Color codes
NORMAL='\033[0;39m'
GREEN='\033[1;32m'
RED='\033[1;31m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'

WORKDIR=$(pwd)
FILENAME='com.freestylelibre.app.de_2019-04-22'

echo -e "${WHITE}Suche APK Datei '${FILENAME}.apk' ...${NORMAL}"
if [ -e APK/${FILENAME}.apk ]; then
  echo -e "${GREEN}  gefunden.${NORMAL}"
else
  echo -e "${RED}  nicht gefunden.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte laden Sie die original APK Datei von https://www.apkmonk.com/download-app/com.freestylelibre.app.de/5_com.freestylelibre.app.de_2019-04-22.apk/ herunter und legen Sie sie im Verzeichnis APK/ ab.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Prüfe MD5 Summe der APK Datei ...${NORMAL}"
md5sum -c APK/${FILENAME}.apk.md5 > /dev/null 2>&1
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte laden Sie die korrekte, unverfälschte original APK herunter.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Enpacke original APK Datei ...${NORMAL}"
apktool d -o /tmp/librelink APK/${FILENAME}.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Patche original App ...${NORMAL}"
cd /tmp/librelink/
git apply --whitespace=nowarn --verbose ${WORKDIR}/xdrip2.git.patch
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Verwende neuen Sourcecode für gepatchte App ...${NORMAL}"
cp -Rv ${WORKDIR}/sources/* /tmp/librelink/smali_classes2/com/librelink/app/
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
cp -Rv ${WORKDIR}/graphics/* /tmp/librelink/
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Kopiere original APK Datei in gepatchte App ...${NORMAL}"
cp ${WORKDIR}/APK/${FILENAME}.apk /tmp/librelink/assets/original.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Baue gepatchte App zusammen ...${NORMAL}"
apktool b -o ${WORKDIR}/APK/librelink_unaligned.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Räume /tmp/ auf ...${NORMAL}"
cd ${WORKDIR}
rm -rf /tmp/librelink/
echo -e "${GREEN}  okay."

echo -e "${WHITE}Optimiere Ausrichtung der gepatchten APK Datei...${NORMAL}"
zipalign -p 4 APK/librelink_unaligned.apk APK/${FILENAME}_patched.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
  rm APK/librelink_unaligned.apk
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Erstelle Keystore zum Signieren der gepatchten APK Datei ...${NORMAL}"
keytool -genkey -v -keystore /tmp/libre-keystore.jks -alias "Libre Signer" -keyalg RSA -keysize 2048 --validity 10000 --storepass geheim -dname "cn=Libre Signer, c=de"
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${WHITE}Signiere gepatchte APK Datei ...${NORMAL}"
apksigner sign --ks-pass pass:geheim --ks /tmp/libre-keystore.jks APK/${FILENAME}_patched.apk
if [ $? = 0 ]; then
  echo -e "${GREEN}  okay.${NORMAL}"
  rm /tmp/libre-keystore.jks
else
  echo -e "${RED}  nicht okay.${NORMAL}"
  echo
  echo -e "${YELLOW}=> Bitte prüfen Sie o.a. Fehler.${NORMAL}"
  exit 1
fi

echo -e "${YELLOW}Fertig! Die fertig gepatchte und signierte APK Datei finden Sie unter APK/${FILENAME}_patched.apk${NORMAL}"
