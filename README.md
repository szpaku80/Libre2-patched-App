# How to patch the Librelink app to provide xDrip with Value received by bluetooth directly from sensor


**IF YOU WANT TO USE THIS, YOU NEED TO ACTIVATE A NEW SENSOR AFTER THE INSTALLATION PROCEDURE IS COMPLETED, IT DOES NOT WORK WITH ALLREADY ACTIVATED SENSORS!!**

**Already activated sensors will also stop sending alarms to the handset device if they had been activated with the unpatched phone app.**


## Get the APK and Tools
1. Load the Version 2.3.0 of the freestyle Libre App DE, for example from [here](https://apkpure.com/de/freestyle-librelink-de/com.freestylelibre.app.de) or [here](https://www.apkmonk.com/download-app/com.freestylelibre.app.de/5_com.freestylelibre.app.de_2019-04-22.apk/)
(The German version does have english language, don't worry.)

2. [OPTIONAL] If you want to check if your Version is correct, check the MD5 (for windows you might need to get an App like: 
http://www.winmd5.com to perform md5 checksumming). The Checksum should be: `420735605bacf0e18d2570079ebaa238`

3. Load the [apkTool](https://ibotpeaches.github.io/Apktool/) and install it as described [here](https://ibotpeaches.github.io/Apktool/install/). It seems that the current 2.4 Version of Apktool has some problems on Windows, please download and install an older 2.3 Version if you are using Windows!

4. Open a CMD-Prompt (windows) or Shell (\*nix) where you downloaded the apk (e.g. your download folder)

5. Use the apktool: `apktool d -o librelink [FILENAME_OF_THE_DOWNLOADED_APK]`

6. You should now have a folder named `librelink` with all the extracted files of the application
7. Copy the patch Files from this repository to the same location as the `librelink` folder (you should now have a directory with at least the following files/folders: `librelink`, `xdrip2.git.patch`, `sources` and `xdrip2.patch`)

## Patch Application 
**Use either of the two methods:**

### OPTION 1: patch method
1. For Windows, get the patch tool from [here](http://gnuwin32.sourceforge.net/packages/patch.htm) and install it correctly. Mac, Linux and *nix should have patch onboard, if not install from your trusted repository.
2. Change in the prompt/shell into the `librelink` folder
3. Use the Patch tool with the patch: `patch -p1 --binary --merge < ../xdrip2.patch`. for Windows `patch -p1 --binary --merge < ..\xdrip2.patch`. Be sure to use CMD-Prompt and not PowerShell,a s PowerShell does not support < operation.

### OPTION 2: git apply method
1. Get your git client ready. For windows install something like [this](https://gitforwindows.org)
2. Change in the prompt/shell into the `librelink` folder
3. Use igt to apply the patch: `git apply ../xdrip2.git.patch`, for Windows `git apply ..\xdrip2.git.patch`

## Add Files
1. In your Filebrowser navigate within the librelink folder to the path `smali_classes2/com/librelink/app/`
2. Copy the following Files from the `sources` folder of this repository to this folder:
	1. `ThirdPartyIntegration.smali`
	2. `ForegroundService.smali`
	3. `CrashReportUtil.smali`
	4. `APKExtractor.smali`
3. Rename the Downloaded APK to `original.apk`
4. Copy the `original.apk` into the Folder `assets` in the `librelink` folder

## Rebuild the APK

1. In the Prompt/Shell move into the folder, which contains the `librelink` folder
2. Use apktool to rebuild the APK: `apktool b -o librelink.apk librelink`
3. Generate a Signing keystore: `keytool -genkey -v -keystore librelink.keystore -alias librelink -keyalg RSA -keysize 2048 -validity 10000`
	1. Fill in the necessary informations. You must enter two passwords, one for the keystore, one for the key, you should note them down! I prefer to use rather simple passwords like both times `librelink` as this keystore is only for the resigned app
	2. **If this fails, please install current java developer tools like [this](https://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)**
	3. If you need to update the App later, omit this step, as the keystore is now available.
4. Sign the APK: `jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore librelink.keystore librelink.apk librelink`. If the jarsigner is not found in Windows, please check that your java variables are setup correctly, like described [here](https://stackoverflow.com/questions/1672281/environment-variables-for-java-installation)

## Install the new APK
5. Uninstall the current librelink app on the phone.
6. Copy the generated `librelink.apk` to your phone (USB, google drive, ... gmail will not work) and install it.

## Finished
**Open the app, go to "Alarms" and give all necessary permissions that the app requests, or else the first sensor you will start with the app will not transmit any data via Bluetooth!!!** As an alternative, you can navigate to the app in your android-settings -> security and enbale there all permission (Location and Files)

If all Steps where succesfully executed, you will have now a patched librelink app, capable of sending its data to [xDrip](https://github.com/jamorham/xDrip-plus).

Wait for more informations about which Version/Patches you need for xDrip to get the Data to Display!
