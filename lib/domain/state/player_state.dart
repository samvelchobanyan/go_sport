import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:just_audio/just_audio.dart';

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

enum PlaybackMode {
  music,
  radio,
}

enum RepeatMode {
  off,
  all,
  one,
}

// === Queue Source ===

@freezed
sealed class QueueSource with _$QueueSource {
  const QueueSource._();

  @override
  String get id => switch (this) {
    QueueSourceAlbum(:final id) => id,
    QueueSourcePlaylist(:final id) => id,
    QueueSourceProgram(:final id) => id,
    QueueSourceFavorites(:final id) => id,
    QueueSourceEpisodes(:final id) => id,
  };

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

  const factory QueueSource.favorites({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourceFavorites;

  const factory QueueSource.episodes({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourceEpisodes;
}

// === State ===

@freezed
class PlayerState with _$PlayerState {
  const factory PlayerState({
    // Playback mode
    @Default(PlaybackMode.music) PlaybackMode mode,

    // Queue (Music)
    @Default([]) List<Track> tracks,
    @Default(0) int currentIndex,
    QueueSource? source,

    // Playback
    @Default(PlayerStatus.idle) PlayerStatus status,
    @Default(Duration.zero) Duration position,
    @Default(Duration.zero) Duration bufferedPosition,
    @Default(Duration.zero) Duration totalDuration,

    // Shuffle & Repeat
    @Default(false) bool shuffleEnabled,
    @Default(RepeatMode.off) RepeatMode repeatMode,
    List<int>? shuffleIndices,

    // Radio
    String? radioTitle,
    String? radioStreamUrl,
    String? radioImageUrl,
    String? radioNowPlaying, // "Artist - Song Name" from ICY metadata

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

  /// Next track considering shuffle order
  Track? get nextTrack {
    if (shuffleEnabled && shuffleIndices != null) {
      final pos = shuffleIndices!.indexOf(currentIndex);
      if (pos != -1 && pos < shuffleIndices!.length - 1) {
        final idx = shuffleIndices![pos + 1];
        return idx < tracks.length ? tracks[idx] : null;
      }
      return null;
    }
    return hasNext ? tracks[currentIndex + 1] : null;
  }

  /// Previous track considering shuffle order
  Track? get prevTrack {
    if (shuffleEnabled && shuffleIndices != null) {
      final pos = shuffleIndices!.indexOf(currentIndex);
      if (pos > 0) {
        final idx = shuffleIndices![pos - 1];
        return idx < tracks.length ? tracks[idx] : null;
      }
      return null;
    }
    return hasPrevious ? tracks[currentIndex - 1] : null;
  }

  /// Actual duration: prefer player-reported duration, fallback to track metadata
  Duration get effectiveDuration =>
      totalDuration > Duration.zero
          ? totalDuration
          : (currentTrack?.duration ?? Duration.zero);

  /// Progress 0.0 - 1.0
  double get progress {
    final durationMs = effectiveDuration.inMilliseconds;
    if (durationMs == 0) return 0;
    return position.inMilliseconds / durationMs;
  }

  /// Buffered progress 0.0 - 1.0
  double get bufferedProgress {
    final durationMs = effectiveDuration.inMilliseconds;
    if (durationMs == 0) return 0;
    return bufferedPosition.inMilliseconds / durationMs;
  }

  /// Is currently playing
  bool get isPlaying => status == PlayerStatus.playing;

  /// Is in radio mode
  bool get isRadioMode => mode == PlaybackMode.radio;

  /// Has active playback to show in MiniPlayer (track or radio)
  bool get hasActivePlayback =>
      (currentTrack != null || isRadioMode) && status != PlayerStatus.idle;

  /// Image URL for display (track image or source image as fallback)
  String? get displayImageUrl {
    final trackImage = currentTrack?.imageUrl;
    if (trackImage != null) {
      return trackImage;
    }
    // Fallback to source image
    return source?.when(
      album: (_, __, imageUrl) => imageUrl,
      playlist: (_, __, imageUrl) => imageUrl,
      program: (_, __, imageUrl) => imageUrl,
      favorites: (_, __, imageUrl) => imageUrl,
      episodes: (_, __, imageUrl) => imageUrl,
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

    // ICY metadata updates (Radio "Now Playing")
    _subscriptions.add(
      _audioHandler.icyMetadataStream.listen((icy) {
        final title = icy?.info?.title;
        if (state.isRadioMode && title != null && title.isNotEmpty) {
          state = state.copyWith(radioNowPlaying: title);
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

    // Sync shuffle mode from audio handler
    final shuffleEnabled = playbackState.shuffleMode == AudioServiceShuffleMode.all;
    if (state.shuffleEnabled != shuffleEnabled) {
      state = state.copyWith(shuffleEnabled: shuffleEnabled);
    }

    // Sync repeat mode from audio handler
    final repeatMode = const {
      AudioServiceRepeatMode.none: RepeatMode.off,
      AudioServiceRepeatMode.all: RepeatMode.all,
      AudioServiceRepeatMode.one: RepeatMode.one,
    }[playbackState.repeatMode] ?? RepeatMode.off;
    if (state.repeatMode != repeatMode) {
      state = state.copyWith(repeatMode: repeatMode);
    }
  }

  // === Public methods ===

  /// Load queue and start playing from index
  Future<void> playQueue(
    List<Track> tracks, {
    required QueueSource source,
    int startIndex = 0,
  }) async {
    if (tracks.isEmpty) return;

    // Same source — just skip to the track
    if (state.source?.id == source.id && state.mode == PlaybackMode.music) {
      state = state.copyWith(currentIndex: startIndex);
      await skipTo(startIndex);
      return;
    }

    // 1. Update UI State immediately (Optimistic update)
    state = state.copyWith(
      mode: PlaybackMode.music,
      tracks: tracks,
      source: source,
      currentIndex: startIndex,
      status: PlayerStatus.loading,
      position: Duration.zero,
      radioNowPlaying: null, // Clear radio metadata
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

  // === Shuffle & Repeat ===

  /// Toggle shuffle mode
  Future<void> toggleShuffle() async {
    final previous = state.shuffleEnabled;
    final next = !previous;

    // Optimistic UI update
    state = state.copyWith(shuffleEnabled: next);

    try {
      await _audioHandler.setShuffleEnabled(next);
      state = state.copyWith(
        shuffleIndices: next ? _audioHandler.shuffleIndices : null,
      );
    } catch (e) {
      // Rollback on failure; playbackState sync will correct as well
      state = state.copyWith(shuffleEnabled: previous, shuffleIndices: null);
    }
  }

  /// Cycle repeat mode: off → all → one → off
  Future<void> cycleRepeatMode() async {
    final previous = state.repeatMode;
    final next = switch (previous) {
      RepeatMode.off => RepeatMode.all,
      RepeatMode.all => RepeatMode.one,
      RepeatMode.one => RepeatMode.off,
    };
    final loopMode = switch (next) {
      RepeatMode.off => LoopMode.off,
      RepeatMode.all => LoopMode.all,
      RepeatMode.one => LoopMode.one,
    };

    // Optimistic UI update
    state = state.copyWith(repeatMode: next);

    try {
      await _audioHandler.setLoopMode(loopMode);
    } catch (e) {
      // Rollback on failure; playbackState sync will correct as well
      state = state.copyWith(repeatMode: previous);
    }
  }

  // === Radio ===

  /// Radio stream constants
  static const _radioStreamUrl = 'https://ice1.somafm.com/groovesalad-128-mp3';
  static const _radioTitle = 'Go Sport Radio';
  static const _radioImageUrl =
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80';

  /// Start playing radio stream
  Future<void> playRadio() async {
    // 1. Update UI state (keep tracks and music queue source for resume later)
    state = state.copyWith(
      mode: PlaybackMode.radio,
      radioTitle: _radioTitle,
      radioStreamUrl: _radioStreamUrl,
      radioImageUrl: _radioImageUrl,
      status: PlayerStatus.loading,
      position: Duration.zero,
      radioNowPlaying: null,
      errorMessage: null,
    );

    // 2. Delegate to AudioHandler
    try {
      await _audioHandler.playRadioStream(
        url: _radioStreamUrl,
        title: _radioTitle,
        imageUrl: _radioImageUrl,
      );
    } catch (e) {
      state = state.copyWith(
        mode: PlaybackMode.music,
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Update track like state in the queue
  void updateTrackLike(String trackId, {required bool isLiked, String? likeId}) {
    final updatedTracks = state.tracks.map((t) {
      if (t.id == trackId) {
        return t.copyWith(isLiked: isLiked, likeId: likeId);
      }
      return t;
    }).toList();
    state = state.copyWith(tracks: updatedTracks);
  }

  /// Resume music playback (after radio)
  Future<void> resumeMusic() async {
    if (state.tracks.isEmpty) return;

    final tracks = state.tracks;
    final index = state.currentIndex;

    state = state.copyWith(
      mode: PlaybackMode.music,
      status: PlayerStatus.loading,
      radioNowPlaying: null, // Clear radio metadata
    );

    try {
      await _audioHandler.setQueue(tracks, initialIndex: index);
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
