// import 'package:flame/game.dart';
// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:flame/collisions.dart';
// import 'package:flame_tiled/flame_tiled.dart';
// import 'components/player_component.dart'; // Import PlayerComponent
// import 'components/enemy_component.dart';  // Import EnemyComponent

// class CodequestGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
//   late final CameraComponent cam;
//   late final TiledComponent map;
//   late final PlayerComponent player;
//   final String selectedCharacter;

//   CodequestGame({required this.selectedCharacter});

//   @override
//   Future<void> onLoad() async {
//     final world = World();

//     // Load the Tiled map
//     map = await TiledComponent.load('CodeQuest.tmx', Vector2.all(16));
//     world.add(map);
//     add(world);

//     // Create collision components
//     final collisionComponents = _createCollisions(map, 'Collisions', 'Platform');
//     for (final collision in collisionComponents) {
//       world.add(collision);
//     }

//     // Get the spawn point for the player
//     final spawnPoint = _getObjectPosition(map, 'spawnpoint', 'Player');
//     if (spawnPoint == null) {
//       throw Exception('Player spawn point not found in the Tiled map.');
//     }
//     print("Player spawn point: $spawnPoint");

//     // Create the player component
//     player = PlayerComponent(character: selectedCharacter);
//     player.position = spawnPoint;
//     world.add(player);

//     // Get all spawn points for enemies and spawn them
//     final enemySpawnPoints = _getAllObjects(map, 'spawnpoint', 'Enemy');
//     if (enemySpawnPoints.isEmpty) {
//       print("No enemy spawn points found in the map.");
//     } else {
//       print("Enemy spawn points: $enemySpawnPoints");
//     }

//     for (final enemySpawn in enemySpawnPoints) {
//       final enemyName = enemySpawn['name']!;
//       final enemyPath = _getEnemySpritePath(enemyName);
//       final enemyPosition = enemySpawn['position']!;
//       print("Creating enemy '$enemyName' at $enemyPosition with sprite '$enemyPath'.");

//       // Check if sprite exists
//       try {
//         final enemy = EnemyComponent(
//           spritePath: enemyPath,
//           enemyName: enemyName,
//           size: Vector2.all(32),
//         )..position = enemyPosition;

//         world.add(enemy);
//         print("Enemy '$enemyName' added to the world.");
//       } catch (e) {
//         print("Failed to add enemy '$enemyName': $e");
//       }
//     }

//     // Set up the camera to follow the player
//     cam = CameraComponent.withFixedResolution(world: world, width: 300, height: 200);
//     cam.follow(player);
//     addAll([cam, world]);

//     print("Game Loaded Successfully!");
//   }

//   /// Creates collision components encapsulating ShapeHitbox from the Tiled map layer and type.
//   List<PositionComponent> _createCollisions(TiledComponent map, String layerName, String objectType) {
//     final objectGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
//     if (objectGroup == null) {
//       print('Collision layer not found!');
//       return [];
//     }

//     return objectGroup.objects
//         .where((obj) => obj.type == objectType && obj.width > 0 && obj.height > 0) // Filter valid objects
//         .map((obj) {
//           print("Adding collision object at (${obj.x}, ${obj.y}) with size (${obj.width}, ${obj.height})");
//           return PositionComponent(
//             position: Vector2(obj.x, obj.y),
//             size: Vector2(obj.width, obj.height),
//           )..add(RectangleHitbox()..collisionType = CollisionType.passive); // Passive walls
//         })
//         .toList();
//   }

//   /// Extracts the position of an object from a specific object group in the Tiled map.
//   Vector2? _getObjectPosition(TiledComponent map, String groupName, String objectName) {
//     final objectGroup = map.tileMap.getLayer<ObjectGroup>(groupName);
//     if (objectGroup == null) return null;

//     for (final obj in objectGroup.objects) {
//       if (obj.name == objectName) {
//         return Vector2(obj.x, obj.y);
//       }
//     }
//     return null;
//   }

//   /// Gets all objects of a specific type and group from the Tiled map.
//   List<Map<String, dynamic>> _getAllObjects(TiledComponent map, String groupName, String objectType) {
//     final objectGroup = map.tileMap.getLayer<ObjectGroup>(groupName);
//     if (objectGroup == null) return [];

//     return objectGroup.objects
//         .where((obj) => obj.type == objectType)
//         .map((obj) => {'name': obj.name, 'position': Vector2(obj.x, obj.y)})
//         .toList();
//   }

//   String _getEnemySpritePath(String enemyName) {
//     switch (enemyName) {
//       case 'Enemy 1':
//         return 'Enemy/enemy.png';
//       case 'Enemy 2':
//         return 'Enemy/enemy2.png';
//       case 'Enemy 3':
//         return 'Enemy/enemy3.png';
//       default:
//         throw Exception('Unknown enemy name: $enemyName');
//     }
//   }
// }


import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/collisions.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/services.dart';

class CodequestGame extends FlameGame with HasKeyboardHandlerComponents, HasCollisionDetection {
  late final CameraComponent cam;
  late final TiledComponent map;
  late final PlayerComponent player;

  final String selectedCharacter;

  CodequestGame({required this.selectedCharacter});

  @override
  Future<void> onLoad() async {
    final world = World();

    // Load the Tiled map
    map = await TiledComponent.load('CodeQuest.tmx', Vector2.all(16));
    world.add(map);
    add(world);

    // Add collision objects from the Tiled map
    final collisionComponents = _createCollisions(map, 'Collisions', 'Platform');
    for (final collision in collisionComponents) {
      world.add(collision);
    }

    // Locate player spawn point from the map
    final spawnPoint = _getObjectPosition(map, 'spawnpoint', 'Player');
    if (spawnPoint == null) {
      throw Exception('Player spawn point not found in the Tiled map.');
    }

    // Add the player at the spawn point
    player = PlayerComponent(character: selectedCharacter);
    player.position = spawnPoint;
    world.add(player);

    // Add enemies from spawn points
    final enemySpawnPoints = _getAllObjects(map, 'spawnpoint', 'Enemy');
    for (final enemySpawn in enemySpawnPoints) {
      final enemyName = enemySpawn['name']!;
      final enemyPath = _getEnemySpritePath(enemyName);
      final enemyPosition = enemySpawn['position']!;
      final enemy = EnemyComponent(
        spritePath: enemyPath,
        enemyName: enemyName,
        size: Vector2.all(32),
      )..position = enemyPosition;
      world.add(enemy);
    }

    // Camera setup
    cam = CameraComponent.withFixedResolution(world: world, width: 300, height: 200);
    cam.follow(player);
    addAll([cam, world]);

    print("Game Loaded Successfully!");
  }

  /// Creates collision components encapsulating ShapeHitbox from the Tiled map layer and type.
  List<PositionComponent> _createCollisions(TiledComponent map, String layerName, String objectType) {
    final objectGroup = map.tileMap.getLayer<ObjectGroup>(layerName);
    if (objectGroup == null) {
      print('Collision layer not found!');
      return [];
    }

    return objectGroup.objects
        .where((obj) => obj.type == objectType && obj.width > 0 && obj.height > 0) // Filter valid objects
        .map((obj) {
          print("Adding collision object at (${obj.x}, ${obj.y}) with size (${obj.width}, ${obj.height})");
          return PositionComponent(
            position: Vector2(obj.x, obj.y),
            size: Vector2(obj.width, obj.height),
          )..add(RectangleHitbox()..collisionType = CollisionType.passive); // Passive walls
        })
        .toList();
  }

  /// Extracts the position of an object from a specific object group in the Tiled map.
  Vector2? _getObjectPosition(TiledComponent map, String groupName, String objectName) {
    final objectGroup = map.tileMap.getLayer<ObjectGroup>(groupName);
    if (objectGroup == null) return null;

    for (final obj in objectGroup.objects) {
      if (obj.name == objectName) {
        return Vector2(obj.x, obj.y);
      }
    }
    return null;
  }

  /// Gets all objects of a specific type and group from the Tiled map.
  List<Map<String, dynamic>> _getAllObjects(TiledComponent map, String groupName, String objectType) {
    final objectGroup = map.tileMap.getLayer<ObjectGroup>(groupName);
    if (objectGroup == null) return [];

    return objectGroup.objects
        .where((obj) => obj.type == objectType)
        .map((obj) => {'name': obj.name, 'position': Vector2(obj.x, obj.y)})
        .toList();
  }

  String _getEnemySpritePath(String enemyName) {
    switch (enemyName) {
      case 'Enemy 1':
        return 'Enemy/enemy.png';
      case 'Enemy 2':
        return 'Enemy/enemy2.png';
      case 'Enemy 3':
        return 'Enemy/enemy3.png';
      default:
        throw Exception('Unknown enemy name: $enemyName');
    }
  }
}

class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
    with HasGameRef<CodequestGame>, KeyboardHandler, CollisionCallbacks {
  final String character;

  final Vector2 _velocity = Vector2.zero(); // Track movement direction and speed
  bool _collidingX = false; // Tracks collisions along the X axis
  bool _collidingY = false; // Tracks collisions along the Y axis

  PlayerComponent({required this.character})
      : super(size: Vector2(32, 32), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Load animations for each state and direction
    final idleForward = await _loadAnimation('Idle.png');
    final idleBackward = await _loadAnimation('IdleBackWard.png');
    final idleLeft = await _loadAnimation('IdleLeft.png');
    final idleRight = await _loadAnimation('IdleRight.png');

    final runForward = await _loadAnimation('RunningForward.png');
    final runBackward = await _loadAnimation('RunningBackward.png');
    final runLeft = await _loadAnimation('RunningLeft.png');
    final runRight = await _loadAnimation('RunningRight.png');

    animations = {
      PlayerState.idleForward: idleForward,
      PlayerState.idleBackward: idleBackward,
      PlayerState.idleLeft: idleLeft,
      PlayerState.idleRight: idleRight,
      PlayerState.runForward: runForward,
      PlayerState.runBackward: runBackward,
      PlayerState.runLeft: runLeft,
      PlayerState.runRight: runRight,
    };

    current = PlayerState.idleForward;

    // Add collision hitbox
    add(RectangleHitbox()
      ..collisionType = CollisionType.active); // Active player
  }

  Future<SpriteAnimation> _loadAnimation(String fileName) async {
    return SpriteAnimation.load(
      'Players/$character/$fileName',
      SpriteAnimationData.sequenced(
        amount: 4, // Number of frames in the animation
        stepTime: 0.5, // Time per frame
        textureSize: Vector2.all(24),
      ),
    );
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Reset velocity
    _velocity.setZero();

    // Handle movement input
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      _velocity.y = -2;
      current = PlayerState.runBackward;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      _velocity.y = 2;
      current = PlayerState.runForward;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _velocity.x = -2;
      current = PlayerState.runLeft;
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _velocity.x = 2;
      current = PlayerState.runRight;
    } else {
      // Reset to idle state
      _velocity.setZero();
      if (current == null) {
        current = PlayerState.idleForward; // Default fallback
      } else {
        switch (current) {
          case PlayerState.runForward:
            current = PlayerState.idleForward;
            break;
          case PlayerState.runBackward:
            current = PlayerState.idleBackward;
            break;
          case PlayerState.runLeft:
            current = PlayerState.idleLeft;
            break;
          case PlayerState.runRight:
            current = PlayerState.idleRight;
            break;
          default:
            current = PlayerState.idleForward; // Default idle state
            break;
        }
      }
    }
    return true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Adjust position based on velocity and collisions
    if (!_collidingX) {
      position.x += _velocity.x;
    }
    if (!_collidingY) {
      position.y += _velocity.y;
    }

    // Reset collision flags for next frame
    _collidingX = false;
    _collidingY = false;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is EnemyComponent) {
      other.interactWithPlayer();
    }
    if (other.children.any((c) => c is RectangleHitbox)) {
      if (_velocity.x != 0) _collidingX = true;
      if (_velocity.y != 0) _collidingY = true;
    }
    super.onCollision(intersectionPoints, other);
  }
}

enum PlayerState {
  idleForward,
  idleBackward,
  idleLeft,
  idleRight,
  runForward,
  runBackward,
  runLeft,
  runRight,
}

class EnemyComponent extends SpriteAnimationComponent with CollisionCallbacks {
  final String enemyName;
  final String spritePath;

  EnemyComponent({
    required this.spritePath,
    required this.enemyName,
    required Vector2 size,
  }) : super(size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    animation = await SpriteAnimation.load(
      spritePath,
      SpriteAnimationData.sequenced(amount: 4, stepTime: 0.5, textureSize: Vector2.all(24)),
    );
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  void interactWithPlayer() {
    final question = _getProgrammingQuestion();
    print('Interaction with $enemyName: $question');
  }

  String _getProgrammingQuestion() {
    switch (enemyName) {
      case 'Enemy 1':
        return 'What is a variable?';
      case 'Enemy 2':
        return 'Explain the concept of polymorphism.';
      case 'Enemy 3':
        return 'Write a function to find the Fibonacci sequence.';
      default:
        return 'No question available.';
    }
  }
}


