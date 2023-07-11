// // ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_const_constructors, curly_braces_in_flow_control_structures, unused_import, duplicate_import, use_build_context_synchronously

// import 'dart:async';
// import 'dart:math';
// import 'package:snabbudget/Screens/auth/forgot.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:snabbudget/Screens/auth/login.dart';
// import '../../../models/usermodel.dart';
// import '../../../utils/mycolors.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../utils/custom_drawer.dart';
// import 'editprofile.dart';

// class ProfileView extends StatefulWidget {
//   final String name;
//   final String email;
//   const ProfileView({super.key, required this.name, required this.email});
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   signOut() async {
//     await auth.signOut();
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => LoginScreen()));
//   }

//   late StreamSubscription subscription;
//   bool isDeviceConnected = false;
//   bool isAlertSet = false;

//   @override
//   void initState() {
//     getConnectivity();
//     super.initState();
//   }

//   getConnectivity() =>
//       subscription = Connectivity().onConnectivityChanged.listen(
//         (ConnectivityResult result) async {
//           isDeviceConnected = await InternetConnectionChecker().hasConnection;
//           if (!isDeviceConnected && isAlertSet == false) {
//             showDialogBox();
//             setState(() => isAlertSet = true);
//           }
//         },
//       );

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     // final controller = Get.put(ProfileController());
//     return Scaffold(
//       extendBody: true,
//       drawer: CustomDrawer(),
//       //backgroundColor: Colors.white,
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           }

//           if (!snapshot.hasData) {
//             return CircularProgressIndicator();
//           }

//           final data = snapshot.data!.data() as Map<String, dynamic>?;

//           if (data == null) {
//             return Text('No user data found.');
//           }

//           final name = data['name'] ?? '';
//           final email = data['email'] ?? '';

//           return
//       SingleChildScrollView(
//         child: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Card(
//               //   color: bgcolor,
//               //   elevation: 3,
//               //   child: Row(
//               //     children: [
//               //       IconButton(
//               //           onPressed: () {
//               //             _scaffoldKey.currentState?.openDrawer();
//               //           },
//               //           icon: const ImageIcon(
//               //             AssetImage("assets/images/menu.png"),
//               //             size: 40,
//               //           )),
//               //       ShaderMask(
//               //         shaderCallback: (bounds) => const LinearGradient(
//               //           colors: [Colors.black, Colors.black],
//               //         ).createShader(bounds),
//               //         child: const Text(
//               //           "Debts",
//               //           style: TextStyle(
//               //               color: Colors.white,
//               //               fontSize: 18,
//               //               fontWeight: FontWeight.bold),
//               //         ).pSymmetric(h: 130),
//               //       ),
//               //     ],
//               //   ),
//               // ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 30,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 1 / 40,
//               ),
//               CircleAvatar(
//                 radius: 50,
//                 child: Icon(
//                   Icons.person,
//                   size: 60,
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   widget.name,
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
//                 ),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 1 / 20,
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(children: [
//                   Container(
//                       height: MediaQuery.of(context).size.height / 11,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           color: bgcolor,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50)),
//                         child: ListTile(
//                           leading: Icon(Icons.person),
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Change Email",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               SizedBox(
//                                 child: Text(
//                                   widget.email,
//                                   softWrap: true,
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(CupertinoIcons.right_chevron),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (ctx) => EditProfile()));
//                             },
//                           ),
//                         ),
//                       )),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 50,
//                   ),
//                   Container(
//                     height: MediaQuery.of(context).size.height / 14,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                         color: bgcolor,
//                         borderRadius: BorderRadius.circular(50)),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50)),
//                       child: ListTile(
//                         leading: Icon(Icons.person),
//                         title: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "Change Name",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(
//                               widget.name,
//                               style: TextStyle(fontSize: 14),
//                             ),
//                           ],
//                         ),
//                         trailing: IconButton(
//                           icon: Icon(CupertinoIcons.right_chevron),
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (ctx) => EditProfile()));
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.of(context).size.height / 50,
//                   ),
//                   Container(
//                       height: MediaQuery.of(context).size.height / 14,
//                       width: MediaQuery.of(context).size.width,
//                       decoration: BoxDecoration(
//                           color: bgcolor,
//                           borderRadius: BorderRadius.circular(50)),
//                       child: Card(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(50)),
//                         child: ListTile(
//                           leading: Icon(Icons.person),
//                           title: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Change Pass",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Text(
//                                 "********",
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ],
//                           ),
//                           trailing: IconButton(
//                             icon: Icon(CupertinoIcons.right_chevron),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (ctx) => ForgitPassword()));
//                             },
//                           ),
//                         ),
//                       )),
//                 ]),
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 20,
//               ),
//               InkWell(
//                 onTap: () {
//                   signOut();
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           //signOut();
//                         },
//                         icon: Icon(
//                           Icons.logout_rounded,
//                           color: Colors.red,
//                           size: 40,
//                         )),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     const Text(
//                       "Log out",
//                       style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//         }
//       ));
//   }

// ignore_for_file: prefer_const_constructors

//   showDialogBox() => showCupertinoDialog<String>(
//         context: context,
//         builder: (BuildContext context) => CupertinoAlertDialog(
//           title: const Text('No Connection'),
//           content: const Text('Please check your internet connectivity'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context, 'Cancel');
//                 setState(() => isAlertSet = false);
//                 isDeviceConnected =
//                     await InternetConnectionChecker().hasConnection;
//                 if (!isDeviceConnected && isAlertSet == false) {
//                   showDialogBox();
//                   setState(() => isAlertSet = true);
//                 }
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/auth/login.dart';
import 'package:snabbudget/Screens/auth/forgot.dart';
import 'package:snabbudget/utils/mycolors.dart';

import 'editprofile.dart';

class ProfileView extends StatelessWidget {
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  ProfileView({Key? key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('UsersData')
            .doc(userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data;
          if (user == null) {
            return Text('User not found');
          }

          final name = user['First Name'];
          final email = user['Email'];

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 30.0),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Change Email',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    email,
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Change Name',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    name,
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Change Password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '********',
                    style: TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgitPassword()),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                InkWell(
                  onTap: () => _signOut(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                        size: 40,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Log out',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
