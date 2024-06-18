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
    apiKey: 'AIzaSyCe92rWBbEtscPGUmICi8NWnrLQWL6C8oE',
    appId: '1:1019656392452:web:52862e0c1ebb4a170fca51',
    messagingSenderId: '1019656392452',
    projectId: 'trackingapp-8c90f',
    authDomain: 'trackingapp-8c90f.firebaseapp.com',
    databaseURL: 'https://trackingapp-8c90f-default-rtdb.firebaseio.com',
    storageBucket: 'trackingapp-8c90f.appspot.com',
    measurementId: 'G-RH7GMNJMJ6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwCoDqpmP9vVvU3oLzU9eqmQf3LmCP6yg',
    appId: '1:1019656392452:android:156a2e2fdef67e710fca51',
    messagingSenderId: '1019656392452',
    projectId: 'trackingapp-8c90f',
    databaseURL: 'https://trackingapp-8c90f-default-rtdb.firebaseio.com',
    storageBucket: 'trackingapp-8c90f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDUp7aElmpWG-PbIidgAzT27dzAlXFqiZ8',
    appId: '1:1019656392452:ios:f7ed7b892db7b1920fca51',
    messagingSenderId: '1019656392452',
    projectId: 'trackingapp-8c90f',
    databaseURL: 'https://trackingapp-8c90f-default-rtdb.firebaseio.com',
    storageBucket: 'trackingapp-8c90f.appspot.com',
    iosClientId: '1019656392452-if8s8gfjb94grrhrnnc7j3nsm7trdd5h.apps.googleusercontent.com',
    iosBundleId: 'com.gosure.cggBaseProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDUp7aElmpWG-PbIidgAzT27dzAlXFqiZ8',
    appId: '1:1019656392452:ios:f7ed7b892db7b1920fca51',
    messagingSenderId: '1019656392452',
    projectId: 'trackingapp-8c90f',
    databaseURL: 'https://trackingapp-8c90f-default-rtdb.firebaseio.com',
    storageBucket: 'trackingapp-8c90f.appspot.com',
    iosClientId: '1019656392452-if8s8gfjb94grrhrnnc7j3nsm7trdd5h.apps.googleusercontent.com',
    iosBundleId: 'com.gosure.cggBaseProject',
  );
}
