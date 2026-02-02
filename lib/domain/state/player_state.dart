import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    @Default(Duration.zero) Duration totalDuration,

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
    // Prefer actual player duration over track metadata
    final durationMs = totalDuration.inMilliseconds > 0 
        ? totalDuration.inMilliseconds 
        : (currentTrack?.duration.inMilliseconds ?? 0);
        
    if (durationMs == 0) return 0;
    return position.inMilliseconds / durationMs;
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
    // Position updates (Direct stream from AppAudioHandler)
    _subscriptions.add(
      _audioHandler.positionStream.listen((position) {
        state = state.copyWith(position: position);
      }),
    );

    // Buffered position updates (Direct stream from AppAudioHandler)
    _subscriptions.add(
      _audioHandler.bufferedPositionStream.listen((buffered) {
        state = state.copyWith(bufferedPosition: buffered);
      }),
    );
    
    // Total Duration updates (Direct stream from AppAudioHandler)
    // Fixes VBR/Stream duration issues
    _subscriptions.add(
      _audioHandler.durationStream.listen((duration) {
        if (duration != null) {
          state = state.copyWith(totalDuration: duration);
        }
      }),
    );

    // Playback state updates (From AudioService logic)
    _subscriptions.add(
      _audioHandler.playbackState.listen((playbackState) {
        _onPlaybackStateChanged(playbackState);
      }),
    );

    // Current ID updates (From AudioService)
    _subscriptions.add(
      _audioHandler.mediaItem.listen((mediaItem) {
        if (mediaItem != null) {
          _onMediaItemChanged(mediaItem);
        }
      }),
    );
  }

  void _onMediaItemChanged(MediaItem mediaItem) {
    // Sync UI index with System playing track
    final index = state.tracks.indexWhere((t) => t.id == mediaItem.id);
    if (index != -1 && index != state.currentIndex) {
      state = state.copyWith(currentIndex: index);
    }
  }

  void _onPlaybackStateChanged(PlaybackState playbackState) {
    final processingState = playbackState.processingState;
    final playing = playbackState.playing;

    PlayerStatus newStatus;

    switch (processingState) {
      case AudioProcessingState.idle:
        newStatus = PlayerStatus.idle;
        break;
      case AudioProcessingState.loading:
      case AudioProcessingState.buffering:
        newStatus = PlayerStatus.loading;
        break;
      case AudioProcessingState.ready:
        newStatus = playing ? PlayerStatus.playing : PlayerStatus.paused;
        break;
      case AudioProcessingState.completed:
        newStatus = PlayerStatus.completed;
        break;
      case AudioProcessingState.error:
        newStatus = PlayerStatus.error;
        break;
    }

    state = state.copyWith(status: newStatus);
  }

  // === Public methods ===

  /// Load queue and start playing from index
  Future<void> playQueue(
    List<Track> tracks, {
    required QueueSource source,
    int startIndex = 0,
  }) async {
    if (tracks.isEmpty) return;

    // 1. Update UI State immediately (Optimistic update)
    state = state.copyWith(
      tracks: tracks,
      source: source,
      currentIndex: startIndex,
      status: PlayerStatus.loading,
      position: Duration.zero,
      errorMessage: null,
    );

    // 2. Delegate to AudioHandler
    try {
      await _audioHandler.setQueue(tracks, initialIndex: startIndex);
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Resume playback
  Future<void> play() async {
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
    await _audioHandler.skipToNext();
  }

  /// Play previous track
  Future<void> previous() async {
    await _audioHandler.skipToPrevious();
  }

  /// Skip to specific track index
  Future<void> skipTo(int index) async {
    await _audioHandler.skipToQueueItem(index);
  }
}

// === Provider ===

final playerStateProvider = NotifierProvider<PlayerNotifier, PlayerState>(
  PlayerNotifier.new,
);
