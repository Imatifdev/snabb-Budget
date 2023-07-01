import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/currency_controller.dart';
import '../models/transaction.dart';

class SummaryWidget extends StatefulWidget {
  final List<Transaction> transactions;
  final List months;

  const SummaryWidget({Key? key, required this.transactions, required this.months})
      : super(key: key);

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  String? currency = "";
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  getCurrency()async{
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }
  @override
  void initState() {
    super.initState();
    getCurrency();
  }
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

    List<DateTime> monthsWithTransactions = transactionsByMonth.keys.toList();

    return SizedBox(
      height: size.height - 150,
      child: ListView.builder(
        itemCount: monthsWithTransactions.length,
        itemBuilder: (BuildContext context, int index) {
          DateTime selectedMonth = monthsWithTransactions[index];
          List<Transaction> transactionsForMonth =
              transactionsByMonth[selectedMonth] ?? [];
          double totalIncome = 0;
          double totalExpense = 0;

          for (var transaction in transactionsForMonth) {
            if (transaction.type == TransactionType.income) {
              totalIncome += transaction.amount;
            } else if (transaction.type == TransactionType.expense) {
              totalExpense += transaction.amount;
            }
          }

          double balance = totalIncome - totalExpense;

          return Padding(
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
                        Text(
                          "${widget.months[selectedMonth.month - 1]} ${selectedMonth.year}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: PieChart(
                            dataMap: {
                              "expense": totalExpense,
                              "income": totalIncome,
                            },
                            colorList: const [
                              Color.fromRGBO(255, 59, 59, 1),
                              Color.fromRGBO(124, 179, 66, 1)
                            ],
                            legendOptions: const LegendOptions(
                              showLegends: false,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValues: false,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Column(
                      children: [
                        Text(
                          "Income ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Expense",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Total      ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          " $currency$totalIncome",
                          style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "-$currency$totalExpense",
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          balance > 0 ? "+$currency$balance" : "$currency$balance",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: balance > 0 ? Colors.green : Colors.red),
                        ),
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
