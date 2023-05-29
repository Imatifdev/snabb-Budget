// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:snabbudget/utils/mycolors.dart';

import '../models/transaction.dart';
import '../utils/custom_bottombar.dart';
import '../utils/expandable_fab.dart';

class DashboardScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<Transaction> transactions = [
    Transaction(
        name: "Money Transfer",
        time: "06:20 PM",
        imgUrl: "assets/images/home.png",
        type: TransactionType.expense,
        category: TransactionCat.moneyTransfer,
        amount: 22),
    Transaction(
        name: "Shopping",
        time: "02:26 PM",
        imgUrl: "assets/images/shopping.png",
        type: TransactionType.expense,
        category: TransactionCat.shopping,
        amount: 100),
    Transaction(
        name: "Taxi",
        time: "02:00 PM",
        imgUrl: "assets/images/travel.png",
        type: TransactionType.expense,
        category: TransactionCat.taxi,
        amount: 80),
    Transaction(
        name: "Salary",
        time: "10:26 AM",
        imgUrl: "assets/images/income.png",
        type: TransactionType.income,
        category: TransactionCat.moneyTransfer,
        amount: 2000),
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),
    Transaction(
        name: "Salary",
        time: "10:26 AM",
        imgUrl: "assets/images/income.png",
        type: TransactionType.income,
        category: TransactionCat.moneyTransfer,
        amount: 2000),
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),
    Transaction(
        name: "Salary",
        time: "10:26 AM",
        imgUrl: "assets/images/income.png",
        type: TransactionType.income,
        category: TransactionCat.moneyTransfer,
        amount: 2000),
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),
  ];

  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        drawer: CustomDrawer(),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: const CustomBottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: const ExpandableFloatingActionButton(),
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
                              _scaffoldKey.currentState?.openDrawer();
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
                                    Text("\$523.82",
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
                                      const Text(
                                        "Income",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    "\$2000.00",
                                    style: TextStyle(
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
                                      const Text(
                                        "Expenses",
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text("\$490.00",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Transactions",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "See All",
                                style:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                              )
                            ]),
                        const SizedBox(
                          height: 5,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Today",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                        SizedBox(
                          height: 410,
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              Transaction transaction = transactions[index];
                              return Card(
                                color: Colors.white,
                                elevation: 0,
                                child: ListTile(
                                  leading: Image.asset(transaction.imgUrl),
                                  title: Text(
                                    transaction.name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(transaction.time),
                                  trailing: Text(
                                      transaction.type == TransactionType.income
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Drawer CustomDrawer() {
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
            drawerTile("assets/images/home-icon.png", "Dashboard"),
            drawerTile("assets/images/user.png", "Accounts"),
            drawerTile("assets/images/dollar.png", "Debt"),
            drawerTile("assets/images/box.png", "Budget"),
            drawerTile("assets/images/calender.png", "Calendar"),
            drawerTile("assets/images/clock.png", "Scheduled Transactions"),
            drawerTile("assets/images/settings.png", "Settings"),
            drawerTile("assets/images/settings-2.png", "Preferences"),
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

  ListTile drawerTile(String imgUrl, String title) {
    return ListTile(
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
          size: 38,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ));
  }
}
