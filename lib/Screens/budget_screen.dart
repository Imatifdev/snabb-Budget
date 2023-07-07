import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import '../models/budget.dart';
import '../models/currency_controller.dart';
import '../models/transaction.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

import '../models/transaction_controller.dart';

class BudgetScreen extends StatefulWidget {
  static const routeName = "budget-screen";
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String? currency = "";
  getCurrency() async {
    CurrencyData currencyData = CurrencyData();
    currency = await currencyData.fetchCurrency(userId);
    //currency = currencyData.currency;
    print(currency);
  }
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  List<Transaction> transactions = [];
  List<Budget> budgetList = [];
  int check = 0;

  void fetchBudgets() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection("UserTransactions")
      .doc(userId)
      .collection("budgets")
      .get();
  if (querySnapshot.docs.isNotEmpty) {
    setState(() {
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      Budget budget = Budget.fromJson(data, documentSnapshot.id);
      budgetList.add(budget);
    }
    });
  }
}
  
  void addBudget()async{
     await showDialog(
      context: context,
      builder: (BuildContext context) => const AddNewBudget(),
    );
  }
  
  Map<String, dynamic> calculate(
    List<Transaction> transactions, Budget budget) {
  double totalAmount = 0;
  int transactionCount = 0;

  for (Transaction transaction in transactions) {
    if (transaction.category == budget.category &&
        transaction.date.isAfter(budget.startDate) &&
        transaction.date.isBefore(budget.endDate)) {
      totalAmount += transaction.amount;
      transactionCount++;
    }
  }

  print(totalAmount);
  print(transactionCount);

  return {
    'totalAmount': totalAmount,
    'transactionCount': transactionCount,
  };
}

  void deleteBudget(String id)async{
    await FirebaseFirestore.instance
      .collection("UserTransactions")
      .doc(userId)
      .collection("budgets").doc(id).delete();
      setState(() {
        //check = 0;
        budgetList.removeWhere((bodget) => bodget.id == id);
      });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrency();
    //fetchBudgets();
    TransactionData transactionData = TransactionData();
    transactionData.fetchTransactions(userId);
    transactions = transactionData.transactions;
    print(transactions);
  }

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => fetchBudgets());
      check++;
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(onPressed: (){
        addBudget();
      }, child: const Icon(Icons.add)),
      body: SafeArea(
        child: SizedBox(
          width: size.width,
          child: Column(children: [
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
            budgetList.isNotEmpty? Expanded(child: 
            ListView.builder(
              itemCount: budgetList.length,
              itemBuilder: (context, index) {
                Budget budget = budgetList[index];
                return budgetCard(budget, context);
              },
              )): const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("No Budget"),
              )      
          ]),
        )
      ),
    );
  }

  Padding budgetCard(Budget budget, BuildContext context) {
    final result = calculate(transactions,budget);
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(budget.name, style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold),),
                            IconButton(onPressed: (){
                              deleteBudget(budget.id);
                            }, icon: const Icon(Icons.delete, color: Colors.red,))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(budget.category.name.capitalized, style: TextStyle(fontSize: 18, color: Theme.of(context).primaryColor),),
                            Image.asset(budget.imgUrl),
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("From", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("${budget.startDate.day}/${budget.startDate.month}/${budget.startDate.year}")
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("To", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text("${budget.endDate.day}/${budget.endDate.month}/${budget.endDate.year}")
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text("Transactions", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text(result['transactionCount'].toString())
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Total", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            Text(currency.toString()+result['totalAmount'].toString(), style: const TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}

class AddNewBudget extends StatefulWidget {

  const AddNewBudget({super.key});

  @override
  _AddNewBudgetState createState() => _AddNewBudgetState();
}

class _AddNewBudgetState extends State<AddNewBudget> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController _name = TextEditingController();
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  DateTime? startDate;
  DateTime? endDate;
  TransactionCat? selectedCategory;
  String errMsg = "";

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
      });
    }
  }

  String getImgUrlForCategory(TransactionCat category) {
  final Map<TransactionCat, String> categoryImgUrls = {
    TransactionCat.travelling: 'assets/images/travel.png',
    TransactionCat.shopping: 'assets/images/shopping.png',
    TransactionCat.transport: 'assets/images/transport.png',
    TransactionCat.home: 'assets/images/home.png',
    TransactionCat.health: 'assets/images/health.png',
    TransactionCat.family: 'assets/images/family.png',
    TransactionCat.foodDrink: 'assets/images/food.png',
  };

  return categoryImgUrls[category] ?? '';
}
  


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
                const Text('Create New Budget').centered(),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _name,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Name',
                          hintText: "Budget Name"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an amount';
                        }
                        return null;
                      },
                    ),
                
                Column(
                  children: [
                    Text("Select Category"),
                    DropdownButton<TransactionCat>(
      value: selectedCategory,
      hint: Text('Select Category'),
      onChanged: (TransactionCat? newValue) {
        setState(() {
          selectedCategory = newValue;
        });
      },
      items: TransactionCat.values.map<DropdownMenuItem<TransactionCat>>(
        (TransactionCat value) {
          return DropdownMenuItem<TransactionCat>(
            value: value,
            child: Text(
              value.toString().split('.').last,
            ),
          );
        },
      ).toList(),
    ),
                  ],
                ),
                Text(errMsg, style: const TextStyle(color: Colors.red),),
                Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => _selectStartDate(context),
          child: Container(
            width: 100,
            height: 50,
            color:Theme.of(context).primaryColor.withOpacity(0.5),
            child: Center(
              child: Text(
                startDate != null
                    ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                    : 'Start Date',
                style: TextStyle(),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _selectEndDate(context),
          child: Container(
            width: 100,
            height: 50,
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            child: Center(
              child: Text(
                endDate != null
                    ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                    : 'End Date',
              ),
            ),
          ),
        ),
      ],
    ),
                
                !isLoading? SizedBox(
                  width: size.width-150,
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate() && selectedCategory!=null && startDate!=null && endDate != null) {
                        setState(() {
                          isLoading = true;
                          errMsg = "";
                        });
                        Budget budget = Budget(
                          id: "khbdne", 
                          transactionNum: 0, 
                          total: 0, 
                          name: _name.text.trim(), 
                          category: selectedCategory as TransactionCat, 
                          startDate: startDate as DateTime, 
                          endDate: endDate as DateTime, 
                          imgUrl: getImgUrlForCategory(selectedCategory as TransactionCat));
                        await FirebaseFirestore.instance.collection("UserTransactions").doc(userId).collection("budgets").add({
                          "id":budget.id,
                          "transactionNum":budget.transactionNum,
                          "name":budget.name,
                          "category": budget.category.toString() ,
                          "startDate":budget.startDate,
                          "endDate":budget.endDate,
                          "total":0,
                          "imgUrl":budget.imgUrl
                        });
                        setState(() {
                          isLoading  =false;
                        });
                        Navigator.of(context).pop();  
                      }else{
                        setState(() {
                          errMsg = "Select a category";
                        });
                      }
                    },
                    child: isLoading? const CircularProgressIndicator(color: Colors.white,):const Text('Add'),
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