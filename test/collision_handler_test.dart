import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math.dart';

import 'package:kombat/components/fighters/fighter_components.dart';
import 'package:kombat/components/fighters/fighter_state.dart';
import 'package:kombat/systems/collision_handler.dart';

void main() {
  test('detects overlapping active hitboxes', () {
    final fighter = FighterComponent(side: FighterSide.left);
    final first = Hitbox(
      position: Vector3.zero(),
      size: Vector3.all(1),
      damage: 10,
      activeDuration: 1,
      owner: fighter,
    );
    final second = Hitbox(
      position: Vector3(0.5, 0.5, 0.5),
      size: Vector3.all(1),
      damage: 0,
      activeDuration: 1,
      owner: fighter,
    );

    expect(CollisionHandler.checkHitboxCollision(first, second), isTrue);
  });
}