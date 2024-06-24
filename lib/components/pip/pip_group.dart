import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/components/pip/pip.dart';
import 'package:flappy_bird/components/pip/pip_position.dart';
import 'package:flappy_bird/core/config.dart';
import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class PipGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  PipGroup();
  final _random = Random();
  @override
  Future<void> onLoad() async {
    position.x = gameRef.size.x;

    final heightMinusGround = gameRef.size.y - GameConfig.gameGround;
    final spacing = 200 + _random.nextDouble() * (heightMinusGround / 4);
    final centerY =
        spacing + _random.nextDouble() * (heightMinusGround - spacing);
    addAll(
      [
        Pip(
          height: centerY - spacing / 2,
          pipPosition: PipPosition.top,
        ),
        Pip(
          height: heightMinusGround - (centerY + spacing / 2),
          pipPosition: PipPosition.bottom,
        ),
      ],
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.x = position.x - (GameConfig.gameSpeed * dt);
    if (position.x < -10) {
      removeFromParent();
      updateScore();
    }
    if (game.isHitPip) {
      removeFromParent();
      game.isHitPip = false;
    }
  }

  void updateScore() async {
    gameRef.bird.score += 1;
    await FlameAudio.play(GameAssets.point);
  }
}
