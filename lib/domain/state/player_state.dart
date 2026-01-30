import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart' as ja;

import '../entities/track.dart';
import '../../core/audio/app_audio_handler.dart';
import '../../core/di/audio_providers.dart';

part 'player_state.freezed.dart';

// === Enums ===

enum PlayerStatus {
  idle,
  loading,
  playing,
  paused,
  completed,
  error,
}

// === Queue Source ===

@freezed
sealed class QueueSource with _$QueueSource {
  const factory QueueSource.album({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourceAlbum;

  const factory QueueSource.playlist({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourcePlaylist;

  const factory QueueSource.program({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourceProgram;
}

// === State ===

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    // Queue
    @Default([]) List<Track> tracks,
    @Default(0) int currentIndex,
    QueueSource? source,

    // Playback
    @Default(PlayerStatus.idle) PlayerStatus status,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,

    // Error
    String? errorMessage,
  }) = _PlayerState;
}

// === Computed properties ===

extension PlayerStateX on PlayerState {
  /// Current track or null if queue is empty
  Track? get currentTrack => tracks.isNotEmpty && currentIndex < tracks.length
      ? tracks[currentIndex]
      : null;

  /// Has next track in queue
  bool get hasNext => currentIndex < tracks.length - 1;

  /// Has previous track in queue
  bool get hasPrevious => currentIndex > 0;

  /// Progress 0.0 - 1.0
  double get progress {
    final duration = currentTrack?.duration;
    if (duration == null || duration == Duration.zero) return 0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  /// Is currently playing
  bool get isPlaying => status == PlayerStatus.playing;

  /// Has active track to show in MiniPlayer
  bool get hasActiveTrack =>
      currentTrack != null && status != PlayerStatus.idle;

  /// Image URL for display (track image or source image as fallback)
  String? get displayImageUrl {
    final trackImage = currentTrack?.imageUrl;
    if (trackImage != null && trackImage.isNotEmpty) {
      return trackImage;
    }
    // Fallback to source image
    return source?.when(
      album: (_, __, imageUrl) => imageUrl,
      playlist: (_, __, imageUrl) => imageUrl,
      program: (_, __, imageUrl) => imageUrl,
    );
  }
}

// === Notifier ===

class PlayerNotifier extends Notifier<PlayerState> {
  late final AppAudioHandler _audioHandler;
  final List<StreamSubscription> _subscriptions = [];

  @override
  PlayerState build() {
    _audioHandler = ref.watch(audioHandlerProvider);
    _listenToAudioHandler();

    ref.onDispose(() {
      for (final sub in _subscriptions) {
        sub.cancel();
      }
    });

    return const PlayerState();
  }

  void _listenToAudioHandler() {
    // Position updates
    _subscriptions.add(
      _audioHandler.positionStream.listen((position) {
        state = state.copyWith(position: position);
      }),
    );

    // Buffered position updates
    _subscriptions.add(
      _audioHandler.bufferedPositionStream.listen((buffered) {
        state = state.copyWith(bufferedPosition: buffered);
      }),
    );

    // Player state updates
    _subscriptions.add(
      _audioHandler.playerStateStream.listen((playerState) {
        _onPlayerStateChanged(playerState);
      }),
    );
  }

  void _onPlayerStateChanged(ja.PlayerState playerState) {
    final processingState = playerState.processingState;
    final playing = playerState.playing;

    PlayerStatus newStatus;

    switch (processingState) {
      case ja.ProcessingState.idle:
        newStatus = PlayerStatus.idle;
        break;
      case ja.ProcessingState.loading:
      case ja.ProcessingState.buffering:
        newStatus = PlayerStatus.loading;
        break;
      case ja.ProcessingState.ready:
        newStatus = playing ? PlayerStatus.playing : PlayerStatus.paused;
        break;
      case ja.ProcessingState.completed:
        _onTrackCompleted();
        return;
    }

    state = state.copyWith(status: newStatus);
  }

  void _onTrackCompleted() {
    if (hasNext) {
      next();
    } else {
      state = state.copyWith(
        status: PlayerStatus.completed,
        position: Duration.zero,
      );
    }
  }

  bool get hasNext => state.hasNext;

  // === Public methods ===

  /// Load queue and start playing from index
  Future<void> playQueue(
    List<Track> tracks, {
    required QueueSource source,
    int startIndex = 0,
  }) async {
    if (tracks.isEmpty) return;

    state = state.copyWith(
      tracks: tracks,
      source: source,
      currentIndex: startIndex,
      status: PlayerStatus.loading,
      position: Duration.zero,
      errorMessage: null,
    );

    try {
      await _audioHandler.setSource(tracks[startIndex].audioUrl);
      await _audioHandler.play();
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Resume playback
  Future<void> play() async {
    if (state.currentTrack == null) return;
    await _audioHandler.play();
  }

  /// Pause playback
  Future<void> pause() async {
    await _audioHandler.pause();
  }

  /// Toggle play/pause
  Future<void> togglePlayPause() async {
    if (state.isPlaying) {
      await pause();
    } else {
      await play();
    }
  }

  /// Stop playback and clear queue
  Future<void> stop() async {
    await _audioHandler.stop();
    state = const PlayerState();
  }

  /// Seek to position
  Future<void> seek(Duration position) async {
    await _audioHandler.seek(position);
  }

  /// Play next track
  Future<void> next() async {
    if (!state.hasNext) return;

    final newIndex = state.currentIndex + 1;
    state = state.copyWith(
      currentIndex: newIndex,
      status: PlayerStatus.loading,
      position: Duration.zero,
    );

    try {
      await _audioHandler.setSource(state.tracks[newIndex].audioUrl);
      await _audioHandler.play();
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Play previous track (or restart current if position > 3 sec)
  Future<void> previous() async {
    // If more than 3 seconds played, restart current track
    if (state.position.inSeconds > 3) {
      await seek(Duration.zero);
      return;
    }

    if (!state.hasPrevious) {
      await seek(Duration.zero);
      return;
    }

    final newIndex = state.currentIndex - 1;
    state = state.copyWith(
      currentIndex: newIndex,
      status: PlayerStatus.loading,
      position: Duration.zero,
    );

    try {
      await _audioHandler.setSource(state.tracks[newIndex].audioUrl);
      await _audioHandler.play();
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Skip to specific track index
  Future<void> skipTo(int index) async {
    if (index < 0 || index >= state.tracks.length) return;

    state = state.copyWith(
      currentIndex: index,
      status: PlayerStatus.loading,
      position: Duration.zero,
    );

    try {
      await _audioHandler.setSource(state.tracks[index].audioUrl);
      await _audioHandler.play();
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}

// === Provider ===

final playerStateProvider = NotifierProvider<PlayerNotifier, PlayerState>(
  PlayerNotifier.new,
);
