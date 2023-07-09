// ignore_for_file: unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/currency_controller.dart';
import '../models/transaction.dart';

class TransactionCard extends StatefulWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  String? currency = "";
  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffeeeeee),
      // color: Colors.white,
      elevation: 5,
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  TransactionImageScreen(transaction: widget.transaction),
            ),
          );
        },
        leading: CircleAvatar(
          backgroundColor: Colors.orange[300],
          child: Text(
            widget.transaction.date.month.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          widget.transaction.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${widget.transaction.date.day.toString()}-' +
            "${widget.transaction.date.month.toString()}-" +
            "${widget.transaction.date.year.toString()}"),
        trailing: Text(
            widget.transaction.type == TransactionType.income
                ? "+$currency${widget.transaction.amount}"
                : "-$currency${widget.transaction.amount}",
            style: TextStyle(
                color: widget.transaction.type == TransactionType.income
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class TransactionImageScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionImageScreen({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(transaction.name),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Name:"),
                    Text(transaction.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Amount:"),
                    Text(transaction.amount.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Type:"),
                    Text(transaction.type.name),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Date:"),
                    Text(transaction.date.toString()),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Time:"),
                    Text(transaction.time),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Transaction Notes:"),
                    Text(transaction.notes),
                  ],
                ),
                const Text("Transaction file:"),
                Center(
                  child: transaction.fileUrl != ""
                      ? Hero(
                          tag: transaction.fileUrl,
                          child: FadeInImage.assetNetwork(
                            placeholder: 'assets/images/bell.png',
                            image: transaction.fileUrl,
                            placeholderErrorBuilder:
                                (context, error, stackTrace) {
                              return const CircularProgressIndicator();
                            },
                          ),
                        )
                      : const Text("No file for this transaction"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
