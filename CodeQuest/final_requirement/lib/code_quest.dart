import 'dart:async';
import 'dart:ui';

import 'package:final_requirement/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class CodeQuest extends FlameGame{
  @override
  Color backgroundColor () => const Color.fromARGB(0, 201, 25, 25);

  late final CameraComponent cam;

  final world = Level();
  

  @override
  FutureOr<void> onLoad() async{
    //load all images into cache
    await images.loadAllImages();
    cam = CameraComponent.withFixedResolution(world: world, width: 330, height: 150);

    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
    return super.onLoad();
  }
}