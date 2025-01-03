import 'package:final_requirement/codequest_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  final String character;
  
  const GameScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Quest - Playing as $character'),
      ),
      body: GameWidget(
      game: CodequestGame(selectedCharacter: character),
      ),
    );
  }
}