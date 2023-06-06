import 'package:flutter/material.dart';
import '../models/IncomeDataMode.dart';
import 'package:intl/intl.dart';

class DisplayIncomeScreen extends StatelessWidget {
  final List<IncomeData> incomeList;

  const DisplayIncomeScreen(this.incomeList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Income Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: incomeList.length,
            itemBuilder: (context, index) {
              IncomeData income = incomeList[index];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    income.imageurl,
                    width: 100,
                    height: 100,
                  ),
                  Text('Name: ${income.name}'),
                  SizedBox(height: 8.0),
                  Text('Amount: ${income.amount}'),
                  SizedBox(height: 8.0),
                  SizedBox(height: 8.0),
                  Text('Date: ${DateFormat.yMMMd().format(income.date)}'),
                  Text('Date: ${(income.time)}'),
                ],
              );
            }),
      ),
    );
  }
}
