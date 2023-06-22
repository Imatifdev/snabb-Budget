import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
class DailyStats extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  DailyStats({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: SafeArea(child: 
      SizedBox(
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
                  "Daily Stats",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 50,)
              ],
            ),
          )),
           statCard(size, "Wallet", "Balance", "\$0.00",Colors.green),
          //  statCard(size, "Bank", "Balance", "PKR 5000",Colors.green),
          //  statCard(size, "Expense", "Amount", "\$500",Colors.red),
          //  statCard(size, "Dept", "Amount", "\$300",Colors.red),
          //  statCard(size, "Credit", "Amount", "\$400",Colors.green),
          //  statCard(size, "Income", "Amount", "\$1600",Colors.green),  
          ],
        ),
      ))
    );
  }

  Column statCard(Size size, String name, String unitName,String amount, Color color) {
    return Column(
          children: [
            const SizedBox(height: 10,),
            SizedBox(
              height: size.height/8.5,
              width: size.width-22,
              child:  Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                      ),
                elevation: 5,
                color: const Color.fromRGBO(245, 246, 255,1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(unitName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),),
                        Text(amount, style: TextStyle(color: color,fontSize: 12, fontWeight: FontWeight.bold,),)
                      ],)
                    ],
                  ),
                ),
              ))
          ],
        );
  }
}