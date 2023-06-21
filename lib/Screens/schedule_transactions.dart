import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/utils/transaction_card.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';
import 'dashboard_screen.dart';



List<Transaction> schedualedTransactions = [
  Transaction(
      name: "Money Transfer",
      time: "06:20 PM",
      date: DateTime.now(),
      imgUrl: "assets/images/home.png",
      type: TransactionType.expense,
      category: TransactionCat.moneyTransfer,
      amount: 22),
  Transaction(
      name: "Shopping",
      time: "02:26 PM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/shopping.png",
      type: TransactionType.expense,
      category: TransactionCat.shopping,
      amount: 100),
  Transaction(
      name: "Taxi",
      time: "02:00 PM",
      date: DateTime.now().subtract(const Duration(days: 2)),
      imgUrl: "assets/images/travel.png",
      type: TransactionType.expense,
      category: TransactionCat.taxi,
      amount: 80),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      imgUrl: "assets/images/income.png",
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      date: DateTime.now().subtract(const Duration(days: 3)),
      imgUrl: "assets/images/others.png",
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      date: DateTime.now().subtract(const Duration(days: 3)),
      imgUrl: "assets/images/income.png",
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/others.png",
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
  Transaction(
      name: "Salary",
      time: "10:26 AM",
      date: DateTime.now().subtract(const Duration(days: 1)),
      imgUrl: "assets/images/income.png",
      type: TransactionType.income,
      category: TransactionCat.moneyTransfer,
      amount: 2000),
  Transaction(
      name: "Bills",
      time: "09:26 PM",
      imgUrl: "assets/images/others.png",
      date: DateTime.now().subtract(const Duration(days: 2)),
      type: TransactionType.expense,
      category: TransactionCat.bills,
      amount: 1000),
];

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({super.key});

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Column(
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
                const Text(
                  "Schedualed Transactions",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
          SizedBox(
              height: size.height-100,
              child: ListView.builder(
                itemCount: schedualedTransactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = schedualedTransactions[index];
                  return InkWell(
                    onTap: (){
                      showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text("Confirm Transaction"),
                  content: const Text("Confirm your schedualed transaction"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child:const Text("Cancel", style: TextStyle(color: Colors.red),),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          transactions.add(transaction);
                          if(transaction.type == TransactionType.income){
                            totalBalance = totalBalance+transaction.amount; 
                          }
                          else if(transaction.type == TransactionType.expense){
                            totalBalance = totalBalance-transaction.amount; 
                          }
                        });
                        Navigator.of(context).push( MaterialPageRoute(builder: (context) => const HomeScreen()),);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        child:Text("Confirm", style: TextStyle(color: Theme.of(context).primaryColor),),
                      ),
                    ),
                    
                  ],
                ),
              );
                    },
                    child: TransactionCard(transaction: transaction));
                },),
            ),
          ],
        )),
    );
  }
}
