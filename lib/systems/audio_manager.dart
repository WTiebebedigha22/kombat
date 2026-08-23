import 'package:audioplayers/audioplayers.dart';

class AudioManager {
  static final AudioPlayer _player = AudioPlayer();
  
  static Future<void> playHitSound() async {
    await _player.play(AssetSource('audio/sfx/punch.mp3'));
  }
  
  static Future<void> playKickSound() async {
    await _player.play(AssetSource('audio/sfx/kick.mp3'));
  }
  
  static Future<void> playFatalitySound() async {
    await _player.play(AssetSource('audio/sfx/fatality.mp3'));
  }
  
  static Future<void> playBackgroundMusic() async {
    await _player.play(AssetSource('audio/music/theme.mp3'), 
      mode: PlayerMode.lowLatency,
    );
  }
  
  static void dispose() {
    _player.dispose();
  }
}