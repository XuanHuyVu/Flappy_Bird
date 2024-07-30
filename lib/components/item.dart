import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:game_flappy_bird/components/player.dart';

class Item extends PositionComponent with CollisionCallbacks {
  Vector2 mSize;
  Item({ required this.mSize}):super(size: mSize) {
    debugMode = false;
  }

  @override
  FutureOr<void> onLoad() {
    add(RectangleHitbox(size: size));
    return super.onLoad();
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    if(other is Player) {
      other.score++;
      removeFromParent();
      FlameAudio.play('point.wav');
      print(other.score);
    }
    super.onCollisionEnd(other);
  }

}