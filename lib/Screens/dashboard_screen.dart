// ignore_for_file: non_constant_identifier_names, unrelated_type_equality_checks, prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable

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
  final String name;
  final List<Transaction> transactions;
  final num snabbWallet;
  DashboardScreen(
      {super.key,
      required this.transactions,
      required this.snabbWallet,
      required this.name});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? currency = "";
  int check = 0;
  num snabWalletBalance = 0;

  var name;

  num calculateTotalBalance(List<Transaction> transactions) {
    num totalBalance = 0;
    for (Transaction transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        totalBalance += transaction.amount;
      } else {
        totalBalance -= transaction.amount;
      }
    }
    return totalBalance;
  }

  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }

  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  num balance = 0.0;

  void getInfo() async {
    var docSnapshot = await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("data")
        .doc("userData")
        .get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        balance = data!["balance"];
      });
    }

    var docSnapshot3 = await FirebaseFirestore.instance
        .collection('UserTransactions')
        .doc(userId)
        .collection("Accounts")
        .doc("snabbWallet")
        .get();
    if (docSnapshot3.exists) {
      Map<String, dynamic>? data = docSnapshot3.data();
      setState(() {
        snabWalletBalance = data!["amount"];
      });
    }

    //var collection = FirebaseFirestore.instance.collection('UsersData');
    //var docSnapshot4 = await collection.doc(userId).get();
    if (docSnapshot.exists) {
      print("ok");
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?["First Name"];
        //phone = data?["Phone"];
      });
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }
    double totalIncomeAmount = 0;
    double totalexpAmount = 0;
    // const List<String> month = [
    //   "Jan",
    //   "Feb",
    //   "March",
    //   "April",
    //   "May",
    //   "June",
    //   "July",
    //   "Aug",
    //   "Sept",
    //   "Oct",
    //   "Nov",
    //   "Dec"
    // ];

    for (Transaction transaction in widget.transactions) {
      if (transaction.type == TransactionType.income) {
        if (transaction.date.month == DateTime.now().month) {
          totalIncomeAmount += transaction.amount;
        }
      }
      if (transaction.type == TransactionType.expense) {
        if (transaction.date.month == DateTime.now().month) {
          totalexpAmount += transaction.amount;
        }
      }
    }

    Future<bool> deleteTransaction(
        BuildContext context, Transaction transaction) async {
      bool confirmed = false;
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Deletion'),
            content:
                const Text('Are you sure you want to delete this transaction?'),
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
        num updatedBalance;
        num updatedSnabbWallet;
        if (transaction.type == TransactionType.income) {
          updatedBalance = balance - transaction.amount;
          updatedSnabbWallet = snabWalletBalance - transaction.amount;
        } else {
          updatedBalance = balance + transaction.amount;
          updatedSnabbWallet = snabWalletBalance + transaction.amount;
        }
        print(updatedBalance);
        try {
          await FirebaseFirestore.instance
              .collection("UserTransactions")
              .doc(userId)
              .collection("data")
              .doc("userData")
              .update({"balance": updatedBalance});
          await FirebaseFirestore.instance
              .collection('UserTransactions')
              .doc(userId)
              .collection('transactions')
              .doc(transaction.id)
              .delete();
          await FirebaseFirestore.instance
              .collection("UserTransactions")
              .doc(userId)
              .collection("Accounts")
              .doc("snabbWallet")
              .update({'amount': updatedSnabbWallet});
          print('Transaction deleted successfully');
          setState(() {
            widget.transactions.removeWhere(
                (transactionz) => transactionz.id == transaction.id);
            confirmed = true;
            check = 0;
          });
        } catch (e) {
          confirmed = false;
          print('Error deleting transaction: $e');
        }
        setState(() {
          widget.transactions
              .removeWhere((trans) => trans.id == transaction.id);
        });
      }
      return confirmed;
    }

    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      drawer: const CustomDrawer(),
      //backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(children: [
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const NotificationScreen(),
                        ));
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
            //previous card
            // Container(
            //   height: 220,
            //   width: size.width - 40,
            //   decoration: BoxDecoration(
            //       gradient: const LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         stops: [
            //           0.20,
            //           //0.40,
            //           0.50, 0.60, 0.70, 0.80, 0.90, 1
            //         ],
            //         colors: [
            //           Color(0xFF335BAA),
            //           //Color(0xFF2E77BB),
            //           Color(0xFF306CB5),
            //           Color(0xFF2D7CBE),
            //           Color(0xFF2C92C3),
            //           Color(0xFF31C3B6),
            //           Color(0xFF31C3B6),
            //           Color(0xFFFBFF2B),
            //         ],
            //       ),
            //       borderRadius: BorderRadius.circular(20)),
            //   child: Padding(
            //     padding: const EdgeInsets.all(14.0),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(left: 10),
            //               child: Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     AppLocalizations.of(context)!.totalAmount,
            //                     style: const TextStyle(
            //                         color: Colors.white, fontSize: 14),
            //                     textAlign: TextAlign.left,
            //                   ),
            //                   Text(
            //                       //"$currency0.00",
            //                       "$currency${calculateTotalBalance(widget.transactions)}",
            //                       style: const TextStyle(
            //                           letterSpacing: 3,
            //                           color: Colors.white,
            //                           fontSize: 22,
            //                           fontWeight: FontWeight.bold),
            //                       textAlign: TextAlign.left)
            //                 ],
            //               ),
            //             ),
            //             IconButton(
            //                 onPressed: () {
            //                   Navigator.of(context).pushNamed(
            //                       TransactionsScreen.routeName); //By Ammar
            //                 },
            //                 icon: const ImageIcon(
            //                   AssetImage("assets/images/dot-menu.png"),
            //                   size: 20,
            //                   color: Colors.white,
            //                 ))
            //           ],
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     CircleAvatar(
            //                         radius: 20,
            //                         backgroundColor:
            //                             Colors.white.withOpacity(0.3),
            //                         child: const Icon(
            //                           Icons.arrow_downward_rounded,
            //                           color: Colors.white,
            //                         )),
            //                     const SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       "${AppLocalizations.of(context)!.income} ${month[(DateTime.now().month) - 1]}",
            //                       style: const TextStyle(
            //                           fontSize: 14, color: Colors.white),
            //                     )
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Text(
            //                   "$currency${totalIncomeAmount.toString()}",
            //                   style: const TextStyle(
            //                       color: Colors.white,
            //                       fontSize: 15,
            //                       fontWeight: FontWeight.bold),
            //                   textAlign: TextAlign.right,
            //                 ),
            //               ],
            //             ),
            //             Column(
            //               children: [
            //                 Row(
            //                   children: [
            //                     CircleAvatar(
            //                         radius: 20,
            //                         backgroundColor:
            //                             Colors.white.withOpacity(0.3),
            //                         child: const Icon(
            //                           Icons.arrow_upward_rounded,
            //                           color: Colors.white,
            //                         )),
            //                     const SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       "${AppLocalizations.of(context)!.expense} ${month[(DateTime.now().month) - 1]}",
            //                       style: const TextStyle(
            //                           fontSize: 14, color: Colors.white),
            //                     )
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 5,
            //                 ),
            //                 Text("$currency${totalexpAmount.toString()}",
            //                     style: const TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.bold)),
            //               ],
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 230,
              child: Stack(children: [
                Positioned(
                  left: 30,
                  right: 30,
                  top: 0,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 20,
                    child: Container(
                      width: 330,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 4, 242, 198),
                            Color.fromARGB(255, 233, 7, 30),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 16,
                            right: 10,
                            child: Image.asset(
                              'assets/images/master.png',
                              width: 60,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 10,
                            child: Image.asset(
                              'assets/images/crd.png',
                              width: 60,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 16,
                            child: Text(
                              'SNABB CARD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 16,
                            child: Text(
                              "Muhammad Atif ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 110,
                            left: 16,
                            child: Row(
                              children: [
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '1234',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 20,
                  right: 20,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 20,
                    child: Container(
                      width: 330,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.fromARGB(255, 33, 33, 33),
                            Color.fromARGB(255, 246, 246, 246),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 16,
                            right: 10,
                            child: Image.asset(
                              'assets/images/master.png',
                              width: 60,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 16,
                            left: 10,
                            child: Image.asset(
                              'assets/images/crd.png',
                              width: 60,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 70,
                            left: 16,
                            child: Text(
                              'SNABB CARD',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 16,
                            child: Text(
                              "Muhammad Atif ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 110,
                            left: 16,
                            child: Row(
                              children: [
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '1234',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  right: 10,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 20,
                    child: Container(
                      width: 330,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFe4b33f),
                            Color(0xFF3e198b),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 16,
                            right: 10,
                            child: Image.asset(
                              'assets/images/logoicon.png',
                              width: 60,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                              top: 16,
                              left: 10,
                              child: Text(
                                "$currency${calculateTotalBalance(widget.transactions)}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              )),
                          Positioned(
                            top: 70,
                            left: 16,
                            child: Text(
                              'SNABB BUDGET',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 16,
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 110,
                            left: 16,
                            child: Row(
                              children: [
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '****',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
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
                              style:
                                  TextStyle(fontSize: 13, color: Colors.grey)),
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
                          height: size.height / 2.5,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: widget.transactions.length,
                            itemBuilder: (context, index) {
                              Transaction transaction =
                                  widget.transactions[index];
                              return Dismissible(
                                confirmDismiss: (direction) async {
                                  bool delete = await deleteTransaction(
                                      context, transaction);
                                  return delete;
                                },
                                key: Key(transaction.id),
                                child:
                                    TransactionCard(transaction: transaction),
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
        ),
      ),
    );
  }
}
