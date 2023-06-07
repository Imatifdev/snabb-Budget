import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios_new_rounded)
                            // const ImageIcon(
                            //   AssetImage("assets/images/menu.png"),
                            //   size: 40,
                            // )
                            ),
                const Text(
                  "SETTINGS",
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
                  child: Text("Basic Settings", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  title: const Text("Language",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("English"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Currency",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("USD"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Erase All",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("Erase all data and progress"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 41,right: 30),
            child: Column(
              children: [
                Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Database Settings", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  title: const Text("Report",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("Generate Reports"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Files",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text(".xls Download"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30,top: 41,right: 30),
            child: Column(
              children: [
                Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Help", style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  title: const Text("Feedback",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("Give feedback and support"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                ListTile(
                  title: const Text("Help",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: const Text("Ask Help"),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
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