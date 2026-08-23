import 'package:flame_3d/components.dart';
import 'package:vector_math/vector_math.dart';
import 'fighter_state.dart';

class FighterComponent extends Component3D {
  final FighterSide side;
  FighterState state = FighterState.idle;
  double health = 100;
  double maxHealth = 100;
  
  // Combat properties
  double punchDamage = 10;
  double kickDamage = 15;
  double speed = 2.5;
  bool isBlocking = false;
  bool facingRight = true;
  
  // Hitboxes
  List<Hitbox> hitboxes = [];
  Hitbox? bodyHitbox;
  
  FighterComponent({required this.side}) {
    // Set initial facing direction
    facingRight = side == FighterSide.right;
  }
  
  @override
  Future<void> onLoad() async {
    // To be overridden by subclasses
    // Create body hitbox
    bodyHitbox = Hitbox(
      position: position,
      size: Vector3(1.0, 2.0, 0.8),
      damage: 0,
      activeDuration: 0,
      owner: this,
    );
  }
  
  void moveForward() {
    if (state == FighterState.hit || state == FighterState.knockedDown) return;
    state = FighterState.walking;
    position.x += facingRight ? speed * 0.016 : -speed * 0.016;
    // Clamp to arena bounds
    position.x = position.x.clamp(-8, 8);
  }
  
  void moveBackward() {
    if (state == FighterState.hit || state == FighterState.knockedDown) return;
    state = FighterState.walking;
    position.x -= facingRight ? speed * 0.016 : -speed * 0.016;
    position.x = position.x.clamp(-8, 8);
  }
  
  void jump() {
    if (state == FighterState.hit || state == FighterState.knockedDown) return;
    state = FighterState.jumping;
    position.y = 2.0;
    Future.delayed(Duration(milliseconds: 500), () {
      position.y = 0;
      if (state == FighterState.jumping) {
        state = FighterState.idle;
      }
    });
  }
  
  void performPunch() {
    if (state == FighterState.hit ||
        state == FighterState.knockedDown ||
        state == FighterState.punching) {
      return;
    }
        
    state = FighterState.punching;
    
    // Create punch hitbox
    Vector3 offset = facingRight 
        ? Vector3(1.2, 0.8, 0) 
        : Vector3(-1.2, 0.8, 0);
    
    Hitbox punchBox = Hitbox(
      position: position + offset,
      size: Vector3(0.8, 0.5, 0.6),
      damage: punchDamage,
      activeDuration: 0.3,
      owner: this,
    );
    hitboxes.add(punchBox);
    
    // Reset after animation
    Future.delayed(Duration(milliseconds: 300), () {
      if (state == FighterState.punching) {
        state = FighterState.idle;
      }
    });
  }
  
  void performKick() {
    if (state == FighterState.hit ||
        state == FighterState.knockedDown ||
        state == FighterState.kicking) {
      return;
    }
        
    state = FighterState.kicking;
    
    Vector3 offset = facingRight 
        ? Vector3(1.4, 0.3, 0) 
        : Vector3(-1.4, 0.3, 0);
    
    Hitbox kickBox = Hitbox(
      position: position + offset,
      size: Vector3(0.7, 0.6, 0.7),
      damage: kickDamage,
      activeDuration: 0.4,
      owner: this,
    );
    hitboxes.add(kickBox);
    
    Future.delayed(Duration(milliseconds: 400), () {
      if (state == FighterState.kicking) {
        state = FighterState.idle;
      }
    });
  }
  
  void block() {
    if (state == FighterState.hit || state == FighterState.knockedDown) return;
    isBlocking = true;
    state = FighterState.blocking;
  }
  
  void unblock() {
    isBlocking = false;
    if (state == FighterState.blocking) {
      state = FighterState.idle;
    }
  }
  
  void takeDamage(double damage) {
    double actualDamage = isBlocking ? damage * 0.2 : damage;
    health -= actualDamage;
    
    if (health < 0) health = 0;
    
    if (!isBlocking) {
      state = FighterState.hit;
      // Knockback
      position.x += facingRight ? -0.3 : 0.3;
      
      Future.delayed(Duration(milliseconds: 200), () {
        if (state == FighterState.hit) {
          state = FighterState.idle;
        }
      });
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update hitboxes
    for (var hitbox in hitboxes) {
      hitbox.update(dt);
    }
    hitboxes.removeWhere((h) => !h.isActive);
    
    // Update body hitbox position
    if (bodyHitbox != null) {
      bodyHitbox!.position = position;
    }
  }
}