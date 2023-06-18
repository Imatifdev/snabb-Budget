import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/transaction.dart';
class SummaryWidget extends StatefulWidget {
  final List<Transaction> transactions;
  final List months;
  const SummaryWidget({super.key, required this.transactions, required this.months});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<DateTime, List<Transaction>> transactionsByMonth = {};
    for (var transaction in widget.transactions) {
      DateTime month = DateTime(transaction.date.year, transaction.date.month);
      if (transactionsByMonth.containsKey(month)) {
        transactionsByMonth[month]!.add(transaction);
      } else {
        transactionsByMonth[month] = [transaction];
      }
    }
    return SizedBox(
      height: size.height-150,
      child: ListView.builder(
        itemCount: 12,
        itemBuilder: (BuildContext context, int index) {
          double totalIncome = 0;
          double totalExpense = 0;
          DateTime selectedMonth = DateTime(DateTime.now().year, index + 1);
          List<Transaction> selectedMonthTransactions = widget.transactions.where((transaction) =>
      transaction.date.year == selectedMonth.year &&
      transaction.date.month == selectedMonth.month).toList();
          List<Transaction> transactionsForMonth = transactionsByMonth[selectedMonth] ?? [];
          for (var transaction in selectedMonthTransactions) {
    if (transaction.type == TransactionType.income) {
      totalIncome += transaction.amount;
    } else if (transaction.type == TransactionType.expense) {
      totalExpense += transaction.amount;
    }
  }

  double balance = totalIncome - totalExpense;
          return transactionsForMonth.isNotEmpty ? Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
           shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("${widget.months[index]} ${DateTime.now().year}",style: const TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
            height: 100,
            width: 100,
            child: PieChart(
              dataMap: {
                "expense":totalExpense,
                "income":totalIncome,
              },
              colorList: const [Color.fromRGBO(255, 59, 59, 1), Color.fromRGBO(124, 179, 66,1)],
              legendOptions: const LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: const ChartValuesOptions(
                showChartValues: false,
              ),
              ),
                )
                    ]       
                ),
                const Column(
                  children: [
                    Text("Income ", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),SizedBox(width: 30,),
                    SizedBox(height: 10,),
                    Text("Expense", style: TextStyle(fontWeight: FontWeight.bold) ,textAlign: TextAlign.left),SizedBox(width: 30,),
                    SizedBox(height: 10,),
                    Text("Total      ", style: TextStyle(fontWeight: FontWeight.bold) ,textAlign: TextAlign.left),SizedBox(width: 30,),
                  ],
                ),
                 Column(
                  children: [
                    Text(" \$$totalIncome", style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text("-\$$totalExpense", style: const TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
                    Text( balance>0? "+\$$balance":"\$$balance",style: TextStyle(fontWeight: FontWeight.bold, color: balance>0?Colors.green:Colors.red)),
                  ],
                )
              ],
            ),
          ),
        ),
      ) : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 5,
           shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("${widget.months[index]} ${DateTime.now().year}",style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(
            height: 100,
            width: 100,
            child: PieChart(
              dataMap: {
                "none":0.0
              },
              colorList: [Color.fromRGBO(255, 59, 59, 1), Color.fromRGBO(124, 179, 66,1)],
              legendOptions: LegendOptions(
                showLegends: false,
              ),
              chartValuesOptions: ChartValuesOptions(
                showChartValues: false,
              ),
              ),
                )
                    ]       
                ),
                const Column(
                  children: [
                    Text("Income ", style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.left,),SizedBox(width: 30,),
                    SizedBox(height: 10,),
                    Text("Expense", style: TextStyle(fontWeight: FontWeight.bold) ,textAlign: TextAlign.left),SizedBox(width: 30,),
                    SizedBox(height: 10,),
                    Text("Total      ", style: TextStyle(fontWeight: FontWeight.bold) ,textAlign: TextAlign.left),SizedBox(width: 30,),
                  ],
                ),
                const Column(
                  children: [
                    Text(" \$0", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("-\$0", style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text(" \$0",style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ),
      );
        },
      ),
    );
  }
}

