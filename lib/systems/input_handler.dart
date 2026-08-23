import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/fighters/fighter_components.dart';
import '../components/fighters/fighter_state.dart';

class InputHandler {
  final FighterComponent player1;
  final FighterComponent player2;
  
  // Player 1 keys
  static const p1Up = LogicalKeyboardKey.keyW;
  static const p1Down = LogicalKeyboardKey.keyS;
  static const p1Left = LogicalKeyboardKey.keyA;
  static const p1Right = LogicalKeyboardKey.keyD;
  static const p1Punch = LogicalKeyboardKey.keyJ;
  static const p1Kick = LogicalKeyboardKey.keyK;
  static const p1Block = LogicalKeyboardKey.keyL;
  
  // Player 2 keys
  static const p2Up = LogicalKeyboardKey.arrowUp;
  static const p2Down = LogicalKeyboardKey.arrowDown;
  static const p2Left = LogicalKeyboardKey.arrowLeft;
  static const p2Right = LogicalKeyboardKey.arrowRight;
  static const p2Punch = LogicalKeyboardKey.numpad1;
  static const p2Kick = LogicalKeyboardKey.numpad2;
  static const p2Block = LogicalKeyboardKey.numpad3;
  
  final Set<LogicalKeyboardKey> pressedKeys = {};
  
  InputHandler({
    required this.player1,
    required this.player2,
  });
  
  void update(double dt) {
    handlePlayer1Input();
    handlePlayer2Input();
  }
  
  void handlePlayer1Input() {
    if (pressedKeys.contains(p1Punch)) {
      player1.performPunch();
    } else if (pressedKeys.contains(p1Kick)) {
      player1.performKick();
    } else if (pressedKeys.contains(p1Block)) {
      player1.block();
    } else {
      player1.unblock();
    }
    
    // Movement
    if (pressedKeys.contains(p1Up)) {
      player1.jump();
    } else if (pressedKeys.contains(p1Right)) {
      player1.moveForward();
    } else if (pressedKeys.contains(p1Left)) {
      player1.moveBackward();
    }
    
    // If no movement keys pressed, go idle
    if (!pressedKeys.any((k) => 
        k == p1Up || k == p1Down || k == p1Left || k == p1Right)) {
      if (player1.state == FighterState.walking) {
        player1.state = FighterState.idle;
      }
    }
  }
  
  void handlePlayer2Input() {
    if (pressedKeys.contains(p2Punch)) {
      player2.performPunch();
    } else if (pressedKeys.contains(p2Kick)) {
      player2.performKick();
    } else if (pressedKeys.contains(p2Block)) {
      player2.block();
    } else {
      player2.unblock();
    }
    
    if (pressedKeys.contains(p2Up)) {
      player2.jump();
    } else if (pressedKeys.contains(p2Right)) {
      player2.moveForward();
    } else if (pressedKeys.contains(p2Left)) {
      player2.moveBackward();
    }
    
    if (!pressedKeys.any((k) => 
        k == p2Up || k == p2Down || k == p2Left || k == p2Right)) {
      if (player2.state == FighterState.walking) {
        player2.state = FighterState.idle;
      }
    }
  }
  
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    pressedKeys.clear();
    pressedKeys.addAll(keysPressed);
    return KeyEventResult.handled;
  }
}