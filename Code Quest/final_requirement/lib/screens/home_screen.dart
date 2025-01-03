import 'package:final_requirement/screens/about_screen.dart';
import 'package:final_requirement/screens/character_selection.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void play(){
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CharacterSelection())
      );
    });
  }

  void about(){
    setState(() {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const AboutScreen())
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: play,
             child: const Text('Play'
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(onPressed: about,
             child: const Text('About'
              ),
            ),
          ],
        ),
      ),
    );
  }
}