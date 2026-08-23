import 'package:flame_3d/camera.dart';
import 'package:flame_3d/components.dart';
import 'package:flame_3d/game.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter/services.dart';
import '../components/fighters/generic_fighter.dart';
import '../components/fighters/fighter_state.dart';
import '../components/arena/arena_component.dart';
import '../systems/input_handler.dart';
import 'match_manager.dart';

class KombatGame extends FlameGame3D<World3D, CameraComponent3D> {
  late GenericFighter player1;
  late GenericFighter player2;
  late ArenaComponent arena;
  late MatchManager matchManager;
  late InputHandler inputHandler;
  
  @override
  Future<void> onLoad() async {
    // Create arena
    arena = ArenaComponent();
    await add(arena);
    
    // Create two generic fighters
    player1 = GenericFighter(side: FighterSide.left);
    await add(player1);
    
    player2 = GenericFighter(side: FighterSide.right);
    await add(player2);
    
    // Match manager
    matchManager = MatchManager(
      fighter1: player1,
      fighter2: player2,
    );
    await add(matchManager);
    
    // Input handler
    inputHandler = InputHandler(
      player1: player1,
      player2: player2,
    );
    
    // Setup 3D camera
    camera.position = Vector3(0, 4, 10);
    camera.target = Vector3(0, 1, 0);
    
    // Add lighting
    add(LightComponent.point(
      position: Vector3(10, 20, 10),
      color: const Color(0xFFFFFFFF),
      intensity: 1.2,
    ));
    add(LightComponent.point(
      position: Vector3(-10, 15, -5),
      color: const Color(0xFF90CAF9),
      intensity: 0.5,
    ));
    add(LightComponent.ambient(
      color: const Color(0xFFFFFFFF),
      intensity: 0.3,
    ));
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    
    // Update input
    inputHandler.update(dt);
    
    // Update match
    matchManager.update(dt);
    
    // Check collisions
    checkCollisions();
  }
  
  void checkCollisions() {
    // Check if player1's attacks hit player2
    for (var hitbox in player1.hitboxes) {
      final bodyHitbox = player2.bodyHitbox;
      if (hitbox.isActive &&
          bodyHitbox != null &&
          bodyHitbox.intersects(hitbox)) {
        player2.takeDamage(hitbox.damage);
        hitbox.deactivate();
        // Play hit sound
        // AudioManager.playHitSound();
      }
    }
    
    // Check if player2's attacks hit player1
    for (var hitbox in player2.hitboxes) {
      final bodyHitbox = player1.bodyHitbox;
      if (hitbox.isActive &&
          bodyHitbox != null &&
          bodyHitbox.intersects(hitbox)) {
        player1.takeDamage(hitbox.damage);
        hitbox.deactivate();
        // AudioManager.playHitSound();
      }
    }
  }
  
  KeyEventResult onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    return inputHandler.onKeyEvent(event, keysPressed);
  }
}