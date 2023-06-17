import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = "preference-Screen";

  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(child: 
      SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               IconButton(
                            onPressed: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/images/menu.png"),
                              size: 40,
                            )),
                const Text(
                  "PREFERENCES",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 41,right: 30),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Basic Account", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  title: const Text("Current",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("Data Saved (On Device), \nDynamic Mobile App \nUnlimited Invoice Save \nAccess To All Categories"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Free", style: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Superior Account", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  //title: const Text("Current",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("All Services From Basic, \nCloud Data From Storage \nSuperior Support \nSuperior Integrations \nAnalysis Tools"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("5 Euro", style: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Elegant Account", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  //title: const Text("Current",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("All Services From Superior, \nUnlimited File Restore \nUnique Integrations \nOne on One Onboarding Assistance"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("15 Euro", style: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
                ),
              ],
            ),
          ),

          ],
        ),
      )
      ),
    );
  }
}
