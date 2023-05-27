// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/signup.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';

import 'dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Perform login or further actions
        String email = _emailController.text;
        String password = _passwordController.text;
        // Process the login credentials
        print('Email: $email');
        print('Password: $password');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  stops: const [0.20, 0.40, 0.50, 0.60, 0.70, 0.80, 0.90, 1],
  colors: const [
    Color(0xFF335BAA),
    Color(0xFF2E77BB),
    Color(0xFF306CB5),
    Color(0xFF2D7CBE),
    Color(0xFF2C92C3),
    Color(0xFF31C3B6),
    Color(0xFF31C3B6),
    Color(0xFFFBFF2B),
  ],
)
            ),
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
                        text: "Sign In Now ",
                      ),
                    ).pOnly(top: 70),
                  ),
                ),
                SizedBox(
                  height: height / 12,
                ),
                Column(
                  children: [
                    TextFormField(
                      cursorColor: Colors.white,
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                      cursorColor: Colors.white,
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
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                  height: height / 4.3,
                ),
                MyButton(title: "SIGN IN", onaction: _submitForm),
                SizedBox(
                  height: height / 40,
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
                    text: 'Don\'t have an Account? ',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Signup',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
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
              ],
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
