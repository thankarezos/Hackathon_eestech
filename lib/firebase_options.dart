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
    apiKey: 'AIzaSyCvgmI-sqP_yZiTwuroumraOR1qredh4vU',
    appId: '1:1002206222994:web:56e9948bb04eae8a21244b',
    messagingSenderId: '1002206222994',
    projectId: 'firstflutter-9b67d',
    authDomain: 'firstflutter-9b67d.firebaseapp.com',
    storageBucket: 'firstflutter-9b67d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-zDD3wiGldsrSKw98Kkbil8XGfVIJkg4',
    appId: '1:1002206222994:android:3693a89df5053a8221244b',
    messagingSenderId: '1002206222994',
    projectId: 'firstflutter-9b67d',
    storageBucket: 'firstflutter-9b67d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD022YcrX3Lficj1rXy4fhOxYsZh8ySaOY',
    appId: '1:1002206222994:ios:7bce597838b8329921244b',
    messagingSenderId: '1002206222994',
    projectId: 'firstflutter-9b67d',
    storageBucket: 'firstflutter-9b67d.appspot.com',
    iosClientId: '1002206222994-9fl6p8gjbq32u3tu8j0kr5oi6r4tjb4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.helloOk',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD022YcrX3Lficj1rXy4fhOxYsZh8ySaOY',
    appId: '1:1002206222994:ios:7bce597838b8329921244b',
    messagingSenderId: '1002206222994',
    projectId: 'firstflutter-9b67d',
    storageBucket: 'firstflutter-9b67d.appspot.com',
    iosClientId: '1002206222994-9fl6p8gjbq32u3tu8j0kr5oi6r4tjb4i.apps.googleusercontent.com',
    iosBundleId: 'com.example.helloOk',
  );
}
