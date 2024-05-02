import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cuse_cafe_connect/controller/TradeBoardController.dart';
import 'package:cuse_cafe_connect/model/UserModel.dart';
import 'package:cuse_cafe_connect/service/UserService.dart';
import 'package:cuse_cafe_connect/view/TradeBoardHome.dart';
import 'package:cuse_cafe_connect/view/TradeBoardManagerView.dart';
import 'package:cuse_cafe_connect/view/head_main_screen.dart';
import 'package:cuse_cafe_connect/view/supervisor_main_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crypto/crypto.dart';

import '../view/user_main_screen.dart';

class UserController {
  final UserService us = UserService();
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  TextEditingController suidController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordSignUpController = TextEditingController();
  TextEditingController reconfirmPasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String errorMessage = '';

  UserController() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  Future<void> loginUser(BuildContext context) async {
    String username = usernameController.text;
    String password = passwordController.text;

    String hashedPassword = sha256.convert(utf8.encode(password)).toString();
    print(hashedPassword);
    UserModel? res = await us.loginUser(username, hashedPassword);
    if (res != null) {
      await saveUserDataInCache(res.userID, res.roleID);
      handleLoginSuccess(context);
    } else {
      handleLoginFailure(context, 'Login failed');
    }
  }

  Future<UserModel?> getProfileDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('userId') ?? 1234;
    UserModel? res = await us.getProfileDetails(userId);
    if (res != null) {
      print("User id : ${res?.userID.toString() ?? ""}");
      return res;
    }
    return null;
  }

  Future<bool> updateProfileDetails(int userID,String email,String fName,String lName,String phoneNo,File? photoPath,) async {
    return us.updateUserDetails(userID,email,fName,lName,phoneNo,photoPath,);
  }

  Future<void> saveUserDataInCache(int? userId, int? roleId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId ?? 1234);
    await prefs.setInt('roleId', roleId ?? 3);
  }
  void handleLoginSuccess(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
    } else if (userRole == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HeadMainScreen()),
      );
    }
  }

  void handleLoginFailure(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  Future<bool> signUp() async {
    String suid = suidController.text;
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String email = emailController.text;
    String password = passwordSignUpController.text;
    String reconfirmPassword = reconfirmPasswordController.text;
    String phoneNumber = phoneNumberController.text;

    if (suid.isEmpty ||
        firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        reconfirmPassword.isEmpty ||
        phoneNumber.isEmpty) {
      errorMessage = 'Please fill all fields';
      return false;
    }

    if (password != reconfirmPassword) {
      errorMessage = 'Passwords do not match';
      return false;
    }
    errorMessage = '';
    String hashedPassword = sha256.convert(utf8.encode(password)).toString();
    bool res = await us.signupUser(
        suid, firstName, lastName, email, hashedPassword, phoneNumber);
    if (!res) {
      errorMessage = 'Please try again later';
    }
    return res;
  }
}