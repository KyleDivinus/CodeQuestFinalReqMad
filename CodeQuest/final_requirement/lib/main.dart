import 'package:final_requirement/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(MyGameApp());
}

class MyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

// import 'package:final_requirement/code_quest.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Flame.device.fullScreen();
//   Flame.device.setLandscape();

//   CodeQuest game = CodeQuest();
//   runApp(
//     GameWidget(game: kDebugMode ? CodeQuest() : game),
//   );
// }
