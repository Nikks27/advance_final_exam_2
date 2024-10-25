// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCAg2yz787R8ev2lXW1tN1BbSetb_Rr-wU',
    appId: '1:637446039076:web:dc25cd13ca90bf6e905ab1',
    messagingSenderId: '637446039076',
    projectId: 'exam-7899b',
    authDomain: 'exam-7899b.firebaseapp.com',
    storageBucket: 'exam-7899b.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdC-f-MCCskY8Yr1PerMcqLcWKD5nWAII',
    appId: '1:637446039076:android:bd427b02e29c6f2b905ab1',
    messagingSenderId: '637446039076',
    projectId: 'exam-7899b',
    storageBucket: 'exam-7899b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD-bj-BdkY4UKQXj72_y8Jinfbo0RESIUk',
    appId: '1:637446039076:ios:482994df403580b3905ab1',
    messagingSenderId: '637446039076',
    projectId: 'exam-7899b',
    storageBucket: 'exam-7899b.appspot.com',
    iosBundleId: 'com.example.advanceFinalExam2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD-bj-BdkY4UKQXj72_y8Jinfbo0RESIUk',
    appId: '1:637446039076:ios:482994df403580b3905ab1',
    messagingSenderId: '637446039076',
    projectId: 'exam-7899b',
    storageBucket: 'exam-7899b.appspot.com',
    iosBundleId: 'com.example.advanceFinalExam2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAg2yz787R8ev2lXW1tN1BbSetb_Rr-wU',
    appId: '1:637446039076:web:471c9070866ba0e3905ab1',
    messagingSenderId: '637446039076',
    projectId: 'exam-7899b',
    authDomain: 'exam-7899b.firebaseapp.com',
    storageBucket: 'exam-7899b.appspot.com',
  );
}