import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class GameOverScreen extends StatelessWidget {
  static const String id = 'gameOver';
  const GameOverScreen({
    super.key,
    required this.game,
  });
  final FlappyBirdGame game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Material(
        color: Colors.transparent.withOpacity(0.6),
        child: Center(
          child: SizedBox(
            width: game.size.x / 1.5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(GameAssets.gameOver),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Score: ',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Game',
                      ),
                    ),
                    Text(
                      '${game.bird.score}',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Game',
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best Score: ',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Game',
                      ),
                    ),
                    Text(
                      '${game.bestScore}',
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Game',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: onRestart,
                  child: Image.asset(GameAssets.playButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onRestart() {
    game.bird.reset();
    game.overlays.remove('gameOver');
    game.resumeEngine();
  }
}
