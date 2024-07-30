import 'package:flutter/material.dart';
import 'package:game_flappy_bird/main.dart';

class GameOver extends StatelessWidget {
  MyGame game;
  GameOver({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/gameover.png'),
          const SizedBox(height: 25,),
          ElevatedButton(
            onPressed: () {
              game.overlays.remove('overgame');
              game.player.restartGame();
              game.resumeEngine();
            },
            child: const Text(
              'Restart',
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber,
                fontWeight: FontWeight.bold
              ),
            )
          ),
        ],
      ),
    );
  }
}