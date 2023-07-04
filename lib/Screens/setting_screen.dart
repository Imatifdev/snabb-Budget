import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction ;
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:snabbudget/Screens/theme_screen.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column hide Row;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pdfWidgets;

import '../models/currency_controller.dart';
import '../models/transaction.dart';
import '../models/transaction_controller.dart';
import 'currency_screen.dart';
import 'export.dart';
import 'language_screen.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = "settings-screen";

  SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    TransactionData transactionData = TransactionData();
    transactionData.fetchTransactions(userId);
    getCurrency();
    transactions = transactionData.transactions;
  }

Future<void> showDeleteConfirmationDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text('Are you sure you want to delete all your data? This action cannot be undone.'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () async{
              await FirebaseFirestore.instance.collection("UserTransactions").doc(userId).collection("transactions").get().then((snapshot) {
  for (DocumentSnapshot ds in snapshot.docs){
    ds.reference.delete();
  }
});
              await FirebaseFirestore.instance.collection("UserTransactions").doc(userId).collection("data").doc("userData").update(
                {
                  "balance":0,
                  "currency":"\$",
                }
              );
              await FirebaseFirestore.instance.collection("UserTransactions").doc(userId).collection("SchedualTrsanactions").get().then((snapshot) {
              for (DocumentSnapshot ds in snapshot.docs){
              ds.reference.delete();
              }
          });
              await FirebaseFirestore.instance.collection("UserTransactions").doc(userId).collection("Accounts").get().then((snapshot) {
              for (DocumentSnapshot ds in snapshot.docs){
              if(ds.id=="snabbWallet"){
               FirebaseFirestore.instance.collection("UserTransactions")
                                .doc(userId).collection("Accounts").doc("snabbWallet")
                                .update({'amount': 0});
              }else{
              ds.reference.delete();
              }
              }
          });
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  Future<void> createExcel(List<Transaction> transactions) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    // Set header "Snabb Budget"
    sheet.getRangeByName('A1').setText('Snabb Budget!');

    // Set column headers
    sheet.getRangeByIndex(2, 1).setText('Serial Number');
    sheet.getRangeByIndex(2, 2).setText('Date');
    sheet.getRangeByIndex(2, 3).setText('Transaction Category');
    sheet.getRangeByIndex(2, 4).setText('Amount');
    sheet.getRangeByIndex(2, 5).setText('Note');

    // Add transaction data
    for (int i = 0; i < transactions.length; i++) {
      final Transaction transaction = transactions[i];
      final int row = i + 3; // Starting from row 3

      // Serial Number
      sheet.getRangeByIndex(row, 1).setNumber(i + 1);

      // Date
      sheet.getRangeByIndex(row, 2).setDateTime(transaction.date);

      // Transaction Category
      sheet
          .getRangeByIndex(row, 3)
          .setText(transaction.category.toString().split('.').last);

      // Amount
      sheet.getRangeByIndex(row, 4).setNumber(transaction.amount.toDouble());

      // Note (if exists)
      if (transaction.name.isNotEmpty) {
        sheet.getRangeByIndex(row, 5).setText(transaction.name);
      }
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Future<void> createPDF(List<Transaction> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Snabb Budget',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
            ),
            pw.Table.fromTextArray(
              context: context,
              data: [
                <String>[
                  'Serial Number',
                  'Date',
                  'Transaction Category',
                  'Amount',
                  'Note'
                ],
                ...transactions.map((transaction) => [
                      '${transactions.indexOf(transaction) + 1}',
                      '${transaction.date}',
                      '${transaction.category.toString().split('.').last}',
                      '${transaction.amount.toDouble()}',
                      '${transaction.name}',
                    ]),
              ],
            ),
          ];
        },
      ),
    );

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/Output.pdf';
    final File file = File(fileName);
    await file.writeAsBytes(await pdf.save());

    OpenFile.open(fileName);
  }

  String? currency = "";
  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    String? local = await currencyData.fetchCurrency(userId);
    setState(() {
      currency = local;
    });
    //currency = currencyData.currency;
    print(currency);
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
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 41, right: 30),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.basicSettings,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            )),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.language,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(AppLocalizations.of(context)!.languageName),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LanguageScreen(),
                            ));
                          },
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.currency,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(currency as String),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CurrencyScreen(),
                            ));
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Change Theme",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("Light"),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ThemeChangeScreen(),
                            ));
                          },
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.eraseAll,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              Text(AppLocalizations.of(context)!.eraseAllData),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            showDeleteConfirmationDialog(context);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 41, right: 30),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.databaseSettings,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            )),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.report,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              AppLocalizations.of(context)!.generateReports),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            createPDF(transactions);
                          },
                        ),
                        ListTile(
                          title: const Text(
                            "Export ",
                            style:  TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text("xls"),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {
                            createExcel(transactions);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 30, top: 41, right: 30),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              AppLocalizations.of(context)!.help,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            )),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.feedback,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(AppLocalizations.of(context)!
                              .giveFeedbackSupport),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {},
                        ),
                        ListTile(
                          title: Text(
                            AppLocalizations.of(context)!.help,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(AppLocalizations.of(context)!.askHelp),
                          trailing: const Icon(Icons.arrow_forward_ios_rounded),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
