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
    @Default([]) List<Album> likedAlbums,
    @Default([]) List<Track> likedTracks,
    @Default([]) List<Program> likedPrograms,
    @Default([]) List<Artist> likedArtists,
    @Default([]) List<Playlist> likedPlaylists,
    @Default([]) List<Track> likedEpisodes,
  }) = _LikeRegistryState;
}

class LikeRegistry extends Notifier<LikeRegistryState> {
  @override
  LikeRegistryState build() => const LikeRegistryState();

  // === Toggle by entity (optimistic + repo + rollback) ===

  Future<void> toggleAlbumLike(Album album) async {
    final idx = state.likedAlbums.indexWhere((a) => a.id == album.id);
    final prevList = state.likedAlbums;

    if (idx >= 0) {
      // Unlike
      final existing = prevList[idx];
      state = state.copyWith(
        likedAlbums: prevList.where((a) => a.id != album.id).toList(),
      );
      try {
        await ref
            .read(albumsRepositoryProvider)
            .toggleLike(album.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedAlbums: prevList);
        rethrow;
      }
    } else {
      // Like
      state = state.copyWith(likedAlbums: [...prevList, album]);
      try {
        final newLikeId =
            await ref.read(albumsRepositoryProvider).toggleLike(album.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedAlbums: state.likedAlbums
                .map((a) => a.id == album.id ? album.copyWith(likeId: newLikeId) : a)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedAlbums: prevList);
        rethrow;
      }
    }
  }

  Future<void> toggleTrackLike(Track track) async {
    final idx = state.likedTracks.indexWhere((t) => t.id == track.id);
    final prevList = state.likedTracks;

    if (idx >= 0) {
      final existing = prevList[idx];
      state = state.copyWith(
        likedTracks: prevList.where((t) => t.id != track.id).toList(),
      );
      try {
        await ref
            .read(featuredPlaylistRepositoryProvider)
            .toggleLikeTrack(track.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedTracks: prevList);
        rethrow;
      }
    } else {
      state = state.copyWith(likedTracks: [...prevList, track]);
      try {
        final newLikeId = await ref
            .read(featuredPlaylistRepositoryProvider)
            .toggleLikeTrack(track.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedTracks: state.likedTracks
                .map((t) => t.id == track.id ? track.copyWith(likeId: newLikeId) : t)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedTracks: prevList);
        rethrow;
      }
    }
  }

  Future<void> toggleProgramLike(Program program) async {
    final idx = state.likedPrograms.indexWhere((p) => p.id == program.id);
    final prevList = state.likedPrograms;

    if (idx >= 0) {
      final existing = prevList[idx];
      state = state.copyWith(
        likedPrograms: prevList.where((p) => p.id != program.id).toList(),
      );
      try {
        await ref
            .read(programsRepositoryProvider)
            .toggleLike(program.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedPrograms: prevList);
        rethrow;
      }
    } else {
      state = state.copyWith(likedPrograms: [...prevList, program]);
      try {
        final newLikeId = await ref
            .read(programsRepositoryProvider)
            .toggleLike(program.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedPrograms: state.likedPrograms
                .map((p) => p.id == program.id ? program.copyWith(likeId: newLikeId) : p)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedPrograms: prevList);
        rethrow;
      }
    }
  }

  Future<void> toggleArtistLike(Artist artist) async {
    final idx = state.likedArtists.indexWhere((a) => a.id == artist.id);
    final prevList = state.likedArtists;

    if (idx >= 0) {
      final existing = prevList[idx];
      state = state.copyWith(
        likedArtists: prevList.where((a) => a.id != artist.id).toList(),
      );
      try {
        await ref
            .read(artistsRepositoryProvider)
            .toggleLike(artist.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedArtists: prevList);
        rethrow;
      }
    } else {
      state = state.copyWith(likedArtists: [...prevList, artist]);
      try {
        final newLikeId = await ref
            .read(artistsRepositoryProvider)
            .toggleLike(artist.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedArtists: state.likedArtists
                .map((a) => a.id == artist.id ? artist.copyWith(likeId: newLikeId) : a)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedArtists: prevList);
        rethrow;
      }
    }
  }

  Future<void> togglePlaylistLike(Playlist playlist) async {
    final idx = state.likedPlaylists.indexWhere((p) => p.id == playlist.id);
    final prevList = state.likedPlaylists;

    if (idx >= 0) {
      final existing = prevList[idx];
      state = state.copyWith(
        likedPlaylists: prevList.where((p) => p.id != playlist.id).toList(),
      );
      try {
        await ref
            .read(featuredPlaylistRepositoryProvider)
            .toggleLike(playlist.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedPlaylists: prevList);
        rethrow;
      }
    } else {
      state = state.copyWith(likedPlaylists: [...prevList, playlist]);
      try {
        final newLikeId = await ref
            .read(featuredPlaylistRepositoryProvider)
            .toggleLike(playlist.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedPlaylists: state.likedPlaylists
                .map((p) => p.id == playlist.id ? playlist.copyWith(likeId: newLikeId) : p)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedPlaylists: prevList);
        rethrow;
      }
    }
  }

  Future<void> toggleEpisodeLike(Track episode) async {
    final idx = state.likedEpisodes.indexWhere((e) => e.id == episode.id);
    final prevList = state.likedEpisodes;

    if (idx >= 0) {
      final existing = prevList[idx];
      state = state.copyWith(
        likedEpisodes: prevList.where((e) => e.id != episode.id).toList(),
      );
      try {
        await ref
            .read(episodesRepositoryProvider)
            .toggleLikeEpisode(episode.id, existing.likeId);
      } catch (e) {
        state = state.copyWith(likedEpisodes: prevList);
        rethrow;
      }
    } else {
      state = state.copyWith(likedEpisodes: [...prevList, episode]);
      try {
        final newLikeId = await ref
            .read(episodesRepositoryProvider)
            .toggleLikeEpisode(episode.id, null);
        if (newLikeId != null) {
          state = state.copyWith(
            likedEpisodes: state.likedEpisodes
                .map((e) => e.id == episode.id ? episode.copyWith(likeId: newLikeId) : e)
                .toList(),
          );
        }
      } catch (e) {
        state = state.copyWith(likedEpisodes: prevList);
        rethrow;
      }
    }
  }

  // === Clear (on logout) ===

  void clear() {
    state = const LikeRegistryState();
  }

  // === Init (eager-load every "My X" endpoint on session start) ===

  /// Loads every page of every "My X" endpoint in parallel and merges into
  /// the registry. Individual failures are swallowed so one bad endpoint
  /// doesn't block the others.
  Future<void> initSession() async {
    Future<void> safe(Future Function() fn) async {
      try {
        await fn();
      } catch (_) {
        // ignore — partial population is fine
      }
    }

    await Future.wait([
      safe(() => _loadAllPages(
            (page) => ref.read(albumsRepositoryProvider).getFavoriteAlbums(page: page),
            _mergeAlbums,
          )),
      safe(() => _loadAllPages(
            (page) => ref.read(programsRepositoryProvider).getFavoritePrograms(page: page),
            _mergePrograms,
          )),
      safe(() => _loadAllPages(
            (page) => ref.read(artistsRepositoryProvider).getFavoriteArtists(page: page),
            _mergeArtists,
          )),
      safe(() async {
        final playlists = await ref
            .read(featuredPlaylistRepositoryProvider)
            .getLikedFeaturedPlaylists();
        _mergePlaylists(playlists);
      }),
      safe(() => _loadAllPages(
            (page) => ref.read(featuredPlaylistRepositoryProvider).getFavoriteTracks(page: page),
            _mergeTracks,
          )),
      safe(() => _loadAllPages(
            (page) => ref.read(episodesRepositoryProvider).getFavoriteEpisodes(page: page),
            _mergeEpisodes,
          )),
    ]);
  }

  /// Loops through pages of a paginated favorites endpoint until exhausted,
  /// merging each page's items into the registry via [merge].
  Future<void> _loadAllPages<T>(
    Future<({List<T> items, bool hasMore})> Function(int page) fetch,
    void Function(List<T> items) merge,
  ) async {
    var page = 1;
    while (true) {
      final result = await fetch(page);
      merge(result.items);
      if (!result.hasMore) break;
      page++;
    }
  }

  // === Merge (private — append-or-update by id) ===

  void _mergeAlbums(List<Album> albums) {
    final next = [...state.likedAlbums];
    for (final album in albums) {
      final idx = next.indexWhere((a) => a.id == album.id);
      if (idx >= 0) {
        next[idx] = album;
      } else {
        next.add(album);
      }
    }
    state = state.copyWith(likedAlbums: next);
  }

  void _mergeTracks(List<Track> tracks) {
    final next = [...state.likedTracks];
    for (final track in tracks) {
      final idx = next.indexWhere((t) => t.id == track.id);
      if (idx >= 0) {
        next[idx] = track;
      } else {
        next.add(track);
      }
    }
    state = state.copyWith(likedTracks: next);
  }

  void _mergePrograms(List<Program> programs) {
    final next = [...state.likedPrograms];
    for (final program in programs) {
      final idx = next.indexWhere((p) => p.id == program.id);
      if (idx >= 0) {
        next[idx] = program;
      } else {
        next.add(program);
      }
    }
    state = state.copyWith(likedPrograms: next);
  }

  void _mergeArtists(List<Artist> artists) {
    final next = [...state.likedArtists];
    for (final artist in artists) {
      final idx = next.indexWhere((a) => a.id == artist.id);
      if (idx >= 0) {
        next[idx] = artist;
      } else {
        next.add(artist);
      }
    }
    state = state.copyWith(likedArtists: next);
  }

  void _mergePlaylists(List<Playlist> playlists) {
    final next = [...state.likedPlaylists];
    for (final playlist in playlists) {
      final idx = next.indexWhere((p) => p.id == playlist.id);
      if (idx >= 0) {
        next[idx] = playlist;
      } else {
        next.add(playlist);
      }
    }
    state = state.copyWith(likedPlaylists: next);
  }

  void _mergeEpisodes(List<Track> episodes) {
    final next = [...state.likedEpisodes];
    for (final episode in episodes) {
      final idx = next.indexWhere((e) => e.id == episode.id);
      if (idx >= 0) {
        next[idx] = episode;
      } else {
        next.add(episode);
      }
    }
    state = state.copyWith(likedEpisodes: next);
  }
}

final likeRegistryProvider =
    NotifierProvider<LikeRegistry, LikeRegistryState>(LikeRegistry.new);
