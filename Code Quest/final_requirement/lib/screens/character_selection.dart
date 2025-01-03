
import 'package:final_requirement/screens/game_screen.dart';
import 'package:flutter/material.dart';

void _confirmCharacter(BuildContext context, String character) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Confirm Selection'),
      content: Text('Are you sure you want to choose $character?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => GameScreen(character: character),
              ),
            );
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
}

class CharacterSelection extends StatelessWidget {
  const CharacterSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Character'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _characterCard(context, 'Aegis', 'assets/images/ChoosePlayer/Aegis.png'),
            _characterCard(context, 'Blaze', 'assets/images/ChoosePlayer/Blaze.png'),
            _characterCard(context, 'Cherry', 'assets/images/ChoosePlayer/Cherry.png'),
          ],
        ),
      ),
    );
  }
}

Widget _characterCard(BuildContext context, String name, String imagePath) {
  return GestureDetector(
    onTap: () => _confirmCharacter(context, name),
    child: Card(
      child: Container( // Replaced Expanded with Container
        padding: const EdgeInsets.all(8), // Add padding for better spacing
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure the column takes minimal space
          children: [
            Image.asset(
              imagePath,
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 8), // Add spacing between image and text
            Text(name),
          ],
        ),
      ),
    ),
  );
}