import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/album.dart';
import '../entities/artist.dart';
import '../entities/playlist.dart';
import '../entities/program.dart';
import '../entities/track.dart';

part 'like_registry.freezed.dart';

@freezed
class LikeRegistryState with _$LikeRegistryState {
  const factory LikeRegistryState({
    @Default({}) Map<String, String> albumLikes,
    @Default({}) Map<String, String> trackLikes,
    @Default({}) Map<String, String> programLikes,
    @Default({}) Map<String, String> artistLikes,
    @Default({}) Map<String, String> playlistLikes,
    @Default({}) Map<String, String> episodeLikes,
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

  // === Mark (point updates after backend success) ===

  void markAlbumLiked(String id, String likeId) {
    state = state.copyWith(albumLikes: {...state.albumLikes, id: likeId});
  }

  void markAlbumUnliked(String id) {
    if (!state.albumLikes.containsKey(id)) return;
    final next = {...state.albumLikes}..remove(id);
    state = state.copyWith(albumLikes: next);
  }

  void markTrackLiked(String id, String likeId) {
    state = state.copyWith(trackLikes: {...state.trackLikes, id: likeId});
  }

  void markTrackUnliked(String id) {
    if (!state.trackLikes.containsKey(id)) return;
    final next = {...state.trackLikes}..remove(id);
    state = state.copyWith(trackLikes: next);
  }

  void markProgramLiked(String id, String likeId) {
    state = state.copyWith(programLikes: {...state.programLikes, id: likeId});
  }

  void markProgramUnliked(String id) {
    if (!state.programLikes.containsKey(id)) return;
    final next = {...state.programLikes}..remove(id);
    state = state.copyWith(programLikes: next);
  }

  void markArtistLiked(String id, String likeId) {
    state = state.copyWith(artistLikes: {...state.artistLikes, id: likeId});
  }

  void markArtistUnliked(String id) {
    if (!state.artistLikes.containsKey(id)) return;
    final next = {...state.artistLikes}..remove(id);
    state = state.copyWith(artistLikes: next);
  }

  void markPlaylistLiked(String id, String likeId) {
    state = state.copyWith(playlistLikes: {...state.playlistLikes, id: likeId});
  }

  void markPlaylistUnliked(String id) {
    if (!state.playlistLikes.containsKey(id)) return;
    final next = {...state.playlistLikes}..remove(id);
    state = state.copyWith(playlistLikes: next);
  }

  void markEpisodeLiked(String id, String likeId) {
    state = state.copyWith(episodeLikes: {...state.episodeLikes, id: likeId});
  }

  void markEpisodeUnliked(String id) {
    if (!state.episodeLikes.containsKey(id)) return;
    final next = {...state.episodeLikes}..remove(id);
    state = state.copyWith(episodeLikes: next);
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

  bool _mapsEqual(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (final entry in a.entries) {
      if (b[entry.key] != entry.value) return false;
    }
    return true;
  }
}

final likeRegistryProvider =
    NotifierProvider<LikeRegistry, LikeRegistryState>(LikeRegistry.new);

// === Extensions: apply likes map to a list of entities ===
// Subscribers in list-holding controllers use these to patch their state
// when the registry changes. Returns the same list instance if nothing
// changed, so callers can short-circuit state updates.

extension AlbumListLikeSync on List<Album> {
  List<Album> withLikes(Map<String, String> likes) {
    var changed = false;
    final next = map((a) {
      final liked = likes.containsKey(a.id);
      final likeId = likes[a.id];
      if (a.isLiked == liked && a.likeId == likeId) return a;
      changed = true;
      return a.copyWith(isLiked: liked, likeId: likeId);
    }).toList();
    return changed ? next : this;
  }
}

extension TrackListLikeSync on List<Track> {
  List<Track> withLikes(Map<String, String> likes) {
    var changed = false;
    final next = map((t) {
      final liked = likes.containsKey(t.id);
      final likeId = likes[t.id];
      if (t.isLiked == liked && t.likeId == likeId) return t;
      changed = true;
      return t.copyWith(isLiked: liked, likeId: likeId);
    }).toList();
    return changed ? next : this;
  }
}

extension ProgramListLikeSync on List<Program> {
  List<Program> withLikes(Map<String, String> likes) {
    var changed = false;
    final next = map((p) {
      final liked = likes.containsKey(p.id);
      final likeId = likes[p.id];
      if (p.isLiked == liked && p.likeId == likeId) return p;
      changed = true;
      return p.copyWith(isLiked: liked, likeId: likeId);
    }).toList();
    return changed ? next : this;
  }
}

extension ArtistListLikeSync on List<Artist> {
  List<Artist> withLikes(Map<String, String> likes) {
    var changed = false;
    final next = map((a) {
      final liked = likes.containsKey(a.id);
      final likeId = likes[a.id];
      if (a.isLiked == liked && a.likeId == likeId) return a;
      changed = true;
      return a.copyWith(isLiked: liked, likeId: likeId);
    }).toList();
    return changed ? next : this;
  }
}

extension PlaylistListLikeSync on List<Playlist> {
  List<Playlist> withLikes(Map<String, String> likes) {
    var changed = false;
    final next = map((p) {
      final liked = likes.containsKey(p.id);
      final likeId = likes[p.id];
      if (p.isLiked == liked && p.likeId == likeId) return p;
      changed = true;
      return p.copyWith(isLiked: liked, likeId: likeId);
    }).toList();
    return changed ? next : this;
  }
}
