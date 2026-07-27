import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/track.dart';
import '../../domain/entities/artist.dart';

/// Provides the singleton [PlayerSessionStorage].
/// Must be overridden in main.dart with the initialized instance.
final playerSessionStorageProvider = Provider<PlayerSessionStorage>(
  (_) => throw UnimplementedError(
    'playerSessionStorageProvider must be overridden in ProviderScope',
  ),
);

/// Serializable snapshot of the music queue, persisted across app restarts.
/// Not a live [PlayerState] — only the fields needed to rebuild the queue.
///
/// Position is NOT part of this snapshot: it changes constantly and is stored
/// under a separate key (a single int) so the frequent position writes don't
/// re-serialize the whole track list. The two are merged on restore.
///
/// [source] is kept as flat fields (not a QueueSource) so this file does not
/// import player_state.dart — that would create a circular import. The notifier
/// maps between these fields and QueueSource.
class PlayerSession {
  final List<Track> tracks;
  final int currentIndex;
  final String sourceType;
  final String sourceId;
  final String sourceTitle;
  final String sourceImageUrl;

  const PlayerSession({
    required this.tracks,
    required this.currentIndex,
    required this.sourceType,
    required this.sourceId,
    required this.sourceTitle,
    required this.sourceImageUrl,
  });

  String toJson() => jsonEncode({
        'tracks': tracks.map(_trackToMap).toList(),
        'currentIndex': currentIndex,
        'sourceType': sourceType,
        'sourceId': sourceId,
        'sourceTitle': sourceTitle,
        'sourceImageUrl': sourceImageUrl,
      });

  static PlayerSession fromJson(String raw) {
    final m = jsonDecode(raw) as Map<String, dynamic>;
    return PlayerSession(
      tracks: (m['tracks'] as List)
          .map((e) => _trackFromMap(e as Map<String, dynamic>))
          .toList(),
      currentIndex: m['currentIndex'] as int,
      sourceType: m['sourceType'] as String,
      sourceId: m['sourceId'] as String,
      sourceTitle: m['sourceTitle'] as String,
      sourceImageUrl: m['sourceImageUrl'] as String,
    );
  }

  static Map<String, dynamic> _trackToMap(Track t) => {
        'id': t.id,
        'title': t.title,
        'artists': t.artists
            .map((a) => {
                  'id': a.id,
                  'artistName': a.artistName,
                  'imageUrl': a.imageUrl,
                  'likeId': a.likeId,
                })
            .toList(),
        'imageUrl': t.imageUrl,
        'durationMs': t.duration.inMilliseconds,
        'audioUrl': t.audioUrl,
        'releaseDate': t.releaseDate?.toIso8601String(),
        'year': t.year,
        'likeId': t.likeId,
      };

  static Track _trackFromMap(Map<String, dynamic> m) {
    final artistsList = (m['artists'] as List?)
            ?.map((a) => Artist(
                  id: a['id'] as String,
                  artistName: a['artistName'] as String,
                  imageUrl: a['imageUrl'] as String,
                  likeId: a['likeId'] as String?,
                ))
            .toList() ??
        [];

    return Track(
      id: m['id'] as String,
      title: m['title'] as String,
      artists: artistsList,
      imageUrl: m['imageUrl'] as String?,
      duration: Duration(milliseconds: m['durationMs'] as int),
      audioUrl: m['audioUrl'] as String,
      releaseDate: m['releaseDate'] != null
          ? DateTime.parse(m['releaseDate'] as String)
          : null,
      year: m['year'] as int?,
      likeId: m['likeId'] as String?,
    );
  }
}

/// Wrapper over SharedPreferences that persists the last player session.
/// Two keys in one store: the heavy queue snapshot (written rarely) and the
/// playback position as a single int (written often). Hides both, plus the
/// JSON (de)serialization, from consumers.
class PlayerSessionStorage {
  static const _sessionKey = 'player_session';
  static const _positionKey = 'player_position';

  SharedPreferences? _prefs;
  PlayerSession? _cachedSession;
  Duration _cachedPosition = Duration.zero;

  /// Last persisted queue snapshot, or null. Synchronous after [init].
  PlayerSession? get session => _cachedSession;

  /// Last persisted playback position. Synchronous after [init].
  Duration get position => _cachedPosition;

  /// Load persisted state into memory. Call once in main() before runApp.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    final raw = _prefs!.getString(_sessionKey);
    if (raw != null) {
      try {
        _cachedSession = PlayerSession.fromJson(raw);
      } catch (_) {
        // Corrupt or outdated snapshot — drop everything, never crash startup.
        await clear();
        return;
      }
    }
    _cachedPosition = Duration(milliseconds: _prefs!.getInt(_positionKey) ?? 0);
  }

  /// Persist the queue snapshot (rare — on queue/track change).
  Future<void> saveSession(PlayerSession session) async {
    _cachedSession = session;
    await _prefs!.setString(_sessionKey, session.toJson());
  }

  /// Persist the playback position (frequent — a single int).
  Future<void> savePosition(Duration position) async {
    _cachedPosition = position;
    await _prefs!.setInt(_positionKey, position.inMilliseconds);
  }

  Future<void> clear() async {
    _cachedSession = null;
    _cachedPosition = Duration.zero;
    await _prefs?.remove(_sessionKey);
    await _prefs?.remove(_positionKey);
  }
}
