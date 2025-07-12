import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  // Firebase API Key (example - replace with actual key)
  static const String apiKey =
      'AIzaSyDconZaCQpkxIJ5KQBF-3tEU0rxYsLkIe8'; // This is your Android app's specific API key
  static const String authDomain = 'appointment-app-27389.firebaseapp.com';
  static const String projectId = 'appointment-app-27389';
  static const String storageBucket =
      'appointment-app-27389.firebasestorage.app';
  static const String messagingSenderId =
      '522858668544'; // This is your Project Number
  static const String appId =
      'YOUR_ANDROID_APP_ID_FROM_FIREBASE_CONSOLE'; // You'll get this unique ID after registering your Android app in the console
  static const String measurementId =
      'YOUR_MEASUREMENT_ID_FROM_FIREBASE_CONSOLE'; // This Google Analytics ID is generated when you register your app

  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
        measurementId: measurementId,
      ),
    );
  }
}
