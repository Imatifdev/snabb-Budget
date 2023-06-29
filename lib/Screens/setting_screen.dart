
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/theme_screen.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column hide Row;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


import 'language_screen.dart';
class SettingScreen extends StatelessWidget {
  static const routeName = "settings-screen";
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  SettingScreen({super.key,});

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.getRangeByName('A1').setText('Hello World!');
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
      final String path = (await getApplicationSupportDirectory()).path;
      final String fileName = '$path/Output.xlsx';
      final File file = File(fileName);
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open(fileName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
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
                        AppLocalizations.of(context)!.settings,
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
                        child: Text(AppLocalizations.of(context)!.basicSettings, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.language,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: const Text("English"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LanguageScreen() ,));
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.currency,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: const Text("USD"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){},
                      ),
                      ListTile(
                        title: const Text("Change Theme",style: TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: const Text("Light"),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const ThemeChangeScreen(),));
                        },
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.eraseAll,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(AppLocalizations.of(context)!.eraseAllData),
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
                              child: Text(AppLocalizations.of(context)!.databaseSettings, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.report,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(AppLocalizations.of(context)!.generateReports),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.files,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(AppLocalizations.of(context)!.xlsDownload),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){
                          createExcel();
                        },
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
                              child: Text(AppLocalizations.of(context)!.help, style: TextStyle(fontWeight: FontWeight.bold ,fontSize: 20, color: Theme.of(context).primaryColor ),)),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.feedback,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(AppLocalizations.of(context)!.giveFeedbackSupport),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: (){},
                      ),
                      ListTile(
                        title: Text(AppLocalizations.of(context)!.help,style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text(AppLocalizations.of(context)!.askHelp),
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
          ],
        ),
      ),
    );
  }
}