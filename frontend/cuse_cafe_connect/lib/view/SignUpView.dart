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
        title: Text('Please Fill in the Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller.suidController,
              decoration: InputDecoration(labelText: '9 Digit SUID'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.emailController,
              decoration: InputDecoration(labelText: 'Email ID'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.passwordSignUpController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.reconfirmPasswordController,
              decoration: InputDecoration(labelText: 'Reconfirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: _controller.phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 20.0),
            Text(
              _controller.errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 20.0),
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
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
