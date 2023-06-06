import 'package:flutter/material.dart';

class IncomeData {
  final double amount;
  final String name;
  final DateTime date;
  final DateTime time;

  final String category;
  final String imageurl;

  IncomeData({
    required this.amount,
    required this.name,
    required this.date,
    required this.time,
    required this.category,
    required this.imageurl,
  });
}

class IncomeDataCategory {
  final String name;
  final String image;

  IncomeDataCategory({required this.name, required this.image});
}

List<IncomeDataCategory> incomeCategories = [
  IncomeDataCategory(name: 'Others', image: 'assets/images/others.png'),
  IncomeDataCategory(name: 'Finance', image: 'assets/images/fiance.png'),
  IncomeDataCategory(name: 'Income', image: 'assets/images/income.png'),
];
