import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flappy_bird/core/config.dart';
import 'package:flappy_bird/core/game_assets.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flutter/material.dart';

class Bird extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  int score = 0;

  @override
  Future<void> onLoad() async {
    debugPrint('size 1 : ${size}');
    size = Vector2(50, 40);
    debugPrint('size 2 : ${size}');
    final birdMidFlap = await Flame.images.load(GameAssets.birdMidFlap);
    // final birdDownFlap = await gameRef.loadSprite(GameAssets.birdDownFlap);
    // final birdUpFlap = await gameRef.loadSprite(GameAssets.birdUpFlap);
    //  current = BirdMovement.middle;

    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    sprite = Sprite(birdMidFlap);

    // sprites = {
    //   BirdMovement.middle: birdMidFlap,
    //   BirdMovement.down: birdDownFlap,
    //   BirdMovement.up: birdUpFlap,
    // };
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += GameConfig.birdVelocity * dt;

    // Prevent the bird from going off the top of the screen
    if (position.y < 0) {
      position.y = 0;
    }
  }

  void fly() {
    add(
      MoveByEffect(
        Vector2(0, GameConfig.gravity),
        EffectController(duration: 0.2, curve: Curves.decelerate),
        //  onComplete: () => current = BirdMovement.down,
      ),
    );
    //  current = BirdMovement.up;
    FlameAudio.play(GameAssets.flying);
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    FlameAudio.play(GameAssets.collision);
    gameOver();
  }

  void gameOver() {
    gameRef.pauseEngine();
    game.isHitPip = true;
    gameRef.overlays.add('gameOver');
    if (score > game.bestScore) {
      debugPrint('score > game.bestScore');
      game.bestScore = score;
      game.setBestScore(game.bestScore);
    }
  }

  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);
    score = 0;
    GameConfig.gameSpeed = 200.0;
    game.speedIncreasedAt25 = false;
    game.speedIncreasedAt50 = false;
  }
}
