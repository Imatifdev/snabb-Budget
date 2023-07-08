// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/account.dart';
import '../models/currency_controller.dart';
import '../models/transaction.dart';
import '../models/transaction_controller.dart';
import '../utils/custom_drawer.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';


class Accounts extends StatefulWidget {
  static const routeName = "Account-Screen";

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<Account> accounts = [];

 num balance=0.0;
 int credit=0;
 int dept=0;
 int expense=0;
 int income=0;
 int cash=0;
 int bankTransfer=0;
 int creditCard=0;
 int check = 0;
 String? currency = "";
 bool deleteCheck = false;
 List<Transaction> transactions = [];
  getCurrency()async{
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }

  void _openAddTransactionDialog() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => AddTransactionDialog(balance:double.parse(balance.toString())),
    );

    if (result != null) {
      setState(() {
        accounts.add(result);
        check = 0;
      });
    }
  }

  void _transferAmount(Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TransferDialog(
        transaction: account,
        transferCallback:
            (double transferredAmount, String name) {
          setState(() {
            account.amount -= transferredAmount;
          });
        },
      ),
    );
  }

  void _showTransactionDetails(Account transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          TransactionDetailsDialog(transaction: transaction),
    );
  }

  void _deleteTransaction(Account account) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          deleteCheck? const CircularProgressIndicator() :TextButton(
            onPressed: () async{
              setState(() {
                deleteCheck = true;
              });
              await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("Accounts").doc(account.id).delete();
              // await FirebaseFirestore.instance.collection("UserTransactions").doc(userId)
              // .collection("data").doc("userData")
              // .update({
              //   "balance":balance-account.amount
              // });
              setState(() {
                deleteCheck = false;
                check = 0;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    getCurrency();
    TransactionData transactionData = TransactionData();
   transactionData.fetchTransactions(userId);
   transactions = transactionData.transactions;
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Account> accountzList = [];
  List<Transaction> transactionzList = [];

  Future<void> getInfo()async{
    List<Transaction> transactions = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot2 = await FirebaseFirestore
        .instance
        .collection('UserTransactions')
        .doc(userId)
        .collection('transactions')
        .get();

    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents2 =
        querySnapshot2.docs;

    for (var document in documents2) {
      Transaction transaction =
          Transaction.fromJson(document.data(), document.id);
      transactions.add(transaction);
    }

    setState(() {
      transactionzList = transactions;
    });
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("Accounts").get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        querySnapshot.docs;
        setState(() {
          for (var document in documents) {
      Account account =
          Account.fromJson(document.data(), document.id);
      accountzList.add(account);
    }
        });                    
    var docSnapshot2 = await FirebaseFirestore.instance
    .collection("UserTransactions").doc(userId)
    .collection("data").doc("userData").get();
    if(docSnapshot2.exists){
      Map<String, dynamic>? data = docSnapshot2.data();
      setState(() {
         balance= data!["balance"];
         credit=data["credit"];
  dept=data["dept"];
  expense=data["expense"];
  income=data["income"];
  cash=data["cash"];
  bankTransfer=data["bankTransfer"];
 creditCard=data["creditCard"];
      });
    }
  }

  num calculateTotalAmount(List<Account> accounts) {
  num totalAmount = 0;

  for (Account account in accounts) {
    totalAmount += account.amount;
  }
  return totalAmount;
}

  num calculateTotalBalance(List<Transaction> transactions) {
  num totalBalance = 0;
  for (Transaction transaction in transactions) {
    if (transaction.type == TransactionType.income) {
      totalBalance += transaction.amount;
    } else {
      totalBalance -= transaction.amount;
    }
  }
  return totalBalance;
}

  @override
  Widget build(BuildContext context) {
    //TransactionData wallet = TransactionData(amount: 100, transactionType: transactionType, currency: currency, notes: notes)
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
    accountzList = [];
  });
     getInfo();});
      check++;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: scaffoldKey,
      extendBody: true,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          scaffoldKey.currentState?.openDrawer();
                        },
                        icon: const ImageIcon(
                          AssetImage("assets/images/menu.png"),
                          size: 40,
                        )),
                    const Text(
                      "Accounts",
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: size.width/8.5,
                    )
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.totalBalance,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                     "$currency${calculateTotalAmount(accountzList)}",
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //transactions.isEmpty?
              //accountCard(Account(id: "ed51", name: "Wallet", amount: double.parse(balance.toString()), currency: "USD", note: "", transferred: false), 69),
              StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('UserTransactions').doc(userId).collection("Accounts")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
              
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Show a progress indicator while loading
                }
              
                List<Account> accounts = snapshot.data!.docs.map((doc) {
                  return Account.fromJson(doc.data(), doc.id);
                }).toList();
              
                return SizedBox(
                  height: size.height-350,
                  child: ListView.builder(
                    itemCount: accounts.length,
                    itemBuilder: (context, index) {
                      Account account = accounts[index];
                      return accountCard(account, index);
                    },
                  ),
                );
              },
              )
        
              // Expanded(
              //         child: ListView.builder(
              //           itemCount: accounts.length,
              //           itemBuilder: (BuildContext context, int index) {
              //            Account account = accounts[index];
              //             return accountCard(account, index);
              //           },
              //         ),
              //       ),
            ],
          ),
        ),
      ).p(10),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransactionDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Card accountCard(Account account, int index) {
    return Card(
                        //color: bgcolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 7,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  account.name,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    // index!=69?IconButton(
                                    //     onPressed: () {
                                    //       if (!account
                                    //           .transferred) {
                                    //         _transferAmount(
                                    //             account);
                                    //       }
                                    //     },
                                    //     icon: const Icon(Icons.compare_arrows)):const SizedBox(),
                                    IconButton(
                                        onPressed: () {
                                          _showTransactionDetails(
                                              account);
                                        },
                                        icon: const Icon(Icons.visibility)),
                                    account.id!="69"?IconButton(
                                        onPressed: () {
                                          _deleteTransaction(account);
                                        },
                                        icon: const Icon(Icons.delete_forever)): const SizedBox()
                                  ],
                                ),
                              ],
                            ).pSymmetric(v: 10),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Balance:",
                                  style: TextStyle(
                                      fontSize: 14,color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                account.id != "69"?
                                Text(                                  
                                  "$currency${account.amount.toString()}",// //By Ammar
                                  // "$currency${double.parse((widget.balance).toStringAsFixed(2))}", //Previous Code
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ):Text(                                  
                                  "$currency${calculateTotalBalance(transactionzList)}",// //By Ammar
                                  // "$currency${double.parse((widget.balance).toStringAsFixed(2))}", //Previous Code
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ).pSymmetric(v: 10),
                            if (account.transferred)
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.flag_circle),
                                  Text(
                                    'Transferred',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                          ],
                        ).p(10),
                      );
  }
}

class AddTransactionDialog extends StatefulWidget {
  final double balance;

  const AddTransactionDialog({super.key, required this.balance});

  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  String? _name;
  double? _amount;
  String? _currency;
  String? _notes;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: size.height/2.1,
            width: size.width-100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('Create New Account').centered(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Name',
                          hintText: "Account Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Amount',
                          hintText: "0.00"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter account name';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _amount = double.parse(value!);
                      },
                    ).expand(),
                    const SizedBox(
                      width: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Currency',
                          hintText: "USD"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a currency';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _currency = value!;
                      },
                    ).expand(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Notes',
                      hintText: "note"),
                  onSaved: (value) {
                    _notes = value!;
                  },
                ).pOnly(bottom: 10),
                !isLoading? SizedBox(
                  width: size.width-150,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          isLoading = true;
                        });
                        final account = 
                        Account(id: "dc6d51d", name: _name!, amount: _amount!, currency: _currency!, note: _notes!, transferred: false);
                        await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("Accounts").add({
                          "name":account.name,
                          "amount":account.amount,
                          "currency":account.currency,
                          "notes":account.currency, 
                          "transferred":account.transferred
                        });
                        await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("data").doc("userData").update({"balance":widget.balance+account.amount});
                        setState(() {
                          isLoading = false;
                        });
                        //await FirebaseFirestore.instance.collection(collectionPath)
                        Navigator.of(context).pop(account);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ): const CircularProgressIndicator(),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TransferDialog extends StatefulWidget {
  final Account transaction;
  final Function(double, String) transferCallback;


  TransferDialog({required this.transaction, required this.transferCallback});

  @override
  _TransferDialogState createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final _formKey = GlobalKey<FormState>();
  double? _transferAmount;
  String? _name;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Transfer Amount'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(labelText: 'Name', hintText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Transfer Amount'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                if (double.parse(value) > widget.transaction.amount) {
                  return 'Transfer amount exceeds available amount';
                }
                return null;
              },
              onSaved: (value) {
                _transferAmount = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async{
            if (_formKey.currentState!.validate()) {
              Account account = Account(id: "d35s14d",name: _name!,amount: _transferAmount as double, currency: widget.transaction.currency,note:widget.transaction.note,transferred: true);
              _formKey.currentState!.save();
              widget.transferCallback(
                  _transferAmount!, _name!);
              await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("Accounts").doc(widget.transaction.id).update({"amount":widget.transaction.amount-_transferAmount!});
              await FirebaseFirestore.instance.collection("UserTransactions")
                        .doc(userId).collection("Accounts").add({
                          "name":account.name,
                          "amount":account.amount,
                          "currency":account.currency,
                          "notes":account.currency, 
                          "transferred":account.transferred
                        });
              Navigator.of(context).pop();
            }
          },
          child: const Text('Transfer'),
        ),
      ],
    );
  }
}

class TransactionDetailsDialog extends StatelessWidget {
  final Account transaction;

  TransactionDetailsDialog({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Transaction Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Amount: ${transaction.amount}'),
         // Text('Transaction Type: ${transaction.transactionType}'),
          Text('Currency: ${transaction.currency}'),
          Text('Notes: ${transaction.note}'),
         // if (transaction.transferred) const Text('Status: Transferred'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
