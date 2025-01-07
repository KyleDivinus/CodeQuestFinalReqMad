import 'dart:convert';

import 'package:codequest_etr/helpers/database_helper.dart';
import 'package:codequest_etr/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FourthStage extends StatefulWidget {
  @override
  _FourthStageState createState() => _FourthStageState();
}

class _FourthStageState extends State<FourthStage> {
  double characterTop = 50;
  double characterLeft = 150;
  double proximityThreshold = 120;
  int enemyLives = 10;
  int questionIndex = 0;

  List<Map<String, dynamic>> questions = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _fetchQuestionsForStage(4); 
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
    double enemyTop = MediaQuery.of(context).size.height / 2 - -50;
    double enemyLeft = MediaQuery.of(context).size.width / 2 - -20;
    enemyLeft += 50;

    double distance = sqrt(pow(characterTop - enemyTop, 2) +
        pow(characterLeft - (MediaQuery.of(context).size.width / 2), 2));

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background/lvl4.jpg',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/characters/enemy.png',
                      width: 85,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/characters/enemy2.png',
                      width: 85,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10),
                    Image.asset(
                      'assets/characters/enemy3.png',
                      width: 85,
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                SizedBox(height: 10),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterTop -= 10;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_upward),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterLeft -= 10;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_left),
                    ),
                    SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterLeft += 10;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_right),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          characterTop += 10;
                        });
                      },
                      child: _buildMovementButton(Icons.arrow_downward),
                    ),
                  ],
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
            'The enemies joined forces to block the safe exit!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Answer the questions to defeat your enemies. Are you ready?',
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  currentQuestion['question'],
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10),
                Column(
                  children: shuffledAnswers
                      .map((answer) => _buildAnswerButton(
                          answer['text'], answer['isCorrect']))
                      .toList(),
                ),
              ],
            ),
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
            'You successfully defeated all the enemies!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Heading to the safe zone...',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Finish'),
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
            'The enemies remain undefeated. Try again!',
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