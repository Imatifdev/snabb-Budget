// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import '../models/transaction.dart';
import '../utils/daily_transactions.dart';
import '../utils/monthly_transactions.dart';
import '../utils/transaction_card.dart';
import '../utils/yearly_transactions.dart';

class TransactionsScreen extends StatefulWidget {
  static const routeName = "transactions-screen";
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>{
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
        date: DateTime.now().subtract(const Duration(days: 365)),
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
        date: DateTime.now().subtract(const Duration(days: 90)),
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
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        date: DateTime.now().subtract(const Duration(days: 2)),
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        date: DateTime.now().subtract(const Duration(days: 30)),
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),
    Transaction(
        name: "Bills",
        time: "09:26 PM",
        imgUrl: "assets/images/others.png",
        date: DateTime.now().subtract(const Duration(days: 50)),
        type: TransactionType.expense,
        category: TransactionCat.bills,
        amount: 1000),            
  ];
  
  int _currentSelection = 0;
  final Map<int, Widget> _children = {
  0: Text('Daily',style: GoogleFonts.montserrat(),),
  1:  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child:Text('Monthly',style: GoogleFonts.montserrat(),)),
  2:  Text('Yearly',style: GoogleFonts.montserrat(),),
};
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    const List<String> month = [
      "Jan","Feb","March","April","May","June","July","Aug","Sept","Oct","Nov","Dec"
    ];
    List<String> dates = List.from(
  {...transactions.map((transaction) => "${month[transaction.date.month]}, ${transaction.date.day}, ${transaction.date.year}")}
);
    List<Widget> children = [
      DailyTransactions(transactions: transactions, dates: dates, month: month),
      MonthlyTransactions(transactions: transactions, month: month,),
      YearlyTransactions(transactions: transactions),
    ];

    return Scaffold(
        body: SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(children: [
          Card(
              child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_rounded)),
                  ),
                ),
                const Text(
                  "Transactions",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {},
                    icon: ImageIcon(
                        const AssetImage("assets/images/search.png"),
                        size: 40,
                        color: Theme.of(context).primaryColor))
              ],
            ),
          )),
          MaterialSegmentedControl(
            verticalOffset: 12,
          children: _children,
          selectionIndex: _currentSelection,
          borderColor: Theme.of(context).primaryColor ,
          selectedColor: Theme.of(context).primaryColor,
          unselectedColor: Colors.white,
          selectedTextStyle: const TextStyle(color: Colors.white),
          unselectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          borderWidth: 0.7,
          borderRadius: 32.0,
          disabledChildren: const [3],
          onSegmentTapped: (index) {
        setState(() {
          _currentSelection = index;
        });
          },
      ),
      children[_currentSelection],
        ]),
      ),
    ));
  }
}
