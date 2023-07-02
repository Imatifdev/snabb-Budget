import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import '../models/currency_controller.dart';
import '../models/transaction.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:intl/intl.dart';

import '../models/transaction_controller.dart';

class BudgetScreen extends StatefulWidget {
  static const routeName = "budget-screen";
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final PageController _controller = PageController(initialPage: 0);
  final PageController _controller2 = PageController(initialPage: 0);
  String? currency = "";
  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }

  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Transaction> transactions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrency();
    TransactionData transactionData = TransactionData();
    transactionData.fetchTransactions(userId);
    transactions = transactionData.transactions;
    print(transactions);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String> categories = {
      AppLocalizations.of(context)!.travel: 'assets/images/travel.png',
      AppLocalizations.of(context)!.shopping: 'assets/images/shopping.png',
      AppLocalizations.of(context)!.transportation:
          'assets/images/transport.png',
      AppLocalizations.of(context)!.home: 'assets/images/home.png',
      AppLocalizations.of(context)!.healthSport: 'assets/images/health.png',
      AppLocalizations.of(context)!.family: 'assets/images/family.png',
      AppLocalizations.of(context)!.foodDrink: 'assets/images/food.png',
    };
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
                child: SizedBox(
              height: 50,
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
                  Text(
                    AppLocalizations.of(context)!.budget,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              ),
            )),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                        '${AppLocalizations.of(context)!.monthly} Expenses'),
                    subtitle: Text('Month: ${getMonthName(currentMonth)}'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        String category = categories.keys.toList()[index];
                        double totalExpense =
                            getMonthlyExpense(category, currentMonth);
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      categories.values.toList()[index]),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _controller.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 120),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          icon: const Icon(Icons
                                              .arrow_back_ios_new_rounded)),
                                      Text(
                                        "Monthly",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _controller.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 120),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.arrow_forward_ios_rounded))
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                category.capitalized,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat.yMMMd()
                                      .format(DateTime.now())),
                                  const Text(
                                    "%",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(DateFormat.yMMMd().format(DateTime.now()
                                      .add(const Duration(days: 30)))),
                                ],
                              ),
                              Container(
                                height: 5,
                                color: Colors.red,
                              ).pSymmetric(v: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Residual Amount"),
                                  Text(
                                      "$currency${totalExpense.toStringAsFixed(2)}")
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Yearly Expenses'),
                    subtitle: Text('Year: $currentYear'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: PageView.builder(
                      controller: _controller2,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        String category = categories.keys.toList()[index];
                        double totalExpense = getYearlyExpense(category);
                        return Card(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                      categories.values.toList()[index]),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            _controller2.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 120),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          icon: const Icon(Icons
                                              .arrow_back_ios_new_rounded)),
                                      Text(
                                        "Yearly",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _controller2.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 120),
                                              curve: Curves.bounceIn,
                                            );
                                          },
                                          icon: const Icon(
                                              Icons.arrow_forward_ios_rounded))
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                category.capitalized,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DateFormat.yMMMd()
                                      .format(DateTime.now())),
                                  const Text(
                                    "%",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(DateFormat.yMMMd().format(DateTime.now()
                                      .add(const Duration(days: 30)))),
                                ],
                              ),
                              Container(
                                height: 5,
                                color: Colors.red,
                              ).pSymmetric(v: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Residual Amount"),
                                  Text(
                                      "$currency${totalExpense.toStringAsFixed(2)}")
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getMonthName(int month) {
    final List<String> monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return monthNames[month - 1];
  }

  double getMonthlyExpense(String category, int month) {
    double totalExpense = 0;
    for (var transaction in transactions) {
      if (transaction.category.toString().split('.').last == category &&
          transaction.type == TransactionType.expense &&
          transaction.date.month == month) {
        totalExpense += transaction.amount;
      }
    }
    return totalExpense;
  }

  double getYearlyExpense(String category) {
    double totalExpense = 0;
    for (var transaction in transactions) {
      if (transaction.category.toString().split('.').last == category &&
          transaction.type == TransactionType.expense &&
          transaction.date.year == currentYear) {
        totalExpense += transaction.amount;
      }
    }
    return totalExpense;
  }
}
