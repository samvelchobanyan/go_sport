// domain/state/player_state_selectors.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../entities/track.dart';
import 'player_state.dart';

/// Playback progress (0.0 - 1.0)
/// Updates ~5 times/sec — only progress bar should watch this
final playerProgressProvider = Provider<double>((ref) {
  return ref.watch(playerStateProvider.select((s) => s.progress));
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
  )));
});