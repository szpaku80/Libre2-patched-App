#!/bin/bash

echo "Suche 'com.freestylelibre.app.de_2019-04-22.apk' ..."
if [ -e APK/com.freestylelibre.app.de_2019-04-22.apk ]; then
  echo "  gefunden."
else
  echo "  nicht gefunden."
  echo
  echo "=> Bitte laden Sie die original APK Datei von https://www.apkmonk.com/download-app/com.freestylelibre.app.de/5_com.freestylelibre.app.de_2019-04-22.apk/ herunter und legen Sie sie im Verzeichnis APK/ ab."
  exit 1
fi

echo "Prüfe MD5 Summe der Datei ..."
md5sum -c APK/com.freestylelibre.app.de_2019-04-22.apk.md5 > /dev/null 2>&1
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte laden Sie die korrekte, unverfälschte original APK herunter."
  exit 1
fi

echo "Enpacke original APK ..."
apktool d -o /tmp/librelink APK/com.freestylelibre.app.de_2019-04-22.apk
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Patche original APK ..."
echo $(pwd) > /tmp/librepatch.pwd
cd /tmp/librelink/
git apply $(cat /tmp/librepatch.pwd)/xdrip2.git.patch
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Verwende neue Grafiken für gepatchte App ..."
cp -Rv $(cat /tmp/librepatch.pwd)/sources/* /tmp/librelink/smali_classes2/com/librelink/app/
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi
chmod 644 /tmp/librelink/smali_classes2/com/librelink/app/*.smali

echo "Verwende neue Grafiken für gepatchte App ..."
cp -Rv $(cat /tmp/librepatch.pwd)/graphics/* /tmp/librelink/
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Kopiere original APK in gepatchte App ..."
cp $(cat /tmp/librepatch.pwd)/APK/com.freestylelibre.app.de_2019-04-22.apk /tmp/librelink/assets/original.apk
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Baue gepatchte APK zusammen ..."
apktool b -o $(cat /tmp/librepatch.pwd)/APK/librelink_unaligned.apk
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Räume /tmp/ auf ..."
cd $(cat /tmp/librepatch.pwd)
rm -rf /tmp/librelink/
rm /tmp/librepatch.pwd
echo "  okay."

echo "Optimiere Ausrichtung der gepatchten APK ..."
zipalign -p 4 APK/librelink_unaligned.apk APK/librelink_aligned.apk
if [ $? = 0 ]; then
  echo "  okay."
else
  echo "  nicht okay."
  echo
  echo "=> Bitte prüfen Sie o.a. Fehler."
  exit 1
fi

echo "Bitte signieren Sie die fertig gepatchte APK Datei APK/librelink_aligned.apk bevor Sie versuchen, diese auf dem SmartPhone zu installieren."
