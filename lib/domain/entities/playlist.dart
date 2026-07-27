import 'package:freezed_annotation/freezed_annotation.dart';

part 'playlist.freezed.dart';

enum PlaylistType { featured, custom }

@freezed
class Playlist with _$Playlist {
  const factory Playlist({
    required String id,
    required String title,
    required String imageUrl,
    required int trackCount,
    @Default([]) List<String> trackDocIds,
    @Default(PlaylistType.featured) PlaylistType type,
    String? likeId,
    // Момент попадания в списки пользователя: для кастомного — время создания,
    // для лайкнутого — время лайка. Используется для хронологической сортировки
    // на экране My Playlists. Nullable для обратной совместимости со старыми
    // местами конструирования; в стейт всегда кладём заполненным.
    DateTime? createdAt,
  }) = _Playlist;
}
