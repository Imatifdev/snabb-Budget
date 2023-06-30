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
  String selectedType = "All";
  bool dateFromPicked = false;
  bool dateToPicked = false;
  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();
  List<String> types = [
    "All",
    'income',
    'expense',
  ];
  double totalAmount = 0.0;
  
  List<Transaction> getFilteredTransactions() {
  List<Transaction> filteredList = widget.transactions;
  if (selectedType == 'income') {
    filteredList = filteredList.where((transaction) => transaction.type == TransactionType.income).toList();
  } else if (selectedType == 'expense') {
    filteredList = filteredList.where((transaction) => transaction.type == TransactionType.expense).toList();
  }

  filteredList = filteredList.where((transaction) => transaction.date.isAfter(selectedDateFrom)).toList();

  filteredList = filteredList.where((transaction) => transaction.date.isBefore(selectedDateTo)).toList();

  // Calculate the total amount
 // setState(() {
    totalAmount = filteredList.fold(0, (double total, transaction) {
    if (transaction.type == TransactionType.income) {
      return total + transaction.amount;
    } else {
      return total - transaction.amount;
    }
  });
 // });
  return filteredList;
}
  
  double calculateTotalBalance() {
    double totalBalance = 0.0;

    List<Transaction> filteredList = getFilteredTransactions();

    for (var transaction in filteredList) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text("Total: "),
                  Text(
          '\$${calculateTotalBalance()}',
          style: TextStyle(
            color: calculateTotalBalance() < 0 ? Colors.red : Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
                ],
              ),
            getFilteredTransactions().isNotEmpty?
            Expanded(
            child: ListView.builder(
              itemCount: getFilteredTransactions().length,
              itemBuilder: (BuildContext context, int index) {
                final transaction = getFilteredTransactions()[index];
                return TransactionCard(transaction: transaction);
              },
            ),
          ): const Padding(
            padding:  EdgeInsets.symmetric(vertical:100.0),
            child:  Center(child: Text("No Transactions for the given filter", textAlign: TextAlign.center,)),
          ),
            ],
          )
        ),
      )
      ],
    );
  }
}