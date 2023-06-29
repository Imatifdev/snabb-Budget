import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/utils/transaction_card.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';



// List<Transaction> schedualedTransactions = [
//   Transaction(
//       name: "Money Transfer",
//       time: "06:20 PM",
//       date: DateTime.now(),
//       imgUrl: "assets/images/home.png",
//       type: TransactionType.expense,
//       category: TransactionCat.moneyTransfer,
//       amount: 22),
//   Transaction(
//       name: "Shopping",
//       time: "02:26 PM",
//       date: DateTime.now().subtract(const Duration(days: 1)),
//       imgUrl: "assets/images/shopping.png",
//       type: TransactionType.expense,
//       category: TransactionCat.shopping,
//       amount: 100),
//   Transaction(
//       name: "Taxi",
//       time: "02:00 PM",
//       date: DateTime.now().subtract(const Duration(days: 2)),
//       imgUrl: "assets/images/travel.png",
//       type: TransactionType.expense,
//       category: TransactionCat.taxi,
//       amount: 80),
//   Transaction(
//       name: "Salary",
//       time: "10:26 AM",
//       imgUrl: "assets/images/income.png",
//       date: DateTime.now().subtract(const Duration(days: 3)),
//       type: TransactionType.income,
//       category: TransactionCat.moneyTransfer,
//       amount: 2000),
//   Transaction(
//       name: "Bills",
//       time: "09:26 PM",
//       date: DateTime.now().subtract(const Duration(days: 3)),
//       imgUrl: "assets/images/others.png",
//       type: TransactionType.expense,
//       category: TransactionCat.bills,
//       amount: 1000),
//   Transaction(
//       name: "Salary",
//       time: "10:26 AM",
//       date: DateTime.now().subtract(const Duration(days: 3)),
//       imgUrl: "assets/images/income.png",
//       type: TransactionType.income,
//       category: TransactionCat.moneyTransfer,
//       amount: 2000),
//   Transaction(
//       name: "Bills",
//       time: "09:26 PM",
//       date: DateTime.now().subtract(const Duration(days: 1)),
//       imgUrl: "assets/images/others.png",
//       type: TransactionType.expense,
//       category: TransactionCat.bills,
//       amount: 1000),
//   Transaction(
//       name: "Salary",
//       time: "10:26 AM",
//       date: DateTime.now().subtract(const Duration(days: 1)),
//       imgUrl: "assets/images/income.png",
//       type: TransactionType.income,
//       category: TransactionCat.moneyTransfer,
//       amount: 2000),
//   Transaction(
//       name: "Bills",
//       time: "09:26 PM",
//       imgUrl: "assets/images/others.png",
//       date: DateTime.now().subtract(const Duration(days: 2)),
//       type: TransactionType.expense,
//       category: TransactionCat.bills,
//       amount: 1000),
// ];

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({super.key});

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  List<Transaction> transactions = [];
  int check = 0;
  int thisMonth = 0;
  int nextMonth = 0;
  int totalAmount = 0;
  Future<List<Transaction>> fetchTransactions() async {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
      .collection('UserTransactions')
      .doc(userId)
      .collection('SchedualTrsanactions')
      .get();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;
  for (var document in documents) {
    Transaction transaction = Transaction.fromJson(document.data(), document.id);
    transactions.add(transaction);
  }
  setState(() {
    transactions = transactions;
  });
  return transactions;
}
  
  int calculateTotalAmount(List<Transaction> transactions, int month) {
  

   for (Transaction transaction in transactions) {
    if (transaction.date.month == month) {
      if (transaction.type == TransactionType.expense) {
        totalAmount -= transaction.amount;
      } else {
        totalAmount += transaction.amount;
      }
    }
  }
  return totalAmount;
}
  
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
  int currentMonth = now.month;
  int nextMonth = currentMonth + 1;
    if(check == 0){
      WidgetsBinding.instance.addPostFrameCallback((_) async{ 
        List<Transaction> transactionz = await fetchTransactions();
        thisMonth = calculateTotalAmount(transactionz, currentMonth);
        nextMonth = calculateTotalAmount(transactionz, nextMonth);
        });
      check = 1;
    }
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
                Text(
                  AppLocalizations.of(context)!.scheduledTransactions,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
          SizedBox(
              height: size.height-200,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
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
                      )
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          //transactions.add(transaction);
                          if(transaction.type == TransactionType.income){
                            totalAmount = totalAmount+transaction.amount; 
                          }
                          else if(transaction.type == TransactionType.expense){
                            totalAmount = totalAmount-transaction.amount; 
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
            SizedBox(
              height: size.height/8.5,
              width: size.width-22,
              child:  Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                      ),
                elevation: 5,
                color: const Color.fromRGBO(245, 246, 255,1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(AppLocalizations.of(context)!.thisMonth),
                        Text(thisMonth.toString(), 
                        style: TextStyle(
                          color: thisMonth>=0? Colors.green:Colors.red,
                        ),)
                      ],),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(AppLocalizations.of(context)!.nextMonth),
                        Text(nextMonth.toString(),
                        style: TextStyle(
                          color: nextMonth>=0? Colors.green:Colors.red,
                        ),
                        )
                      ],)
                    ],
                  ),
                ),
              ))
          ],
        )),
    );
  }
}
