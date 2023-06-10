import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/balance.dart';
import 'package:snabbudget/Screens/dashboard_screen.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/Screens/setting_screen.dart';
import 'package:snabbudget/Screens/summary_screen.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';

import 'mycolors.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              const Padding(
                padding: EdgeInsets.only(top: 55.0, bottom: 20),
                child: Text("Snabb",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              const Divider(
                color: Colors.white,
                thickness: 2,
                indent: 40,
                endIndent: 40,
              ),
              const SizedBox(
                height: 20,
              ),
              drawerTile(context,"assets/images/home-icon.png", "Dashboard", HomeScreen.routeName),
              drawerTile(context,"assets/images/user.png", "Accounts",""),
              drawerTile(context,"assets/images/dollar.png", "Dept", BalanceScreen.routeName),
              drawerTile(context,"assets/images/box.png", "Budget",""),
              drawerTile(context,"assets/images/calender.png", "Calendar",""),
              drawerTile(context,"assets/images/minus.png", "Summary",SummaryScreen.routeName),
              drawerTile(context,"assets/images/transfer.png", "Transactions",TransactionsScreen.routeName),
              drawerTile(context,"assets/images/clock.png", "Scheduled Transactions",""),
              drawerTile(context,"assets/images/settings.png", "Settings",SettingScreen.routeName),
              drawerTile(context,"assets/images/settings-2.png", "Preferences",""),
            ]),
            const Column(
              children: [
                Divider(
                  color: Colors.white,
                  thickness: 2,
                  indent: 40,
                  endIndent: 40,
                ),
                ListTile(
                    leading: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                      size: 38,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ListTile drawerTile(BuildContext context, String imgUrl, String title, String routeName) {
    return ListTile(
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
          size: 38,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
         ),
        onTap:(){
          Navigator.of(context).pushNamed(routeName);
        },
      );
  }
}
