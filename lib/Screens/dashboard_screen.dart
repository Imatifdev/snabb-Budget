// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';

// class DashboardScreen extends StatelessWidget {
//   DashboardScreen({super.key});
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: const Icon(Icons.add),
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//             child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Card(
//                 elevation: 3,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           _scaffoldKey.currentState?.openDrawer();
//                         },
//                         icon: const Icon(Icons.menu)),
//                     Container(
//                       child: Shimmer.fromColors(
//                           baseColor: Color(0xff9B710F),
//                           highlightColor: Color(0xffFFE62E),
//                           period: Duration(milliseconds: 1200),
//                           child: Text(
//                             'Shimmer Text',
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           )),
//                     ),
//                     IconButton(
//                         onPressed: () {}, icon: const Icon(Icons.notifications))
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 200,
//                 child: Card(
//                   color: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Column(
//                               children: [
//                                 Text(
//                                   "Total Amount",
//                                   style: TextStyle(
//                                       color: Colors.white, fontSize: 18),
//                                 ),
//                                 Text(
//                                   "\$523.82",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(
//                                   Icons.menu_open_rounded,
//                                   size: 35,
//                                   color: Colors.white,
//                                 ))
//                           ],
//                         ),
//                         const Row(
//                           children: [
//                             //Icon(Icons.arrow_downward_rounded, size: 35,color: Colors.white,),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:snabbudget/utils/mycolors.dart';

import '../models/transaction.dart';
import '../utils/custom_bottombar.dart';


class DashboardScreen extends StatelessWidget {
  final List<Transaction> transactions = [
  Transaction(
    name: "Money Transfer", 
    time: "06:20 PM", 
    imgUrl: "assets/images/home.png", 
    type: TransactionType.expense, 
    category: TransactionCat.moneyTransfer, 
    amount: 22),
    Transaction(
    name: "Shopping", 
    time: "02:26 PM", 
    imgUrl: "assets/images/shopping.png", 
    type: TransactionType.expense, 
    category: TransactionCat.shopping, 
    amount: 100),
    Transaction(
    name: "Taxi", 
    time: "02:00 PM", 
    imgUrl: "assets/images/travel.png", 
    type: TransactionType.expense, 
    category: TransactionCat.taxi, 
    amount: 80),
    Transaction(
    name: "Salary", 
    time: "10:26 AM", 
    imgUrl: "assets/images/income.png", 
    type: TransactionType.income, 
    category: TransactionCat.moneyTransfer, 
    amount: 2000),
    Transaction(
    name: "Bills", 
    time: "09:26 PM", 
    imgUrl: "assets/images/others.png", 
    type: TransactionType.expense, 
    category: TransactionCat.bills, 
    amount: 1000),
];

  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      extendBody: true, 
      backgroundColor: Colors.grey[50],
      bottomNavigationBar: CustomBottomBar(),
       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: (){},
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0), // Adjust the border radius as needed
          ), 
            backgroundColor:const Color.fromRGBO(46, 166, 193, 1),
            child: const Icon(Icons.add),),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage("assets/images/menu.png"),size: 40,)),
                     ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xff9B710F),Color.fromRGBO(243,215,42,1), Color(0xff9B710F),],
                    ).createShader(bounds),
                    child: const Text("Snab Budget",
                      style: TextStyle(
                          color: Colors.white,
                           fontSize: 14
                        ),
                      ),
                    ),
                    IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage("assets/images/bell.png"),size: 40,))
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                height: 220,
                width: size.width-40,
                decoration: BoxDecoration(
                   gradient: LinearGradient(
            colors: [
              gradient1,
              gradient2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text("Total Amount", style: TextStyle(color: Colors.white,fontSize: 14), textAlign: TextAlign.left,),
                        Text("\$523.82",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),textAlign: TextAlign.left)],
                      ),
                      IconButton(onPressed: (){}, icon: const ImageIcon( AssetImage("assets/images/dot-menu.png") , size: 20,color: Colors.white,))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Column(
                           children: [
                             Row(
                               children: [
                                 CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  child: const Icon(Icons.arrow_downward_rounded ,color: Colors.white,)),
                                 const SizedBox(width: 5,),
                                 const Text("Income", style: TextStyle(fontSize: 14 ,color: Colors.white),)
                               ],
                             ),
                            const SizedBox(height: 5,),
                            const Text("\$2000.00",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
                           ],
                         ),
                         Column(
                           children: [
                             Row(
                               children: [
                                 CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  child: const Icon(Icons.arrow_upward_rounded ,color: Colors.white,)),
                                 const SizedBox(width: 5,),
                                 const Text("Expenses", style: TextStyle(fontSize: 14 ,color: Colors.white),)
                               ],
                             ),
                            const SizedBox(height: 5,),
                            const Text("\$490.00",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold)),
                           ],
                         )
                      ],
                    )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: size.width-40,
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [ 
                        Text(
                          "Transactions", 
                          style: TextStyle(
                            fontSize: 20, 
                            color: Colors.black, 
                            fontWeight: FontWeight.bold),
                            ),
                        Text("See All", style: TextStyle(
                            fontSize: 13, 
                            color: Colors.grey),)    
                          ]
                        ),
                    const SizedBox(height: 5,),    
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Today", style: TextStyle(
                              fontSize: 13, 
                              color: Colors.grey),),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        itemCount: transactions.length,
                        itemBuilder: (context, index) {
                        Transaction transaction = transactions[index];
                        return Card(
                          color: Colors.white,
                          elevation: 0,
                          child: ListTile(
                            leading: Image.asset(transaction.imgUrl),
                            title: Text(transaction.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                            subtitle: Text(transaction.time),
                            trailing: Text(transaction.type == TransactionType.income?"+\$${transaction.amount}":"-\$${transaction.amount}",style: TextStyle(color:transaction.type == TransactionType.income? Colors.green:Colors.red)),
                        
                          ),
                        );
                      },),
                    ),
                  ],
                ),
              ) 
            ],
          ),
        ),
      ),
    ));
  }
}
