import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/components/pip/pip_position.dart';
import 'package:flappy_bird/core/config.dart';
import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class Pip extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  Pip({
    required this.height,
    required this.pipPosition,
  });
  @override
  final double height;
  final PipPosition pipPosition;

  @override
  Future<void> onLoad() async {
    final pip = await Flame.images.load(GameAssets.pip);
    final pipRotated = await Flame.images.load(GameAssets.pipRotated);
    size = Vector2(50, height);
    switch (pipPosition) {
      case PipPosition.bottom:
        position.y = gameRef.size.y - size.y - GameConfig.gameGround;
        sprite = Sprite(pip);
        break;
      case PipPosition.top:
        position.y = 0;
        sprite = Sprite(pipRotated);
        break;
    }
    add(RectangleHitbox());
  }
}
