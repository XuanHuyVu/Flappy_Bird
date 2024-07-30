import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';

import '../utility/config.dart';

class Ground extends ParallaxComponent with CollisionCallbacks{
  Ground():super(){
    debugMode = false;
  }

  @override
  Future<void> onLoad() async {
    parallax  = await game.loadParallax([ParallaxImageData('ground.png')],
      baseVelocity: Vector2(Config.speedGame, 0),
      fill: LayerFill.none,
      alignment: Alignment.bottomLeft
    );
    add(RectangleHitbox(
      position: Vector2(0, game.size.y - Config.heightGround),
      size: Vector2(game.size.x, Config.heightGround)
    ));
    
    return super.onLoad();
  }
}