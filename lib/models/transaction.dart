import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Replace these enum definitions with your existing ones
enum TransactionType { income, expense }
enum TransactionCat { moneyTransfer, shopping, taxi, bills }

class Transaction {
  final String name;
  final String time;
  final DateTime date;
  final String imgUrl;
  final TransactionType type;
  final TransactionCat category;
  final int amount;

  Transaction({
    required this.name,
    required this.time,
    required this.date,
    required this.imgUrl,
    required this.type,
    required this.category,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    final TransactionType type = TransactionType.values.firstWhere(
      (value) => value.toString() == json['type'],
      orElse: () => TransactionType.expense,
    );

    final TransactionCat category = TransactionCat.values.firstWhere(
      (value) => value.toString() == json['category'],
      orElse: () => TransactionCat.moneyTransfer,
    );

    return Transaction(
      name: json['name'],
      time: json['time'],
      date: json['date'].toDate(),
      imgUrl: json['imgUrl'],
      type: type,
      category: category,
      amount: json['amount'],
    );
  }
}
