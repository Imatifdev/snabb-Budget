// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';

final List<Transaction> transactions = [
  //Transaction(
  //     name: "Money Transfer",
  //     time: "06:20 PM",
  //     date: DateTime.now(),
  //     imgUrl: "assets/images/home.png",
  //     type: TransactionType.expense,
  //     category: TransactionCat.moneyTransfer,
  //     amount: 22),
  // Transaction(
  //     name: "Shopping",
  //     time: "02:26 PM",
  //     date: DateTime.now().subtract(const Duration(days: 1)),
  //     imgUrl: "assets/images/shopping.png",
  //     type: TransactionType.expense,
  //     category: TransactionCat.shopping,
  //     amount: 100),
  // Transaction(
  //     name: "Taxi",
  //     time: "02:00 PM",
  //     date: DateTime.now().subtract(const Duration(days: 2)),
  //     imgUrl: "assets/images/travel.png",
  //     type: TransactionType.expense,
  //     category: TransactionCat.taxi,
  //     amount: 80),
  // Transaction(
  //     name: "Salary",
  //     time: "10:26 AM",
  //     imgUrl: "assets/images/income.png",
  //     date: DateTime.now().subtract(const Duration(days: 3)),
  //     type: TransactionType.income,
  //     category: TransactionCat.moneyTransfer,
  //     amount: 2000),
  // Transaction(
  //     name: "Bills",
  //     time: "09:26 PM",
  //     date: DateTime.now().subtract(const Duration(days: 3)),
  //     imgUrl: "assets/images/others.png",
  //     type: TransactionType.expense,
  //     category: TransactionCat.bills,
  //     amount: 1000),
  // Transaction(
  //     name: "Salary",
  //     time: "10:26 AM",
  //     date: DateTime.now().subtract(const Duration(days: 3)),
  //     imgUrl: "assets/images/income.png",
  //     type: TransactionType.income,
  //     category: TransactionCat.moneyTransfer,
  //     amount: 2000),
];
double totalBalance = 523.24;

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  DashboardScreen({super.key});
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
    for (Transaction transaction in transactions) {
      if (transaction.type == TransactionType.income) {
        totalIncomeAmount += transaction.amount;
      }

      if (transaction.type == TransactionType.expense) {
        totalexpAmount += transaction.amount;
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        extendBody: true,
        drawer: const CustomDrawer(),
        backgroundColor: Colors.grey[100],
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
                            onPressed: () {},
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
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text("\$0.00",
                                        // ${double.parse((totalBalance).toStringAsFixed(2))}",
                                        style: TextStyle(
                                            letterSpacing: 3,
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.left)
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
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
                                        "Income ${month[(DateTime.now().month) - 1]}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    totalIncomeAmount.toString(),
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
                                        "Expenses ${month[(DateTime.now().month) - 1]}",
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(totalexpAmount.toString(),
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
                              const Text(
                                "Transactions",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
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
                        if (transactions.isNotEmpty)
                          Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Today",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey),
                                ),
                              ),
                              SizedBox(
                                height: 410,
                                child: ListView.builder(
                                  itemCount: transactions.length,
                                  itemBuilder: (context, index) {
                                    Transaction transaction =
                                        transactions[index];
                                    return Card(
                                      color: Colors.white,
                                      elevation: 0,
                                      child: ListTile(
                                        leading:
                                            Image.asset(transaction.imgUrl),
                                        title: Text(
                                          transaction.name,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(transaction.time),
                                        trailing: Text(
                                            transaction.type ==
                                                    TransactionType.income
                                                ? "+\$${transaction.amount}"
                                                : "-\$${transaction.amount}",
                                            style: TextStyle(
                                                color: transaction.type ==
                                                        TransactionType.income
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        else
                          const SizedBox(
                            height: 300,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No Transactions to show\nStart Adding your transactions",
                                  textAlign: TextAlign.center,
                                )),
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
