import 'move.dart';

class CharacterData {
  final String name;
  final double health;
  final double speed;
  final double punchDamage;
  final double kickDamage;
  final List<Move> specialMoves;
  final String modelPath;
  final String portraitPath;
  
  CharacterData({
    required this.name,
    this.health = 100,
    this.speed = 2.5,
    this.punchDamage = 10,
    this.kickDamage = 15,
    this.specialMoves = const [],
    required this.modelPath,
    required this.portraitPath,
  });
}