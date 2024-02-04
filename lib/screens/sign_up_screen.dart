import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../resources/auth_methods.dart';
import '../utils/snack_bar.dart';
import '../widgets/text_field_input.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  Uint8List? selctedImage;
  bool isloading = false;

  Future<void> pickProfileImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) return;

    selctedImage = kIsWeb
        ? await image.readAsBytes()
        : await File(image.path).readAsBytes();
    setState(() {});
  }

  Future<void> signUp() async {
    isloading = true;
    setState(() {});
    String res = await AuthMethods().signupUser(
      email: emailController.text,
      pass: passController.text,
      bio: bioController.text,
      userName: userNameController.text,
      image: selctedImage!,
    );
    isloading = false;
    setState(() {});

    if (res == 'success') {
      log('user is looged in');
    } else {
      showSnackBar(context: context, content: res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/ic_instagram.svg',
                  color: Colors.white,
                ),

                const SizedBox(height: 60),

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    selctedImage == null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.blue.shade400,
                            child: const Center(
                              child: Icon(
                                Icons.attribution_rounded,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(
                              selctedImage!,
                            ),
                          ),
                    Positioned(
                      bottom: -5,
                      right: 2,
                      child: IconButton(
                        color: blueColor,
                        onPressed: () async {
                          await pickProfileImage();
                        },
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextFieldInput(
                  controller: userNameController,
                  hintText: 'Enter your Username',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                TextFieldInput(
                  controller: bioController,
                  hintText: 'Enter your bio',
                  textInputType: TextInputType.text,
                ),
                const SizedBox(height: 30),

                //Button

                isloading == true
                    ? const Center(child: CircularProgressIndicator())
                    : GestureDetector(
                        onTap: () async {
                          await signUp();
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
                  text: const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: 'Signup',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
