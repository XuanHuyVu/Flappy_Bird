import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

import '../utility/config.dart';

class Pipe extends SpriteComponent with HasGameReference{
  final bool isTop;
  @override
  final double height;
  Pipe({ required this.isTop, required this.height}):super() {
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() async {
    final pipe = await Flame.images.load('pipe.png');
    size = Vector2(70, height);
    if(isTop) {
      flipVerticallyAroundCenter();
      position.y = height;
      sprite = Sprite(pipe);
    } else {
      position.y = game.size.y - Config.heightGround - size.y;
      sprite = Sprite(pipe);
    }
    add(RectangleHitbox());

    return super.onLoad();
  }
}