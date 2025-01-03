// import 'package:final_requirement/codequest_game.dart';
// import 'package:final_requirement/data/data.dart';

// import 'package:flame/components.dart';

// import 'package:flutter/material.dart';

// import 'question_overlay.dart';

// class EnemyComponent extends SpriteAnimationComponent with HasGameRef<CodequestGame> {
//   final String enemyName;
//   final String spritePath;

//   EnemyComponent({
//     required this.enemyName,
//     required this.spritePath,
//     required Vector2 size,
//   }) : super(size: size);

//   late Sprite sprite;

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     sprite = await Sprite.load(spritePath);
//   }

//   @override
//   void render(Canvas canvas) {
//     // Render enemy sprite
//     sprite.render(canvas, position: position, size: size);
//     super.render(canvas);
//   }

//   @override
//   void update(double dt) {
//     // Update enemy logic here (example movement or animations)
//     super.update(dt);
//   }

//   void interactWithPlayer() {
//     // Handle the interaction with the player
//     print('$enemyName is interacting with the player!');

//     // Show the question overlay using Flame's overlay system
//     gameRef.overlays.add('questionOverlay');
//   }
// }

// class EnemyComponentWidget extends StatefulWidget {
//   final String enemyName;

//   const EnemyComponentWidget({super.key, required this.enemyName});

//   @override
//   EnemyComponentWidgetState createState() => EnemyComponentWidgetState();
// }

// class EnemyComponentWidgetState extends State<EnemyComponentWidget> {
//   bool questionAsked = false;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!questionAsked) {
//           _showQuestion();
//           setState(() {
//             questionAsked = true;
//           });
//         }
//         interactWithPlayer();
//       },
//       child: Container(
//         color: Colors.blue, // Example enemy container
//         child: Center(
//           child: Text(widget.enemyName),
//         ),
//       ),
//     );
//   }

//   void _showQuestion() {
//     final question = enemyQuestions[widget.enemyName];
//     if (question != null) {
//       // Show the Question Overlay
//       showDialog(
//         context: context,
//         builder: (context) {
//           return QuestionOverlay(
//             questionText: question.questionText,
//             answerOptions: question.answerOptions,
//             onAnswerSelected: (selectedAnswer) {
//               _handleAnswer(selectedAnswer, question);
//               Navigator.of(context).pop(); // Close the overlay
//             },
//           );
//         },
//       );
//     }
//   }

//   void _handleAnswer(String selectedAnswer, Question question) {
//     // Check if the selected answer matches the correct answer
//     int selectedAnswerIndex = question.answerOptions.indexOf(selectedAnswer);

//     // Check if the selected answer index matches the correct answer index
//     if (selectedAnswerIndex == question.correctAnswerIndex) {
//       // Handle correct answer
//       print("Correct answer!");
//       // Add logic for correct answer (e.g., reward player, remove enemy, etc.)
//     } else {
//       // Handle wrong answer
//       print("Wrong answer!");
//       // Add logic for wrong answer (e.g., penalize player, reset question, etc.)
//     }
//   }

//   void interactWithPlayer() {
//     // Handle the interaction with the player in the widget context
//     print('${widget.enemyName} is interacting with the player!');
//   }
// }