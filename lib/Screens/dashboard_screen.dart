// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:shimmer/shimmer.dart';

// class DashboardScreen extends StatelessWidget {
//   DashboardScreen({super.key});
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Card(
//                 elevation: 3,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           _scaffoldKey.currentState?.openDrawer();
//                         },
//                         icon: const Icon(Icons.menu)),
//                     Container(
//                       child: Shimmer.fromColors(
//                           baseColor: Color(0xff9B710F),
//                           highlightColor: Color(0xffFFE62E),
//                           period: Duration(milliseconds: 1200),
//                           child: Text(
//                             'Shimmer Text',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )),
//                     ),
//                     IconButton(
//                         onPressed: () {}, icon: const Icon(Icons.notifications))
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: Card(
//                   color: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Column(
//                               children: [
//                                 Text(
//                                   "Total Amount",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 18),
//                                 ),
//                                 Text(
//                                   "\$523.82",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.menu_open_rounded,
//                                   size: 35,
//                                   color: Colors.white,
//                                 ))
//                           ],
//                         ),
//                         const Row(
//                           children: [
//                             //Icon(Icons.arrow_downward_rounded, size: 35,color: Colors.white,),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            // Close the drawer if it's open
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
          child: Stack(
            children: <Widget>[
              Container(
                  // Main content of your app
                  // ...
                  ),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () {
                    // Do nothing to prevent the tap event from propagating to the main content
                  },
                  child: Container(
                    width: 250.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(-2.0, 0.0),
                          blurRadius: 4.0,
                        ),
                      ],
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                          ),
                          child: Text(
                            'Drawer Header',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.home),
                          title: Text('Home'),
                          onTap: () {
                            // Handle home menu item tap
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                          onTap: () {
                            // Handle settings menu item tap
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.help),
                          title: Text('Help'),
                          onTap: () {
                            // Handle help menu item tap
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
