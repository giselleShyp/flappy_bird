import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/core/config.dart';
import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

class Ground extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    final ground = await Flame.images.load(GameAssets.ground);
    parallax = Parallax(
      [
        ParallaxLayer(
          ParallaxImage(
            ground,
            fill: LayerFill.none,
          ),
        ),
      ],
    );
    add(
      RectangleHitbox(
        position: Vector2(0, gameRef.size.y - GameConfig.gameGround),
        size: Vector2(gameRef.size.x, GameConfig.gameGround),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = GameConfig.gameSpeed;
  }
}
