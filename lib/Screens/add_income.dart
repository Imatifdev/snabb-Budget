import 'package:flutter/material.dart';

class AddIncome extends StatefulWidget {
  static const routeName = "add-income";
  const AddIncome({super.key});

  @override
  State<AddIncome> createState() => _AddIncomeState();
}

class _AddIncomeState extends State<AddIncome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
               gradient: LinearGradient(colors: [
                Color.fromRGBO(191, 240, 53, 1),
                Color.fromRGBO(143, 192, 6, 1),
                Color.fromRGBO(124, 168, 0, 1),
               ]),
               borderRadius: BorderRadius.only(bottomRight: Radius.circular(18),bottomLeft: Radius.circular(18))
              ),
              height: 100,
              width: double.infinity,
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[ CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back_rounded)),
                      Text("ADD INCOME", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)),
                      SizedBox(width: 20,)
                      ]
                              ,
                    ),
                ),
              ),
                
            
            )
          ],),
        ),
      )
    );
  }
}