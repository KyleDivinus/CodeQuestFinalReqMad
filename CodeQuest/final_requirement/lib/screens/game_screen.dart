import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import '../components/game_controller.dart';

class GameScreen extends StatelessWidget {
  final String character;

  GameScreen({required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: GameController(character: character),
      ),
    );
  }
}