import 'package:cuse_cafe_connect/firebase_options.dart';
import 'package:cuse_cafe_connect/view/LoginView.dart';
import 'package:cuse_cafe_connect/view/main_screen.dart';
import 'package:cuse_cafe_connect/view/splash_screen.dart';
import 'package:cuse_cafe_connect/view/stu_cafe_group_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
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
