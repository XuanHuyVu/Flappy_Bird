import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_flappy_bird/components/background.dart';
import 'package:game_flappy_bird/components/ground.dart';
import 'package:game_flappy_bird/components/player.dart';
import 'package:game_flappy_bird/components/ground_pipe.dart';
import 'package:game_flappy_bird/overlays/game_over.dart';
import 'package:game_flappy_bird/overlays/start_game.dart';

void main() {
  runApp( GameWidget(
    game: MyGame(),
    overlayBuilderMap: {
      'Startgame': (ctx, MyGame game) {
        return StartGame(game: game);
      },
      'overgame': (ctx, MyGame game) {
        return GameOver(game: game);
      }
    },
    initialActiveOverlays: const ['Startgame'],
  ));
}

class MyGame extends FlameGame with HasCollisionDetection, TapDetector {
  late Player player;
  late TextComponent scoreText;
  double elapseTimePipe = 0.0;
  @override
  FutureOr<void> onLoad() {
    add(Background());
    add(Ground());
    add(player = Player());
    add(scoreText = addScore());
    return super.onLoad();
  }

  TextComponent addScore() {
    return TextComponent(
        text: 'Score: 0',
        position: Vector2(size.x*0.5, 80),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white
            )
        )
    );
  }

  @override
  void update(double dt) {
    if(elapseTimePipe > 2.0) {
      add(GroundPipe());
      elapseTimePipe = 0.0;
    } else {
      elapseTimePipe += dt;
      scoreText.text = 'Score: ${player.score}';
    }

    super.update(dt);
  }

  void removePipe() {
    for(var node in children) {
      if(node is GroundPipe) {
        node.removeFromParent();
      }
    }
  }

  @override
  void onTap() {
    player.addFly();
    super.onTap();
  }
}