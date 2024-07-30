import 'package:flutter/material.dart';
import 'package:game_flappy_bird/main.dart';

class StartGame extends StatelessWidget {
  MyGame game;
  StartGame({ super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          game.overlays.remove('Startgame');
          game.resumeEngine();
        },
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover
            )
          ),
          child: Image.asset('assets/images/message.png'),
        ),
      ),
    );
  }
}
