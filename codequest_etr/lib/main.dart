import 'package:flutter/material.dart';
import 'package:codequest_etr/screens/home_screen.dart';
import 'package:codequest_etr/screens/char_select_screen.dart';
import 'package:codequest_etr/screens/instruction_screen.dart';
import 'package:codequest_etr/screens/about_screen.dart';

void main() {
  runApp(const CodeQuest());
}

class CodeQuest extends StatelessWidget {
  const CodeQuest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Code Quest ETR',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.red,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/charSelect': (context) => const CharSelectScreen(),
        '/instructions': (context) => InstructionScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}
