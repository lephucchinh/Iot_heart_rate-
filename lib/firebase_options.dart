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
    apiKey: 'AIzaSyCjzfa1XRGh-D6vm6fgzrK6yIz8QT9hUpU',
    appId: '1:750638496295:web:5630b672a6a355d571ac02',
    messagingSenderId: '750638496295',
    projectId: 'iot-realtime-a0b41',
    authDomain: 'iot-realtime-a0b41.firebaseapp.com',
    storageBucket: 'iot-realtime-a0b41.appspot.com',
    measurementId: 'G-3LGNN5M9NZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCigNSL7tJrvGqetGvGgsVUYpfC0N15lrI',
    appId: '1:750638496295:android:76a667b97607b45f71ac02',
    messagingSenderId: '750638496295',
    projectId: 'iot-realtime-a0b41',
    storageBucket: 'iot-realtime-a0b41.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDX_gRUANWj1NBxAnJXayV9q-UzYqSCWn4',
    appId: '1:750638496295:ios:5fdfc1085b17721571ac02',
    messagingSenderId: '750638496295',
    projectId: 'iot-realtime-a0b41',
    storageBucket: 'iot-realtime-a0b41.appspot.com',
    iosBundleId: 'com.example.iotRealtime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDX_gRUANWj1NBxAnJXayV9q-UzYqSCWn4',
    appId: '1:750638496295:ios:f558f71759ad2fef71ac02',
    messagingSenderId: '750638496295',
    projectId: 'iot-realtime-a0b41',
    storageBucket: 'iot-realtime-a0b41.appspot.com',
    iosBundleId: 'com.example.iotRealtime.RunnerTests',
  );
}
