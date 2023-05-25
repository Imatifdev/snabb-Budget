import 'package:flutter/material.dart';

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: const ImageIcon(AssetImage("assets/images/home-icon.png"),size: 40,),
            onPressed: () => _onItemTapped(0),
            color: _selectedIndex == 0 ? const Color.fromRGBO(46, 166, 193, 1) : Colors.grey,
          ),
          IconButton(
            icon: const ImageIcon(AssetImage("assets/images/bar-chart.png"),size: 40,),
            onPressed: () => _onItemTapped(1),
            color: _selectedIndex == 1 ? const Color.fromRGBO(46, 166, 193, 1): Colors.grey,
          ),
          IconButton(
            icon: const ImageIcon(AssetImage("assets/images/user.png"),size: 40,),
            onPressed: () => _onItemTapped(2),
            color: _selectedIndex == 2 ? const Color.fromRGBO(46, 166, 193, 1) : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _onItemTapped(3),
            color: _selectedIndex == 3 ? Colors.transparent : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
