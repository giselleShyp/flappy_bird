import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  static const String id = 'mainMenu';
  const MainMenuScreen({
    super.key,
    required this.game,
  });
  final FlappyBirdGame game;
  @override
  Widget build(BuildContext context) {
    game.pauseEngine();
    return GestureDetector(
      onTap: () {
        game.overlays.remove('mainMenu');
        game.resumeEngine();
      },
      child: Material(
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  GameAssets.message,
                ),
              ],
            ),
          )),
    );
  }
}
