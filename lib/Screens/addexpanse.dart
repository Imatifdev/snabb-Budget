// ignore_for_file: unused_local_variable, prefer_const_constructors, depend_on_referenced_packages

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/IncomeDataMode.dart';
import '../models/expanseDataModel.dart';
import '../models/transaction.dart';
import 'dashboard_screen.dart';

class AddExpanse extends StatefulWidget {
  static const routeName = "add-expense";
  const AddExpanse({super.key});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String file = "";
  TimeOfDay _selectedTime = TimeOfDay.now();

  final TextEditingController _noteController = TextEditingController();
  DropdownItem? _selectedItem;

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

  ExpanseDataCategory? selectedCategory;
  List<ExpanseData> incomeDatList = [];

//function for storing data and passing to another screen
  void _saveExpense() {
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

      ExpanseData expense = ExpanseData(
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
        transactions.add(Transaction(
          amount: int.parse(_amountController.text),
          category: TransactionCat.moneyTransfer,
          type: TransactionType.expense,
          date: _selectedDate,
          imgUrl: image,
          name: _nameController.text,
          time: _selectedTime.toString(),
        ));
        _nameController.clear();
        _amountController.clear();
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  List<File> _selectedFiles = [];

  Future<void> _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
    );

    if (result != null && result.files.isNotEmpty) {
      List<File> pickedFiles = result.paths.map((path) => File(path!)).toList();
      setState(() {
        _selectedFiles.addAll(pickedFiles);
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
  }

  Widget _buildFilePreview() {
    return Expanded(
      child: ListView.builder(
        itemCount: _selectedFiles.length,
        itemBuilder: (context, index) {
          File file = _selectedFiles[index];
          return ListTile(
            leading: _getFileIcon(file),
            // title: Text('File ${index + 1}'),
            //subtitle: Text(file.path),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _removeFile(index),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilePreview1() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Adjust the number of columns as needed
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: _selectedFiles.length,
        itemBuilder: (context, index) {
          File file = _selectedFiles[index];
          return GestureDetector(
            onTap: () {
              // Perform any action when the file is tapped
              print('File ${index + 1} tapped');
            },
            child: Stack(
              children: [
                Container(
                    height: 200,
                    width: 200,
                    child: _getFilePreviewWidget(file)),
                Positioned(
                    top: -10,
                    right: -10,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete_sharp,
                        size: 20,
                        color: Colors.red,
                      ),
                      onPressed: () => _removeFile(index),
                    )),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _getFilePreviewWidget(File file) {
    if (file.path.endsWith('.pdf')) {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.picture_as_pdf),
      );
    } else if (file.path.endsWith('.jpg') ||
        file.path.endsWith('.jpeg') ||
        file.path.endsWith('.png')) {
      return Image.file(file, fit: BoxFit.cover);
    } else {
      return Container(
        color: Colors.grey[300],
        child: const Icon(Icons.attach_file),
      );
    }
  }

  Widget _getFileIcon(File file) {
    if (file.path.endsWith('.pdf')) {
      return const Icon(Icons.picture_as_pdf);
    } else if (file.path.endsWith('.jpg') ||
        file.path.endsWith('.jpeg') ||
        file.path.endsWith('.png')) {
      return Image.file(file, width: 24, height: 24); // Display image file
    } else {
      return const Icon(Icons.attach_file);
    }
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
        title: Text("ADD EXPENSE",
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
                Color.fromRGBO(231, 147, 86, 1),
                Color.fromRGBO(250, 129, 51, 1),
                Color.fromRGBO(241, 96, 9, 1),
              ]),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18))),
        ),
      ),
      body: SingleChildScrollView(
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
                      "Expense Name",
                      style: TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
                    ),
                    SizedBox(
                      height: height / 80,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters long';
                        }
                        return null;
                      },
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.black),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                        fillColor: Colors.black.withOpacity(0.2),
                        hintText: "Expense Name ",
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
                      style: TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
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
                              hintText: "0.0 ",
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
                      style: TextStyle(fontSize: 16, color: Color(0xff2EA6C1)),
                    ),
                    SizedBox(
                      height: height / 80,
                    ),
                    SizedBox(
                      width: width / 1.3,
                      child: DropdownButtonFormField<ExpanseDataCategory>(
                        value: selectedCategory,
                        hint: Text('Category'),
                        onChanged: (ExpanseDataCategory? newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        },
                        items: expanseCategories
                            .map((ExpanseDataCategory category) {
                          return DropdownMenuItem<ExpanseDataCategory>(
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
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () => _selectDate(context),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 15),
                              Text(
                                '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff2EA6C1)),
                              ),
                            ],
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
                            },
                            child: Text("Add File")),
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
                      onPressed: () {_saveExpense();},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text("Add"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownItem {
  final String name;
  final String imagePath;

  DropdownItem(this.name, this.imagePath);
}
