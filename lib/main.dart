import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}

final style = TextStyle(color: BasicPalette.white.color);
final regular = TextPaint(style: style);

/// This example simply adds a rotating white square on the screen.
/// If you press on a square, it will be removed.
/// If you press anywhere else, another square will be added.
class MyGame extends FlameGame with TapDetector, DoubleTapDetector {
  bool isPlaying = false;
  int trackNumber = 1;
  int x =1;
  TextComponent intructions = TextComponent();
  String intructionsString = 'play: single tap\n'
      'stop: single tap\n'
      'next song :double tap';
  @override
  Future<void> onLoad() async {
    super.onLoad();
    intructions
      ..text = intructionsString + '\n track number: $trackNumber'
      ..textRenderer = regular
      ..y = 100;
    add(intructions);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
    
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (!isPlaying) {
      switch (trackNumber) {
        case 1:
          FlameAudio.bgm.play('track_2.mp3');
          isPlaying = true;
          break;
        case 2:
          FlameAudio.bgm.play('track_1.mp3');
          isPlaying = true;
          break;
      }
      intructions.text = intructionsString +
          '\n track number: $trackNumber\n' 'status: playing';
    } else {
      FlameAudio.bgm.stop();
      isPlaying = false;
      intructions.text =
          intructionsString + '\n track number: $trackNumber\n' 'status: stop';
    }
  }

  @override
  void onDoubleTap() {
    print('double');
    trackNumber++;
    FlameAudio.bgm.stop();
    if (trackNumber > 2) {
      trackNumber = 1;
    }
    if (isPlaying) {
      switch (trackNumber) {
        case 1:
          FlameAudio.bgm.play('track_2.mp3');
          isPlaying = true;
          break;
        case 2:
          FlameAudio.bgm.play('track_1.mp3');
          isPlaying = true;
          break;
      }
      intructions.text = intructionsString +
          '\n track number: $trackNumber\n' 'status: playing';
    } else {
      intructions.text =
          intructionsString + '\n track number: $trackNumber\n' 'status: stop';
    }
  }
}
