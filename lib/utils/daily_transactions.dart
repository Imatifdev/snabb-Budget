import 'package:flutter/material.dart';

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
    return Expanded(
        child: ListView.builder(
          itemCount: widget.dates.length,
          itemBuilder: (context, index) {
          var  selectedDate = widget.dates[index];
          List specificTrans = [];
          specificTrans = widget.transactions.where((transaction) => "${widget.month[transaction.date.month]}, ${transaction.date.day}, ${transaction.date.year}" == selectedDate).toList();
          return Padding(
            padding: const EdgeInsets.all(20), 
            child: Column( 
            mainAxisAlignment: MainAxisAlignment.start,  
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: "${widget.month[DateTime.now().month]}, ${DateTime.now().day}, ${DateTime.now().year}" == widget.dates[index]? 
          const Text("Today") :Text(widget.dates[index].toString()),
              ),
              SizedBox(
              height: specificTrans.length*80,
              //specificTrans.length == 1?80: specificTrans.length == 2?160: specificTrans.length == 3?240: specificTrans.length == 3?320 : 400 ,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                            itemCount: specificTrans.length,
                            itemBuilder: (context, index) {
                              Transaction transaction = specificTrans[index];
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
              )
          
        ]),
        );},),
      );
  }
}