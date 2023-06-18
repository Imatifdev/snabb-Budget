import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../utils/custom_drawer.dart';
import '../../utils/custombtn.dart';
import '../../utils/customtextfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  //final TextEditingController _passController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  //final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  Future<void> updateUserData(String uid, String newUsername, String newEmail,
      String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'First Name': newUsername,
        'Email': newEmail,
      });
      print('Document updated successfully.');
    } catch (e) {
      print('Error updating document: $e');
    }
    await FirebaseFirestore.instance
        .collection('UsersData')
        .doc(uid)
        .set({'First Name': newUsername}, SetOptions(merge: true));
  }

  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Card(
                color: bgcolor,
                elevation: 3,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/menu.png"),
                          size: 40,
                        )),
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.black, Colors.black],
                      ).createShader(bounds),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ).pSymmetric(h: 110),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (value.length < 2) {
                          return 'Enter a valid name';
                        }
                        return null;
                      },
                      textEditingController: _nameController,
                      hintText: "Abc",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      textEditingController: _emailController,
                      hintText: "abc@gmail.com",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (value.length < 11) {
                          return 'Enter a valid phone num';
                        }
                        return null;
                      },
                      textEditingController: _mobilecontroller,
                      hintText: "2567388929",
                      textInputType: TextInputType.emailAddress,
                      action: TextInputAction.next,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyCustomButton(
                              title: "Cancel",
                              borderrad: 25,
                              onaction: () {
                                Navigator.pop(context);
                              },
                              color1: Colors.red,
                              color2: Colors.red,
                              width: MediaQuery.of(context).size.width),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: MyCustomButton(
                              title: "Save",
                              borderrad: 25,
                              onaction: () {
                                updateUserData(
                                    userId,
                                    _nameController.text,
                                    _emailController.text,
                                    _mobilecontroller.text);
                                Get.to(() => HomeScreen());
                                Get.snackbar(
                                    "Message", "Your has has been updated",
                                    snackPosition: SnackPosition.BOTTOM,
                                    colorText: Colors.black,
                                    backgroundColor: bgcolor);
                              },
                              color1: Colors.green,
                              color2: Colors.green,
                              width: MediaQuery.of(context).size.width),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
