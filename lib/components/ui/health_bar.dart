import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../../components/fighters/fighter_components.dart';

class HealthBar extends PositionComponent {
  final FighterComponent fighter;
  final bool isPlayer1;
  
  HealthBar({
    required this.fighter,
    required this.isPlayer1,
    super.position,
  }) : super(
    size: Vector2(300, 30),
    anchor: Anchor.topLeft,
  );
  
  @override
  void render(Canvas canvas) {
    // Background
    final bgPaint = Paint()..color = Colors.black54;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      bgPaint,
    );
    
    // Health bar
    final healthPercent = fighter.health / fighter.maxHealth;
    final healthColor = healthPercent > 0.5 
        ? Colors.green 
        : healthPercent > 0.25 
            ? Colors.orange 
            : Colors.red;
    
    final healthPaint = Paint()..color = healthColor;
    canvas.drawRect(
      Rect.fromLTWH(2, 2, (size.x - 4) * healthPercent, size.y - 4),
      healthPaint,
    );
    
    // Border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.x, size.y),
      borderPaint,
    );
    
    // Fighter name
    // ... add text rendering
  }
}