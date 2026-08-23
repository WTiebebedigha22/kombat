import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class CombatText extends PositionComponent {
  final String message;
  final double duration;
  double elapsed = 0;
  bool visible = true;
  
  CombatText({
    required this.message,
    this.duration = 2.0,
    super.position,
  }) : super(
    size: Vector2(400, 100),
    anchor: Anchor.center,
  );
  
  @override
  void render(Canvas canvas) {
    if (!visible) return;
    
    final textStyle = TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: Colors.red,
      shadows: [
        const Shadow(
          color: Colors.black,
          offset: Offset(3, 3),
          blurRadius: 6,
        ),
      ],
    );
    
    final textSpan = TextSpan(text: message, style: textStyle);
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
  }
  
  @override
  void update(double dt) {
    elapsed += dt;
    if (elapsed >= duration) {
      visible = false;
    }
  }
}