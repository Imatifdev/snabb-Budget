// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_element, no_leading_underscores_for_local_identifiers, avoid_print, use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snabbudget/Screens/auth/signup.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../models/loginviewmodel.dart';
import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool obsCheck = false;

  bool _isLoggingIn = false;

  final LoginViewModel _loginVM = LoginViewModel();

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
        Navigator.of(context).pushNamed(HomeScreen.routeName);
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
                InkWell(
                    splashColor: Colors.white,
                    onTap: _isLoggingIn
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoggingIn = true;
                              });
                              bool isLoggedIn = await _loginVM.login(
                                  _emailController.text,
                                  _passwordController.text);
                              setState(() {
                                _isLoggingIn = false;
                              });
                              if (!isLoggedIn) {
                                Fluttertoast.showToast(
                                  msg: 'Invalid email or password',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              } else {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => HomeScreen()),
                                    (Route<dynamic> route) => false);
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
                      child: _isLoggingIn
                          ? CircularProgressIndicator().centered()
                          : Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ).centered(),
                    )),
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
