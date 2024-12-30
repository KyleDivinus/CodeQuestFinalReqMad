import 'package:flutter/material.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(CodeQuest());
}

class CodeQuest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeQuest',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}