import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/transaction_card.dart';
import '../models/transaction.dart';
import '../utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({Key? key}) : super(key: key);

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Transaction> transactions = [];
  num thisMonthBalance = 0;
  num nextMonthBalance = 0;
  bool isLoadConfirm = false;
  num balance = 0;
  int check = 0;
  num snabbWallet = 0;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  void getInfo() async {
    var docSnapshot2 = await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("data")
        .doc("userData")
        .get();
    if (docSnapshot2.exists) {
      Map<String, dynamic>? data = docSnapshot2.data();
      setState(() {
        balance = data!["balance"];
      });
    }
    var docSnapshot3 = await FirebaseFirestore.instance
    .collection('UserTransactions').doc(userId).collection("Accounts")
    .doc("snabbWallet").get();
    if(docSnapshot3.exists){
      Map<String, dynamic>? data = docSnapshot3.data();
      setState(() {
        snabbWallet = data!["amount"];
      });
    }
    print(userId);
  }

  Future<void> fetchTransactions() async {
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
    calculateTotalAmount(transactions);
  }

  void calculateTotalAmount(List<Transaction> transactions) {
  int currentYear = DateTime.now().year;
  int currentMonth = DateTime.now().month;
  int nextMonth = currentMonth + 1;
  num localThisMonthBalance = 0;
  num localNextMonthBalance = 0;

  for (Transaction transaction in transactions) {
    if (transaction.date.year == currentYear && transaction.date.month == currentMonth) {
      if (transaction.type == TransactionType.expense) {
        localThisMonthBalance -= transaction.amount;
      } else {
        localThisMonthBalance += transaction.amount;
      }
    }
    if (transaction.date.year == currentYear && transaction.date.month == nextMonth) {
      if (transaction.type == TransactionType.expense) {
        localNextMonthBalance -= transaction.amount;
      } else {
        localNextMonthBalance += transaction.amount;
      }
    }
  }

  setState(() {
    thisMonthBalance = localThisMonthBalance;
    nextMonthBalance = localNextMonthBalance;
    print("thissssss month $thisMonthBalance nexxxxt month $nextMonth");
  });
}


  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => getInfo());
      check++;
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
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.scheduledTransactions,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
            ),
            transactions.isNotEmpty? SizedBox(
              height: size.height - 200,
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  Transaction transaction = transactions[index];
                  return InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Confirm Transaction"),
                          content: const Text("Confirm your scheduled transaction"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text("Cancel"),
                            ),
                            TextButton(
                              onPressed: () async{
                                num updatedBalance;
                                num updatedSnabbWallet;
                                setState(() {
                                  isLoadConfirm = true;
                                });
                                Transaction confirmTransaction = 
                                Transaction(
                                  amount: transaction.amount,
                                  category: transaction.category,
                                  date: transaction.date,
                                  fileUrl: transaction.fileUrl,
                                  id: transaction.id,
                                  imgUrl: transaction.imgUrl,
                                  name: transaction.name,
                                  time: transaction.time,
                                  type: transaction.type, notes: transaction.notes                                  
                                  );
                                await FirebaseFirestore.instance.collection("UserTransactions")
                                .doc(userId).collection("transactions").add(confirmTransaction.toJson());
                                if(transaction.type == TransactionType.income){
                                  updatedBalance = balance+transaction.amount;
                                  updatedSnabbWallet = snabbWallet+transaction.amount;
                                }else{
                                  updatedBalance = balance-transaction.amount;
                                  updatedSnabbWallet = snabbWallet-transaction.amount;
                                }
                                await FirebaseFirestore.instance.collection("UserTransactions")
                                .doc(userId).collection("data").doc("userData")
                                .update({"balance": updatedBalance});
                                await FirebaseFirestore.instance.collection("UserTransactions")
                                .doc(userId).collection("SchedualTrsanactions").doc(transaction.id).delete();
                                await FirebaseFirestore.instance.collection("UserTransactions")
                                .doc(userId).collection("Accounts").doc("snabbWallet")
                                .update({'amount': updatedSnabbWallet}); 
                                setState(() {
                                  isLoadConfirm = false;
                                  transactions.removeWhere((transactionz) => transaction.id == transactionz.id);
                                });
                                Navigator.of(ctx).pop();
                              },
                              child: !isLoadConfirm? const Text("Confirm"):const CircularProgressIndicator(),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.add),
                        TransactionCard(transaction: transaction),
                      ],
                    ),
                  );
                },
              ),
            ):const Padding(
              padding:  EdgeInsets.all(40.0),
              child:  Center(child:  Text("No Schedualed Transactions")),
            ) ,
            
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
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
                          Text(AppLocalizations.of(context)!.thisMonth,
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text("$thisMonthBalance", 
                          style: TextStyle(
                            color: thisMonthBalance>=0? Colors.green:Colors.red,
                          ),)
                        ],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text(AppLocalizations.of(context)!.nextMonth,
                      style: const TextStyle(fontWeight: FontWeight.bold),),
                          Text("$nextMonthBalance",
                          style: TextStyle(
                            color: nextMonthBalance>=0? Colors.green:Colors.red,
                          ),
                          )
                        ],)
                      ],
                    ),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}
