import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../models/currency_controller.dart';
import '../models/transaction.dart';

class DailyStats extends StatefulWidget {
  final List<Transaction> transactions;
  final num balance;
  final int credit;
  final int dept;
  final int expense;
  final int income;
  final int cash;
  final int bankTransfer;
  final int creditCard;
  DailyStats(
      {super.key,
      required this.balance,
      required this.credit,
      required this.dept,
      required this.expense,
      required this.income,
      required this.cash,
      required this.bankTransfer,
      required this.creditCard, required this.transactions});

  @override
  State<DailyStats> createState() => _DailyStatsState();
}

class _DailyStatsState extends State<DailyStats> {
  String? currency = "";
  num income = 0;
  int incomeNum = 0;
  num expense = 0;
  int expNum = 0;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }
  num calculateTotalBalance(List<Transaction> transactions) {
    income = 0;
    expense = 0;
    incomeNum = 0;
    expNum = 0;
  num totalBalance = 0;
  for (Transaction transaction in transactions) {
    if (transaction.type == TransactionType.income) {
      totalBalance += transaction.amount;
      if(transaction.date.day == DateTime.now().day){
        income +=transaction.amount;
        incomeNum++;
      }
    } else {
      totalBalance -= transaction.amount;
      if(transaction.date.day == DateTime.now().day){
        expense += transaction.amount;
        expNum++;
      } 
    }
  }
  return totalBalance;
}

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCurrency();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawer(),
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   // bottom: PreferredSize(
        //   //         preferredSize: Size(size.width, 50), child: ),
        // ),
        body: SafeArea(
            child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
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
                      const Text(
                        "Daily Stats",
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  )),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    statCard(
                    size,
                    "Snabb ${AppLocalizations.of(context)!.wallet}",
                    AppLocalizations.of(context)!.balance,
                    "$currency${calculateTotalBalance(widget.transactions)}",
                    Colors.green, 69),
                    statCard(size, "Today's Expenses", "Amount", "$currency$expense",Colors.red, incomeNum),
                    statCard(size, "Today's Incomes", "Amount", "$currency$income",Colors.green, expNum),
                  ],
                ),
              ),
            ],
          ),
        )));
  }

  Column statCard(
      Size size, String name, String unitName, String amount, Color color, int count) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: size.height / 7.5,
            width: size.width - 22,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 5,
              //color: const Color.fromRGBO(245, 246, 255,1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current $unitName",
                            style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold,
                              //color: Colors.grey
                            )),
                        Text(
                          amount,
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                   count!=69? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Number of $name",
                            style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold,
                              //color: Colors.grey
                            )),
                        Text(
                          count.toString(),
                          style: TextStyle(
                            color: color,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ):const SizedBox(),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}
