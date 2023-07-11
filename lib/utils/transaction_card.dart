// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
              child: Image.asset(widget.transaction.imgUrl)),
          title: Text(
            widget.transaction.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('${widget.transaction.date.day.toString()}-'
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
            padding: const EdgeInsets.all(20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 20,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Transaction Sheet",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      leading: Image.asset(transaction.imgUrl),
                      title: Text(
                        "Transaction Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.name.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.price_change,
                        size: 50,
                      ),
                      title: Text(
                        "Transaction Amount",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.amount.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.type_specimen_rounded,
                        size: 50,
                      ),
                      title: Text(
                        "Transaction Type",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.type.name.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.calendar_month,
                        size: 50,
                      ),
                      title: Text(
                        "Transaction Date",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${transaction.date.day.toString()}/${transaction.date.month.toString()}/${transaction.date.year.toString()}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.watch_later,
                        size: 50,
                      ),
                      title: Text(
                        "Transaction Time",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.time.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.note_add,
                        size: 50,
                      ),
                      title: Text(
                        "Transaction Notes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        transaction.notes.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(CupertinoIcons.right_chevron),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Name:"),
                    //     Text(transaction.category.toString()),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Amount:"),
                    //     Text(transaction.amount.toString()),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Type:"),
                    //     Text(transaction.type.name),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Date:"),
                    //     Text(
                    //         '${transaction.date.day.toString()}/${transaction.date.month.toString()}/${transaction.date.year.toString()}'),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Time:"),
                    //     Text(transaction.time),
                    //   ],
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text("Transaction Notes:"),
                    //     Text(transaction.notes),
                    //   ],
                    // ),
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
        ),
      ),
    );
  }
}
