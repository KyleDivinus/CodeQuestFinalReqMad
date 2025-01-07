
import 'dart:convert';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'game_database.db'),
      version: 1,
      onCreate: _createDb,
    );
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        stage INTEGER NOT NULL,
        question TEXT NOT NULL,
        answers TEXT NOT NULL
      )
    ''');
    await _populateQuestions(db);
  }

  Future<void> _populateQuestions(Database db) async {
    final questions = [
      // Stage 1
      {
        "stage": 1,
        "question": "What is the main programming language used in Flutter?",
        "answers": jsonEncode([
          {"text": "Dart", "isCorrect": true},
          {"text": "JavaScript", "isCorrect": false},
          {"text": "Kotlin", "isCorrect": false},
        ]),
      },
      {
        "stage": 1,
        "question": "What widget is used to display text in Flutter?",
        "answers": jsonEncode([
          {"text": "Button", "isCorrect": false},
          {"text": "Container", "isCorrect": false},
          {"text": "Text", "isCorrect": true},
        ]),
      },

      // Stage 2
      {
        "stage": 2,
        "question": "What is the purpose of the pubspec.yaml file in a Flutter project?",
        "answers": jsonEncode([
          {"text": "To define widget layouts.", "isCorrect": false},
          {"text": "To configure app themes.", "isCorrect": false},
          {"text": "To manage dependencies and metadata.", "isCorrect": true},
        ]),
      },
      {
        "stage": 2,
        "question": "Which method is used to create a new widget in Flutter?",
        "answers": jsonEncode([
          {"text": "build()", "isCorrect": true},
          {"text": "create()", "isCorrect": false},
          {"text": "init()", "isCorrect": false},
        ]),
      },
      {
        "stage": 2,
        "question": "What is a key benefit of using Flutter?",
        "answers": jsonEncode([
          {"text": "Built-in database integration.", "isCorrect": false},
          {"text": "Single codebase for multiple platforms.", "isCorrect": true},
          {"text": "Automatic API generation.", "isCorrect": false},
        ]),
      },
      {
        "stage": 2,
        "question": "In Dart, which keyword is used to declare a constant variable?",
        "answers": jsonEncode([
          {"text": "final", "isCorrect": false},
          {"text": "static", "isCorrect": false},
          {"text": "const", "isCorrect": true},
        ]),
      },

      // Stage 3
      {
        "stage": 3,
        "question": "What is the main function in a Flutter app?",
        "answers": jsonEncode([
          {"text": "runApp()", "isCorrect": true},
          {"text": "main()", "isCorrect": false},
          {"text": "startApp()", "isCorrect": false},
        ]),
      },
      {
        "stage": 3,
        "question": "Which widget is used to create a scrollable list?",
        "answers": jsonEncode([
          {"text": "ListView", "isCorrect": true},
          {"text": "Column", "isCorrect": false},
          {"text": "Row", "isCorrect": false},
        ]),
      },
      {
        "stage": 3,
        "question": "What is the purpose of the setState() method?",
        "answers": jsonEncode([
          {"text": "To update the UI", "isCorrect": true},
          {"text": "To initialize variables", "isCorrect": false},
          {"text": "To create a new widget", "isCorrect": false},
        ]),
      },
      {
        "stage": 3,
        "question": "Which of the following is a valid way to declare a variable in Dart?",
        "answers": jsonEncode([
          {"text": "var name;", "isCorrect": true},
          {"text": "name: String;", "isCorrect": false},
          {"text": "String name;", "isCorrect": false},
        ]),
      },
      {
        "stage": 3,
        "question": "What is the purpose of the Future class in Dart?",
        "answers": jsonEncode([
          {"text": "To handle asynchronous operations", "isCorrect": true},
          {"text": "To create a new thread", "isCorrect": false},
          {"text": "To manage state", "isCorrect": false},
        ]),
      },

      // Stage 4
      {
        "stage": 4,
        "question": "Which of the following correctly describes the async and await keywords?",
        "answers": jsonEncode([
          {"text": "They allow for non-blocking asynchronous code execution.", "isCorrect": true},
          {"text": "They are used for synchronous programming.", "isCorrect": false},
          {"text": "They are only used in StatefulWidget.", "isCorrect": false},
          {"text": "They are used to define constants.", "isCorrect": false},
        ]),
      },
      {
        "stage": 4,
        "question": "What will happen if you call setState() inside the build() method of a StatefulWidget?",
        "answers": jsonEncode([
          {"text": "It will throw an error.", "isCorrect": true},
          {"text": "It will rebuild the widget.", "isCorrect": false},
          {"text": "It will initialize the state.", "isCorrect": false},
          {"text": "It will have no effect.", "isCorrect": false},
        ]),
      },
      {
        "stage": 4,
        "question": "In sqflite, what is the purpose of the Transaction class?",
        "answers": jsonEncode([
          {"text": "To ensure atomic operations on the database.", "isCorrect": true},
          {"text": "To manage multiple database connections.", "isCorrect": false},
          {"text": "To handle asynchronous queries.", "isCorrect": false},
          {"text": "To create new tables.", "isCorrect": false},
        ]),
      },
      {
        "stage": 4,
        "question": "Which of the following is NOT a valid way to query data in sqflite?",
        "answers": jsonEncode([
          {"text": "SELECT", "isCorrect": false},
          {"text": "JOIN", "isCorrect": false},
          {"text": "GROUP BY", "isCorrect": false},
          {"text": "FIND", "isCorrect": true},
        ]),
      },
    ];

    for (var question in questions) {
      await db.insert('questions', question);
    }
  }

  Future<List<Map<String, dynamic>>> getQuestionsByStage(int stage) async {
    final db = await database;
    return await db.query(
      'questions',
      where: 'stage = ?',
      whereArgs: [stage],
    );
  }
}
