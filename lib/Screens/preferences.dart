import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


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
                Text(
                  AppLocalizations.of(context)!.preferences,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
                  child: Text(AppLocalizations.of(context)!.basicAccount, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.current,style: const TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(AppLocalizations.of(context)!.dataSavedOnDevice),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context)!.free, style: const TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.superiorAccount, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  //title: const Text("Current",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(AppLocalizations.of(context)!.cloudDataStorage),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context)!.fiveEuro, style: const TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
                ),
                const SizedBox(height: 30,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppLocalizations.of(context)!.elegantAccount, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                ListTile(
                  //title: const Text("Current",style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(AppLocalizations.of(context)!.unlimitedFileRestore),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                  onTap: (){},
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(AppLocalizations.of(context)!.fifteenEuro, style: const TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.bold,))),
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
