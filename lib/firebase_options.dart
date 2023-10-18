// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB043UhS0iY5rPAOhuL5Tw_e1SvIEQEJLQ',
    appId: '1:360238320558:web:b7cf749c32de982978963f',
    messagingSenderId: '360238320558',
    projectId: 'database-cordova-a0a14',
    authDomain: 'database-cordova-a0a14.firebaseapp.com',
    storageBucket: 'database-cordova-a0a14.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0D9lCrSE9IT6P0h9nuFABI4Yvho1ot24',
    appId: '1:360238320558:android:e5f12c5c191fda0d78963f',
    messagingSenderId: '360238320558',
    projectId: 'database-cordova-a0a14',
    storageBucket: 'database-cordova-a0a14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHaJHRRn6ctJT8NyNgivC2vkvHQFod6Eg',
    appId: '1:360238320558:ios:64b9ff2eb8d44c1c78963f',
    messagingSenderId: '360238320558',
    projectId: 'database-cordova-a0a14',
    storageBucket: 'database-cordova-a0a14.appspot.com',
    iosBundleId: 'com.example.flutterApplicationCordova',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHaJHRRn6ctJT8NyNgivC2vkvHQFod6Eg',
    appId: '1:360238320558:ios:64b9ff2eb8d44c1c78963f',
    messagingSenderId: '360238320558',
    projectId: 'database-cordova-a0a14',
    storageBucket: 'database-cordova-a0a14.appspot.com',
    iosBundleId: 'com.example.flutterApplicationCordova',
  );
}