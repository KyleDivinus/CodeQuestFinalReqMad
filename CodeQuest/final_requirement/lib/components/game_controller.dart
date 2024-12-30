import 'package:flame/game.dart';
import 'player.dart';
import 'enemy.dart';
import 'health.dart';

class GameController extends FlameGame {
  late Player player;
  late Health health;
  List<Enemy> enemies = [];

  GameController({required String character}) {
    player = Player(character);
    health = Health(4); // Starting with 4 health points
    add(player);
    add(health);
    _initializeEnemies();
  }

  void _initializeEnemies() {
    // Add enemies to the game
    for (int i = 1; i <= 3; i++) {
      Enemy enemy = Enemy(i);
      enemy.position = Vector2(100.0 * i, 100.0); // Ensure this is a double
      enemies.add(enemy);
      add(enemy);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update game logic, check for interactions, etc.
    checkCollisions();
  }

  void checkCollisions() {
    // Logic to check for collisions between player and enemies
    for (var enemy in enemies) {
      if (player.toRect().overlaps(enemy.toRect())) {
        enemy.interact(); // Trigger interaction with the enemy
      }
    }
  }
}