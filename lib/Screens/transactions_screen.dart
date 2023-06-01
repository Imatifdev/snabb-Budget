import 'package:flutter/material.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>{
int _currentSelection = 0;
final Map<int, Widget> _children = {
  0: const Text('Daily'),
  1: const Padding(padding: EdgeInsets.all(8) ,child:Text('Monthly')),
  2: const Text('Yearly'),
};
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My App',
          style: TextStyle(color: Colors.black),
        ),
       
      ),
      body: SizedBox(width: double.infinity,
      child: Column(children: [
        MaterialSegmentedControl(
    children: _children,
    selectionIndex: _currentSelection,
    borderColor: Colors.grey,
    selectedColor: Colors.redAccent,
    unselectedColor: Colors.white,
    selectedTextStyle: const TextStyle(color: Colors.white),
    unselectedTextStyle: const TextStyle(color: Colors.redAccent),
    borderWidth: 0.7,
    borderRadius: 32.0,
    disabledChildren: [3],
    onSegmentTapped: (index) {
      setState(() {
        _currentSelection = index;
      });
    },
),
_children[_currentSelection] as Widget
      ]),
      )
    );
  }
}
