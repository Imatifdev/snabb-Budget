import 'package:flutter/material.dart';
import 'package:snabbudget/utils/custom_drawer.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class DailyStats extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final double balance;
  final int credit;
  final int dept;
  final int expense;
  final int income;
  final int cash;
  final int bankTransfer;
  final int creditCard;
  DailyStats({super.key, required this.balance, required this.credit, required this.dept, required this.expense, required this.income, required this.cash, required this.bankTransfer, required this.creditCard});

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
            statCard(size, AppLocalizations.of(context)!.wallet, AppLocalizations.of(context)!.balance,"\$${balance.toString()}",Colors.green),
            // statCard(size, "Bank", "Balance", "\$${bankTransfer.toString()}",Colors.green),
            // statCard(size, "Expense", "Amount", "\$${expense.toString()}",Colors.red),
            // statCard(size, "Dept", "Amount", "\$${dept.toString()}",Colors.red),
            // statCard(size, "Credit", "Amount", "\$${credit.toString()}",Colors.green),
            // statCard(size, "Income", "Amount", "\$${income.toString()}",Colors.green),  
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
                //color: const Color.fromRGBO(245, 246, 255,1),
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
                        Text(unitName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, 
                        //color: Colors.grey
                        )
                        ),
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