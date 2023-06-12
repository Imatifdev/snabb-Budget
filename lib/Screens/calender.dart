import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  static const routeName = "Calender-Screen";

  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Calender")),
    );
  }
}
