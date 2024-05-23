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
    apiKey: 'AIzaSyB54taFHbbExyIubTVWDbUTY9zW8eV1H8Y',
    appId: '1:683515539892:web:9d6c2e3cc421abe3ecc2e1',
    messagingSenderId: '683515539892',
    projectId: 'currant-e9b8d',
    authDomain: 'currant-e9b8d.firebaseapp.com',
    storageBucket: 'currant-e9b8d.appspot.com',
    measurementId: 'G-DD66JD3HPD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB8nmlh4PRIFWfcvvpWc11MnIxCTIuNVy0',
    appId: '1:683515539892:android:bc7ac6157b52a708ecc2e1',
    messagingSenderId: '683515539892',
    projectId: 'currant-e9b8d',
    storageBucket: 'currant-e9b8d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGksKa6O9qtOSIxWYFUhAHV35ZliEf_WA',
    appId: '1:683515539892:ios:6092fb22dddb128eecc2e1',
    messagingSenderId: '683515539892',
    projectId: 'currant-e9b8d',
    storageBucket: 'currant-e9b8d.appspot.com',
    iosBundleId: 'com.example.currant',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGksKa6O9qtOSIxWYFUhAHV35ZliEf_WA',
    appId: '1:683515539892:ios:3f822a42f87fa6e8ecc2e1',
    messagingSenderId: '683515539892',
    projectId: 'currant-e9b8d',
    storageBucket: 'currant-e9b8d.appspot.com',
    iosBundleId: 'com.example.currant.RunnerTests',
  );
}
