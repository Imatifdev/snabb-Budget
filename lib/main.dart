// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snabbudget/Screens/addexpanse.dart';
import 'package:snabbudget/Screens/budget.dart';
import 'package:snabbudget/Screens/calender.dart';
import 'package:snabbudget/Screens/dashboard_screen.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/Screens/preferences.dart';
import 'package:snabbudget/Screens/schedule_transactions.dart';
import 'package:snabbudget/Screens/summary_screen.dart';
import 'package:snabbudget/Screens/welcome.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';
import 'package:snabbudget/testingfiles/testsc.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'Screens/accounts.dart';
import 'Screens/addincome.dart';
import 'Screens/balance.dart';
import 'Screens/dept.dart';
import 'Screens/setting_screen.dart';
import 'controller/IncomeProvider.dart';
import 'controller/balanceProvider.dart';
import 'utils/materialColor.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BalanceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SelectedItemProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: GoogleFonts.montserrat().fontFamily,
          primaryColor: const Color.fromRGBO(46, 166, 193, 1),
          primarySwatch: generateMaterialColor(
            const Color.fromRGBO(46, 166, 193, 1),
          ),
        ),
        home: FirebaseAuth.instance.currentUser != null
            ? HomeScreen()
            : Welcome(),
        routes: {
          CalenderScreen.routeName: (context) => const CalenderScreen(),
          ScheduleTransactions.routeName: (context) =>
              const ScheduleTransactions(),
          BudgetScreen.routeName: (context) => const BudgetScreen(),
          PreferencesScreen.routeName: (context) => const PreferencesScreen(),
          Accounts.routeName: (ctx) => Accounts(),
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          AddExpanse.routeName: (ctx) => const AddExpanse(),
          AddIncome.routeName: (ctx) => const AddIncome(),
          BalanceScreen.routeName: (ctx) => BalanceScreen(),
          SettingScreen.routeName: (ctx) => SettingScreen(),
          SummaryScreen.routeName: (ctx) => SummaryScreen(),
          TransactionsScreen.routeName: (ctx) => TransactionsScreen(),
        },
      ),
    );
  }
}
