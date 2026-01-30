import 'package:just_audio/just_audio.dart';

/// Wrapper around just_audio player.
/// Provides streams for position, duration, and player state.
class AppAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  // === Streams ===

  /// Current playback position
  Stream<Duration> get positionStream => _player.positionStream;

  /// Buffered position
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;

  /// Total duration of current track
  Stream<Duration?> get durationStream => _player.durationStream;

  /// Player state (playing, paused, etc.)
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  // === Current values ===

  Duration get position => _player.position;
  Duration? get duration => _player.duration;
  bool get playing => _player.playing;

  // === Playback control ===

  /// Load and prepare audio source
  Future<void> setSource(String url) async {
    await _player.setUrl(url);
  }

  /// Start or resume playback
  Future<void> play() async {
    await _player.play();
  }

  /// Pause playback
  Future<void> pause() async {
    await _player.pause();
  }

  /// Stop playback and reset position
  Future<void> stop() async {
    await _player.stop();
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  /// Dispose player resources
  Future<void> dispose() async {
    await _player.dispose();
  }
}
