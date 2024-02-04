import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/screens/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/utils/snack_bar.dart';

import '../resources/auth_methods.dart';
import '../widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isloading = false;
  Future<void> loginUser() async {
    isloading = true;
    setState(() {});
    String res = await AuthMethods()
        .loginUser(email: emailController.text, pass: passController.text);

    isloading = false;

    if (res == 'success') {
      log('user is logged in');
    } else {
      showSnackBar(context: context, content: res);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: Colors.white,
              ),
              const SizedBox(height: 60),
              TextFieldInput(
                controller: emailController,
                hintText: 'Enter your Email',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFieldInput(
                controller: passController,
                isPass: true,
                hintText: 'Enter your Password',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),

              //Button

              isloading == true
                  ? const Center(child: CircularProgressIndicator())
                  : GestureDetector(
                      onTap: () async {
                        await loginUser();
                      },
                      child: Container(
                        child: Text('Login'),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: ShapeDecoration(
                            color: blueColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),

              const SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Signup',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignupScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
