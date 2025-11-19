import 'package:audioplayers/audioplayers.dart';

/// Service to handle karaoke and audio playback
class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  /// Play an audio file from assets
  Future<void> playAudio(String assetPath) async {
    try {
      await _audioPlayer.stop();
      await _audioPlayer.play(AssetSource(assetPath));
      _isPlaying = true;
      print('🎵 Playing audio: $assetPath');
    } catch (e) {
      print('❌ Error playing audio: $e');
    }
  }

  /// Stop current audio playback
  Future<void> stopAudio() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
      print('⏹️ Audio stopped');
    } catch (e) {
      print('❌ Error stopping audio: $e');
    }
  }

  /// Pause audio playback
  Future<void> pauseAudio() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
      print('⏸️ Audio paused');
    } catch (e) {
      print('❌ Error pausing audio: $e');
    }
  }

  /// Resume audio playback
  Future<void> resumeAudio() async {
    try {
      await _audioPlayer.resume();
      _isPlaying = true;
      print('▶️ Audio resumed');
    } catch (e) {
      print('❌ Error resuming audio: $e');
    }
  }

  /// Set volume (0.0 to 1.0)
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
    } catch (e) {
      print('❌ Error setting volume: $e');
    }
  }

  /// Check if audio is currently playing
  bool get isPlaying => _isPlaying;

  /// Get current playback position
  Future<Duration?> getCurrentPosition() async {
    try {
      return await _audioPlayer.getCurrentPosition();
    } catch (e) {
      print('❌ Error getting position: $e');
      return null;
    }
  }

  /// Get audio duration
  Future<Duration?> getDuration() async {
    try {
      return await _audioPlayer.getDuration();
    } catch (e) {
      print('❌ Error getting duration: $e');
      return null;
    }
  }

  /// Listen to player state changes
  Stream<PlayerState> get onPlayerStateChanged =>
      _audioPlayer.onPlayerStateChanged;

  /// Listen to position updates
  Stream<Duration> get onPositionChanged => _audioPlayer.onPositionChanged;

  /// Dispose audio player
  void dispose() {
    _audioPlayer.dispose();
  }
}

/// Sample karaoke songs for testing
class KaraokeSongs {
  static const List<Map<String, String>> sampleSongs = [
    {
      'id': 'karaoke_001',
      'title': 'Happy Birthday',
      'audioPath': 'audio/happy_birthday.mp3', // Placeholder
    },
    {
      'id': 'karaoke_002',
      'title': 'Twinkle Twinkle',
      'audioPath': 'audio/twinkle.mp3', // Placeholder
    },
    {
      'id': 'karaoke_003',
      'title': 'Row Row Your Boat',
      'audioPath': 'audio/row_boat.mp3', // Placeholder
    },
  ];
}
