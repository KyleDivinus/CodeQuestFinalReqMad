import 'package:flutter/material.dart';
import 'package:codequest_etr/screens/game_screen.dart';

class CharSelectScreen extends StatelessWidget {
  const CharSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Choose Your Character',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 8,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Character 1 - Blaze
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(characterName: 'Blaze'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Transform.scale(
                          scale: 1.8,
                          child: Image.asset(
                            'assets/characters/char1.png',
                            width: 220,
                            height: 220,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Blaze',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Character 2 - Cherry
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(characterName: 'Cherry'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Transform.scale(
                          scale: 1.8,
                          child: Image.asset(
                            'assets/characters/char2.png',
                            width: 220,
                            height: 220,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Cherry',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),

                  // Character 3 - Aegis
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              GameScreen(characterName: 'Aegis'),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Transform.scale(
                          scale: 1.8,
                          child: Image.asset(
                            'assets/characters/char3.png',
                            width: 220,
                            height: 220,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Aegis',
                          style: TextStyle(
                            fontFamily: 'PressStart2P',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
