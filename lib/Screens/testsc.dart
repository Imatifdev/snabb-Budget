// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _enteredText = '';
  double _enteredPrice = 0.0;
  DateTime? _selectedDate;
  List<Map<String, dynamic>> _enteredDataList1 = [];
  List<Map<String, dynamic>> _enteredDataList2 = [];

  void _openDialog() {
    bool _shouldStoreData = false;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
                title: Text('New Debt'),
                content: Container(
                  height: 401,
                  width: 400,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                setState(() {
                                  _enteredText = value;
                                });
                              },
                              decoration: InputDecoration(
                                  hintText: 'Enter Value in digit'),
                            ),
                          ),
                          Image(
                              height: 50,
                              width: 50,
                              image: AssetImage("assets/images/cal.png"))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Created the Associated \nTransaction(income)",
                            style: TextStyle(fontSize: 16),
                          ),
                          Switch(
                            value: _shouldStoreData,
                            onChanged: (value) {
                              setState(() {
                                _shouldStoreData = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.wallet),
                          Text("Wallet"),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.date_range_rounded),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Text(_selectedDate == null
                                ? 'Date'
                                : 'Date:        ${_selectedDate.toString().substring(0, 10)}'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.data_exploration),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Text(_selectedDate == null
                                ? 'Payback Date'
                                : 'Payback Date:      ${_selectedDate.toString().substring(0, 10)}'),
                          ),
                        ],
                      ),
                      TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _enteredPrice = double.tryParse(value) ?? 0.0;
                          });
                        },
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter Name'),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          ElevatedButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: Text('Save'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _storeData(_shouldStoreData);
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                        child: Text('Save'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          _storeData(_shouldStoreData);
                        },
                      ),
                    ],
                  ),
                ));
          },
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    try {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
        });
      }
    } catch (e) {
      print('Error selecting date: $e');
    }
  }

  void _storeData(bool shouldStoreInList1) {
    setState(() {
      final data = {
        'text': _enteredText,
        'price': _enteredPrice,
        'date': _selectedDate,
      };

      if (shouldStoreInList1) {
        _enteredDataList1.add(data);
      } else {
        _enteredDataList2.add(data);
      }

      _enteredText = '';
      _enteredPrice = 0.0;
      _selectedDate = null;
    });
  }

  Widget _buildCard(Map<String, dynamic> data) {
    final height = MediaQuery.of(context).size.height;

    final width = MediaQuery.of(context).size.width;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: height / 3,
              color: Colors.grey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Image(
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/paid.png"),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dept",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Text(
                                "You",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_forward_sharp,
                                color: Colors.red,
                              ),
                              Text(
                                "Charles",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ).pSymmetric(h: 20, v: 20),
                  Column(
                    children: [
                      Row(
                        children: [],
                      )
                    ],
                  )
                ],
              ),
            ),
            Text(
              'Details: ${data['text']}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${data['price'].toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            Text(
              'Date: ${data['date'].toString().substring(0, 10)}',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dialog Demo'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Open Dialog'),
            onPressed: _openDialog,
          ),
          SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _enteredDataList1.length + _enteredDataList2.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < _enteredDataList1.length) {
                  return _buildCard(_enteredDataList1[index]);
                } else {
                  return _buildCard(
                      _enteredDataList2[index - _enteredDataList1.length]);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
