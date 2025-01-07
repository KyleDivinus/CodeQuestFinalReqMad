import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Instructions',
          style: TextStyle(
            fontFamily: 'PressStart2P',
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red,
        elevation: 4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Objective Section
            Text(
              'Objective:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'The goal of the game is to defeat an enemy by answering Flutter/Dart related questions.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Controls Section
            Text(
              'Controls:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Use the Arrow keys to move your character around the screen.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),

            // Levels Section
            Text(
              'Levels:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'There are 4 levels in total, each with increasing difficulty:',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Level 1: Easiest, with simple questions.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Level 2: Moderate difficulty with more questions.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Level 3: Harder questions and more challenges.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Level 4: The final boss level with advanced questions.',
              style: TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
