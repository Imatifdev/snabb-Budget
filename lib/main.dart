// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snabbudget/Screens/addexpanse.dart';
import 'package:snabbudget/Screens/budget_screen.dart';
import 'package:snabbudget/Screens/calender.dart';
import 'package:snabbudget/Screens/dashboard_screen.dart';
import 'package:snabbudget/Screens/graphs_screen.dart';
import 'package:snabbudget/Screens/home_screen.dart';
import 'package:snabbudget/Screens/preferences.dart';
import 'package:snabbudget/Screens/schedule_transactions.dart';
import 'package:snabbudget/Screens/summary_screen.dart';
import 'package:snabbudget/Screens/welcome.dart';
import 'package:snabbudget/Screens/transactions_screen.dart';
import 'package:snabbudget/testingfiles/testsc.dart';
import 'package:snabbudget/utils/brighness_provider.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'Screens/accounts.dart';
import 'Screens/addincome.dart';
import 'Screens/deptsscreen.dart';
import 'Screens/setting_screen.dart';
import 'controller/IncomeProvider.dart';
import 'controller/balanceProvider.dart';
import 'l10n/l10n.dart';
import 'utils/materialColor.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(locale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale("en");
  setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BalanceProvider>(
          create: (context) => BalanceProvider(),
        ),
        ChangeNotifierProvider<SelectedItemProvider>(
          create: (context) => SelectedItemProvider(),
        ),
        ChangeNotifierProvider<BrightnessProvider>(
          create: (context) => BrightnessProvider(),
        ),
      ],
      child: Consumer<BrightnessProvider>(
        builder: (context, brightnessProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Snabb Budget',
            theme: ThemeData(
              brightness: brightnessProvider.brightness == AppBrightness.light
                  ? Brightness.light
                  : Brightness.dark,
              fontFamily: GoogleFonts.montserrat().fontFamily,
              primaryColor: const Color.fromRGBO(46, 166, 193, 1),
              primarySwatch: generateMaterialColor(
                const Color.fromRGBO(46, 166, 193, 1),
              ),
            ),
            home: FirebaseAuth.instance.currentUser != null
                ? const HomeScreen()
                : Welcome(),
            supportedLocales: L10n.all,
            locale: _locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            routes: {
              CalenderScreen.routeName: (context) => const CalenderScreen(),
              ScheduleTransactions.routeName: (context) =>
                  const ScheduleTransactions(),
              BudgetScreen.routeName: (context) => BudgetScreen(),
              PreferencesScreen.routeName: (context) =>
                  const PreferencesScreen(),
              Accounts.routeName: (ctx) => Accounts(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              // AddExpanse.routeName: (ctx) => const AddExpanse(),
              // AddIncome.routeName: (ctx) => const AddIncome(),
              BalanceScreen.routeName: (ctx) => BalanceScreen(),
              SettingScreen.routeName: (ctx) => SettingScreen(),
              SummaryScreen.routeName: (ctx) => SummaryScreen(),
              TransactionsScreen.routeName: (ctx) => TransactionsScreen(),
              GraphScreen.routeName: (ctx)=> GraphScreen(),
            },
          );
        },
      ),
    );
  }
}
