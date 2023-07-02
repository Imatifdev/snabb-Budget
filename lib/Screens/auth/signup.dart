// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_element, no_leading_underscores_for_local_identifiers, avoid_print, sort_child_properties_last, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/auth/verification.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/registerviewmodel.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _name = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final RegisterViewModel _registerVM = RegisterViewModel();

  String errMsg = "";
  bool _isSigningUp = false;

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return "null";
  }

  String _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return "null";
  }

  String _validatename(String value) {
    if (value.isEmpty) {
      return 'Please enter a name';
    }
    if (value.length < 3) {
      return 'Name should be valid';
    }
    return "null";
  }

  @override
  Widget build(BuildContext context) {
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Perform login or further actions
        String email = _emailController.text;
        String password = _passwordController.text;

        // Process the login credentials
        Navigator.of(context).pushNamed(HomeScreen.routeName);

        Navigator.push(context,
            MaterialPageRoute(builder: (ctx) => EmailVerificationScreen()));
        print('Email: $email');
        print('Password: $password');
      }
    }

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [
                0.2,
                0.31,
                0.31,
                0.51,
                0.51,
                0.95,
                0.95,
                1,
              ],
              colors: const [
                Color.fromRGBO(47, 110, 182, 1), // Dark blue
                Color.fromRGBO(47, 110, 182, 1), // Dark blue
                Color.fromRGBO(44, 133, 192, 1), // Blue
                Color.fromRGBO(44, 133, 192, 1), // Blue
                Color.fromRGBO(49, 194, 170, 1), // Sea green
                Color.fromRGBO(47, 183, 187, 1), // Sea green
                Colors.yellow, // Yellow
                Colors.yellow, // Yellow
              ],
              tileMode: TileMode.clamp,
            )),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  VxArc(
                    height: 70,
                    edge: VxEdge.bottom,
                    child: Container(
                      height: height / 3.5,
                      width: width,
                      color: Colors.white,
                      child: Center(
                        child: CustomText(
                          fontWeight: FontWeight.bold,
                          fontsize: 32,
                          color: font,
                          text: "Sign Up",
                        ),
                      ).pOnly(top: 70),
                    ),
                  ),
                  SizedBox(
                    height: height / 13,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          if (value.length < 3) {
                            return 'name should be valid';
                          }
                          return null;
                        },
                        controller: _name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            fillColor: Colors.white.withOpacity(0.2),
                            hintText: "Full Name",
                            hintStyle: TextStyle(color: simplefont),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true),
                      ),
                      SizedBox(
                        height: height / 34,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            fillColor: Colors.white.withOpacity(0.2),
                            hintText: "Email Address",
                            hintStyle: TextStyle(color: simplefont),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true),
                      ),
                      SizedBox(
                        height: height / 32,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                        obscureText: true,
                        controller: _passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            errorStyle: TextStyle(color: Colors.white),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            fillColor: Colors.white.withOpacity(0.2),
                            hintText: "Password ",
                            hintStyle: TextStyle(color: simplefont),
                            alignLabelWithHint: true,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true),
                      ),
                    ],
                  ).pSymmetric(h: 20),
                  SizedBox(
                    height: height / 7,
                  ),
                  InkWell(
                    splashColor: Colors.white,
                    onTap: _isSigningUp
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isSigningUp = true;
                              });
                              // call Firebase function to sign up user
                              bool isRegistered = false;
                              isRegistered = await _registerVM.register(
                                  _emailController.text.trim(),
                                  _passwordController.text.trim(),
                                  _name.text.trim());
                              if (isRegistered) {
                                var userId =
                                    FirebaseAuth.instance.currentUser!.uid;
                                await FirebaseFirestore.instance
                                    .collection("UsersData")
                                    .doc(userId)
                                    .set({
                                  "First Name": _name.text.trim(),
                                  "Email": _emailController.text.trim(),
                                });
                                await FirebaseFirestore.instance
                                    .collection("UserTransactions")
                                    .doc(userId)
                                    .collection("data")
                                    .doc("userData")
                                    .set({
                                  "balance": 0,
                                  "credit": 0,
                                  "dept": 0,
                                  "expense": 0,
                                  "income": 0,
                                  "cash": 0,
                                  "bankTransfer": 0,
                                  "creditCard": 0,
                                  "currency":"\$"
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) =>
                                            EmailVerificationScreen()),
                                    (Route<dynamic> route) => false);
                              } else {
                                setState(() {
                                  _isSigningUp = false;
                                  errMsg = _registerVM.message;
                                });
                              }
                            }
                          },
                    child: Container(
                      height: 40,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      child: _isSigningUp
                          ? const CircularProgressIndicator().centered()
                          : const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ).centered(),
                    ),
                  ),
                  SizedBox(
                    height: height / 42,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'By signing up you are accepting ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Terms and',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Conditions ',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'and',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: ' Privacy Policy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 35,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Already have an Account? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Sign in',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height / 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onaction;
  const MyButton({
    super.key,
    required this.title,
    required this.onaction,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.white,
      onTap: onaction,
      child: Container(
        height: 40,
        width: 300,
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: Colors.white),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double fontsize;
  final FontWeight? fontWeight;
  final Color? color;
  const CustomText(
      {super.key,
      required this.fontsize,
      this.fontWeight,
      required this.text,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}
