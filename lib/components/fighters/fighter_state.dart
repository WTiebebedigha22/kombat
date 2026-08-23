import 'package:vector_math/vector_math.dart';

import 'fighter_components.dart';

enum FighterState {
  idle,
  walking,
  punching,
  kicking,
  blocking,
  hit,
  knockedDown,
  jumping,
}

enum FighterSide { left, right }

class Hitbox {
  Vector3 position;
  Vector3 size;
  double damage;
  double activeDuration;
  double elapsedTime = 0;
  bool isActive = true;
  final FighterComponent owner;
  
  Hitbox({
    required this.position,
    required this.size,
    required this.damage,
    required this.activeDuration,
    required this.owner,
  });
  
  bool intersects(Hitbox other) {
    // AABB collision detection
    return position.x < other.position.x + other.size.x &&
           position.x + size.x > other.position.x &&
           position.y < other.position.y + other.size.y &&
           position.y + size.y > other.position.y &&
           position.z < other.position.z + other.size.z &&
           position.z + size.z > other.position.z;
  }
  
  void deactivate() {
    isActive = false;
  }
  
  void update(double dt) {
    elapsedTime += dt;
    if (elapsedTime >= activeDuration) {
      isActive = false;
    }
  }
}