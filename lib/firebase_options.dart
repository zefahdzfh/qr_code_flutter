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
    apiKey: 'AIzaSyChBh7aBd8kNFlurP_j6HPQsVUx1KmoTgQ',
    appId: '1:702287280880:web:4446a0722b29e05659e035',
    messagingSenderId: '702287280880',
    projectId: 'qr-code-pas',
    authDomain: 'qr-code-pas.firebaseapp.com',
    storageBucket: 'qr-code-pas.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpiQxU0Y9eutzREVQVZGyrLkE_gptDH14',
    appId: '1:702287280880:android:6601ff75ead81ef259e035',
    messagingSenderId: '702287280880',
    projectId: 'qr-code-pas',
    storageBucket: 'qr-code-pas.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCH8v6TRUOK0S_a3OT_G2rFdI6Rr0BD9TI',
    appId: '1:702287280880:ios:3915eef3d3b7264159e035',
    messagingSenderId: '702287280880',
    projectId: 'qr-code-pas',
    storageBucket: 'qr-code-pas.appspot.com',
    iosBundleId: 'com.example.qrCodePas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCH8v6TRUOK0S_a3OT_G2rFdI6Rr0BD9TI',
    appId: '1:702287280880:ios:3915eef3d3b7264159e035',
    messagingSenderId: '702287280880',
    projectId: 'qr-code-pas',
    storageBucket: 'qr-code-pas.appspot.com',
    iosBundleId: 'com.example.qrCodePas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyChBh7aBd8kNFlurP_j6HPQsVUx1KmoTgQ',
    appId: '1:702287280880:web:66a1106669f55bba59e035',
    messagingSenderId: '702287280880',
    projectId: 'qr-code-pas',
    authDomain: 'qr-code-pas.firebaseapp.com',
    storageBucket: 'qr-code-pas.appspot.com',
  );
}
