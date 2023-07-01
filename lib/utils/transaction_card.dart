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
  getCurrency()async{
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
                             // color: Colors.white,
                              elevation: 0,
                              child: ListTile(
                                onTap: (){
                                  Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TransactionImageScreen(imageUrl: widget.transaction.fileUrl),
            ),
          );
                                },
                                leading: Image.asset(widget.transaction.imgUrl),
                                title: Text(
                                  widget.transaction.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(widget.transaction.time),
                                trailing: Text(
                                    widget.transaction.type == TransactionType.income
                                        ? "+$currency${widget.transaction.amount}"
                                        : "-$currency${widget.transaction.amount}",
                                    style: TextStyle(
                                        color: widget.transaction.type ==
                                                TransactionType.income
                                            ? Colors.green
                                            : Colors.red,
                                        fontWeight: FontWeight.bold)),
                              ),
                            );
  }
}

class TransactionImageScreen extends StatelessWidget {
  final String imageUrl;

  const TransactionImageScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loading File"),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/bell.png',
            image: imageUrl,
            placeholderErrorBuilder: (context, error, stackTrace) {
                  return CircularProgressIndicator();
                },
          ),
        ),
      ),
    );
  }
}