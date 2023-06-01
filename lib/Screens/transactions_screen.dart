import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen>{
int _currentSelection = 0;
final Map<int, Widget> _children = {
  0: Text('Daily',style: GoogleFonts.montserrat(),),
  1:  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child:Text('Monthly',style: GoogleFonts.montserrat(),)),
  2:  Text('Yearly',style: GoogleFonts.montserrat(),),
};
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(width: double.infinity,
        child: Column(children: [
         Card(
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(child: IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_rounded)),) ,
                const Text("Transactions", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                IconButton(onPressed: (){}, icon: ImageIcon(const AssetImage("assets/images/search.png"),size: 40,color: Theme.of(context).primaryColor) )],
            ),
          )),
          MaterialSegmentedControl(
            verticalOffset: 12,
          children: _children,
          selectionIndex: _currentSelection,
          borderColor: Theme.of(context).primaryColor ,
          selectedColor: Theme.of(context).primaryColor,
          unselectedColor: Colors.white,
          selectedTextStyle: const TextStyle(color: Colors.white),
          unselectedTextStyle: TextStyle(color: Theme.of(context).primaryColor),
          borderWidth: 0.7,
          borderRadius: 32.0,
          disabledChildren: [3],
          onSegmentTapped: (index) {
        setState(() {
          _currentSelection = index;
        });
          },
      ),
      _children[_currentSelection] as Widget
        ]),
        ),
      )
    );
  }
}
