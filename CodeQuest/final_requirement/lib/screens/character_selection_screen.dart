import 'package:flutter/material.dart';
import 'game_screen.dart';

class CharacterSelectionScreen extends StatelessWidget {
  final List<String> characters = ['Aegis', 'Blaze', 'Cherry'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Your Character')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showConfirmationDialog(context, characters[index]);
            },
            child: Image.asset('assets/images/ChoosePlayer/${characters[index]}.png'),
          );
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String character) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Character'),
          content: Text('Do you want to select $character?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cancel
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen(character: character)),
                );
              },
              child: const Text('Proceed'),
            ),
          ],
        );
      },
    );
  }
}