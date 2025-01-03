// data.dart

class Question {
  final String questionText;
  final List<String> answerOptions; // List of answers
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answerOptions,
    required this.correctAnswerIndex,
  });

  // Method to check if the player's selected answer is correct
  bool checkAnswer(int playerAnswerIndex) {
    return playerAnswerIndex == correctAnswerIndex;
  }
}

final Map<String, Question> enemyQuestions = {
  'Enemy 1': Question(
    questionText: 'What is a variable?',
    answerOptions: ['A type of loop', 'A container for data', 'A function'],
    correctAnswerIndex: 1, // "A container for data" is correct
  ),
  'Enemy 2': Question(
    questionText: 'Explain the concept of polymorphism.',
    answerOptions: ['A way to write code faster', 'A way to use different data types', 'A way to use methods in multiple classes'],
    correctAnswerIndex: 2, // "A way to use methods in multiple classes" is correct
  ),
  'Enemy 3': Question(
    questionText: 'Write a function to find the Fibonacci sequence.',
    answerOptions: ['A recursive function', 'A loop that counts to 10', 'A series of print statements'],
    correctAnswerIndex: 0, // "A recursive function" is correct
  ),
};