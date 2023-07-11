import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snabbudget/models/transaction.dart';

class Budget {
  final String id;
  final String name;
  final int transactionNum;
  final TransactionCat category;
  final DateTime startDate;
  final DateTime endDate;
  final String imgUrl;
  final num total;
  final num amount;

  Budget({
    required this.id,
    required this.amount,
    required this.transactionNum,
    required this.total,
    required this.name,
    required this.category,
    required this.startDate,
    required this.endDate,
    required this.imgUrl,
  });

  factory Budget.fromJson(Map<String, dynamic> json, String id) {
    return Budget(
      id: id,
      name: json['name'],
      amount: json['amount'],
      transactionNum: json['transactionNum'],
      total: json['total'],
      category: TransactionCat.values.firstWhere(
        (value) => value.toString() == json['category'],
        orElse: () => TransactionCat.others,
      ),
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      imgUrl: json['imgUrl'],
    );
  }
}
