import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:codequest_etr/helpers/database_helper.dart';

class GameScreen extends StatefulWidget {
  final String characterName;

  GameScreen({required this.characterName});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  double characterTop = 50;
  double characterLeft = 150;
  double proximityThreshold = 120;
  int enemyLives = 2;
  int questionIndex = 0;

  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final dbHelper = DatabaseHelper();
    final fetchedQuestions = await dbHelper.getQuestionsByStage(4); 
    setState(() {
      questions = fetchedQuestions;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background/lvl1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Existing UI elements...
          _buildEnemy(),
          _buildInteractionButton(),
        ],
      ),
    );
  }

  Widget _buildEnemy() {
    return Positioned(
      top: MediaQuery.of(context).size.height / 2 - 60,
      left: MediaQuery.of(context).size.width - 180,
      child: Column(
        children: [
          Image.asset(
            'assets/characters/enemy.png',
            width: 80,
            height: 120,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
          Text(
            'Lives: $enemyLives',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractionButton() {
    return Positioned(
      bottom: 50,
      right: 50,
      child: GestureDetector(
        onTap: () {
          if (enemyLives > 0) _showFightDialog(context);
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            color: Colors.black,
          ),
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  void _showFightDialog(BuildContext context) {
    if (questionIndex >= questions.length) {
      _showVictoryDialog(context);
      return;
    }

    final currentQuestion = questions[questionIndex];
    final answers = List<Map<String, dynamic>>.from(
        jsonDecode(currentQuestion['answers']));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Fight! Question ${questionIndex + 1}',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                currentQuestion['question'],
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 10),
              ...answers.map((answer) {
                return ElevatedButton(
                  onPressed: () {
                    if (answer['isCorrect']) {
                      setState(() {
                        enemyLives--;
                        questionIndex++;
                      });
                      Navigator.of(context).pop();
                      if (enemyLives == 0) {
                        _showVictoryDialog(context);
                      }
                    } else {
                      Navigator.of(context).pop();
                      _showDefeatDialog(context);
                    }
                  },
                  child: Text(answer['text']),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showVictoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Victory!',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Proceed to the next stage (game_screen2.dart)
              },
              child: Text('Next Stage'),
            ),
          ],
        );
      },
    );
  }

  void _showDefeatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Defeat!',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFightDialog(context);
              },
              child: Text('Retry'),
            ),
          ],
        );
      },
    );
  }
}
