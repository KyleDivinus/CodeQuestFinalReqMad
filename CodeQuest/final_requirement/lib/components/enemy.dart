import 'package:flame/components.dart';
import 'package:logger/logger.dart'; // Import the logger package
import 'dart:math';

class Enemy extends SpriteComponent {
  final int enemyType;
  bool isInteracting = false; // To track if the enemy is interacting with the player
  List<String> questions = []; // List of questions for the enemy
  String? currentQuestion; // Current question being asked
  final Logger logger = Logger(); // Create a logger instance

  Enemy(this.enemyType) {
    // Set the size of the enemy
    size = Vector2(16, 16);
    _loadQuestions(); // Load questions for this enemy
  }

  @override
  Future<void> onLoad() async {
    // Load enemy sprites based on type
    sprite = await Sprite.load('assets/images/Enemy/Enemy$enemyType.png');
  }

  void _loadQuestions() {
    // Load questions based on enemy type
    switch (enemyType) {
      case 1:
        questions = [
          "What is the output of print(2 + 2)?",
          "What is a variable?",
        ];
        break;
      case 2:
        questions = [
          "What does HTML stand for?",
          "What is CSS used for?",
        ];
        break;
      case 3:
        questions = [
          "What is a function?",
          "What is an array?",
        ];
        break;
      default:
        questions = ["What is programming?"];
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update enemy state (e.g., idle behavior)
    if (isInteracting) {
      // Logic for interaction (e.g., display question)
      // You can implement a timer or a condition to end interaction
    }
  }

  // Method to interact with the player
  void interact() {
    if (!isInteracting) {
      isInteracting = true;
      // Randomly select a question from the list
      currentQuestion = questions[Random().nextInt(questions.length)];
      logger.i("Enemy asks: $currentQuestion"); // Log the question
      // Here you can implement a way to show the question in the UI
    }
  }

  // Method to check the player's answer
  bool checkAnswer(String answer) {
    // Logic to check if the answer is correct
    // For simplicity, let's assume the correct answer is always "4" for the first question
    if (currentQuestion == questions[0] && answer == "4") {
      isInteracting = false; // End interaction
      logger.i("Correct answer provided."); // Log correct answer
      return true; // Correct answer
    }
    // Add more conditions for other questions
    logger.w("Incorrect answer provided."); // Log incorrect answer
    return false; // Incorrect answer
  }
}