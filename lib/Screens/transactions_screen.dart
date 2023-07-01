// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../models/transaction.dart';
import '../models/transaction_controller.dart';
import '../utils/daily_transactions.dart';
import '../utils/monthly_transactions.dart';
import '../utils/yearly_transactions.dart';

class TransactionsScreen extends StatefulWidget {
  static const routeName = "transactions-screen";
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>{
  // final List<Transaction> transactions = [
  //   Transaction(
  //       name: "Money Transfer",
  //       time: "06:20 PM",
  //       date: DateTime.now(),
  //       imgUrl: "assets/images/home.png",
  //       type: TransactionType.expense,
  //       category: TransactionCat.moneyTransfer,
  //       amount: 22),
  //   Transaction(
  //       name: "Shopping",
  //       time: "02:26 PM",
  //       date: DateTime.now().subtract(const Duration(days: 365)),
  //       imgUrl: "assets/images/shopping.png",
  //       type: TransactionType.expense,
  //       category: TransactionCat.shopping,
  //       amount: 100),
  //   Transaction(
  //       name: "Taxi",
  //       time: "02:00 PM",
  //       date: DateTime.now().subtract(const Duration(days: 2)),
  //       imgUrl: "assets/images/travel.png",
  //       type: TransactionType.expense,
  //       category: TransactionCat.taxi,
  //       amount: 80),
  //   Transaction(
  //       name: "Salary",
  //       time: "10:26 AM",
  //       imgUrl: "assets/images/income.png",
  //       date: DateTime.now().subtract(const Duration(days: 3)),
  //       type: TransactionType.income,
  //       category: TransactionCat.moneyTransfer,
  //       amount: 2000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       date: DateTime.now().subtract(const Duration(days: 3)),
  //       imgUrl: "assets/images/others.png",
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),
  //   Transaction(
  //       name: "Salary",
  //       time: "10:26 AM",
  //       date: DateTime.now().subtract(const Duration(days: 3)),
  //       imgUrl: "assets/images/income.png",
  //       type: TransactionType.income,
  //       category: TransactionCat.moneyTransfer,
  //       amount: 2000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       date: DateTime.now().subtract(const Duration(days: 90)),
  //       imgUrl: "assets/images/others.png",
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),
  //   Transaction(
  //       name: "Salary",
  //       time: "10:26 AM",
  //       date: DateTime.now().subtract(const Duration(days: 1)),
  //       imgUrl: "assets/images/income.png",
  //       type: TransactionType.income,
  //       category: TransactionCat.moneyTransfer,
  //       amount: 2000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       imgUrl: "assets/images/others.png",
  //       date: DateTime.now().subtract(const Duration(days: 2)),
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       imgUrl: "assets/images/others.png",
  //       date: DateTime.now().subtract(const Duration(days: 2)),
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       imgUrl: "assets/images/others.png",
  //       date: DateTime.now().subtract(const Duration(days: 30)),
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),
  //   Transaction(
  //       name: "Bills",
  //       time: "09:26 PM",
  //       imgUrl: "assets/images/others.png",
  //       date: DateTime.now().subtract(const Duration(days: 50)),
  //       type: TransactionType.expense,
  //       category: TransactionCat.bills,
  //       amount: 1000),            
  // ];
  final userId  = FirebaseAuth.instance.currentUser!.uid;
  List<Transaction> transactions = [];
  int _currentSelection = 0;
  int check = 0;
  
  @override
  void initState() {
    super.initState();
   TransactionData transactionData = TransactionData();
   transactionData.fetchTransactions(userId);
   transactions = transactionData.transactions;
   print(transactions);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    const List<String> month = [
      "Jan","Feb","March","April","May","June","July","Aug","Sept","Oct","Nov","Dec"
    ];
    List<String> dates = List.from(
  {...transactions.map((transaction) => "${month[transaction.date.month-1]}, ${transaction.date.day}, ${transaction.date.year}")}
);
    List<Widget> children = [
      DailyTransactions(transactions: transactions, dates: dates, month: month),
      MonthlyTransactions(transactions: transactions, month: month,),
      YearlyTransactions(transactions: transactions),
    ];

    final Map<int, Widget> _children = {
  0: Text(AppLocalizations.of(context)!.daily,style: GoogleFonts.montserrat(),),
  1:  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child:Text(AppLocalizations.of(context)!.monthly,style: GoogleFonts.montserrat(),)),
  2:  Text(AppLocalizations.of(context)!.yearly,style: GoogleFonts.montserrat(),),
};

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
                    backgroundColor: Colors.white,
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
