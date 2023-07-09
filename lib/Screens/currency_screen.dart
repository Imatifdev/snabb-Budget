import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/currency_controller.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  String? currency = "";
  void changeCurrency(String? _currency)async{
  await FirebaseFirestore.instance.collection("UserTransactions").
  doc(userId).collection("data").doc("userData")
  .update({
    "currency":_currency,
  });
  setState(() {
    currency = _currency;
  });
  }
  getCurrency()async{
    CurrencyData currencyData = CurrencyData();
    String? local = await currencyData.fetchCurrency(userId);
    setState(() {
    currency = local;   
    });
    //currency = currencyData.currency;
    print(currency);
  }
  @override
  void initState() {
    super.initState();
    getCurrency();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Choose Your Currency", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)),
                    const SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("United States Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Euro", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "€", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("British Pound", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "£", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Japenese Yen", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "¥", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Canadian Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "C\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Australian Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "A\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Swiss Franc", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Fr", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Chinese Yaun", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "C¥", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Swedish Krona", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Kr", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("New Zealand Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "NZ\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Indian Rupee", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "₹", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Brazilian Real", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "R\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Russian Ruble", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "₽", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("South African Rand", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "R", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hong Kong Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "HK\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Singapore Dollar", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "S\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Norwegian Krone", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "kr", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Mexican Peso", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Mex\$", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Turkish Lira", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "₺", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("South Korean Won", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "₩", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Danish Krone", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "kr", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Polish Zloty", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "zł", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Thai Baht", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "฿", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Thai Baht", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "฿", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Indonesian Rupiah", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Rp", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hungarian Forint", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Ft", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Czech Koruna", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "Kč", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Pakistani Rupee", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "PKR", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("German Euro", style: TextStyle(fontSize: 16)),
                        Radio(
                            value: "€", groupValue: currency, onChanged: changeCurrency),
                      ],
                    ),
                ],
              ),
            ),
          )),
      ),
    );
  }
}