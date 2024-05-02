import 'dart:async';
import 'package:cuse_cafe_connect/view/LoginView.dart';
import 'package:cuse_cafe_connect/view/head_main_screen.dart';
import 'package:cuse_cafe_connect/view/supervisor_main_screen.dart';
import 'package:cuse_cafe_connect/view/user_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() {
  super.initState();
  Timer(Duration(seconds: 3), () {
    checkCacheAndNavigate();
  });
}

Future<void> checkCacheAndNavigate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int userId = prefs.getInt('userId') ?? -1;
  
  if (userId != -1) {
    print("User ID: $userId");
    int userRole = prefs.getInt('roleId') ?? 3;

    if (userRole == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserMainScreen()),
      );
    } else if (userRole == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SupervisorMainScreen()),
      );
    }else if (userRole == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HeadMainScreen()),
      );
    }
  } else {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/splash_back.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/splash_front.png', // Replace with your center image path
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
