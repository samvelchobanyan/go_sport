// domain/state/player_state_selectors.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/track.dart';
import 'player_state.dart';

/// Playback progress (0.0 - 1.0)
/// Updates ~5 times/sec — only progress bar should watch this
final playerProgressProvider = Provider<double>((ref) {
  return ref.watch(playerStateProvider.select((s) => s.progress));
});

/// SeekBar data: position, buffered, duration + seek permission
/// Updates ~5 times/sec — only SeekBar should watch this
final playerSeekBarProvider = Provider<({
  Duration position,
  Duration bufferedPosition,
  Duration duration,
  bool canSeek,
})>((ref) {
  return ref.watch(playerStateProvider.select((s) => (
    position: s.position,
    bufferedPosition: s.bufferedPosition,
    duration: s.effectiveDuration,
    canSeek: s.effectiveDuration > Duration.zero &&
             s.status != PlayerStatus.loading,
  )));
});

/// All player info except position-related fields
/// Updates only on: track change, play/pause, mode switch, radio metadata
final playerInfoProvider = Provider<({
  Track? track,
  bool isPlaying,
  bool isRadioMode,
  PlayerStatus status,
  String? displayImageUrl,
  String? radioTitle,
  String? radioImageUrl,
  String? radioNowPlaying,
  bool shuffleEnabled,
  RepeatMode repeatMode,
  bool canGoNext,
  bool canGoPrev,
})>((ref) {
  return ref.watch(playerStateProvider.select((s) => (
    track: s.currentTrack,
    isPlaying: s.isPlaying,
    isRadioMode: s.isRadioMode,
    status: s.status,
    displayImageUrl: s.displayImageUrl,
    radioTitle: s.radioTitle,
    radioImageUrl: s.radioImageUrl,
    radioNowPlaying: s.radioNowPlaying,
    shuffleEnabled: s.shuffleEnabled,
    repeatMode: s.repeatMode,
    canGoNext: s.canGoNext,
    canGoPrev: s.canGoPrev,
  )));
});