// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';

final List<Transaction> transactions = [
  Transaction(
      name: "Money Transfer",
      time: "06:20 PM",
      date: DateTime.now(),
      imgUrl: "assets/images/home.png",
      type: TransactionType.expense,
      category: TransactionCat.moneyTransfer,
      amount: 22),
  Transaction(
      name: "Shopping",
      time: "02:26 PM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/shopping.png",
      type: TransactionType.expense,
      category: TransactionCat.shopping,
      amount: 100),
  Transaction(
      name: "Taxi",
      time: "02:00 PM",
      date: DateTime.now().subtract(const Duration(days: 2)),
      imgUrl: "assets/images/travel.png",
      type: TransactionType.expense,
      category: TransactionCat.taxi,
      amount: 80),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      imgUrl: "assets/images/income.png",
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      date: DateTime.now().subtract(const Duration(days: 3)),
      imgUrl: "assets/images/others.png",
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      date: DateTime.now().subtract(const Duration(days: 3)),
      imgUrl: "assets/images/income.png",
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/others.png",
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/income.png",
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      imgUrl: "assets/images/others.png",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
];

class SeeAllTransactions extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(transaction.time),
                        trailing: Text(
                            transaction.type == TransactionType.income
                                ? "+\$${transaction.amount}"
                                : "-\$${transaction.amount}",
                            style: TextStyle(
                                color:
                                    transaction.type == TransactionType.income
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
        )),
      ),
    );
  }
}
