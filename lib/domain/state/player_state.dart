import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:just_audio/just_audio.dart';

import '../entities/track.dart';
import '../../core/audio/app_audio_handler.dart';
import '../../core/audio/player_session_storage.dart';
import '../../core/di/audio_providers.dart';
import '../../core/di/repository_providers.dart';

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
    QueueSourceArtist(:final id) => id,
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

  const factory QueueSource.artist({
    required String id,
    required String title,
    required String imageUrl,
  }) = QueueSourceArtist;
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

  /// Can move to a next track — respects repeat-all wrap and shuffle order
  bool get canGoNext => repeatMode == RepeatMode.all || nextTrack != null;

  /// Can move to a previous track — respects repeat-all wrap and shuffle order
  bool get canGoPrev => repeatMode == RepeatMode.all || prevTrack != null;

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
      artist: (_, __, imageUrl) => imageUrl,
    );
  }
}

// === Notifier ===

class PlayerNotifier extends Notifier<PlayerState> {
  late final AppAudioHandler _audioHandler;
  final List<StreamSubscription> _subscriptions = [];
  AppLifecycleListener? _lifecycleListener;
  Timer? _positionSaveTimer;

  /// Music playback position, stashed when switching to radio so
  /// [resumeMusic] can continue from where the track left off.
  Duration _musicPosition = Duration.zero;

  @override
  PlayerState build() {
    _audioHandler = ref.watch(audioHandlerProvider);
    _listenToAudioHandler();

    // Persist the session when the app goes to background / is torn down.
    _lifecycleListener = AppLifecycleListener(
      onPause: _persistNow,
      onDetach: _persistNow,
    );

    // Persist the position periodically while playing so a hard kill loses at
    // most a few seconds — a single-int write, not the whole snapshot.
    _positionSaveTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (state.isPlaying && state.mode == PlaybackMode.music) _savePosition();
    });

    ref.onDispose(() {
      for (final sub in _subscriptions) {
        sub.cancel();
      }
      _lifecycleListener?.dispose();
      _positionSaveTimer?.cancel();
    });

    // Prime the mini-player once, after this build settles (don't touch state
    // during build). Restores the last session, or falls back to featured.
    Future(_restoreOrPrime);

    return const PlayerState();
  }

  /// On startup: restore the last saved session, else prime a featured playlist.
  /// Only acts on an untouched player so it never clobbers active playback.
  Future<void> _restoreOrPrime() async {
    if (state.status != PlayerStatus.idle || state.tracks.isNotEmpty) return;

    // 1. Restore last persisted session (app was killed).
    final storage = ref.read(playerSessionStorageProvider);
    final saved = storage.session;
    if (saved != null) {
      await loadPausedQueue(
        saved.tracks,
        source: _sourceFromSession(saved),
        index: saved.currentIndex,
        position: storage.position,
      );
      return;
    }

    // 2. First launch ever — prime the first featured playlist, paused.
    try {
      final repo = ref.read(featuredPlaylistRepositoryProvider);
      final playlists = await repo.getFeaturedPlaylists();
      if (playlists.isEmpty) return;

      final first = playlists.first;
      final tracks = await repo.getPlaylistTracks(first.id);
      if (tracks.isEmpty) return;

      // Re-check: the user may have started playback while we fetched.
      if (state.status != PlayerStatus.idle || state.tracks.isNotEmpty) return;

      await loadPausedQueue(
        tracks,
        source: QueueSource.playlist(
          id: first.id,
          title: first.title,
          imageUrl: first.imageUrl,
        ),
      );
    } catch (_) {
      // Offline / featured unavailable — leave the mini-player empty as before.
    }
  }

  /// Rebuild a [QueueSource] from the flat fields stored in a [PlayerSession].
  QueueSource _sourceFromSession(PlayerSession s) => switch (s.sourceType) {
        'album' => QueueSource.album(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
        'program' => QueueSource.program(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
        'favorites' => QueueSource.favorites(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
        'episodes' => QueueSource.episodes(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
        'artist' => QueueSource.artist(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
        _ => QueueSource.playlist(
            id: s.sourceId, title: s.sourceTitle, imageUrl: s.sourceImageUrl),
      };

  /// Persist the current music queue snapshot so it survives an app kill.
  /// Skips radio and empty/sourceless states — only a real music session.
  void _saveSession() {
    if (state.mode != PlaybackMode.music) return;
    if (state.tracks.isEmpty) return;
    final source = state.source;
    if (source == null) return;

    final (type, id, title, imageUrl) = _sourceToFields(source);
    unawaited(
      ref.read(playerSessionStorageProvider).saveSession(
            PlayerSession(
              tracks: state.tracks,
              currentIndex: state.currentIndex,
              sourceType: type,
              sourceId: id,
              sourceTitle: title,
              sourceImageUrl: imageUrl,
            ),
          ),
    );
  }

  /// Persist just the playback position (a single int). Music only —
  /// radio position is meaningless and would corrupt the saved music session.
  void _savePosition() {
    if (state.mode != PlaybackMode.music) return;
    if (state.tracks.isEmpty) return;
    unawaited(
      ref.read(playerSessionStorageProvider).savePosition(state.position),
    );
  }

  /// Flush both snapshot and position — used on app background / teardown.
  void _persistNow() {
    _saveSession();
    _savePosition();
  }

  /// Flatten a [QueueSource] into fields for [PlayerSession].
  (String, String, String, String) _sourceToFields(QueueSource source) =>
      switch (source) {
        QueueSourceAlbum(:final id, :final title, :final imageUrl) =>
          ('album', id, title, imageUrl),
        QueueSourcePlaylist(:final id, :final title, :final imageUrl) =>
          ('playlist', id, title, imageUrl),
        QueueSourceProgram(:final id, :final title, :final imageUrl) =>
          ('program', id, title, imageUrl),
        QueueSourceFavorites(:final id, :final title, :final imageUrl) =>
          ('favorites', id, title, imageUrl),
        QueueSourceEpisodes(:final id, :final title, :final imageUrl) =>
          ('episodes', id, title, imageUrl),
        QueueSourceArtist(:final id, :final title, :final imageUrl) =>
          ('artist', id, title, imageUrl),
      };

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
      _saveSession(); // persist the new current track
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

    // Same source — just skip to the track. Only when the player actually
    // has the queue loaded: after a playback error (or stop) the native
    // player is idle and a bare seek silently does nothing — fall through
    // to the full reload below instead. The queue must also still match the
    // list the user tapped in: with paginated sources (artist, favorites)
    // the on-screen list can outgrow the loaded queue, so verify the tapped
    // index exists and holds the same track before a bare skip.
    final playerAlive = state.status != PlayerStatus.error &&
        state.status != PlayerStatus.idle;
    final queueMatches = startIndex < state.tracks.length &&
        state.tracks[startIndex].id == tracks[startIndex].id;
    if (state.source?.id == source.id &&
        state.mode == PlaybackMode.music &&
        playerAlive &&
        queueMatches) {
      state = state.copyWith(currentIndex: startIndex);
      await skipTo(startIndex);
      _saveSession();
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

    // 2. Delegate to AudioHandler, then start playback
    try {
      await _audioHandler.setQueue(tracks, initialIndex: startIndex, fallbackArtUrl: source.imageUrl);
      await _audioHandler.play();
      _saveSession();
    } catch (e) {
      state = state.copyWith(
        status: PlayerStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  /// Load a queue WITHOUT starting playback — sits paused at [position].
  /// Used to prime the mini-player on startup (restored session or featured
  /// playlist). Twin of [playQueue] minus the final play() and with a position.
  Future<void> loadPausedQueue(
    List<Track> tracks, {
    required QueueSource source,
    int index = 0,
    Duration position = Duration.zero,
  }) async {
    if (tracks.isEmpty) return;

    // 1. Update UI state so the mini-player shows the track, silent (paused)
    state = state.copyWith(
      mode: PlaybackMode.music,
      tracks: tracks,
      source: source,
      currentIndex: index,
      position: position,
      status: PlayerStatus.paused,
      radioNowPlaying: null,
      errorMessage: null,
    );

    // 2. Load into the player at the given position; do NOT play.
    try {
      await _audioHandler.setQueue(
        tracks,
        initialIndex: index,
        initialPosition: position,
        fallbackArtUrl: source.imageUrl,
      );
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
  // static const _radioStreamUrl = 'https://ice1.somafm.com/groovesalad-128-mp3';
  static const _radioStreamUrl = 'https://gosport.webcaramba.com/gosport128.mp3';
  static const _radioTitle = 'Go Sport Radio';
  static const _radioImageUrl =
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=300&q=80';

  /// Start playing radio stream
  Future<void> playRadio() async {
    // 0. Stash current music position so resumeMusic can continue from it
    if (state.mode == PlaybackMode.music) {
      _musicPosition = state.position;
    }

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

  /// Resume music playback (after radio)
  Future<void> resumeMusic() async {
    if (state.tracks.isEmpty) return;

    final tracks = state.tracks;
    final index = state.currentIndex;

    state = state.copyWith(
      mode: PlaybackMode.music,
      status: PlayerStatus.loading,
      position: _musicPosition, // Restore stashed music position
      radioNowPlaying: null, // Clear radio metadata
    );

    try {
      await _audioHandler.setQueue(
        tracks,
        initialIndex: index,
        initialPosition: _musicPosition,
        fallbackArtUrl: state.source?.imageUrl,
      );
      await _audioHandler.play();
      _saveSession();
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
