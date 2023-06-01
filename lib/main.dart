// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snabbudget/Screens/addexpanse.dart';
import 'package:snabbudget/Screens/welcome.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';
import 'Screens/addincome.dart';
import 'utils/materialColor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(46, 166, 193, 1),
        primarySwatch: generateMaterialColor(
          const Color.fromRGBO(46, 166, 193, 1),
        ),
        fontFamily: GoogleFonts.montserrat().fontFamily,
      ),
      home: TransactionsScreen(),
      routes: {
        AddExpanse.routeName: (ctx) => const AddExpanse(),
        AddIncome.routeName: (ctx) => const AddIncome(),
      },
    );
  }
}
