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
        Text(DateTime.now().year.toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),),
        SizedBox(
          height: size.height - 220,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.month.length,
            onPageChanged: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final currentMonth = index + 1;
              final filteredTransactions = widget.transactions
                  .where((transaction) => transaction.date.month == currentMonth)
                  .toList();

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.month[index],
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (filteredTransactions.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredTransactions.length,
                        itemBuilder: (context, index) {
                          final transaction = filteredTransactions[index];
                          return TransactionCard(transaction: transaction);
                        },
                      ),
                    )
                  else
                    const Text(
                      'No transactions for this month',
                      style: TextStyle(fontSize: 18),
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
