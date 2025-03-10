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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyC0_cljvluXT5a1Z_7bmior0II107ARlUE',
    appId: '1:270982984976:web:62c4d03cc8a3c2f54e6195',
    messagingSenderId: '270982984976',
    projectId: 'notesapp-c4858',
    authDomain: 'notesapp-c4858.firebaseapp.com',
    storageBucket: 'notesapp-c4858.firebasestorage.app',
    measurementId: 'G-95STBE1FPW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD8KGHwhHa43VunAN9xFj_pjlKetgUiHXE',
    appId: '1:270982984976:android:39795b97e58454c44e6195',
    messagingSenderId: '270982984976',
    projectId: 'notesapp-c4858',
    storageBucket: 'notesapp-c4858.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuPfAXpCFwMe2wb6O8ZzzEWGgXXfUe1uc',
    appId: '1:270982984976:ios:4c0211f828948b204e6195',
    messagingSenderId: '270982984976',
    projectId: 'notesapp-c4858',
    storageBucket: 'notesapp-c4858.firebasestorage.app',
    iosBundleId: 'com.example.firebaseValidationTask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC0_cljvluXT5a1Z_7bmior0II107ARlUE',
    appId: '1:270982984976:web:f7611c69010f16be4e6195',
    messagingSenderId: '270982984976',
    projectId: 'notesapp-c4858',
    authDomain: 'notesapp-c4858.firebaseapp.com',
    storageBucket: 'notesapp-c4858.firebasestorage.app',
    measurementId: 'G-KKCJ2VDWKW',
  );
}
