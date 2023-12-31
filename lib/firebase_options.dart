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
    apiKey: 'AIzaSyAcezwDsu5oCKgAASQPLLN5qrO_BoUcASs',
    appId: '1:326398993054:web:9922ee97b3cbfd5271d18f',
    messagingSenderId: '326398993054',
    projectId: 'travelmate-a7b2e',
    authDomain: 'travelmate-a7b2e.firebaseapp.com',
    storageBucket: 'travelmate-a7b2e.appspot.com',
    measurementId: 'G-YEV70ENZ4C',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4C334WGd_7nXtFs6tNpCDNtFhnQpzvyE',
    appId: '1:326398993054:android:8d5f516437caa2fd71d18f',
    messagingSenderId: '326398993054',
    projectId: 'travelmate-a7b2e',
    storageBucket: 'travelmate-a7b2e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBAThFlxWlcR6DAncUs6VDhSVZVz-JYMSk',
    appId: '1:326398993054:ios:ab318d8f976ed7f371d18f',
    messagingSenderId: '326398993054',
    projectId: 'travelmate-a7b2e',
    storageBucket: 'travelmate-a7b2e.appspot.com',
    iosBundleId: 'com.example.travelmatex',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBAThFlxWlcR6DAncUs6VDhSVZVz-JYMSk',
    appId: '1:326398993054:ios:ec8479f446e080e871d18f',
    messagingSenderId: '326398993054',
    projectId: 'travelmate-a7b2e',
    storageBucket: 'travelmate-a7b2e.appspot.com',
    iosBundleId: 'com.example.travelmatex.RunnerTests',
  );
}
