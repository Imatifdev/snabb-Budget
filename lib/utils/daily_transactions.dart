import 'package:flutter/material.dart';
import 'package:snabbudget/utils/transaction_card.dart';

import '../models/transaction.dart';

class DailyTransactions extends StatefulWidget {
  final List transactions;
  final List dates;
  final List month;
  const DailyTransactions({super.key, required this.transactions, required this.dates, required this.month});

  @override
  State<DailyTransactions> createState() => _DailyTransactionsState();
}

class _DailyTransactionsState extends State<DailyTransactions> {
  @override
  Widget build(BuildContext context) {
     return widget.transactions.isNotEmpty? Expanded(
        child: ListView.builder(
          itemCount: widget.dates.length,
          itemBuilder: (context, index) {
          var  selectedDate = widget.dates[index];
          List specificTrans = [];
          specificTrans = widget.transactions.where((transaction) =>
  "${widget.month[transaction.date.month - 1]}, ${transaction.date.day}, ${transaction.date.year}" == selectedDate
).toList();
          return Padding(
            padding: const EdgeInsets.all(20), 
            child: Column( 
            mainAxisAlignment: MainAxisAlignment.start,  
            children: [
              Align(
  alignment: Alignment.topLeft,
  child: "${widget.month[DateTime.now().month - 1]}, ${DateTime.now().day}, ${DateTime.now().year}" == widget.dates[index] ?
    const Text("Today") :
    Text(widget.dates[index].toString()),
),


              SizedBox(
              height: specificTrans.length*80,
              //specificTrans.length == 1?80: specificTrans.length == 2?160: specificTrans.length == 3?240: specificTrans.length == 3?320 : 400 ,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                            itemCount: specificTrans.length,
                            itemBuilder: (context, index) {
                              Transaction transaction = specificTrans[index];
                              return TransactionCard(transaction: transaction);
                            },
                          ),
              )
          
        ]),
        );},),
      ): const  Padding(
        padding:  EdgeInsets.all(80.0),
        child: Text("No Transactions"),
      ) ;
  }
}