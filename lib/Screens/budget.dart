import 'package:flutter/material.dart';

class BudgetScreen extends StatefulWidget {
  static const routeName = "Budget-Screen";

  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Budget")),
    );
  }
}
