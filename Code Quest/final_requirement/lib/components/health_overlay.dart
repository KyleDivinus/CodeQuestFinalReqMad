// import 'package:flame/components.dart';
// import 'package:flame/flame.dart';
// import 'player_component.dart';


// class HealthBarComponent extends SpriteComponent {
//   final PlayerComponent player;

//   HealthBarComponent(this.player);

//   late final Sprite fullHeart;
//   late final Sprite twoHeart;
//   late final Sprite oneHeart;
//   late final Sprite noHeart;

//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//     size = Vector2(100, 20);
//     position = Vector2(10, 10); // Health bar position

//     // Load health bar sprites
//     await loadHealthSprites();

//     // Set a default sprite to avoid the assertion error
//     sprite = fullHeart; // Use fullHeart as the default sprite
//   }

//   Future<void> loadHealthSprites() async {
//     fullHeart = Sprite(await Flame.images.load('UI/fullhearth.png'));
//     twoHeart = Sprite(await Flame.images.load('UI/twohearth.png'));
//     oneHeart = Sprite(await Flame.images.load('UI/onehearth.png'));
//     noHeart = Sprite(await Flame.images.load('UI/nohearth.png'));
//   }

//   @override
//   void update(double dt) {
//     super.update(dt);

//     // Dynamically update the sprite based on the player's health
//     if (player.health > 66) {
//       sprite = fullHeart;
//     } else if (player.health > 33) {
//       sprite = twoHeart;
//     } else if (player.health > 0) {
//       sprite = oneHeart;
//     } else {
//       sprite = noHeart;
//     }
//   }
// }
// import 'package:final_requirement/codequest_game.dart';
// import 'package:flutter/material.dart';


// class HealthOverlay extends StatelessWidget {
//   final CodequestGame game;

//   const HealthOverlay(this.game, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Determine the correct image based on the player's health
//     String healthImage;
//     switch (game.playerHealth) {
//       case 3:
//         healthImage = 'assets/images/UI/fullhearth.png';
//         break;
//       case 2:
//         healthImage = 'assets/images/UI/twohearth.png';
//         break;
//       case 1:
//         healthImage = 'assets/images/UI/onehearth.png';
//         break;
//       default:
//         healthImage = 'assets/images/UI/noheart.png';
//     }

//     return Positioned(
//       top: 10,
//       left: 10,
//       child: Image.asset(
//         healthImage,
//         width: 100,
//         height: 30,
//       ),
//     );
//   }
// }

