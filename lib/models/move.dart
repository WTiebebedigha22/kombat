import '../components/fighters/fighter_state.dart';

class Move {
  final String name;
  final FighterState state;
  final double damage;
  final double startupFrames;
  final double activeFrames;
  final double recoveryFrames;
  final double range;
  final bool isSpecial;
  
  Move({
    required this.name,
    required this.state,
    required this.damage,
    required this.startupFrames,
    required this.activeFrames,
    required this.recoveryFrames,
    required this.range,
    this.isSpecial = false,
  });
}