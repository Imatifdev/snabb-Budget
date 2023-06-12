import 'package:flutter/material.dart';

class PreferencesScreen extends StatefulWidget {
  static const routeName = "Budget-Screen";

  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Pref")),
    );
  }
}
