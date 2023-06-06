import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/IncomeProvider.dart';
import '../models/IncomeDataMode.dart';

class AddIncomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _addIncomeData(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final amount = double.parse(_amountController.text);
      final category =
          Provider.of<IncomeProvider>(context, listen: false).selectedCategory;
      final date = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final incomeData = IncomeData(
        name: name,
        amount: amount,
        date: date,
        time: date,
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayIncomeScreen(incomeData: incomeData),
        ),
      );
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Income'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Amount'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              Consumer<IncomeProvider>(
                builder: (context, incomeProvider, _) {
                  return DropdownButtonFormField<String>(
                    value: incomeProvider.selectedCategory,
                    items: incomeProvider.categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        incomeProvider.setSelectedCategory(value);
                      }
                    },
                    decoration: InputDecoration(labelText: 'Category'),
                  );
                },
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectDate(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: DateFormat.yMMMd().format(_selectedDate),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              InkWell(
                onTap: () => _selectTime(context),
                child: IgnorePointer(
                  child: TextFormField(
                    controller: TextEditingController(
                      text: _selectedTime.format(context),
                    ),
                    decoration: InputDecoration(
                      labelText: 'Time',
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _addIncomeData(context),
                child: Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IncomeProvider with ChangeNotifier {
  List<String> _categories = ['Category 1', 'Category 2', 'Category 3'];
  String _selectedCategory = 'Category 1';

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}

class DisplayIncomeScreen extends StatelessWidget {
  final IncomeData incomeData;

  DisplayIncomeScreen({required this.incomeData});

  @override
  Widget build(BuildContext context) {
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    final selectedItem = selectedItemProvider.selectedItem;

    return Scaffold(
      appBar: AppBar(
        title: Text('Income Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedItem != null)
              Image.asset(
                selectedItem.imagePath,
                width: 100,
                height: 100,
              ),
            if (selectedItem != null) SizedBox(height: 10),
            if (selectedItem != null) Text(selectedItem.title),
            Text('Name: ${incomeData.name}'),
            SizedBox(height: 8.0),
            Text('Amount: ${incomeData.amount}'),
            SizedBox(height: 8.0),
            SizedBox(height: 8.0),
            Text('Date: ${DateFormat.yMMMd().format(incomeData.date)}'),
            Text('Date: ${(incomeData.time)}'),
          ],
        ),
      ),
    );
  }
}
