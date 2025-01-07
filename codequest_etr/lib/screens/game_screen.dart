import 'dart:convert';

import 'package:codequest_etr/helpers/database_helper.dart';
import 'package:codequest_etr/screens/game_screen2.dart';
import 'package:flutter/material.dart';
import 'dart:math';

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
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchQuestionsForStage(1); 
  }

  Future<void> _fetchQuestionsForStage(int stage) async {
    final dbQuestions = await _databaseHelper.getQuestionsByStage(stage);
    setState(() {
      questions = dbQuestions.map((question) {
        return {
          'question': question['question'],
          'answers': jsonDecode(question['answers']), 
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    String imagePath = _getCharacterImagePath(widget.characterName);
    double enemyTop = MediaQuery.of(context).size.height / 2 - 60;
    double enemyLeft = MediaQuery.of(context).size.width - 180;
    double distance =
        _calculateDistance(characterTop, characterLeft, enemyTop, enemyLeft);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildBackground(),
          _buildCharacter(imagePath),
          _buildEnemy(enemyTop, enemyLeft),
          _buildMovementControls(),
          _buildInteractionButton(distance),
        ],
      ),
    );
  }

  String _getCharacterImagePath(String characterName) {
    switch (characterName) {
      case 'Blaze':
        return 'assets/characters/char1.png';
      case 'Cherry':
        return 'assets/characters/char2.png';
      case 'Aegis':
        return 'assets/characters/char3.png';
      default:
        return 'assets/characters/default.png';
    }
  }

  double _calculateDistance(double characterTop, double characterLeft,
      double enemyTop, double enemyLeft) {
    return sqrt(
        pow(characterTop - enemyTop, 2) + pow(characterLeft - enemyLeft, 2));
  }

  Widget _buildBackground() {
    return Positioned.fill(
      child: Image.asset(
        'assets/background/lvl1.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCharacter(String imagePath) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      top: characterTop,
      left: characterLeft,
      child: Image.asset(
        imagePath,
        width: 50,
        height: 50,
      ),
    );
  }

  Widget _buildEnemy(double enemyTop, double enemyLeft) {
    return Positioned(
      top: enemyTop,
      left: enemyLeft,
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
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementControls() {
    return Positioned(
      bottom: 50,
      left: 50,
      child: Column(
        children: [
          _buildMovementButton(Icons.arrow_upward, () {
            setState(() {
              characterTop -= 20;
            });
          }),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMovementButton(Icons.arrow_left, () {
                setState(() {
                  characterLeft -= 20;
                });
              }),
              SizedBox(width: 10),
              _buildMovementButton(Icons.arrow_right, () {
                setState(() {
                  characterLeft += 20;
                });
              }),
            ],
          ),
          SizedBox(height: 10),
          _buildMovementButton(Icons.arrow_downward, () {
            setState(() {
              characterTop += 20;
            });
          }),
        ],
      ),
    );
  }

  Widget _buildMovementButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
          color: Colors.black,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildInteractionButton(double distance) {
    return Positioned(
      bottom: 50,
      right: 50,
      child: GestureDetector(
        onTap: distance < proximityThreshold
            ? () {
                _showInteractionDialog(context);
              }
            : null,
        child: _buildInteractionButtonWidget(),
      ),
    );
  }

  Widget _buildInteractionButtonWidget() {
    return Container(
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
    );
  }

  void _showInteractionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Defeat this enemy by answering questions!',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              'Answer the questions to defeat your enemy. Are you ready?',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Roboto',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFightDialog(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Fight'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey[800],
                foregroundColor: Colors.white,
              ),
              child: Text('Run'),
            ),
          ],
        );
      },
    );
  }

  void _showFightDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Fight! Question ${questionIndex + 1}',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _buildQuestionWidgets(),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildQuestionWidgets() {
    List<Widget> questionWidgets = [];
    if (questionIndex < questions.length) {
      questionWidgets.add(Text(
        questions[questionIndex]['question'],
        style:
            TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: 14),
      ));
      questionWidgets.add(SizedBox(height: 10));
      for (var answer in questions[questionIndex]['answers']) {
        questionWidgets
            .add(_buildAnswerButton(answer['text'], answer['isCorrect']));
      }
    }
    return questionWidgets;
  }

  Widget _buildAnswerButton(String answer, bool isCorrect) {
    return ElevatedButton(
      onPressed: () {
        if (isCorrect) {
          setState(() {
            enemyLives--;
            questionIndex++;
          });
          if (enemyLives == 0 && questionIndex == questions.length) {
            _showVictoryDialog(context);
          } else {
            Navigator.of(context).pop();
            _showFightDialog(context);
          }
        } else {
          // Call the showWrongAnswerDialog here for incorrect answers
          Navigator.of(context).pop();
          _showWrongAnswerDialog(context);
        }
      },
      child: Text(answer),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white, width: 2),
      ),
    );
  }

  void _showWrongAnswerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text(
            'Wrong Answer!',
            style: TextStyle(
              color: Colors.red,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'The enemy remains undefeated. Try again!',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showFightDialog(context);
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Try Again'),
            ),
          ],
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
            'You successfully defeated the enemy!',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondStage()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Next Stage'),
            ),
          ],
        );
      },
    );
  }
}