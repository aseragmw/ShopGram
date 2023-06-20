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
    apiKey: 'AIzaSyDtXFF1iHO7LM5o_XcMlyjPjn_2aGKYT5U',
    appId: '1:718393624958:web:ea840af17e3af5e0f9cb2f',
    messagingSenderId: '718393624958',
    projectId: 'serag-shopgram',
    authDomain: 'serag-shopgram.firebaseapp.com',
    storageBucket: 'serag-shopgram.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDm6mxXKT7WTxtw2xd8TdS9GTTtdk6bm4',
    appId: '1:718393624958:android:38c2eeed7698bd07f9cb2f',
    messagingSenderId: '718393624958',
    projectId: 'serag-shopgram',
    storageBucket: 'serag-shopgram.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOjZk3ClgCk9YcN_m3-46t8pCXVZ0h3-w',
    appId: '1:718393624958:ios:886dd6c8d78211f9f9cb2f',
    messagingSenderId: '718393624958',
    projectId: 'serag-shopgram',
    storageBucket: 'serag-shopgram.appspot.com',
    iosClientId: '718393624958-1hqjshap08kjq263rt9htmelnam7an6t.apps.googleusercontent.com',
    iosBundleId: 'com.example.dbShop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDOjZk3ClgCk9YcN_m3-46t8pCXVZ0h3-w',
    appId: '1:718393624958:ios:886dd6c8d78211f9f9cb2f',
    messagingSenderId: '718393624958',
    projectId: 'serag-shopgram',
    storageBucket: 'serag-shopgram.appspot.com',
    iosClientId: '718393624958-1hqjshap08kjq263rt9htmelnam7an6t.apps.googleusercontent.com',
    iosBundleId: 'com.example.dbShop',
  );
}