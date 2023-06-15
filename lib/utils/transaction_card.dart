import 'package:flutter/material.dart';

import '../models/transaction.dart';
class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
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
  }
}