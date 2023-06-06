import 'package:flutter/material.dart';

class Expense {
  final double amount;
  final String name;
  final DateTime dateTime;
  final String category;
  final IconData icon;

  Expense({
    required this.amount,
    required this.name,
    required this.dateTime,
    required this.category,
    required this.icon,
  });
}

class ExpenseCategory {
  final String name;
  final IconData icon;

  ExpenseCategory({required this.name, required this.icon});
}

List<ExpenseCategory> expenseCategories = [
  ExpenseCategory(name: 'Food', icon: Icons.fastfood),
  ExpenseCategory(name: 'Shopping', icon: Icons.shopping_cart),
  ExpenseCategory(name: 'Transportation', icon: Icons.directions_car),
  ExpenseCategory(name: 'Entertainment', icon: Icons.movie),
  ExpenseCategory(name: 'Utilities', icon: Icons.lightbulb),
];

class ExpenseScreen extends StatefulWidget {
  @override
  _ExpenseScreenState createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<Expense> expenses = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  ExpenseCategory? selectedCategory;

  @override
  void dispose() {
    amountController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _saveExpense() {
    if (amountController.text.isNotEmpty &&
        nameController.text.isNotEmpty &&
        selectedCategory != null) {
      double amount = double.parse(amountController.text);
      String name = nameController.text;
      DateTime dateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      IconData icon = selectedCategory!.icon;

      Expense expense = Expense(
        amount: amount,
        name: name,
        dateTime: dateTime,
        category: selectedCategory!.name,
        icon: icon,
      );

      setState(() {
        expenses.add(expense);
        amountController.clear();
        nameController.clear();
        selectedCategory = null;
      });
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpenseListScreen(expenses),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: _selectDate,
                    child: Text('Select Date'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextButton(
                    onPressed: _selectTime,
                    child: Text('Select Time'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<ExpenseCategory>(
              value: selectedCategory,
              hint: Text('Category'),
              onChanged: (ExpenseCategory? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: expenseCategories.map((ExpenseCategory category) {
                return DropdownMenuItem<ExpenseCategory>(
                  value: category,
                  child: Row(
                    children: [
                      Icon(category.icon),
                      SizedBox(width: 10),
                      Text(category.name),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveExpense,
              child: Text('Save Expense'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseListScreen extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseListScreen(this.expenses);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense List'),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          Expense expense = expenses[index];
          return ListTile(
            leading: Icon(expense.icon),
            title: Text(expense.name),
            subtitle: Text('${expense.amount.toStringAsFixed(2)}'),
            trailing: Text(expense.dateTime.toString()),
          );
        },
      ),
    );
  }
}
