import 'package:flutter/material.dart';

import '../models/transaction.dart';
class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

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
              builder: (context) => TransactionImageScreen(imageUrl: transaction.fileUrl),
            ),
          );
                                },
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