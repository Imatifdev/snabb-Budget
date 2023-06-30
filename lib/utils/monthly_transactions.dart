import 'package:flutter/material.dart';
import 'package:snabbudget/utils/transaction_card.dart';

import '../models/transaction.dart';

class MonthlyTransactions extends StatefulWidget {
  final List<String> month;
  final List<Transaction> transactions;

  const MonthlyTransactions({Key? key, required this.month, required this.transactions})
      : super(key: key);

  @override
  State<MonthlyTransactions> createState() => _MonthlyTransactionsState();
}

class _MonthlyTransactionsState extends State<MonthlyTransactions> {
  final PageController _controller = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Filter the months that have transactions
    List<int> monthsWithTransactions = [];
    for (int i = 0; i < widget.month.length; i++) {
      final currentMonth = i + 1;
      final filteredTransactions = widget.transactions
          .where((transaction) => transaction.date.month == currentMonth)
          .toList();
      if (filteredTransactions.isNotEmpty) {
        monthsWithTransactions.add(i);
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.bounceIn,
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            IconButton(
              onPressed: () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.bounceIn,
                );
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
        Text(
          DateTime.now().year.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: size.height - 220,
          child: PageView.builder(
            controller: _controller,
            itemCount: monthsWithTransactions.length,
            onPageChanged: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final currentMonthIndex = monthsWithTransactions[index];
              final currentMonth = currentMonthIndex + 1;
              final filteredTransactions = widget.transactions
                  .where((transaction) => transaction.date.month == currentMonth)
                  .toList();

              final monthName = widget.month[currentMonthIndex];

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    monthName,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return TransactionCard(transaction: transaction);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
