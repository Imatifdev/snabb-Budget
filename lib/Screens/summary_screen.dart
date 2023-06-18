import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:snabbudget/utils/category_widget.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import '../utils/summary_widget.dart';
import 'dashboard_screen.dart';

class SummaryScreen extends StatefulWidget {
  static const routeName = "summary-screen";
  SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  final Map<String, double> dataMap = {
    "Expense": 3,
    "Income": 1,
  };
  String selectedType = "Income";

  DateTime selectedDateFrom = DateTime.now();
  DateTime selectedDateTo = DateTime.now();

  List<String> types = [
    'Income',
    'Expense',
  ];
  List<String> months = [
    "Janvary",
    "Feburary",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  int _currentSelection = 0;
    final Map<int, Widget> _children = {
  0: Text('Summary',style: GoogleFonts.montserrat(),),
  1:  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child:Text('Category',style: GoogleFonts.montserrat(),)),
  };
  List<DateTime> monthsWithTransactions = [];

  
  
    

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
    SummaryWidget(transactions: transactions,months: months,),
    CategoryWidget(transactions: transactions)
  ];
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Card(
              child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 IconButton(
                            onPressed: () {
                              scaffoldKey.currentState?.openDrawer();
                            },
                            icon: const ImageIcon(
                              AssetImage("assets/images/menu.png"),
                              size: 40,
                            )),
                const Text(
                  "Summery",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
          const SizedBox(height: 5,),
          MaterialSegmentedControl(
            verticalOffset: 12,
          selectionIndex: _currentSelection,
          borderColor: Theme.of(context).primaryColor ,
          selectedColor: Theme.of(context).primaryColor,
          unselectedColor: Colors.white,
          selectedTextStyle: const TextStyle(color: Colors.white),
          unselectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          borderWidth: 0.7,
          borderRadius: 32.0,
          disabledChildren: const [3],
          onSegmentTapped: (index) {
        setState(() {
          _currentSelection = index;
        });
          },
          children: _children,
      ),
      const SizedBox(height: 10,),
      children[_currentSelection]
          ],
        ),
      ))
    );
  }
}