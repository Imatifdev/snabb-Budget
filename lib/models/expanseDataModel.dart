import 'package:flutter/material.dart';

class ExpanseData {
  final double amount;
  final String name;
  final DateTime date;
  final DateTime time;

  final String category;
  final String imageurl;

  ExpanseData({
    required this.amount,
    required this.name,
    required this.date,
    required this.time,
    required this.category,
    required this.imageurl,
  });
}

class ExpanseDataCategory {
  final String name;
  final String image;

  ExpanseDataCategory({required this.name, required this.image});
}

List<ExpanseDataCategory> expanseCategories = [
  ExpanseDataCategory(name: 'Pets', image: 'assets/images/pets.png'),
  ExpanseDataCategory(name: 'Others', image: 'assets/images/others.png'),
  ExpanseDataCategory(name: 'Transport', image: 'assets/images/transport.png'),
  ExpanseDataCategory(name: 'Home', image: 'assets/images/home.png'),
  ExpanseDataCategory(name: 'Health', image: 'assets/images/health.png'),
  ExpanseDataCategory(name: 'Family', image: 'assets/images/family.png'),
  ExpanseDataCategory(name: 'Food/Drink', image: 'assets/images/food.png'),
  ExpanseDataCategory(name: 'Shopping', image: 'assets/images/shopping.png'),
  ExpanseDataCategory(name: 'Travelling', image: 'assets/images/travel.png'),
];
