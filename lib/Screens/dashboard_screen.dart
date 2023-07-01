// ignore_for_file: non_constant_identifier_names

// import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';
import '../models/currency_controller.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../utils/transaction_card.dart';
import 'notification_screen.dart';


class DashboardScreen extends StatefulWidget {
  final List<Transaction> transactions;
  final double balance;
  DashboardScreen({super.key, required this.transactions, required this.balance});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? currency = "";
  getCurrency()async{
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }
  @override
  void initState(){
    super.initState();
    getCurrency();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double totalIncomeAmount = 0;
    double totalexpAmount = 0;
    const List<String> month = [
      "Jan",
      "Feb",
      "March",
      "April",
      "May",
      "June",
      "July",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec"
    ];
    for (Transaction transaction in widget.transactions) {
      if (transaction.type == TransactionType.income) {
        totalIncomeAmount += transaction.amount;
      }

      if (transaction.type == TransactionType.expense) {
        totalexpAmount += transaction.amount;
      }
    }
  Future<bool> deleteTransaction(BuildContext context,String transactionId) async {
    bool confirmed = false;
    bool confirmDelete = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Confirm'),
            onPressed: () {
              confirmed = true;
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmDelete == true) {
    // Delete the transaction document from Firebase
    try {
      await FirebaseFirestore.instance
          .collection('UserTransactions')
      .doc(userId)
      .collection('transactions').doc(transactionId).delete();
      print('Transaction deleted successfully');
      setState(() {
        widget.transactions.removeWhere((transaction) => transaction.id == transactionId);
        confirmed = true;
      });
    } catch (e) {
      confirmed = false;
      print('Error deleting transaction: $e');
    }
  }
  return confirmed;
}
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        extendBody: true,
        drawer: const CustomDrawer(),
        //backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    elevation: 3,
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
                        ShaderMask(
                          shaderCallback: (bounds) => const LinearGradient(
                            colors: [
                              Color(0xff9B710F),
                              Color.fromRGBO(243, 215, 42, 1),
                              Color(0xff9B710F),
                            ],
                          ).createShader(bounds),
                          child: const Text(
                            "SNABB BUDGET",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NotificationScreen(),));
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/images/bell.png"),
                              size: 40,
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 220,
                    width: size.width - 40,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.20,
                            //0.40,
                            0.50, 0.60, 0.70, 0.80, 0.90, 1
                          ],
                          colors: [
                            Color(0xFF335BAA),
                            //Color(0xFF2E77BB),
                            Color(0xFF306CB5),
                            Color(0xFF2D7CBE),
                            Color(0xFF2C92C3),
                            Color(0xFF31C3B6),
                            Color(0xFF31C3B6),
                            Color(0xFFFBFF2B),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.totalAmount,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      //"$currency0.00",
                                         "$currency${double.parse((widget.balance).toStringAsFixed(2))}",
                                        style: const TextStyle(
                                            letterSpacing: 3,
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(TransactionsScreen.routeName); //By Ammar
                                  },
                                  icon: const ImageIcon(
                                    AssetImage("assets/images/dot-menu.png"),
                                    size: 20,
                                    color: Colors.white,
                                  ))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.3),
                                          child: const Icon(
                                            Icons.arrow_downward_rounded,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context)!.income} ${month[(DateTime.now().month) - 1]}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "$currency${totalIncomeAmount.toString()}",                                  
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                          radius: 20,
                                          backgroundColor:
                                              Colors.white.withOpacity(0.3),
                                          child: const Icon(
                                            Icons.arrow_upward_rounded,
                                            color: Colors.white,
                                          )),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "${AppLocalizations.of(context)!.expense} ${month[(DateTime.now().month) - 1]}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("$currency${totalexpAmount.toString()}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: size.width - 40,
                    child: Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                " ${AppLocalizations.of(context)!.transactions}",
                                style: const TextStyle(
                                    fontSize: 20,
                                    //color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                child: const Text("See All",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.grey)),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(TransactionsScreen.routeName);
                                },
                              )
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        if (widget.transactions.isNotEmpty)
                          Column(
                            children: [
                              SizedBox(
                                height: 410,
                                child: ListView.builder(
                                  itemCount: widget.transactions.length,
                                  itemBuilder: (context, index) {
                                    Transaction transaction =
                                        widget.transactions[index];
                                    return Dismissible(
                                      confirmDismiss: (direction) async{
                                        bool delete = await deleteTransaction(context, transaction.id);
                                        return delete;
                                      },
                                      key: Key(transaction.id),
                                      child: TransactionCard(transaction: transaction), 
                                      // Card(
                                      //   elevation: 0,
                                      //   child: ListTile(
                                      //     leading:
                                      //         Image.asset(transaction.imgUrl),
                                      //     title: Text(
                                      //       transaction.name,
                                      //       style: const TextStyle(
                                      //           fontWeight: FontWeight.bold),
                                      //     ),
                                      //     subtitle: Text(transaction.time),
                                      //     trailing: Text(
                                      //         transaction.type ==
                                      //                 TransactionType.income
                                      //             ? "+$currency${transaction.amount}"
                                      //             : "-$currency${transaction.amount}",
                                      //         style: TextStyle(
                                      //             color: transaction.type ==
                                      //                     TransactionType.income
                                      //                 ? Colors.green
                                      //                 : Colors.red,
                                      //             fontWeight: FontWeight.bold)),
                                      //   ),
                                      // ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.noTransactions,
                                      textAlign: TextAlign.center,
                                    )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        ))));
  }
}
