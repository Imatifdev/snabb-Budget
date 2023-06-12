// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/signup.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
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
        )
//           LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,

//   // stops: const [
//   //   0.20,
//   //   0.40,
//   //   0.50,
//   //   0.60,
//   //   0.70,
//   //   0.80,
//   //   0.90,
//   //   1
//   //   ],
//   colors: const [
//     Color(0xFF335BAA),
//     Color(0xFF2E77BB),
//     Color(0xFF306CB5),
//     Color(0xFF2D7CBE),
//     Color(0xFF2C92C3),
//     Color(0xFF31C3B6),
//     Color(0xFF31C3B6),
//     Color(0xFFFBFF2B),
//   ],
// )
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
                    text: "Welcome !",
                  ),
                ).pOnly(top: 70),
              ),
            ),
            SizedBox(
              height: height / 12,
            ),
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: height / 3.3,
              width: width / 1.1,
              color: Colors.white,
            ),
            SizedBox(
              height: height / 12,
            ),
            MyButton(
              title: "Signup",
              onaction: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignupScreen()));
              },
            ),
            SizedBox(
              height: height / 50,
            ),
            CustomText(
              fontsize: 16,
              color: Colors.white,
              text: "Already have an account?",
            ).centered(),
            SizedBox(
              height: height / 50,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: CustomText(
                fontWeight: FontWeight.bold,
                fontsize: 14,
                color: Colors.white,
                text: "Sign in",
              ).centered(),
            ),
            SizedBox(
              height: height / 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  fontsize: 16,
                  color: simplefont,
                  text: "Continue without creating an account ",
                ).centered(),
                Icon(
                  CupertinoIcons.arrow_right_circle_fill,
                  color: Colors.grey.shade100,
                )
              ],
            ),
          ],
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        )),
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
