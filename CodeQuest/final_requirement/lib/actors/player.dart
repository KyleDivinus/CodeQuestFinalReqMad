import 'dart:async';

import 'package:final_requirement/code_quest.dart';
import 'package:flame/components.dart';

enum PlayerState{
  idle, running 
}

class Player extends SpriteAnimationGroupComponent with HasGameRef <CodeQuest>{
  late final SpriteAnimation idleAnimation;
  final double stepTime = 0.05;


  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }
  
  void _loadAllAnimations() {
    idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache('Players/Char_001_Idle.png'),
      SpriteAnimationData.sequenced(
      amount: 4,
       stepTime: stepTime,
        textureSize: Vector2.all(64),
        ),
      );
      //List of animations
      animations = {
        PlayerState.idle: idleAnimation
      };
      // Set current animation
      current = PlayerState.idle;
  }
}