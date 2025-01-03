// import 'package:flutter/material.dart';

// class QuestionOverlay extends StatelessWidget {
//   final String questionText;
//   final List<String> answerOptions;
//   final Function(String) onAnswerSelected;

//   const QuestionOverlay({
//     super.key, // Use super parameter for key
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
//         children: answerOptions.map((answer) {
//           return ListTile(
//             title: Text(answer),
//             onTap: () {
//               onAnswerSelected(answer); // Pass the selected answer back
//             },
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
