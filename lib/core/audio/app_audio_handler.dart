import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
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
      
      debugPrint("AudioHandler: Event Received. Playing=$playing, State=$processingState"); // <--- LOG

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
      ));
    });

    // 2. Broadcast current track changes to the system
    _player.currentIndexStream.listen((index) {
      if (index != null && queue.value.isNotEmpty && index < queue.value.length) {
        mediaItem.add(queue.value[index]);
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

  /// Load a new queue of tracks and start playing from [initialIndex]
  Future<void> setQueue(List<Track> tracks, {int initialIndex = 0}) async {
    if (tracks.isEmpty) return;

    // 1. Create MediaItems for the system (Metadata)
    final mediaItems = tracks.map((track) {
      return MediaItem(
        id: track.id,
        album: 'Go Sport Music',
        title: track.title,
        artist: track.artistName,
        duration: track.duration,
        artUri: Uri.parse(track.imageUrl),
        extras: {'audioUrl': track.audioUrl}, // Backup URL if needed
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

    // 5. Load into player
    await _player.setAudioSource(
      ConcatenatingAudioSource(children: audioSources),
      initialIndex: initialIndex,
    );
    
    await _player.play();
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

  /// Dispose player resources
  Future<void> dispose() async {
    await _player.dispose();
  }
}
