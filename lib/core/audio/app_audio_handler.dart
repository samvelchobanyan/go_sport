import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/track.dart';

/// Wrapper around just_audio player that implements audio_service.
/// Acts as a bridge between the app/system and the underlying audio player.
class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player = AudioPlayer();

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
        playbackState.add(playbackState.value.copyWith(
          processingState: AudioProcessingState.error,
        ));
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
  }) async {
    if (tracks.isEmpty) return;

    // 1. Create MediaItems
    final mediaItems = tracks.map((track) {
      return MediaItem(
        id: track.id,
        album: 'Go Sport Music',
        title: track.title,
        artist: track.artistName,
        duration: track.duration,
        artUri: track.imageUrl != null ? Uri.parse(track.imageUrl!) : null,
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

    // 5. Load into player (paused; caller decides when to play)
    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
      initialIndex: initialIndex,
      initialPosition: initialPosition,
    );
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
    // 1. Clear system queue (radio has no queue)
    queue.add([]);

    // 2. Set radio MediaItem for system notification / lock screen
    mediaItem.add(MediaItem(
      id: 'radio',
      title: title,
      artist: 'Live',
      artUri: Uri.parse(imageUrl),
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
