import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_card.dart';
class YearlyTransactions extends StatefulWidget {
  final List<Transaction> transactions;
  const YearlyTransactions({super.key, required this.transactions});

  @override
  State<YearlyTransactions> createState() => _YearlyTransactionsState();
}

class _YearlyTransactionsState extends State<YearlyTransactions> {
  final PageController _pageController = PageController();
  
  List<int> getUniqueYears() {
    final List<int> years = [];
    for (var transaction in widget.transactions) {
      final year = transaction.date.year;
      if (!years.contains(year)) {
        years.add(year);
      }
    }
    years.sort();
    return years;
  }

  List<Transaction> getTransactionsByYear(int year) {
    return widget.transactions.where((transaction) => transaction.date.year == year).toList();
  }

  String getMonthName(int month) {
    switch (month) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<int> years = getUniqueYears();
    Size size = MediaQuery.of(context).size;
    return Column(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.bounceIn,
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
            ),
            IconButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 120),
                  curve: Curves.bounceIn,
                );
              },
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      SizedBox(
        height: size.height - 210,
        child: PageView.builder(
        controller: _pageController,
        itemCount: years.length,
        itemBuilder: (context, index) {
          final currentYear = years[index];
          final filteredTransactions = getTransactionsByYear(currentYear);
          if (filteredTransactions.isEmpty) {
            return Container();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text(
                  currentYear.toString(),
                  style:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  itemBuilder: (context, monthIndex) {
                    final currentMonth = monthIndex + 1;
                    final monthTransactions = filteredTransactions
                        .where((transaction) => transaction.date.month == currentMonth)
                        .toList();
          
                    if (monthTransactions.isEmpty) {
                      return Container(); // Return an empty container if no transactions for the month
                    }
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getMonthName(currentMonth),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey
                              ),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: monthTransactions.length,
                          itemBuilder: (context, transactionIndex) {
                            final transaction = monthTransactions[transactionIndex];
                            return TransactionCard(transaction:transaction);
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      ),
        ],
      );
  }
}