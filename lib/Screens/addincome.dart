// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';

import '../utils/mycolors.dart';
import 'package:velocity_x/velocity_x.dart';

class AddIncome extends StatefulWidget {
  static const routeName = "add-income";
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DropdownItem? _selectedItem;

  List<DropdownItem> _dropdownItems = [
    DropdownItem('Others', 'assets/images/others.png'),
    DropdownItem('Finance', 'assets/images/fiance.png'),
    DropdownItem('Income', 'assets/images/income.png'),
  ];
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
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
      // floatingActionButton: Center(
      //   child: FloatingActionButton.extended(
      //       onPressed: () {}, label: Text("Add").pSymmetric(h: 60)),
      // ),
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
      body: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Income Name",
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
                              if (value.length < 1) {
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
                      child: DropdownButtonFormField<DropdownItem>(
                        hint: Text("Category"),
                        value: _selectedItem,
                        onChanged: (DropdownItem? newValue) {
                          setState(() {
                            _selectedItem = newValue;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: _dropdownItems.map((DropdownItem item) {
                          return DropdownMenuItem<DropdownItem>(
                            value: item,
                            child: Container(
                              child: Row(
                                children: [
                                  Image.asset(
                                    item.imagePath,
                                    width: 30,
                                    height: 30,
                                  ),
                                  SizedBox(width: 10),
                                  Text(item.name),
                                ],
                              ),
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
                            onPressed: () {}, child: Text("Add File"))
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
                  height: height/12,
                ),
                Center(
                  child: SizedBox(
                    width: width / 2,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: Text("Add File"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
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
