import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/components/background.dart';
import 'package:flappy_bird/components/bird/bird.dart';
import 'package:flappy_bird/components/ground.dart';
import 'package:flappy_bird/components/pip/pip_group.dart';
import 'package:flappy_bird/core/config.dart';
import 'package:flame/src/timer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  FlappyBirdGame() {
    pauseWhenBackgrounded = true;
  }
  late Timer interval;
  Bird bird = Bird();
  bool isHitPip = false;
  late TextComponent score;
  int bestScore = 0;
  bool speedIncreasedAt25 = false;
  bool speedIncreasedAt50 = false;

  @override
  Future<void> onLoad() async {
    bestScore = await getBestScore();
    interval = Timer(
      GameConfig.pipeInterval,
      repeat: true,
      onTick: () => add(
        PipGroup(),
      ),
    );
    interval.start();
    await addAll(
      [
        Background(),
        bird = Bird(),
        // PipGroup(),
        score = buildScoreText(),
      ],
    );
    await add(Ground());
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
    score.text = 'Score : ${bird.score}';
    // Update game speed based on the current score
    updateGameSpeed(bird.score);
    updatePipeInterval(bird.score);
  }

  @override
  void onTap() {
    super.onTap();
    bird.fly();
  }

  Future<int> getBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('best_score') ?? 0;
  }

  Future<void> setBestScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('best_score', score);
  }

  TextComponent buildScoreText() {
    return TextComponent(
      text: 'Score : 0',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'Game',
          color: Colors.white,
        ),
      ),
      position: Vector2(10, 10),
    );
  }

  TextComponent buildBestScoreText() {
    return TextComponent(
      text: 'Best Score : $bestScore',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontFamily: 'Game',
          color: Colors.white,
        ),
      ),
      position: Vector2(size.x - 250, 10),
    );
  }

  void updateGameSpeed(int score) {
    GameConfig.gameSpeed = 200 + (score ~/ 5) * 15;
    debugPrint('GameConfig.gameSpeed : ${GameConfig.gameSpeed}');
  }

  void updatePipeInterval(int score) {
    double newInterval;
    if (score < 5) {
      newInterval = 2.0;
    } else if (score >= 5 && score < 15) {
      newInterval = 1.5;
    } else {
      newInterval = 1.0;
    }

    if (GameConfig.pipeInterval != newInterval) {
      GameConfig.pipeInterval = newInterval;
      restartInterval();
    }
  }

  void restartInterval() {
    interval.stop();
    interval = Timer(
      GameConfig.pipeInterval,
      repeat: true,
      onTick: () => add(
        PipGroup(),
      ),
    );
    interval.start();
  }
}
