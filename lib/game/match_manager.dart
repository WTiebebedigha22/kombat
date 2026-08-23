import 'package:flame/components.dart';
import '../components/fighters/fighter_components.dart';

enum MatchState { ready, fighting, roundEnd, matchEnd }

class MatchManager extends Component {
  final FighterComponent fighter1;
  final FighterComponent fighter2;
  MatchState state = MatchState.ready;
  int round = 1;
  int maxRounds = 3;
  int player1Wins = 0;
  int player2Wins = 0;
  
  MatchManager({
    required this.fighter1,
    required this.fighter2,
  });
  
  @override
  void update(double dt) {
    super.update(dt);
    
    if (state == MatchState.fighting) {
      // Check for KO
      if (fighter1.health <= 0 || fighter2.health <= 0) {
        state = MatchState.roundEnd;
        handleRoundEnd();
      }
    }
  }
  
  void startMatch() {
    state = MatchState.fighting;
    fighter1.health = 100;
    fighter2.health = 100;
    fighter1.position = Vector3(-3, 0, 0);
    fighter2.position = Vector3(3, 0, 0);
  }
  
  void handleRoundEnd() {
    // Determine winner
    if (fighter1.health <= 0) {
      player2Wins++;
    } else {
      player1Wins++;
    }
    
    // Check match end
    if (player1Wins >= (maxRounds ~/ 2) + 1 || 
        player2Wins >= (maxRounds ~/ 2) + 1) {
      state = MatchState.matchEnd;
      // Show "FATALITY!" or "K.O."
    } else {
      // Start next round
      Future.delayed(Duration(seconds: 2), () {
        startMatch();
      });
    }
  }
}