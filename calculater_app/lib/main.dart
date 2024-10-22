import 'package:calculater_app/calculater_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalculaterApp());
}

class CalculaterApp extends StatelessWidget {
  const CalculaterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
