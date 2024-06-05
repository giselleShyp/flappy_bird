import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';
import 'package:flappy_bird/core/game_assets.dart';

class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    final background = await Flame.images.load(GameAssets.background);
    size = gameRef.size;
    sprite = Sprite(background);
  }
}
