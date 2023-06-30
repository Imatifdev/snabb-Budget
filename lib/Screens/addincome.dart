// ignore_for_file: unused_local_variable, prefer_const_constructors, prefer_final_fields, depend_on_referenced_packages, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import '../models/IncomeDataMode.dart';
import 'schedule_transactions.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';


class AddIncome extends StatefulWidget {
  static const routeName = "add-income";
  final double balance;
  const AddIncome({super.key, required this.balance});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String pathFile = "";
  TimeOfDay _selectedTime = TimeOfDay.now();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController _noteController = TextEditingController();
  String formatTime = "";
  bool isLoading = false;
  final storage = FirebaseStorage.instance;


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _selectedDate = pickedDate;
      print(_selectedDate);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null) {
      _selectedTime = pickedTime;
      formatTime = "${_selectedTime.hour}:${_selectedTime.minute}";
    }
  }

  Future<void> _takePicture() async {
  final picker = ImagePicker();
  var pickImage = await picker.pickImage(source: ImageSource.camera);
  var pathPickImage = pickImage!.path;

  if (pickImage != null) {
    setState(() {
      pathFile = pickImage!.path;
    });

    final File file = File(pickImage.path);
    final String fileName = '${DateTime.now()}.jpg';
    final Reference storageRef = storage.ref().child(fileName);
    final UploadTask uploadTask = storageRef.putFile(file);

    await uploadTask.whenComplete(() async {
      final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        pathPickImage = imageUrl ;
      });
    });
  }
}


  IncomeDataCategory? selectedCategory;
  List<IncomeData> incomeDatList = [];

//function for storing data and passing to another screen
  void _saveIncome() async {
  if (_formKey.currentState!.validate() && selectedCategory != null) {
    setState(() {
      isLoading = true; // Show the progress indicator
    });

    double amount = double.parse(_amountController.text);
    String name = _nameController.text.isNotEmpty
        ? _nameController.text
        : selectedCategory!.name; // Use category name if name is not provided
    DateTime dateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    String image = selectedCategory!.image;

    // Upload image to Firebase Cloud Storage
    String imageUrl = "";
    if (pathFile.isNotEmpty) {
      Reference storageReference = FirebaseStorage.instance.ref().child(DateTime.now().toString());
      TaskSnapshot taskSnapshot = await storageReference.putFile(File(pathFile));
      imageUrl = await taskSnapshot.ref.getDownloadURL();
    }

    // Save data to Firestore
    DocumentReference transactionRef = await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("transactions")
        .add({
      "name": name,
      "amount": int.parse(_amountController.text),
      "category": "TransactionCat.moneyTransfer",
      "type": "TransactionType.income",
      "date": _selectedDate,
      "time": formatTime,
      "imgUrl": image,
      "fileUrl":imageUrl // Use the obtained image URL
    });

    // Update user's balance
    await FirebaseFirestore.instance
        .collection("UserTransactions")
        .doc(userId)
        .collection("data")
        .doc("userData")
        .update({"balance": widget.balance + amount});

    setState(() {
      _nameController.clear();
      _amountController.clear();
      isLoading = false; // Hide the progress indicator
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }
}


  void schedualeTransaction() async {
    if ( _formKey.currentState!.validate() &&
        selectedCategory != null) {
      double amount = double.parse(_amountController.text);
      String name = _nameController.text;
      // DateTime dateTime = DateTime(
      //   _selectedDate.year,
      //   _selectedDate.month,
      //   _selectedDate.day,
      // );
      // DateTime time = DateTime(
      //   _selectedDate.hour,
      //   _selectedDate.minute,
      // );
      String image = selectedCategory!.image;
      await FirebaseFirestore.instance.
      collection("UserTransactions").doc(userId).
      collection("SchedualTrsanactions").add({
       "name": name,
      "amount": int.parse(_amountController.text),
      "category": "TransactionCat.moneyTransfer",
      "type": "TransactionType.income",
      "date": _selectedDate,
      "time": formatTime,
      "imgUrl": image, 
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScheduleTransactions(),
      ),
    );
  }

  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void initializeCamera() async {
    final cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.medium);
    await _cameraController!.initialize();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
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
        title: Text(AppLocalizations.of(context)!.addIncome,
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
                        AppLocalizations.of(context)!.incomeName,
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
                          hintText: "${AppLocalizations.of(context)!.incomeName} (optional) ",
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
                        AppLocalizations.of(context)!.amount,
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
                                hintText: AppLocalizations.of(context)!.amount,
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
                        AppLocalizations.of(context)!.category,
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
                          hint: Text(AppLocalizations.of(context)!.category),
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
                              onPressed: _takePicture, child: Text(AppLocalizations.of(context)!.addFile)),
                          SizedBox(
                              width: 200,
                              child: Text(
                                pathFile,
                                softWrap: true,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: (){
                              schedualeTransaction();
                            },
                            child: Text(
                              AppLocalizations.of(context)!.schedule,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2EA6C1)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ).pSymmetric(h: 20),
                  SizedBox(
                    height: height / 20,
                  ),
                !isLoading?
                  Center(
                    child: SizedBox(
                      width: width / 2,
                      child:  
                      
                      ElevatedButton(
                        onPressed: () {
                          _saveIncome();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        child: Text(AppLocalizations.of(context)!.add),
                      ),
                    ),
                  ): CircularProgressIndicator()
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
