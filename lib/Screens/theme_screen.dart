import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/brighness_provider.dart';

class ThemeChangeScreen extends StatefulWidget {
  const ThemeChangeScreen({super.key});

  @override
  State<ThemeChangeScreen> createState() => _ThemeChangeScreenState();
}

class _ThemeChangeScreenState extends State<ThemeChangeScreen> {
  @override
  Widget build(BuildContext context) {
  final brightnessProvider = Provider.of<BrightnessProvider>(context);
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Choose a theme", style: TextStyle(fontSize: 20, color: Theme.of(context).primaryColor),), 
            RadioListTile<AppBrightness>(
                title: const Text('Light'),
                value: AppBrightness.light,
                groupValue: brightnessProvider.brightness,
                onChanged: (value) {
                  brightnessProvider.brightness = value!;
                },
              ),
              RadioListTile<AppBrightness>(
                title: const Text('Dark'),
                value: AppBrightness.dark,
                groupValue: brightnessProvider.brightness,
                onChanged: (value) {
                  brightnessProvider.brightness = value!;
                },
              ),
          ],
        ),
      )),
    );
  }
}