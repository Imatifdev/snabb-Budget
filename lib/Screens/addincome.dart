// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_final_fields, depend_on_referenced_packages

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import '../models/IncomeDataMode.dart';
import '../models/transaction.dart';
import 'dashboard_screen.dart';
import 'schedule_transactions.dart';

class AddIncome extends StatefulWidget {
  static const routeName = "add-income";
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String file = "";
  TimeOfDay _selectedTime = TimeOfDay.now();

  final TextEditingController _noteController = TextEditingController();
  // DropdownItem? _selectedItem;
  // List<DropdownItem> _dropdownItems = [
  //   DropdownItem('Others', 'assets/images/others.png'),
  //   DropdownItem('Finance', 'assets/images/fiance.png'),
  //   DropdownItem('Income', 'assets/images/income.png'),
  // ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      _selectedTime = pickedTime;
    }
  }

  IncomeDataCategory? selectedCategory;
  List<IncomeData> incomeDatList = [];

//function for storing data and passing to another screen
  void _saveIncome() {
    if (_formKey.currentState!.validate() &&
        selectedCategory != null) {
      double amount = double.parse(_amountController.text);
      String name = _nameController.text;
      DateTime dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );
      DateTime time = DateTime(
        _selectedDate.hour,
        _selectedDate.minute,
      );

      String image = selectedCategory!.image;

      IncomeData expense = IncomeData(
        amount: amount,
        name: name,
        time: time,
        date: dateTime,
        category: selectedCategory!.name,
        imageurl: image,
      );

      setState(() {
        incomeDatList.add(expense);
        selectedCategory = null;
        transactions.add( Transaction(
          amount: int.parse(_amountController.text),
          category: TransactionCat.moneyTransfer,
          type: TransactionType.income,
          date: _selectedDate,
          imgUrl: image,
          name: _nameController.text,
          time: _selectedTime.format(context),
          
        ) );
        _nameController.clear();
        _amountController.clear();
      });
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
    }
  }

  void schedualeTransaction() {
    if (_amountController.text.isNotEmpty &&
        _nameController.text.isNotEmpty &&
        selectedCategory != null) {
      double amount = double.parse(_amountController.text);
      String name = _nameController.text;
      DateTime dateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
      );
      DateTime time = DateTime(
        _selectedDate.hour,
        _selectedDate.minute,
      );

      String image = selectedCategory!.image;


      setState(() {
        schedualedTransactions.add( Transaction(
          amount: int.parse(_amountController.text),
          category: TransactionCat.moneyTransfer,
          type: TransactionType.income,
          date: _selectedDate,
          imgUrl: image,
          name: _nameController.text,
          time: _selectedTime.format(context),
          
        ) );
        _nameController.clear();
        _amountController.clear();
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleTransactions(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FloatingActionButton.extended(
        onPressed: () {}, label: Text("Add").pSymmetric(h: 60));
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;

    FloatingActionButton.extended(
        onPressed: () {}, label: Text("Add").pSymmetric(h: 60));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("ADD INCOME",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17)),
        centerTitle: true,
        leading: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white,
                child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_rounded)))
            .p(10),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromRGBO(191, 240, 53, 1),
                Color.fromRGBO(143, 192, 6, 1),
                Color.fromRGBO(124, 168, 0, 1),
              ]),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18))),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Income Name (optional)",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      TextFormField(
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter a name';
                        //   }
                        //   if (value.length < 3) {
                        //     return 'Name must be at least 3 characters long';
                        //   }
                        //   return null;
                        // },
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.black),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                          fillColor: Colors.black.withOpacity(0.2),
                          hintText: "Income Name ",
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      Text(
                        "Amount ",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a valid amount';
                                }
                                if (value.isEmpty) {
                                  return 'Password must be at least 1 digit long';
                                }
                                return null;
                              },
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 20),
                                fillColor: Colors.black.withOpacity(0.2),
                                hintText: "Enter your amount: 0.00 ",
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          Icon(Icons.attach_money, color: Color(0xff2EA6C1))
                              .pSymmetric(h: 16)
                        ],
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      Text(
                        "Category ",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      SizedBox(
                        width: width / 1.3,
                        child: DropdownButtonFormField<IncomeDataCategory>(
                          value: selectedCategory,
                          hint: Text('Category'),
                          onChanged: (IncomeDataCategory? newValue) {
                            setState(() {
                              selectedCategory = newValue;
                            });
                          },
                          items: incomeCategories
                              .map((IncomeDataCategory category) {
                            return DropdownMenuItem<IncomeDataCategory>(
                              value: category,
                              child: Row(
                                children: [
                                  Image.asset(
                                    category.image,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(category.name),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
      
                        // DropdownButtonFormField<DropdownItem>(
                        //   hint: Text("Category"),
                        //   value: _selectedItem,
      
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.all(10),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        //   items: _dropdownItems.map((DropdownItem item) {
                        //     return DropdownMenuItem<DropdownItem>(
                        //       value: item,
                        //       child: Row(
                        //         children: [
                        //           Image.asset(
                        //             item.imagePath,
                        //             width: 30,
                        //             height: 30,
                        //           ),
                        //           SizedBox(width: 10),
                        //           Text(item.name),
                        //         ],
                        //       ),
                        //     );
                        //   }).toList(),
                        // ),
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context),
                              child: IgnorePointer(
                                child: TextFormField(
                                  controller: TextEditingController(
                                    text:
                                        '  ${DateFormat.yMMMd().format(_selectedDate)}',
                                  ),
                                  decoration: InputDecoration(
                                    labelText: 'Date',
                                    prefix: Icon(Icons.calendar_today),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: width / 3.3),
                          InkWell(
                            onTap: () => _selectTime(context),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 15),
                                Text(
                                  '${_selectedTime.hour}:${_selectedTime.minute}',
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xff2EA6C1)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.note_alt_outlined,
                            size: 35,
                          ).pOnly(right: 10),
                          Expanded(
                            child: TextFormField(
                              maxLines: 4,
                              controller: _noteController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                errorStyle: TextStyle(color: Colors.black),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                fillColor: Colors.black.withOpacity(0.2),
                                hintText: "notes",
                                alignLabelWithHint: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.file_present_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () async{
                            FilePickerResult? result = await FilePicker.platform.pickFiles();
                            if (result != null) {
                              setState(() {
                                file = result.names[0] as String;
                              });
                            }  
                            },child: Text("Add File")),
                            SizedBox(
                              width: 200,
                              child: Text(file, softWrap: true,)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Scheduled?",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff2EA6C1)),
                          ),
                        ],
                      )
                    ],
                  ).pSymmetric(h: 20),
                  SizedBox(
                    height: height / 20,
                  ),
                  Center(
                    child: SizedBox(
                      width: width / 2,
                      child: ElevatedButton(
                        onPressed: () {
                          _saveIncome();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Text("Add "),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnotherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Another Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
