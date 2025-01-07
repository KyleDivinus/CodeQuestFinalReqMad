import 'dart:convert';

import 'package:codequest_etr/helpers/database_helper.dart';
import 'package:codequest_etr/screens/game_screen3.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SecondStage extends StatefulWidget {
  @override
  _SecondStageState createState() => _SecondStageState();
}

class _SecondStageState extends State<SecondStage> {
  double characterTop = 50;
  double characterLeft = 150;
  double proximityThreshold = 120;
  int enemyLives = 4;
  int questionIndex = 0;

  List<Map<String, dynamic>> questions = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchQuestionsForStage(2); 
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
    String imagePath = 'assets/characters/char1.png';
    double enemyTop = MediaQuery.of(context).size.height / 2 - 20;
    double enemyLeft = MediaQuery.of(context).size.width - 180;
    double distance = sqrt(
        (characterTop - enemyTop) * (characterTop - enemyTop) +
            (characterLeft - enemyLeft) * (characterLeft - enemyLeft));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background/lvl2.jpg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            top: characterTop,
            left: characterLeft,
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
          ),
          Positioned(
            top: enemyTop,
            left: enemyLeft,
            child: Column(
              children: [
                Image.asset(
                  'assets/characters/enemy2.png',
                  width: 80,
                  height: 120,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 5),
                Text(
                  'Lives: $enemyLives',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      characterTop -= 20;
                    });
                  },
                  child: _buildMovementButton(Icons.arrow_upward),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterLeft -= 20;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_left),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterLeft += 20;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_right),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      characterTop += 20;
                    });
                  },
                  child: _buildMovementButton(Icons.arrow_downward),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            right: 50,
            child: GestureDetector(
              onTap: distance < proximityThreshold
                  ? () {
                      _showInteractionDialog(context);
                    }
                  : null,
              child: _buildInteractionButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovementButton(IconData icon) {
    return Container(
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
    );
  }

  Widget _buildInteractionButton() {
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
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Answer the questions to defeat your enemy. Are you ready?',
            style: TextStyle(color: Colors.white),
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
    if (questionIndex >= questions.length) {
      _showVictoryDialog(context);
      return;
    }

    Map<String, dynamic> currentQuestion = questions[questionIndex];
    List<Map<String, dynamic>> shuffledAnswers = [
      ...currentQuestion['answers']
    ];
    shuffledAnswers.shuffle();

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
              Column(
                children: shuffledAnswers
                    .map((answer) =>
                        _buildAnswerButton(answer['text'], answer['isCorrect']))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnswerButton(String answer, bool isCorrect) {
    return ElevatedButton(
      onPressed: () {
        if (isCorrect) {
          setState(() {
            enemyLives--;
            questionIndex++;
          });
          if (enemyLives > 0) {
            Navigator.of(context).pop();
            _showFightDialog(context);
          } else {
            _showVictoryDialog(context);
          }
        } else {
          _showDefeatDialog(context);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white, width: 2),
      ),
      child: Text(answer),
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
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ThirdStage()),
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

  void _showDefeatDialog(BuildContext context) {
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
            style: TextStyle(color: Colors.white),
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
}