// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/balanceProvider.dart';
import '../models/balance_data.dart';
import '../utils/balance_ex.dart';
import '../utils/custom_drawer.dart';
import '../utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../globals.dart' as globals;

import 'dashboard_screen.dart';

class BalanceScreen extends StatefulWidget {
  static const routeName = "balance-screen";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  BalanceScreen({super.key});
  @override
  State<BalanceScreen> createState() => _BalanceScreenState();
}


class _BalanceScreenState extends State<BalanceScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: widget.scaffoldKey,
        extendBody: true,
        drawer: CustomDrawer(),
        backgroundColor: Colors.grey[100],
        body: Column(
          children: [
            Card(
              child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
               IconButton(
                            onPressed: () {
                              widget.scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/images/menu.png"),
                              size: 40,
                            )),
                const Text(
                  "DEBTS",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Residual Payment",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Consumer<BalanceProvider>(
                  builder: (context, balanceProvider, _) {
                    String balanceText;
                    if (balanceProvider.totalBalance >= 0) {
                      balanceText = NumberFormat.currency(symbol: '\$')
                          .format(balanceProvider.totalBalance);
                    } else {
                      balanceText =
                          '-${NumberFormat.currency(symbol: '\$').format(-balanceProvider.totalBalance)}';
                    }
                    return Text(balanceText);
                  },
                ),
              ],
            ).pSymmetric(h: 20),
            Consumer<BalanceProvider>(
              builder: (context, balanceProvider, _) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: balanceProvider.balanceList.length,
                    itemBuilder: (context, index) {
                      final data = balanceProvider.balanceList[index];
                      String status;
                      if (data.balanceType == "Credit") {
                        status = "Paid";
                      } else if (data.balanceType == "Debit") {
                        status = "Pending";
                      } else {
                        status = "";
                      }
                      return Column(
                        children: [
                          Stack(children: [
                            Card(
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: bgcolor,
                                  ),
                                  child: data.balanceType == "Credit"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/images/paid.png"),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${data.balanceType}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'You',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_right_alt_sharp,
                                                          size: 35,
                                                          color:
                                                              data.balanceType ==
                                                                      "Credit"
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        Text(
                                                          data.person,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ).pOnly(left: 20),
                                              ],
                                            ).pSymmetric(v: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${DateFormat.yMMMd().format(data.currentDate)}'),
                                                Text(
                                                  "%",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '${DateFormat.yMMMd().format(data.dueDate)}'),
                                              ],
                                            ),
                                            Container(
                                              height: 5,
                                              color:
                                                  data.balanceType == "Credit"
                                                      ? Colors.green
                                                      : Colors.red,
                                            ).pSymmetric(v: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('0.00 Rs'),
                                                Text(
                                                  "0.00 Rs",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    ' ${NumberFormat.currency(symbol: '\$').format(data.balance)}'),
                                              ],
                                            ),
                                            if (data.balanceType == "Debit")
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      "assets/images/notpaid.png"),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        '${data.balanceType}',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Residual Payment',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    ' $status  ${NumberFormat.currency(symbol: '\$').format(data.balance)}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ).p(20)
                                      //debit
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset(
                                                    "assets/images/notpaid.png"),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${data.balanceType}',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          data.person,
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .arrow_right_alt_sharp,
                                                          size: 35,
                                                          color:
                                                              data.balanceType ==
                                                                      "Credit"
                                                                  ? Colors.green
                                                                  : Colors
                                                                      .black,
                                                        ),
                                                        Text(
                                                          'You',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ).pOnly(left: 20)
                                              ],
                                            ).pSymmetric(v: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    '${DateFormat.yMMMd().format(data.currentDate)}'),
                                                Text(
                                                  "%",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '${DateFormat.yMMMd().format(data.dueDate)}'),
                                              ],
                                            ),
                                            Container(
                                              height: 5,
                                              color:
                                                  data.balanceType == "Credit"
                                                      ? Colors.green
                                                      : Colors.red,
                                            ).pSymmetric(v: 5),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text('0.00 Rs'),
                                                Text(
                                                  "0.00 Rs",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    ' ${NumberFormat.currency(symbol: '\$').format(data.balance)}'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Residual Payment',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    ' $status  ${NumberFormat.currency(symbol: '\$').format(data.balance)}',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ).p(20)),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: IconButton(
                                    onPressed: () {}, icon: Icon(Icons.delete)))
                          ]),
                        ],
                      );
                    },
                  ).p(10),
                );
              },
            ),
          ],
        ),
        floatingActionButton: BlanceExpandableFloating(),
        //  Column(
        //   mainAxisAlignment: MainAxisAlignment.end,
        //   children: [
        //     FloatingActionButton(
        //     onPressed: () => _openAddBalanceDialog(context, 'Credit'),
        //       child: Icon(Icons.add),
        //     ),
        //     SizedBox(height: 16),
        //     FloatingActionButton(
        //       onPressed: () => _openAddBalanceDialog(context, 'Debit'),
        //       child: Icon(Icons.remove),
        //     ),
        //   ],
        // ),
      ),
    );
  }

  void _openAddBalanceDialog(BuildContext context, String balanceType) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddBalanceDialog(balanceType: balanceType);
      },
    );
  }
  
  ListTile drawerTile(String imgUrl, String title) {
    return ListTile(
        leading: ImageIcon(
          AssetImage(imgUrl),
          color: Colors.white,
          size: 38,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ));
  }
}

class ExpandableFloatingActionButton extends StatefulWidget {
  const ExpandableFloatingActionButton({super.key});

  @override
  _ExpandableFloatingActionButtonState createState() =>
      _ExpandableFloatingActionButtonState();
}

class _ExpandableFloatingActionButtonState
    extends State<ExpandableFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;

      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (_isExpanded)
          if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.red,
            child: const ImageIcon(AssetImage("assets/images/minus.png")),
          ),
        if (_isExpanded) const SizedBox(height: 16),
        if (_isExpanded)
          FloatingActionButton(
            onPressed: () {},
            heroTag: null,
            backgroundColor: Colors.green,
            child: const Icon(Icons.add),
          ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: SizedBox(
              height: 60,
              width: 60,
              child: FittedBox(
                  child: FloatingActionButton(
                backgroundColor: const Color.fromRGBO(46, 166, 193, 1),
                onPressed: _toggleExpanded,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                //  heroTag: null,
                child: AnimatedIcon(
                  icon: AnimatedIcons.add_event,
                  progress: _animation,
                ),
              ))),
        ),
      ],
    );
  }
}

class AddBalanceDialog extends StatefulWidget {
  final String balanceType;

  AddBalanceDialog({required this.balanceType});

  @override
  _AddBalanceDialogState createState() => _AddBalanceDialogState();
}

class _AddBalanceDialogState extends State<AddBalanceDialog> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _balanceController = TextEditingController();
  TextEditingController _currentDateController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  TextEditingController _person = TextEditingController();

  DateTime _currentDate = DateTime.now();
  DateTime _dueDate = DateTime.now();

  @override
  void dispose() {
    _balanceController.dispose();
    _currentDateController.dispose();
    _dueDateController.dispose();
    _person.dispose();
    super.dispose();
  }

  void _saveBalanceData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final balanceData = BalanceData(
          balanceType: widget.balanceType,
          balance: double.parse(_balanceController.text),
          currentDate: _currentDate,
          dueDate: _dueDate,
          person: _person.text);

      Provider.of<BalanceProvider>(context, listen: false)
          .addBalance(balanceData);

      Navigator.pop(context);
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller, DateTime initialDate) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        controller.text = DateFormat.yMMMd().format(selectedDate);
        if (controller == _currentDateController) {
          _currentDate = selectedDate;
        } else if (controller == _dueDateController) {
          _dueDate = selectedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: 440,
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'New ${widget.balanceType}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _balanceController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        decoration:
                            InputDecoration(labelText: 'Balance Amount'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the balance amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    Image.asset(
                      "assets/images/cal.png",
                      height: 50,
                      width: 50,
                    ),
                  ],
                ).pSymmetric(v: 10),
                Row(
                  children: [
                    Text(
                      "Create the associated \ntransaction (Expanse)",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.wallet)),
                        Text(
                          "Wallet:",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
                InkWell(
                  onTap: () => _selectDate(
                      context, _currentDateController, _currentDate),
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: _currentDateController,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the current date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () =>
                            _selectDate(context, _dueDateController, _dueDate),
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: _dueDateController,
                            decoration: InputDecoration(
                              labelText: 'Payback Date',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the due date';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  controller: _person,
                  decoration: InputDecoration(
                    labelText: 'To',
                    prefixIcon: Icon(Icons.person_2),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => _saveBalanceData(context),
          child: Text('Save'),
        ),
      ],
    );
  }
}
