import 'package:flutter/material.dart';

class ScheduleTransactions extends StatefulWidget {
  static const routeName = "Schedule-Transactions";

  const ScheduleTransactions({super.key});

  @override
  State<ScheduleTransactions> createState() => _ScheduleTransactionsState();
}

class _ScheduleTransactionsState extends State<ScheduleTransactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Schedule")),
    );
  }
}
