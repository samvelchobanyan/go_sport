import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../core/di/repository_providers.dart';
import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/playlist.dart';
import '../entities/program.dart';
import '../entities/track.dart';

part 'like_registry.freezed.dart';

@freezed
class LikeRegistryState with _$LikeRegistryState {
  const factory LikeRegistryState({
    @Default({}) Map<String, String?> albumLikes,
    @Default({}) Map<String, String?> trackLikes,
    @Default({}) Map<String, String?> programLikes,
    @Default({}) Map<String, String?> artistLikes,
    @Default({}) Map<String, String?> playlistLikes,
    @Default({}) Map<String, String?> episodeLikes,
  }) = _LikeRegistryState;
}

class LikeRegistry extends Notifier<LikeRegistryState> {
  @override
  LikeRegistryState build() => const LikeRegistryState();

  // === Read ===

  bool isAlbumLiked(String id) => state.albumLikes.containsKey(id);
  String? albumLikeId(String id) => state.albumLikes[id];

  bool isTrackLiked(String id) => state.trackLikes.containsKey(id);
  String? trackLikeId(String id) => state.trackLikes[id];

  bool isProgramLiked(String id) => state.programLikes.containsKey(id);
  String? programLikeId(String id) => state.programLikes[id];

  bool isArtistLiked(String id) => state.artistLikes.containsKey(id);
  String? artistLikeId(String id) => state.artistLikes[id];

  bool isPlaylistLiked(String id) => state.playlistLikes.containsKey(id);
  String? playlistLikeId(String id) => state.playlistLikes[id];

  bool isEpisodeLiked(String id) => state.episodeLikes.containsKey(id);
  String? episodeLikeId(String id) => state.episodeLikes[id];

  // === Toggle (active: optimistic + repo + rollback) ===

  Future<void> toggleAlbum(String id) async {
    final wasLiked = state.albumLikes.containsKey(id);
    final prevLikeId = state.albumLikes[id];

    state = state.copyWith(
      albumLikes: wasLiked
          ? ({...state.albumLikes}..remove(id))
          : {...state.albumLikes, id: null},
    );

    try {
      final repo = ref.read(albumsRepositoryProvider);
      final newLikeId = await repo.toggleLike(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state = state.copyWith(albumLikes: {...state.albumLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        albumLikes: wasLiked
            ? {...state.albumLikes, id: prevLikeId}
            : ({...state.albumLikes}..remove(id)),
      );
      rethrow;
    }
  }

  Future<void> toggleTrack(String id) async {
    final wasLiked = state.trackLikes.containsKey(id);
    final prevLikeId = state.trackLikes[id];

    state = state.copyWith(
      trackLikes: wasLiked
          ? ({...state.trackLikes}..remove(id))
          : {...state.trackLikes, id: null},
    );

    try {
      final repo = ref.read(featuredPlaylistRepositoryProvider);
      final newLikeId =
          await repo.toggleLikeTrack(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state = state.copyWith(trackLikes: {...state.trackLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        trackLikes: wasLiked
            ? {...state.trackLikes, id: prevLikeId}
            : ({...state.trackLikes}..remove(id)),
      );
      rethrow;
    }
  }

  Future<void> toggleProgram(String id) async {
    final wasLiked = state.programLikes.containsKey(id);
    final prevLikeId = state.programLikes[id];

    state = state.copyWith(
      programLikes: wasLiked
          ? ({...state.programLikes}..remove(id))
          : {...state.programLikes, id: null},
    );

    try {
      final repo = ref.read(programsRepositoryProvider);
      final newLikeId = await repo.toggleLike(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state =
            state.copyWith(programLikes: {...state.programLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        programLikes: wasLiked
            ? {...state.programLikes, id: prevLikeId}
            : ({...state.programLikes}..remove(id)),
      );
      rethrow;
    }
  }

  Future<void> toggleArtist(String id) async {
    final wasLiked = state.artistLikes.containsKey(id);
    final prevLikeId = state.artistLikes[id];

    state = state.copyWith(
      artistLikes: wasLiked
          ? ({...state.artistLikes}..remove(id))
          : {...state.artistLikes, id: null},
    );

    try {
      final repo = ref.read(artistsRepositoryProvider);
      final newLikeId = await repo.toggleLike(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state =
            state.copyWith(artistLikes: {...state.artistLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        artistLikes: wasLiked
            ? {...state.artistLikes, id: prevLikeId}
            : ({...state.artistLikes}..remove(id)),
      );
      rethrow;
    }
  }

  Future<void> togglePlaylist(String id) async {
    final wasLiked = state.playlistLikes.containsKey(id);
    final prevLikeId = state.playlistLikes[id];

    state = state.copyWith(
      playlistLikes: wasLiked
          ? ({...state.playlistLikes}..remove(id))
          : {...state.playlistLikes, id: null},
    );

    try {
      final repo = ref.read(featuredPlaylistRepositoryProvider);
      final newLikeId = await repo.toggleLike(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state = state
            .copyWith(playlistLikes: {...state.playlistLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        playlistLikes: wasLiked
            ? {...state.playlistLikes, id: prevLikeId}
            : ({...state.playlistLikes}..remove(id)),
      );
      rethrow;
    }
  }

  Future<void> toggleEpisode(String id) async {
    final wasLiked = state.episodeLikes.containsKey(id);
    final prevLikeId = state.episodeLikes[id];

    state = state.copyWith(
      episodeLikes: wasLiked
          ? ({...state.episodeLikes}..remove(id))
          : {...state.episodeLikes, id: null},
    );

    try {
      final repo = ref.read(episodesRepositoryProvider);
      final newLikeId =
          await repo.toggleLikeEpisode(id, wasLiked ? prevLikeId : null);
      if (!wasLiked && newLikeId != null) {
        state =
            state.copyWith(episodeLikes: {...state.episodeLikes, id: newLikeId});
      }
    } catch (e) {
      state = state.copyWith(
        episodeLikes: wasLiked
            ? {...state.episodeLikes, id: prevLikeId}
            : ({...state.episodeLikes}..remove(id)),
      );
      rethrow;
    }
  }

  // === Sync (batch from backend responses) ===

  void syncAlbumsLikes(List<Album> albums) {
    final next = {...state.albumLikes};
    for (final album in albums) {
      if (album.isLiked && album.likeId != null) {
        next[album.id] = album.likeId!;
      } else {
        next.remove(album.id);
      }
    }
    if (!_mapsEqual(next, state.albumLikes)) {
      state = state.copyWith(albumLikes: next);
    }
  }

  void syncTracksLikes(List<Track> tracks) {
    final next = {...state.trackLikes};
    for (final track in tracks) {
      if (track.isLiked && track.likeId != null) {
        next[track.id] = track.likeId!;
      } else {
        next.remove(track.id);
      }
    }
    if (!_mapsEqual(next, state.trackLikes)) {
      state = state.copyWith(trackLikes: next);
    }
  }

  void syncProgramsLikes(List<Program> programs) {
    final next = {...state.programLikes};
    for (final program in programs) {
      if (program.isLiked && program.likeId != null) {
        next[program.id] = program.likeId!;
      } else {
        next.remove(program.id);
      }
    }
    if (!_mapsEqual(next, state.programLikes)) {
      state = state.copyWith(programLikes: next);
    }
  }

  void syncArtistsLikes(List<Artist> artists) {
    final next = {...state.artistLikes};
    for (final artist in artists) {
      if (artist.isLiked && artist.likeId != null) {
        next[artist.id] = artist.likeId!;
      } else {
        next.remove(artist.id);
      }
    }
    if (!_mapsEqual(next, state.artistLikes)) {
      state = state.copyWith(artistLikes: next);
    }
  }

  void syncPlaylistsLikes(List<Playlist> playlists) {
    final next = {...state.playlistLikes};
    for (final playlist in playlists) {
      if (playlist.isLiked && playlist.likeId != null) {
        next[playlist.id] = playlist.likeId!;
      } else {
        next.remove(playlist.id);
      }
    }
    if (!_mapsEqual(next, state.playlistLikes)) {
      state = state.copyWith(playlistLikes: next);
    }
  }

  void syncEpisodesLikes(List<Track> episodes) {
    final next = {...state.episodeLikes};
    for (final episode in episodes) {
      if (episode.isLiked && episode.likeId != null) {
        next[episode.id] = episode.likeId!;
      } else {
        next.remove(episode.id);
      }
    }
    if (!_mapsEqual(next, state.episodeLikes)) {
      state = state.copyWith(episodeLikes: next);
    }
  }

  // === Clear (on logout) ===

  void clear() {
    state = const LikeRegistryState();
  }

  // === Init (eager-load all "My X" endpoints on session start) ===

  /// Loads page 1 of every "My X" endpoint in parallel. Each repo syncs the
  /// registry as a side effect. Individual failures are swallowed so one bad
  /// endpoint doesn't block the others.
  Future<void> initSession() async {
    Future<void> safe(Future Function() fn) async {
      try {
        await fn();
      } catch (_) {
        // ignore — partial population is fine
      }
    }

    await Future.wait([
      safe(() => ref.read(albumsRepositoryProvider).getFavoriteAlbums(page: 1)),
      safe(() => ref.read(programsRepositoryProvider).getFavoritePrograms(page: 1)),
      safe(() => ref.read(artistsRepositoryProvider).getFavoriteArtists(page: 1)),
      safe(() =>
          ref.read(featuredPlaylistRepositoryProvider).getLikedFeaturedPlaylists()),
      safe(() =>
          ref.read(featuredPlaylistRepositoryProvider).getFavoriteTracks(page: 1)),
      safe(() => ref.read(episodesRepositoryProvider).getFavoriteEpisodes(page: 1)),
    ]);
  }

  // === Helpers ===

  bool _mapsEqual(Map<String, String?> a, Map<String, String?> b) {
    if (a.length != b.length) return false;
    for (final entry in a.entries) {
      if (!b.containsKey(entry.key)) return false;
      if (b[entry.key] != entry.value) return false;
    }
    return true;
  }
}

final likeRegistryProvider =
    NotifierProvider<LikeRegistry, LikeRegistryState>(LikeRegistry.new);
