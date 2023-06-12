// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:snabbudget/utils/mycolors.dart';

import '../utils/custom_drawer.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionData {
  double amount;
  final String transactionType;
  final String currency;
  final String notes;
  bool transferred;

  TransactionData({
    required this.amount,
    required this.transactionType,
    required this.currency,
    required this.notes,
    this.transferred = false,
  });
}

class Accounts extends StatefulWidget {
  static const routeName = "Account-Screen";

  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  List<TransactionData> transactions = [];
  double totalAmount = 0.0;

  void _openAddTransactionDialog() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) => AddTransactionDialog(),
    );

    if (result != null) {
      setState(() {
        transactions.add(result);
        totalAmount += result.amount;
      });
    }
  }

  void _transferAmount(TransactionData transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) => TransferDialog(
        transaction: transaction,
        transferCallback:
            (double transferredAmount, String selectedTransactionType) {
          setState(() {
            transaction.amount -= transferredAmount;
            transactions.add(
              TransactionData(
                amount: transferredAmount,
                transactionType: selectedTransactionType,
                currency: transaction.currency,
                notes: transaction.notes,
                transferred: true,
              ),
            );
          });
        },
      ),
    );
  }

  void _showTransactionDetails(TransactionData transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          TransactionDetailsDialog(transaction: transaction),
    );
  }

  void _deleteTransaction(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirm Deletion'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                totalAmount -= transactions[index].amount;
                transactions.removeAt(index);
              });
              Navigator.of(context).pop();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBody: true,
      drawer: const CustomDrawer(),
      body: SafeArea(
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
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color(0xff9B710F),
                        Color.fromRGBO(243, 215, 42, 1),
                        Color(0xff9B710F),
                      ],
                    ).createShader(bounds),
                    child: const Text(
                      "SNABB BUDGET",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const ImageIcon(
                        AssetImage("assets/images/bell.png"),
                        size: 40,
                      ))
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  totalAmount.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: bgcolor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 7,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transactions[index].transactionType,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (!transactions[index].transferred) {
                                        _transferAmount(transactions[index]);
                                      }
                                    },
                                    icon: Icon(Icons.compare_arrows)),
                                IconButton(
                                    onPressed: () {
                                      _showTransactionDetails(
                                          transactions[index]);
                                    },
                                    icon: Icon(Icons.visibility)),
                                IconButton(
                                    onPressed: () {
                                      _deleteTransaction(index);
                                    },
                                    icon: Icon(Icons.delete_forever))
                              ],
                            ),
                          ],
                        ).pSymmetric(v: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              transactions[index].amount.toString(),
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ).pSymmetric(v: 10),
                        if (transactions[index].transferred)
                          Row(
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
                },
              ),
            ),
          ],
        ),
      ).p(10),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTransactionDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddTransactionDialog extends StatefulWidget {
  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedTransactionType;
  double? _amount;
  String? _currency;
  String? _notes;

  List<String> transactionTypes = [
    'Wallet',
    'Credit Card',
    'Bank Transfer',
    'Cash',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Container(
            height: 370,
            width: 300,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text('Create New Account').centered(),
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedTransactionType,
                  items: transactionTypes.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTransactionType = newValue;
                    });
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Account Type',
                      hintText: "Select Account"),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a account type';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Amount',
                          hintText: "0.00"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
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
                    SizedBox(
                      width: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Currency',
                          hintText: "USD \$"),
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
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Notes',
                      hintText: "note"),
                  onSaved: (value) {
                    _notes = value!;
                  },
                ).pOnly(bottom: 20),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final transactionData = TransactionData(
                          amount: _amount!,
                          transactionType: _selectedTransactionType!,
                          currency: _currency!,
                          notes: _notes!,
                        );
                        Navigator.of(context).pop(transactionData);
                      }
                    },
                    child: Text('Add'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
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
  final TransactionData transaction;
  final Function(double, String) transferCallback;

  TransferDialog({required this.transaction, required this.transferCallback});

  @override
  _TransferDialogState createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  final _formKey = GlobalKey<FormState>();
  double? _transferAmount;
  String? _selectedTransactionType;
  List<String> transactionTypes = [
    'Wallet',
    'Bank Transfer',
    'Cash',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transfer Amount'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedTransactionType,
              items: transactionTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTransactionType = newValue;
                });
              },
              decoration: InputDecoration(labelText: 'Transaction Type'),
              validator: (value) {
                if (value == null) {
                  return 'Please select a transaction type';
                }
                return null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Transfer Amount'),
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
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.transferCallback(
                  _transferAmount!, _selectedTransactionType!);
              Navigator.of(context).pop();
            }
          },
          child: Text('Transfer'),
        ),
      ],
    );
  }
}

class TransactionDetailsDialog extends StatelessWidget {
  final TransactionData transaction;

  TransactionDetailsDialog({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Transaction Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Amount: ${transaction.amount}'),
          Text('Transaction Type: ${transaction.transactionType}'),
          Text('Currency: ${transaction.currency}'),
          Text('Notes: ${transaction.notes}'),
          if (transaction.transferred) Text('Status: Transferred'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
