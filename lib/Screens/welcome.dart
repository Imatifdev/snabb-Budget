// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
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
              height: height / 3.5,
              width: width / 1.3,
              color: Colors.white,
            ),
            SizedBox(
              height: height / 12,
            ),
            MyButton(
              title: "Signup",
              onaction: () {},
            ),
            SizedBox(
              height: height / 40,
            ),
            CustomText(
              fontsize: 16,
              color: Colors.white,
              text: "Already have an account?",
            ).centered(),
            SizedBox(
              height: height / 40,
            ),
            CustomText(
              fontWeight: FontWeight.bold,
              fontsize: 14,
              color: Colors.white,
              text: "Sign in",
            ).centered(),
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
