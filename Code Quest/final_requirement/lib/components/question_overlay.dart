// import 'package:flutter/material.dart';

// class QuestionOverlay extends StatelessWidget {
//   final String questionText;
//   final List<String> answerOptions;
//   final Function(String) onAnswerSelected;

//   // Use super parameters for the constructor
//   const QuestionOverlay({
//     super.key, // Use super.key instead of Key? key
//     required this.questionText,
//     required this.answerOptions,
//     required this.onAnswerSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(questionText),
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: answerOptions.map((option) {
//           return ElevatedButton(
//             onPressed: () {
//               onAnswerSelected(option);
//             },
//             child: Text(option),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }