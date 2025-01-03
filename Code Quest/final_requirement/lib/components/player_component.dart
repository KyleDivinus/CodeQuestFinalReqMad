// import 'package:final_requirement/codequest_game.dart';
// import 'package:final_requirement/components/enemy_component.dart';
// import 'package:flame/components.dart';
// import 'package:flame/collisions.dart';
// import 'package:flutter/services.dart';
// import '../player_enum.dart';

// class PlayerComponent extends SpriteAnimationGroupComponent<PlayerState>
//     with HasGameRef<CodequestGame>, KeyboardHandler, CollisionCallbacks {
//   final String character;
//   final Vector2 _velocity = Vector2.zero();
//   bool _collidingX = false;
//   bool _collidingY = false;

//   PlayerComponent({required this.character})
//       : super(size: Vector2(32, 32), anchor: Anchor.center);

//   @override
//   Future<void> onLoad() async {
//     final idleForward = await _loadAnimation('Idle.png');
//     final idleBackward = await _loadAnimation('IdleBackWard.png');
//     final idleLeft = await _loadAnimation('IdleLeft.png');
//     final idleRight = await _loadAnimation('IdleRight.png');
//     final runForward = await _loadAnimation('RunningForward.png');
//     final runBackward = await _loadAnimation('RunningBackward.png');
//     final runLeft = await _loadAnimation('RunningLeft.png');
//     final runRight = await _loadAnimation('RunningRight.png');

//     animations = {
//       PlayerState.idleForward: idleForward,
//       PlayerState.idleBackward: idleBackward,
//       PlayerState.idleLeft: idleLeft,
//       PlayerState.idleRight: idleRight,
//       PlayerState.runForward: runForward,
//       PlayerState.runBackward: runBackward,
//       PlayerState.runLeft: runLeft,
//       PlayerState.runRight: runRight,
//     };

//     current = PlayerState.idleForward;

//     add(RectangleHitbox()..collisionType = CollisionType.active);
//   }

//   Future<SpriteAnimation> _loadAnimation(String fileName) async {
//     return SpriteAnimation.load(
//       'Players/$character/$fileName',
//       SpriteAnimationData.sequenced(
//         amount: 4,
//         stepTime: 0.5,
//         textureSize: Vector2.all(24),
//       ),
//     );
//   }

//   @override
//   bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
//     _velocity.setZero();

//     if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
//       _velocity.y = -2;
//       current = PlayerState.runBackward;
//     } else if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
//       _velocity.y = 2;
//       current = PlayerState.runForward;
//     } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
//       _velocity.x = -2;
//       current = PlayerState.runLeft;
//     } else if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
//       _velocity.x = 2;
//       current = PlayerState.runRight;
//     } else {
//       _velocity.setZero();
//       switch (current) {
//         case PlayerState.runForward:
//           current = PlayerState.idleForward;
//           break;
//         case PlayerState.runBackward:
//           current = PlayerState.idleBackward;
//           break;
//         case PlayerState.runLeft:
//           current = PlayerState.idleLeft;
//           break;
//         case PlayerState.runRight:
//           current = PlayerState.idleRight;
//           break;
//         default:
//           current = PlayerState.idleForward;
//       }
//     }
//     return true;
//   }

//   @override
//     void update(double dt) {
//       super.update(dt);
//       if (!_collidingX) position.x += _velocity.x;
//       if (!_collidingY) position.y += _velocity.y;
//       _collidingX = _collidingY = false;
//     }

//     @override
//   void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
//     // Only call interactWithPlayer if the other component is an EnemyComponent
//     if (other is EnemyComponent) {
//       other.interactWithPlayer();  // Call interactWithPlayer on EnemyComponent
//     }

//     if (other.children.any((c) => c is RectangleHitbox)) {
//       if (_velocity.x != 0) _collidingX = true;
//       if (_velocity.y != 0) _collidingY = true;
//     }
//     super.onCollision(intersectionPoints, other);
//   }
// }


// // import 'package:flame/collisions.dart';
// // import 'package:flame/components.dart';
// // import 'package:flame/game.dart';
// // import 'package:flame/geometry.dart';

// // // Class for your player component
// // class PlayerComponent extends SpriteComponent with Hitbox, Collidable {
// //   final String characterName;

// //   PlayerComponent({required this.characterName, required Vector2 size})
// //       : super(size: size);

// //   @override
// //   Future<void> onLoad() async {
// //     // Load sprite or image based on character name
// //     switch (characterName) {
// //       case 'Aegis':
// //         sprite = await Sprite.load('assets/images/players/aegis.png');
// //         break;
// //       case 'Blaze':
// //         sprite = await Sprite.load('assets/images/players/blaze.png');
// //         break;
// //       case 'Cherry':
// //         sprite = await Sprite.load('assets/images/players/cherry.png');
// //         break;
// //       default:
// //         sprite = await Sprite.load('assets/images/players/default.png');
// //         break;
// //     }
// //     super.onLoad();
// //   }
// // }
