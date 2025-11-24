import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(AllYouCanEatApp());
}

class AllYouCanEatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'All You Can Eat',
      theme: ThemeData(
        primarySwatch: Colors.red,
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

