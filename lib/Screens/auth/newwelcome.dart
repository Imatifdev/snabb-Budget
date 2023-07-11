// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'login.dart';
import 'newsignup.dart';

class NewWelcome extends StatelessWidget {
  const NewWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffe1e6ef),
      body: Column(
        children: [
          SizedBox(
            height: size / 10,
          ),
          Image(
            fit: BoxFit.contain,
            width: width,
            height: size / 2.8,
            image: AssetImage('assets/images/1.png'),
          ),
          SizedBox(
            height: size / 8,
          ),
          Text(
            "Snabb Budget",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: size / 30,
          ),
          Text(
            'Most budget apps offer a variety of features and tools to help users reach their financial goals, such as setting savings goals, tracking progress, and providing insights your financial goals.',
            textAlign: TextAlign.center,
          ).pSymmetric(h: 20),
          SizedBox(
            height: size / 8,
          ),
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => NewSignupScreen()));
                  },
                  child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white),
                        child: Text("Register").centered(),
                      ))).expand(),
              InkWell(
                 onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => LoginScreen()));
                  },
                 
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xffe9ebf3)),
                      child: Text("Sign In").centered(),
                    ))
              ).expand(),
            ],
          ).pSymmetric(h: 20),
        ],
      ),
    );
  }
}
