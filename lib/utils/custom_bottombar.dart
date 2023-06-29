import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomBar({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const ImageIcon(
              AssetImage("assets/images/home-icon.png"),
              size: 40,
            ),
            onPressed: () => onTabSelected(0),
            color: selectedIndex == 0
                ? const Color.fromRGBO(46, 166, 193, 1)
                : Colors.grey,
          ),
          IconButton(
            icon: const ImageIcon(
              AssetImage("assets/images/bar-chart.png"),
              size: 40,
            ),
            onPressed: () => onTabSelected(1),
            color: selectedIndex == 1
                ? const Color.fromRGBO(46, 166, 193, 1)
                : Colors.grey,
          ),
          IconButton(
            icon: const ImageIcon(
              AssetImage("assets/images/user.png"),
              size: 40,
            ),
            onPressed: () => onTabSelected(2),
            color: selectedIndex == 2
                ? const Color.fromRGBO(46, 166, 193, 1)
                : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => onTabSelected(3),
            color:
                selectedIndex == 3 ? Colors.transparent : Colors.transparent,
          ),
        ],
      ),
    );
    // return Container(
    //   height: 80,
    //   decoration: const BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(15),
    //       topRight: Radius.circular(15),
    //     ),
    //   ),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       IconButton(
    //         icon: const Icon(Icons.home),
    //         onPressed: () => onTabSelected(0),
    //         color: selectedIndex == 0 ? Colors.blue : Colors.grey,
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.pie_chart),
    //         onPressed: () => onTabSelected(1),
    //         color: selectedIndex == 1 ? Colors.blue : Colors.grey,
    //       ),
    //       IconButton(
    //         icon: const Icon(Icons.person),
    //         onPressed: () => onTabSelected(2),
    //         color: selectedIndex == 2 ? Colors.blue : Colors.grey,
    //       ),
    //     ],
    //   ),
    // );
  }
}
