import 'package:flutter/material.dart';
import '../models/transaction.dart';


List<Transaction> schedualedTransactions = [
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

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({super.key});

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Schedule Transactions"),
            SizedBox(
              height: 300,
              child: ListView.builder(
                itemCount: schedualedTransactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = schedualedTransactions[index];
                  return ListTile(
                    title: Text(transaction.name),
                  );
                },),
            ),
          ],
        )),
    );
  }
}
