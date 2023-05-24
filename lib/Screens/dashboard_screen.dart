import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){}, child: const Icon(Icons.add),),
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
                    IconButton(onPressed: (){}, icon: const Icon(Icons.menu_rounded)),
                    Text("SNAB BUDGET", style: TextStyle(
                      foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1),),
                    IconButton(onPressed: (){}, icon: const Icon(Icons.notifications))
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: Card(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(30),
  ),
                  elevation: 2,
                  child:  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [const Column(
                          children: [
                          Text("Total Amount", style: TextStyle(color: Colors.white,fontSize: 18),),
                          Text("\$523.82",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)],
                        ),
                        IconButton(onPressed: (){}, icon: const Icon(Icons.menu_open_rounded, size: 35,color: Colors.white,))
                        ],
                      ),
                      const Row(
                        children: [
                          //Icon(Icons.arrow_downward_rounded, size: 35,color: Colors.white,),
                        ],
                      )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}