# native_updater

Forked from [ofload/native_updater](https://github.com/ofload/native_updater "Original package")

> Flutter package for prompting users to update with a native dialog whether using the app store version or any version at the user's discretion.

When a latest app version is available via user defined logic, a simple alert prompt widget is displayed. With today's modern app stores, there is little need to persuade users to update because most of them are already using the auto update feature. However, there may be times when an app needs to be updated more quickly than usual, and nagging a user to update will entice the update sooner.

The UI comes in two flavors: Material Design for Android and Cupertino for iOS. The [UpdateMaterialAlert](#material-alert-example) widget is used to display the native Android alert prompt, and the [UpdateCupertinoAlert](#cupertino-alert-example) widget is used to display the native iOS alert prompt.

## Installation via GitHub

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Add the follwing line inside pubspec.yaml:
  native_updater:
    git: https://github.com/Jeferson505/native_updater.git
```

## Setup

### Android

Already good to go.

### iOS

To be able to show your App Name in the Cupertino Alert Dialog, add the following key, if there isn't, to your _Info.plist_ file, located in `<project root>/ios/Runner/Info.plist`:

```xml
<key>CFBundleDisplayName</key>
<string>YOUR APP NAME</string>
```

## Usage

Just add this code whenever you want to display the update alert, and it will handle the rest.

```dart
NativeUpdater.displayUpdateAlert(
  context,
  forceUpdate: true,
);
```

Or with the optional parameters to customize the alert.

```dart
NativeUpdater.displayUpdateAlert(
  context,
  forceUpdate: true,
  appStoreUrl: '<Your App Store URL>',
  iOSDescription: '<Your iOS Description>',
  iOSUpdateButtonLabel: '<Your iOS Update Button Label>',
  iOSCloseButtonLabel: '<Your iOS Close Button Label>',
  iOSIgnoreButtonLabel: '<Your iOS Ignore Button Label>',
  iOSAlertTitle: '<Your Dialog Title>',
);
```

## Parameters Explanation

### Required Parameters

**context** is the location in the tree where this widget builds.

**forceUpdate** is to tell whether the alert is forcing an update or not. Set to `true` if you are forcing an update. Set to `false` if you are giving an option to update later.

### Optional Parameters

**appStoreUrl** is to launch your App Store URL if you're developing for iOS. Follow this [link](https://support.google.com/admob/answer/3086746?hl=en "Find your app store URL") on how to find your App Store URL.

**iOSDescription** is to use your custom alert description on `UpdateCupertinoAlert`. The default is `<App Name> requires that you update to the latest version. You cannot use this app until it is updated.` or `<App Name> recommends that you update to the latest version. You can keep using this app while downloading the update.`

**iOSUpdateButtonLabel** is used to set your custom Update Button Label on `UpdateCupertinoAlert`. The default is `Update`.

**iOSCloseButtonLabel** is used to set your custom Close Button Label on`UpdateCupertinoAlert`. The default is `Close App`.

**iOSIgnoreButtonLabel** is used to set  your custom Ignore Button Label on`UpdateCupertinoAlert`. The default is `Later`.

**iOSAlertTitle** is used to set your custom Dialog Title on`UpdateCupertinoAlert`. The default is `Update Available`.

## Full Example

```dart
import 'package:flutter/material.dart';
import 'package:native_updater/native_updater.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'native_updater example',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    checkVersion();
  }

  Future<void> checkVersion() async {
    /// For example: You got status code of 412 from the
    /// response of HTTP request.
    /// Let's say the statusCode 412 requires you to force update
    int statusCode = 412;

    /// This could be kept in our local
    int localVersion = 9;

    /// This could get from the API
    int serverLatestVersion = 10;

    Future.delayed(Duration.zero, () {
      if (statusCode == 412) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: true,
          appStoreUrl: '<Your App Store URL>',
          iOSDescription: '<Your iOS description>',
          iOSUpdateButtonLabel: 'Upgrade',
          iOSCloseButtonLabel: 'Exit',
          errorText: "Error",
          errorCloseButtonLabel: "Close",
          errorSubtitle: "This app version wasn't downloaded from Play Store",
        );
      } else if (serverLatestVersion > localVersion) {
        NativeUpdater.displayUpdateAlert(
          context,
          forceUpdate: false,
          appStoreUrl: '<Your App Store URL>',
          iOSDescription: '<Your description>',
          iOSUpdateButtonLabel: 'Upgrade',
          iOSIgnoreButtonLabel: 'Next Time',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your App'),
      ),
      body: const Center(
        child: Text('Native Updater Example'),
      ),
    );
  }
}
```

## Screenshots of Material Alert

### An example of a flexible update flow

![image](screenshots/android_flexible_flow.png)

### An example of an immediate update flow

![image](screenshots/android_immediate_flow.png)

## Screenshots of Cupertino Alert

|                 Force Update                  |               Can Update Later                |
| :-------------------------------------------: | :-------------------------------------------: |
| ![image](screenshots/cupertino_example_1.png) | ![image](screenshots/cupertino_example_2.png) |
