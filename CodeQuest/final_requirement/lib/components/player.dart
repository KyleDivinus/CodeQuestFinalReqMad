import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart'; // Import for KeyEvent and LogicalKeyboardKey
import 'package:flame/flame.dart'; // Import for Flame.images

class Player extends SpriteAnimationComponent with KeyboardHandler {
  // Player properties
  String character;
  int healthPoints = 4; // Starting health points
  late SpriteAnimation idleAnimation;
  late SpriteAnimation walkAnimation;

  Player(this.character) {
    // Set the size of the player
    size = Vector2(16, 16);
    position = Vector2(45.33, 42.00); // Initial spawn point
  }

  @override
  Future<void> onLoad() async {
    await _loadAnimations(); // Load animations asynchronously
    animation = idleAnimation; // Start with idle animation
  }

  Future<void> _loadAnimations() async {
    // Load animations for the character
    final idleSpriteSheetImage = await Flame.images.load('assets/images/Players/$character/Char_idle.png');
    final walkSpriteSheetImage = await Flame.images.load('assets/images/Players/$character/Char.png');

    // Create animations from the loaded images
    idleAnimation = SpriteAnimation.fromFrameData(
      idleSpriteSheetImage,
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 0.1,
        textureSize: Vector2(16, 16),
      ),
    );

    walkAnimation = SpriteAnimation.fromFrameData(
      walkSpriteSheetImage,
      SpriteAnimationData.sequenced(
        amount: 4, // Number of frames in the walking animation
        stepTime: 0.1,
        textureSize: Vector2(16, 16),
      ),
    );

    // Set the initial animation
    animation = idleAnimation;
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Update player state, handle movement, etc.
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      switch (event.logicalKey.keyLabel) {
        case 'Arrow Up':
          _move(Vector2(0, -1));
          break;
        case 'Arrow Down':
          _move(Vector2(0, 1));
          break;
        case 'Arrow Left':
          _move(Vector2(-1, 0));
          break;
        case 'Arrow Right':
          _move(Vector2(1, 0));
          break;
      }
    }
    return false; // Return false to indicate that the event was not fully handled
  }

  void _move(Vector2 direction) {
    // Move the player in the specified direction
    position.add(direction * 2); // Adjust speed as needed
    animation = walkAnimation; // Change to walking animation
  }

  void stop() {
    // Stop the player and switch to idle animation
    animation = idleAnimation;
  }

  void decreaseHealth() {
    if (healthPoints > 0) {
      healthPoints--;
      // Update health UI or handle player death
    }
  }
}