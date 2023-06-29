import 'package:flutter/material.dart';
import 'package:snabbudget/utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


import '../utils/custom_drawer.dart';

class Debt extends StatefulWidget {
  const Debt({super.key});

  @override
  State<Debt> createState() => _DebtState();
}

class _DebtState extends State<Debt> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        drawer: const CustomDrawer(),
        backgroundColor: Colors.grey[100],
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const ExpandableFloatingActionButton(),
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Card(
             // color: bgcolor,
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
                      "Debts",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ).pSymmetric(h: 130),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.residualAmount,
                  style: const TextStyle(fontSize: 22),
                ),
                const Text(
                  "\$0.00",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ).pSymmetric(h: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Card(
                  elevation: 5,
                  child: Container(
                    height: height / 3,
                    width: width,
                    decoration: BoxDecoration(
                        color: bgcolor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ).p(20),
            )
          ],
        ),
      ),
    );
  }

  // Drawer CustomDrawer() {
  //   return Drawer(
  //     child: Container(
  //       decoration: BoxDecoration(
  //         gradient: LinearGradient(
  //           colors: [
  //             gradient1,
  //             gradient2,
  //           ],
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Column(children: [
  //             const Padding(
  //               padding: EdgeInsets.only(top: 55.0, bottom: 20),
  //               child: Text("Snabb",
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold)),
  //             ),
  //             const Divider(
  //               color: Colors.white,
  //               thickness: 2,
  //               indent: 40,
  //               endIndent: 40,
  //             ),
  //             const SizedBox(
  //               height: 20,
  //             ),
  //             drawerTile("assets/images/home-icon.png", "Dashboard"),
  //             drawerTile("assets/images/user.png", "Accounts"),
  //             drawerTile("assets/images/dollar.png", "Debt"),
  //             drawerTile("assets/images/box.png", "Budget"),
  //             drawerTile("assets/images/calender.png", "Calendar"),
  //             drawerTile("assets/images/clock.png", "Scheduled Transactions"),
  //             drawerTile("assets/images/settings.png", "Settings"),
  //             drawerTile("assets/images/settings-2.png", "Preferences"),
  //           ]),
  //           const Column(
  //             children: [
  //               Divider(
  //                 color: Colors.white,
  //                 thickness: 2,
  //                 indent: 40,
  //                 endIndent: 40,
  //               ),
  //               ListTile(
  //                   leading: Icon(
  //                     Icons.logout_rounded,
  //                     color: Colors.white,
  //                     size: 38,
  //                   ),
  //                   title: Text(
  //                     "Logout",
  //                     style: TextStyle(fontSize: 14, color: Colors.white),
  //                   )),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ListTile drawerTile(String imgUrl, String title) {
  //   return ListTile(
  //       leading: ImageIcon(
  //         AssetImage(imgUrl),
  //         color: Colors.white,
  //         size: 38,
  //       ),
  //       title: Text(
  //         title,
  //         style: const TextStyle(fontSize: 14, color: Colors.white),
  //       ));
  // }

}

class ExpandableFloatingActionButton extends StatefulWidget {
  const ExpandableFloatingActionButton({super.key});

  @override
  _ExpandableFloatingActionButtonState createState() =>
      _ExpandableFloatingActionButtonState();
}

class _ExpandableFloatingActionButtonState
    extends State<ExpandableFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {
              // Handle first action
            },
            backgroundColor: const Color.fromRGBO(86, 111, 245, 1),
            heroTag: null,
            child: const ImageIcon(AssetImage("assets/images/transfer.png")),
          ),
        if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.red,
            child: const ImageIcon(AssetImage("assets/images/minus.png")),
          ),
        if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                  child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(46, 166, 193, 1),
                onPressed: _toggleExpanded,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                //  heroTag: null,
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: _animation,
                ),
              ))),
        ),
      ],
    );
  }
}
