import 'package:cuse_cafe_connect/controller/UserController.dart';
import 'package:cuse_cafe_connect/view/SignUpView.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final UserController controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2), // Add some spacing at the top
            Center(
              child: Image.asset(
                'assets/login_image.png', // Replace with your image path
                height: 300, // Adjust the height as needed
              ),
            ),
            SizedBox(
                height: 20), // Add spacing between the image and the fields
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: controller.usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        alignLabelWithHint: true,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 60.0),
                  ElevatedButton(
                    onPressed: () {
                      controller.loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF76900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 100.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No Account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpView()),
                          );
                        },
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            color: Color(0xFFF76900),
                            //decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
