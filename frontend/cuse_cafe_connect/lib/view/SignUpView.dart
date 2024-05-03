import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/view/LoginView.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter the details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/login_image.png', // Replace with your image path
                  height: 250, // Adjust the height as needed
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.suidController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '9 Digit SUID',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.firstNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'First Name',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.lastNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Last Name',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.emailController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email ID',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.passwordSignUpController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  obscureText: true,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.reconfirmPasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Reconfirm Password',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  obscureText: true,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _controller.phoneNumberController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.only(left: 16),
                  ),
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 7.0),
              Text(
                _controller.errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 7.0),
              ElevatedButton(
                onPressed: () async {
                  bool res = await _controller.signUp();
                  if (!res) {
                    setState(() {});
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF76900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
