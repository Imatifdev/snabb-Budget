import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:snabbudget/models/transaction.dart';

class TransactionData {
  static TransactionData? _instance;
  final List<Transaction> _transactions = [];

  factory TransactionData() {
    _instance ??= TransactionData._internal();
    return _instance!;
  }

  TransactionData._internal();

  Future<void> fetchTransactions(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('UserTransactions')
        .doc(userId)
        .collection('transactions')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;

    _transactions.clear(); // Clear the existing transactions before adding new ones

    documents.forEach((document) {
      Transaction transaction = Transaction.fromJson(document.data(),document.id);
      _transactions.add(transaction);
    });
  }

  List<Transaction> get transactions {
    return _transactions;
  }
}
