import 'dart:async';

import 'package:final_requirement/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World{

  

  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async{
    
    level = await TiledComponent.load('CodeQuest.tmx', Vector2.all(16));

    add(level);
    add(Player());
    return super.onLoad();
  }
}