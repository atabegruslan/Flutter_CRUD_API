# Travel Blog Android App

## Related Projects

- This is the Laravel part of https://github.com/atabegruslan/Laravel_CRUD_API
- This is an update of https://github.com/Ruslan-Aliyev/Android_CRUD_API

## Counterparts

| Java  | Kotlin  | Flutter  | ReactNative  |
|---|---|---|---|
|   |   | [this](https://github.com/atabegruslan/Flutter_CRUD)  |   |

## Building blocks

https://github.com/atabegruslan/Others/blob/master/Mobile/android_building_blocks.md

## Other Info about this

### Setup Flutter (Mac)

https://flutter.dev/docs/get-started/install/macos

- Have Java & AndroidStudio
- Download Flutter
	- `cd Applications`
	- `git clone https://github.com/flutter/flutter.git`
	- `sudo chmod 777 flutter`
	- Add `flutter` to path
		- preferably: `nano ~/.bash_profile`, `export PATH=/Users/ruslan/Applications/flutter/bin:$PATH`, `source $HOME/.bash_profile`
		- or: `export PATH="$PATH:pwd/flutter/bin"`
		- or: `nano /etc/paths`, `/Users/ruslan/Applications/flutter/bin`
- In AndroidStudio's Package Manager
	- Get DART plugin
	- Get Flutter Plugin

### Setup Flutter (Windows)

https://flutter.dev/docs/get-started/install/windows

- Have Java & AndroidStudio
- Download Flutter
	- `git clone https://github.com/flutter/flutter.git` in `C:\`
	- Add `C:/flutter/bin;` to user env path
- In AndroidStudio's Package Manager
	- Get DART plugin
	- Get Flutter Plugin

### Useful commands that you can now run

- Check if you can use the flutter command: `flutter` or `flutter --version`
- See your devices: `flutter devices` 
- Check that all the requirement of flutter development is met: `flutter doctor` 
- Helpful for debugging: `flutter doctor -v`
- Helpful for debugging: `flutter run --verbose`

Note: For Windows, these are better ran in PowerShell 5+.

### Start Flutter Project

Open AndroidStudio, file, new, chose *new flutter project* . 

If you chose 'new project', you'd start to develop Android apps using Java the old fashioned way. (or Kotlin if you have the Kotlin plugin and ticked 'include Kotlin support' in the start-new-project wizard)

### Making this project

- Chopper: https://github.com/Ruslan-Aliyev/Flutter_Chopper
- Dummy API: https://reqres.in/
- Handle Responses: https://medium.com/@boylenssen/converting-the-response-from-chopper-to-an-object-642fd46608ff
- Multiple Providers: https://codewithandrea.com/videos/advanced-provider-tutorial-part2/

### Publishing APK

- https://www.youtube.com/watch?v=g1fByAsqQRk&list=PLMQAFLQy-nKch8Tk31y4i6MxMI9V9C-XO&index=5
- https://flutter.dev/docs/deployment/android
