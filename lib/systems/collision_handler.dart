import '../components/fighters/fighter_components.dart';
import '../components/fighters/fighter_state.dart';

class CollisionHandler {
  static bool checkHitboxCollision(Hitbox hitbox1, Hitbox hitbox2) {
    if (!hitbox1.isActive || !hitbox2.isActive) return false;
    
    // AABB collision check
    return hitbox1.position.x < hitbox2.position.x + hitbox2.size.x &&
           hitbox1.position.x + hitbox1.size.x > hitbox2.position.x &&
           hitbox1.position.y < hitbox2.position.y + hitbox2.size.y &&
           hitbox1.position.y + hitbox1.size.y > hitbox2.position.y &&
           hitbox1.position.z < hitbox2.position.z + hitbox2.size.z &&
           hitbox1.position.z + hitbox1.size.z > hitbox2.position.z;
  }
  
  static bool areFightersClose(FighterComponent a, FighterComponent b, double distance) {
    return (a.position - b.position).length < distance;
  }
}