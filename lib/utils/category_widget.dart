import 'package:flutter/material.dart';
import 'package:snabbudget/utils/transaction_card.dart';

import '../models/transaction.dart';
class CategoryWidget extends StatefulWidget {
  final List<Transaction> transactions;
  final List<String> months; 
  const CategoryWidget({super.key, required this.transactions, required this.months});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  Future<void> _selectDate(BuildContext context, bool from) async {
      final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if(from){
      if (picked != null && picked != selectedDateFrom) {
      setState(() {
        selectedDateFrom = picked;
        dateFromPicked = true;
      });
    }
    }else{
      if(picked != null && picked != selectedDateTo) {
      setState(() {
        selectedDateTo = picked;
        dateToPicked = true;
      });
    }
    }
  }
  String selectedType = "Income";
  bool dateFromPicked = false;
  bool dateToPicked = false;
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  List<String> types = [
    'Income',
    'Expense',
  ];
  List<Transaction> filteredTrsanctions = [
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
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
        padding: const EdgeInsets.symmetric(horizontal:20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft ,
              child: Text("Type", 
              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 13),)),
            const SizedBox(height: 10,), 
            Container(
             width: double.infinity,
             padding: const EdgeInsets.symmetric(vertical:15, horizontal: 5),
             decoration: BoxDecoration(
               color: Theme.of(context).primaryColor.withOpacity(0.1),
               borderRadius: BorderRadius.circular(5),
          border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 2.0,
          ),
        ),
              child: SizedBox(
                child: DropdownButton<String>(
                   value: selectedType,
                   onChanged: (newValue) {
                     setState(() {
                       selectedType = newValue as String;
                     });
                   },
                   items: types.map<DropdownMenuItem<String>>((String value) {
                     return DropdownMenuItem<String>(
                       value: value,
                       child: Text(value),
                     );
                   }).toList(),
                   hint: const Text('Select a type'),
                   dropdownColor: Theme.of(context).primaryColor,
                            icon: const Icon(Icons.arrow_drop_down),
                            underline: Container(
                 height: 1,
                 color: Theme.of(context).primaryColor,
                            ),
                            elevation: 1,
                            isExpanded: true,
                            isDense: true,
                            selectedItemBuilder: (BuildContext context) {
                 return types.map<Widget>((String value) {
                   return Container(
                     alignment: Alignment.centerLeft,
                     child: Padding(
                       padding: const EdgeInsets.symmetric(horizontal:8.0),
                       child: Text(
                         value,style: TextStyle(fontSize: 14 ,color: Theme.of(context).primaryColor.withOpacity(0.5), fontWeight: FontWeight.bold),
                       ),
                     ),
                   );
                 }).toList();
                            },
                 ),
              ),
            ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(
                  width: size.width/3,
                  child: Column(
                    children: [
                      Align(
                              alignment: Alignment.centerLeft ,
                              child: Text("From", 
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 13),)),
                            const SizedBox(height: 10,), 
                            Container(
                              width: size.width/3,
                             decoration: BoxDecoration(
                               color: Theme.of(context).primaryColor.withOpacity(0.1),
                               borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                          ),
                        ),
                              child: TextButton(onPressed: (){
                                _selectDate(context,true);
                              }, child:Text( !dateFromPicked? "Select Date":" ${selectedDateFrom.day} ${widget.months[selectedDateFrom.month]} ${selectedDateFrom.year} ", style: const TextStyle(color:Colors.black),)),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width/3,
                  child: Column(
                    children: [
                        Align(
                              alignment: Alignment.centerLeft ,
                              child: Text("To", 
                              style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 13),)),
                            const SizedBox(height: 10,), 
                            Container(
                              width: size.width/3,
                             decoration: BoxDecoration(
                               color: Theme.of(context).primaryColor.withOpacity(0.1),
                               borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2.0,
                          ),
                        ),
                              child:TextButton(onPressed: (){
                                _selectDate(context,false);
                              }, child: Text( !dateToPicked? "Select Date":" ${selectedDateTo.day} ${widget.months[selectedDateTo.month]} ${selectedDateFrom.year}", style: const TextStyle(color:Colors.black),)),
                            ),
                      ],
                  ),
                )
              ],)
          ],
        ),
      ),
      const SizedBox(height: 30,),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          height: size.height/1.8,
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Results")),
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Total: "),
                  Text("-\$458542", style:TextStyle(color: Colors.red))
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTrsanctions.length,
                  itemBuilder: (context, index) {
                    Transaction transaction = filteredTrsanctions[index];
                  return TransactionCard(transaction: transaction);
                },),
              )
            ],
          )
        ),
      )
      ],
    );
  }
}