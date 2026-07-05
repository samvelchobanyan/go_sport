import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/services.dart' show PlatformException, rootBundle;
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

import '../../domain/entities/track.dart';

/// Bundled artwork shown by the system player (lock screen / notification)
/// when a track has no cover of its own. Materialized to a file because
/// MediaItem.artUri only accepts URIs the native side can read (http/file),
/// not Flutter asset paths.
const _noImageAsset = 'assets/images/noimage_lock_screen.png';

/// Wrapper around just_audio player that implements audio_service.
/// Acts as a bridge between the app/system and the underlying audio player.
class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();

  // === Broken-track handling: current state and plan ======================
  //
  // just_audio 0.9.x has a flawed error model; this class works around it:
  //
  // 1. Broken track DURING playback — the native side auto-advances past it
  //    (Android plugin re-prepares onto failed+1, up to 5 errors per load;
  //    iOS AVQueuePlayer skips failed items by itself). The onError recovery
  //    below only nudges play() when playback stalled after the jump, or
  //    skips manually when the player is genuinely stuck on the failed item.
  //
  // 2. Broken STARTING track — setAudioSource throws, and when the native
  //    player was created for that load (cold start) just_audio disposes it,
  //    discarding even a successful native auto-advance. The retry loop in
  //    [setQueue] steps over broken start indices until one loads.
  //
  // KNOWN UNFIXED (reproduced 2026-07-05): the Android plugin stops
  // auto-advancing after 5 errors per load (cumulative errorCount, reset
  // only by the next full load). Past that limit the player is dead in
  // eternal buffering: seekToNext on an errored ExoPlayer is a no-op and
  // taps only move the Dart-side index. Deliberately NOT worked around —
  // a proper fix (full queue reload from recovery) would add yet another
  // layer of scaffolding that the planned upgrade makes obsolete.
  //
  // PLAN — upgrade to just_audio ^0.10.x, which redesigns error handling:
  //  - AudioPlayer(maxSkipsOnError: N) replaces the onError recovery below
  //    (counts CONSECUTIVE errors, resets on every successfully loaded
  //    track — no permanent poisoning);
  //  - errorStream replaces playbackEventStream.onError (errors are data,
  //    no reentrancy hazard);
  //  - the dispose-on-failed-initial-load catch is removed upstream, so the
  //    retry loop in setQueue is likely removable too (verify on an album
  //    with broken leading tracks);
  //  - setAudioSource(ConcatenatingAudioSource(...)) migrates to the new
  //    playlist API, setAudioSources(...).
  // On upgrade delete: the onError recovery block, _recovering,
  // _loadingQueue, the retry loop in setQueue. Then regression-test music,
  // radio + ICY, shuffle, lock screen / background, and session restore.
  // =========================================================================

  /// True while a broken-track recovery (skip/stop) is in flight. just_audio
  /// can deliver more than one error event for a single failed source; without
  /// this guard each event schedules its own seekToNext and tracks get
  /// skipped two at a time.
  bool _recovering = false;

  /// True while [setQueue] is loading the queue (including load retries).
  /// Failed load attempts emit the same error events as playback failures,
  /// but during a load they are owned by the retry loop in [setQueue] —
  /// the onError recovery must stand down, otherwise two mechanisms would
  /// command the player simultaneously.
  bool _loadingQueue = false;

  /// file:// URI of the materialized [_noImageAsset]; null until first queue
  /// load (or if materialization failed — then artUri just stays null).
  Uri? _noImageArtUri;

  /// Copy [_noImageAsset] from the bundle to the app support directory once,
  /// so the system player can read it via a file:// URI.
  Future<void> _ensureNoImageArt() async {
    if (_noImageArtUri != null) return;
    try {
      final dir = await getApplicationSupportDirectory();
      final file = File('${dir.path}/noimage_lock_screen.png');
      if (!await file.exists()) {
        final bytes = await rootBundle.load(_noImageAsset);
        await file.writeAsBytes(bytes.buffer.asUint8List());
      }
      _noImageArtUri = Uri.file(file.path);
    } catch (_) {
      // Best-effort: no fallback art is better than a crash on queue load.
    }
  }

  /// Parse [url] only if it is a real network URL the native side can load.
  /// Filters out nulls and non-network values (e.g. bundled asset paths used
  /// as playlist covers), which would otherwise reach the system as dead URIs.
  Uri? _networkUri(String? url) =>
      url != null && url.startsWith('http') ? Uri.parse(url) : null;

  AppAudioHandler() {
    _init();
  }

  Future<void> _init() async {
    // 1. Broadcast playback events (playing state, controls, position) to the system
    _player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = _player.playing;
      final processingState = _player.processingState;
      

      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[processingState]!,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
        shuffleMode: _player.shuffleModeEnabled
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        repeatMode: const {
          LoopMode.off: AudioServiceRepeatMode.none,
          LoopMode.all: AudioServiceRepeatMode.all,
          LoopMode.one: AudioServiceRepeatMode.one,
        }[_player.loopMode]!,
      ));
    }, onError: (Object error, StackTrace stackTrace) {
      // TEMP DEBUG: broken-track recovery diagnostics
      debugPrint('AudioRecovery: onError fired — error=$error, '
          'currentIndex=${_player.currentIndex}, '
          'processingState=${_player.processingState}, '
          'recovering=$_recovering');
      playbackState.add(playbackState.value.copyWith(
        processingState: AudioProcessingState.error,
      ));
      // While setQueue is loading, errors belong to its retry loop —
      // recovery here would command the player mid-load and corrupt it.
      if (_loadingQueue) {
        debugPrint('AudioRecovery: load in progress — retry loop owns this error');
        return;
      }
      if (_recovering) {
        debugPrint('AudioRecovery: duplicate error ignored (recovery in flight)');
        return;
      }
      _recovering = true;
      // Both platform plugins report which item failed in the error payload
      // ({index: N}); the current index is only a fallback because by the
      // time we act the native side may have moved on (Android re-prepares
      // onto the next item itself; iOS broadcasts preload errors for
      // upcoming items while the current one is still playing).
      int? failedIndex;
      if (error is PlatformException && error.details is Map) {
        failedIndex = (error.details as Map)['index'] as int?;
      }
      failedIndex ??= _player.currentIndex;
      // Deferred via Future: seek/play/stop feed the same event stream that
      // is delivering this error, and a synchronous call throws
      // "Cannot fire new event" (controller is still firing).
      Future(() async {
        try {
          debugPrint('AudioRecovery: recovery start — failedIndex=$failedIndex, '
              'currentIndex=${_player.currentIndex}, '
              'playing=${_player.playing}, '
              'processingState=${_player.processingState}');
          if (_player.currentIndex != failedIndex) {
            // Native side already moved past the broken item, or the error
            // was a preload failure for an upcoming item — only nudge
            // playback if it actually stalled.
            if (!_player.playing) {
              debugPrint('AudioRecovery: moved past failed item but stalled — play()');
              await _player.play();
              debugPrint('AudioRecovery: after play — '
                  'currentIndex=${_player.currentIndex}, '
                  'playing=${_player.playing}, '
                  'processingState=${_player.processingState}');
            } else {
              debugPrint('AudioRecovery: playback unaffected — no action');
            }
          } else if (_player.hasNext) {
            // Player is genuinely stuck on the broken item — skip it.
            debugPrint('AudioRecovery: stuck on failed item — seekToNext()');
            await _player.seekToNext();
            await _player.play();
            debugPrint('AudioRecovery: after seekToNext+play — '
                'currentIndex=${_player.currentIndex}, '
                'playing=${_player.playing}, '
                'processingState=${_player.processingState}');
          } else {
            debugPrint('AudioRecovery: no next track — stopping');
            await _player.stop();
          }
        } catch (e) {
          // Player may be unrecoverable after the error; leave it stopped
          // rather than crash on a second attempt.
          debugPrint('AudioRecovery: recovery FAILED — $e');
        } finally {
          _recovering = false;
          debugPrint('AudioRecovery: recovery finished, flag reset');
        }
      });
    });

    // TEMP DEBUG: trace every index change to see who moves the playhead
    _player.currentIndexStream.listen((index) {
      debugPrint('AudioRecovery: currentIndexStream -> $index');
    });

    // 2. Broadcast current track changes to the system
    _player.currentIndexStream.listen((index) {
      if (index != null && queue.value.isNotEmpty && index < queue.value.length) {
        final item = queue.value[index];
        mediaItem.add(item);
      }
    });

    // 3. Update playback state when duration changes (Fix for VBR or wrong metadata)
    _player.durationStream.listen((totalDuration) {
      final oldMediaItem = mediaItem.value;
      if (oldMediaItem != null && totalDuration != null) {
        // Update MediaItem with actual duration from player
        mediaItem.add(oldMediaItem.copyWith(duration: totalDuration));
      }
    });
  }

  // === Public Getters for UI ===

  /// Direct position stream for smooth UI sliders.
  /// AudioService stream updates are throttled to save battery.
  Stream<Duration> get positionStream => _player.positionStream;

  /// Direct buffered position stream.
  Stream<Duration> get bufferedPositionStream => _player.bufferedPositionStream;

  /// Direct duration stream (Real time updates from decoder)
  Stream<Duration?> get durationStream => _player.durationStream;

  // === Queue Management ===

  /// Load a new queue of tracks positioned at [initialIndex] / [initialPosition].
  /// Does NOT start playback — call [play] separately when playback is wanted.
  Future<void> setQueue(
    List<Track> tracks, {
    int initialIndex = 0,
    Duration initialPosition = Duration.zero,
    String? fallbackArtUrl,
  }) async {
    if (tracks.isEmpty) return;

    await _ensureNoImageArt();

    // 1. Create MediaItems
    final mediaItems = tracks.map((track) {
      return MediaItem(
        id: track.id,
        album: 'Go Sport Music',
        title: track.title,
        artist: track.artistName,
        duration: track.duration,
        artUri: _networkUri(track.imageUrl) ??
            _networkUri(fallbackArtUrl) ??
            _noImageArtUri,
        extras: {'audioUrl': track.audioUrl, 'imageUrl': track.imageUrl},
      );
    }).toList();

    // 2. Update system queue immediately
    queue.add(mediaItems);

    // 3. Create AudioSources for just_audio (Actual playback)
    final audioSources = tracks.map((track) {
      return AudioSource.uri(
        Uri.parse(track.audioUrl),
        tag: track, // Store rich Track object in tag for retrieval if needed
      );
    }).toList();

    // 4. Update MediaItem immediately for the starting track
    if (mediaItems.isNotEmpty && initialIndex < mediaItems.length) {
      mediaItem.add(mediaItems[initialIndex]);
    }

    // 5. Load into player (paused; caller decides when to play).
    //
    // WORKAROUND for the just_audio 0.9.x error model: if the STARTING track
    // fails to load, setAudioSource throws and — when the native player was
    // created for this load (cold start) — disposes it, discarding even a
    // successful native auto-advance. Broken tracks encountered DURING
    // playback are handled fine (native auto-advance + onError recovery);
    // only a broken start kills the whole queue. So on failure we retry the
    // load from each following index until one succeeds. Remove this loop
    // when upgrading to just_audio 0.10.x (maxSkipsOnError / errorStream).
    _loadingQueue = true;
    try {
      var index = initialIndex;
      var position = initialPosition;
      while (true) {
        try {
          await _player.setAudioSource(
            ConcatenatingAudioSource(children: audioSources),
            initialIndex: index,
            initialPosition: position,
          );
          break;
        } catch (e) {
          // TEMP DEBUG
          debugPrint('AudioRecovery: setAudioSource FAILED '
              '(initialIndex=$index) — $e');
          index += 1;
          position = Duration.zero; // saved position applied to original track only
          if (index >= tracks.length) rethrow; // nothing in the queue is loadable
          // TEMP DEBUG
          debugPrint('AudioRecovery: retrying load from index $index');
        }
      }
    } finally {
      _loadingQueue = false;
    }
  }

  // === Playback Controls ===

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> skipToNext() => _player.seekToNext();

  @override
  Future<void> skipToPrevious() => _player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    await _player.seek(Duration.zero, index: index);
    if (!_player.playing) {
      await _player.play();
    }
  }

  // === Radio Stream ===

  /// Play a live radio stream
  Future<void> playRadioStream({
    required String url,
    required String title,
    required String imageUrl,
  }) async {
    await _ensureNoImageArt();

    // 1. Clear system queue (radio has no queue)
    queue.add([]);

    // 2. Set radio MediaItem for system notification / lock screen
    mediaItem.add(MediaItem(
      id: 'radio',
      title: title,
      artist: 'Live',
      artUri: _networkUri(imageUrl) ?? _noImageArtUri,
      // duration is null for live streams
    ));

    // 3. Load and play the stream
    await _player.setAudioSource(AudioSource.uri(Uri.parse(url)));
    await _player.play();
  }

  // === Shuffle & Repeat ===

  /// Enable or disable shuffle mode.
  Future<void> setShuffleEnabled(bool enabled) async {
    await _player.setShuffleModeEnabled(enabled);
    if (enabled) await _player.shuffle();
  }

  /// Set loop/repeat mode.
  Future<void> setLoopMode(LoopMode mode) async {
    await _player.setLoopMode(mode);
  }

  /// Shuffle indices — playback order when shuffle is ON.
  List<int>? get shuffleIndices => _player.shuffleIndices;

  /// ICY metadata stream for live radio (current song info)
  Stream<IcyMetadata?> get icyMetadataStream => _player.icyMetadataStream;

  /// Dispose player resources
  Future<void> dispose() async {
    await _player.dispose();
  }
}
