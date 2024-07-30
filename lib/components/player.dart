import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/foundation.dart';
import 'package:game_flappy_bird/components/ground.dart';
import 'package:game_flappy_bird/components/pipe.dart';
import 'package:game_flappy_bird/main.dart';
import 'package:game_flappy_bird/utility/config.dart';

class Player extends SpriteAnimationComponent with HasGameRef<MyGame>, CollisionCallbacks{
  Player():super() {
    debugMode = false;
  }
  var velocityBird = 0.0;
  int score = 0;
  @override
  FutureOr<void> onLoad() async {
    List<Sprite> spriteList = [
      await Sprite.load('bluebird-downflap.png'),
      await Sprite.load('bluebird-midflap.png'),
      await Sprite.load('bluebird-upflap.png'),
    ];

    final ani = SpriteAnimation.spriteList(spriteList, stepTime: 0.15);
    size = Vector2(34, 26);
    position = Vector2(70, game.size.y/2);
    animation = ani;
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void update(double dt) {
    addGravity(dt);
    if(position.y < 5) {
      gameOver();
      FlameAudio.play('die.wav');
    }
    super.update(dt);
  }

  void addGravity(double dt) {
    velocityBird += Config.gravity*dt;
    final newPosition = position.y + velocityBird*dt;
    position = Vector2(position.x, newPosition);
    anchor = Anchor.center;
    final anpha = clampDouble(velocityBird/180, -pi*0.25, pi*0.25);
    angle = anpha;
  }

  void addFly() {
    FlameAudio.play('wing.wav');
    velocityBird = -110;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Ground || other is Pipe) {
      print('Va cham');
      FlameAudio.play('hit.wav');
      gameOver();
      FlameAudio.play('die.wav');
    }
    super.onCollisionStart(intersectionPoints, other);
  }

   void gameOver() {
    game.pauseEngine();
    game.overlays.add('overgame');
  }

  void restartGame() {
    score = 0;
    game.removePipe();
    position = Vector2(70, game.size.y/2);

  }
}