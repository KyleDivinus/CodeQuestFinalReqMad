import 'package:flutter/material.dart';
import 'character_selection_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CodeQuest')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CharacterSelectionScreen()),
                );
              },
              child: Text('Play'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'CodeQuest',
                  applicationVersion: '1.0.0',
                  children: [
                    Text('CodeQuest is a fun RPG game where you solve coding problems!'),
                  ],
                );
              },
              child: Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}