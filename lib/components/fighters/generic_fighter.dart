import 'dart:math' show sin;

import 'package:vector_math/vector_math.dart';
import 'fighter_components.dart';
import 'fighter_state.dart';

class GenericFighter extends FighterComponent {
  double elapsedTime = 0;

  GenericFighter({required super.side});
  
  @override
  Future<void> onLoad() async {
    // Position based on side
    position = side == FighterSide.left 
        ? Vector3(-3, 0, 0) 
        : Vector3(3, 0, 0);
    
    // Scale
    scale = Vector3(0.5, 0.5, 0.5);
    
    // Set facing direction
    if (side == FighterSide.left) {
      facingRight = true;
      rotation.setEuler(0, 0, 0);
    } else {
      facingRight = false;
      rotation.setEuler(0, 3.14159, 0); // 180 degrees
    }
    
    // Call parent onLoad
    await super.onLoad();
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    elapsedTime += dt;
    
    // Simple idle bob
    if (state == FighterState.idle) {
      position.y = 0.1 * sin(elapsedTime * 2);
    }
    
    // Update facing
    if (side == FighterSide.left) {
      facingRight = true;
      rotation.setEuler(0, 0, 0);
    } else {
      facingRight = false;
      rotation.setEuler(0, 3.14159, 0);
    }
  }
}