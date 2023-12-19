import 'package:flutter/material.dart';
import 'package:native_updater/native_updater.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'native_updater example',
      home: _Home(
        key: Key('home'),
      ),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<_Home> {
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
          errorSubtitle: "This version of the app isn't legit",
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
