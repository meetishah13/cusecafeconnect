import 'dart:io'; // Import 'dart:io' for Platform class
import 'package:cuse_cafe_connect/firebase_options.dart';
import 'package:cuse_cafe_connect/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared preferences

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setPlatformInCache(); // Set platform in cache
  runApp(MyApp());
}

Future<void> setPlatformInCache() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // if (Platform.isAndroid) {
  //   await prefs.setString('platform', 'android');
  // } else if (Platform.isIOS) {
  //   await prefs.setString('platform', 'ios');
  // }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
