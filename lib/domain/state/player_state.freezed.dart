// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$QueueSource {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSourceCopyWith<QueueSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSourceCopyWith<$Res> {
  factory $QueueSourceCopyWith(
    QueueSource value,
    $Res Function(QueueSource) then,
  ) = _$QueueSourceCopyWithImpl<$Res, QueueSource>;
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class _$QueueSourceCopyWithImpl<$Res, $Val extends QueueSource>
    implements $QueueSourceCopyWith<$Res> {
  _$QueueSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$QueueSourceAlbumImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourceAlbumImplCopyWith(
    _$QueueSourceAlbumImpl value,
    $Res Function(_$QueueSourceAlbumImpl) then,
  ) = __$$QueueSourceAlbumImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$QueueSourceAlbumImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourceAlbumImpl>
    implements _$$QueueSourceAlbumImplCopyWith<$Res> {
  __$$QueueSourceAlbumImplCopyWithImpl(
    _$QueueSourceAlbumImpl _value,
    $Res Function(_$QueueSourceAlbumImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourceAlbumImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QueueSourceAlbumImpl implements QueueSourceAlbum {
  const _$QueueSourceAlbumImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.album(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourceAlbumImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourceAlbumImplCopyWith<_$QueueSourceAlbumImpl> get copyWith =>
      __$$QueueSourceAlbumImplCopyWithImpl<_$QueueSourceAlbumImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) {
    return album(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) {
    return album?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) {
    if (album != null) {
      return album(id, title, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) {
    return album(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) {
    return album?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) {
    if (album != null) {
      return album(this);
    }
    return orElse();
  }
}

abstract class QueueSourceAlbum implements QueueSource {
  const factory QueueSourceAlbum({
    required final String id,
    required final String title,
    required final String imageUrl,
  }) = _$QueueSourceAlbumImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourceAlbumImplCopyWith<_$QueueSourceAlbumImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueSourcePlaylistImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourcePlaylistImplCopyWith(
    _$QueueSourcePlaylistImpl value,
    $Res Function(_$QueueSourcePlaylistImpl) then,
  ) = __$$QueueSourcePlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$QueueSourcePlaylistImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourcePlaylistImpl>
    implements _$$QueueSourcePlaylistImplCopyWith<$Res> {
  __$$QueueSourcePlaylistImplCopyWithImpl(
    _$QueueSourcePlaylistImpl _value,
    $Res Function(_$QueueSourcePlaylistImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourcePlaylistImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QueueSourcePlaylistImpl implements QueueSourcePlaylist {
  const _$QueueSourcePlaylistImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.playlist(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourcePlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourcePlaylistImplCopyWith<_$QueueSourcePlaylistImpl> get copyWith =>
      __$$QueueSourcePlaylistImplCopyWithImpl<_$QueueSourcePlaylistImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) {
    return playlist(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) {
    return playlist?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) {
    if (playlist != null) {
      return playlist(id, title, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) {
    return playlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) {
    return playlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) {
    if (playlist != null) {
      return playlist(this);
    }
    return orElse();
  }
}

abstract class QueueSourcePlaylist implements QueueSource {
  const factory QueueSourcePlaylist({
    required final String id,
    required final String title,
    required final String imageUrl,
  }) = _$QueueSourcePlaylistImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourcePlaylistImplCopyWith<_$QueueSourcePlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueSourceProgramImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourceProgramImplCopyWith(
    _$QueueSourceProgramImpl value,
    $Res Function(_$QueueSourceProgramImpl) then,
  ) = __$$QueueSourceProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$QueueSourceProgramImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourceProgramImpl>
    implements _$$QueueSourceProgramImplCopyWith<$Res> {
  __$$QueueSourceProgramImplCopyWithImpl(
    _$QueueSourceProgramImpl _value,
    $Res Function(_$QueueSourceProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourceProgramImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QueueSourceProgramImpl implements QueueSourceProgram {
  const _$QueueSourceProgramImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.program(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourceProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourceProgramImplCopyWith<_$QueueSourceProgramImpl> get copyWith =>
      __$$QueueSourceProgramImplCopyWithImpl<_$QueueSourceProgramImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) {
    return program(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) {
    return program?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) {
    if (program != null) {
      return program(id, title, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) {
    return program(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) {
    return program?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) {
    if (program != null) {
      return program(this);
    }
    return orElse();
  }
}

abstract class QueueSourceProgram implements QueueSource {
  const factory QueueSourceProgram({
    required final String id,
    required final String title,
    required final String imageUrl,
  }) = _$QueueSourceProgramImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourceProgramImplCopyWith<_$QueueSourceProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueSourceFavoritesImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourceFavoritesImplCopyWith(
    _$QueueSourceFavoritesImpl value,
    $Res Function(_$QueueSourceFavoritesImpl) then,
  ) = __$$QueueSourceFavoritesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$QueueSourceFavoritesImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourceFavoritesImpl>
    implements _$$QueueSourceFavoritesImplCopyWith<$Res> {
  __$$QueueSourceFavoritesImplCopyWithImpl(
    _$QueueSourceFavoritesImpl _value,
    $Res Function(_$QueueSourceFavoritesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourceFavoritesImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QueueSourceFavoritesImpl implements QueueSourceFavorites {
  const _$QueueSourceFavoritesImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.favorites(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourceFavoritesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourceFavoritesImplCopyWith<_$QueueSourceFavoritesImpl>
  get copyWith =>
      __$$QueueSourceFavoritesImplCopyWithImpl<_$QueueSourceFavoritesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) {
    return favorites(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) {
    return favorites?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) {
    if (favorites != null) {
      return favorites(id, title, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) {
    return favorites(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) {
    return favorites?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) {
    if (favorites != null) {
      return favorites(this);
    }
    return orElse();
  }
}

abstract class QueueSourceFavorites implements QueueSource {
  const factory QueueSourceFavorites({
    required final String id,
    required final String title,
    required final String imageUrl,
  }) = _$QueueSourceFavoritesImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourceFavoritesImplCopyWith<_$QueueSourceFavoritesImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueSourceEpisodesImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourceEpisodesImplCopyWith(
    _$QueueSourceEpisodesImpl value,
    $Res Function(_$QueueSourceEpisodesImpl) then,
  ) = __$$QueueSourceEpisodesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String imageUrl});
}

/// @nodoc
class __$$QueueSourceEpisodesImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourceEpisodesImpl>
    implements _$$QueueSourceEpisodesImplCopyWith<$Res> {
  __$$QueueSourceEpisodesImplCopyWithImpl(
    _$QueueSourceEpisodesImpl _value,
    $Res Function(_$QueueSourceEpisodesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourceEpisodesImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$QueueSourceEpisodesImpl implements QueueSourceEpisodes {
  const _$QueueSourceEpisodesImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.episodes(id: $id, title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourceEpisodesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, title, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourceEpisodesImplCopyWith<_$QueueSourceEpisodesImpl> get copyWith =>
      __$$QueueSourceEpisodesImplCopyWithImpl<_$QueueSourceEpisodesImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String id, String title, String imageUrl)
    favorites,
    required TResult Function(String id, String title, String imageUrl)
    episodes,
  }) {
    return episodes(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String id, String title, String imageUrl)? favorites,
    TResult? Function(String id, String title, String imageUrl)? episodes,
  }) {
    return episodes?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String id, String title, String imageUrl)? favorites,
    TResult Function(String id, String title, String imageUrl)? episodes,
    required TResult orElse(),
  }) {
    if (episodes != null) {
      return episodes(id, title, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceFavorites value) favorites,
    required TResult Function(QueueSourceEpisodes value) episodes,
  }) {
    return episodes(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceFavorites value)? favorites,
    TResult? Function(QueueSourceEpisodes value)? episodes,
  }) {
    return episodes?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceFavorites value)? favorites,
    TResult Function(QueueSourceEpisodes value)? episodes,
    required TResult orElse(),
  }) {
    if (episodes != null) {
      return episodes(this);
    }
    return orElse();
  }
}

abstract class QueueSourceEpisodes implements QueueSource {
  const factory QueueSourceEpisodes({
    required final String id,
    required final String title,
    required final String imageUrl,
  }) = _$QueueSourceEpisodesImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourceEpisodesImplCopyWith<_$QueueSourceEpisodesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerState {
  // Playback mode
  PlaybackMode get mode => throw _privateConstructorUsedError; // Queue (Music)
  List<Track> get tracks => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  QueueSource? get source => throw _privateConstructorUsedError; // Playback
  PlayerStatus get status => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get bufferedPosition => throw _privateConstructorUsedError;
  Duration get totalDuration =>
      throw _privateConstructorUsedError; // Shuffle & Repeat
  bool get shuffleEnabled => throw _privateConstructorUsedError;
  RepeatMode get repeatMode => throw _privateConstructorUsedError;
  List<int>? get shuffleIndices => throw _privateConstructorUsedError; // Radio
  String? get radioTitle => throw _privateConstructorUsedError;
  String? get radioStreamUrl => throw _privateConstructorUsedError;
  String? get radioImageUrl => throw _privateConstructorUsedError;
  String? get radioNowPlaying =>
      throw _privateConstructorUsedError; // "Artist - Song Name" from ICY metadata
  // Error
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
    PlayerState value,
    $Res Function(PlayerState) then,
  ) = _$PlayerStateCopyWithImpl<$Res, PlayerState>;
  @useResult
  $Res call({
    PlaybackMode mode,
    List<Track> tracks,
    int currentIndex,
    QueueSource? source,
    PlayerStatus status,
    Duration position,
    Duration bufferedPosition,
    Duration totalDuration,
    bool shuffleEnabled,
    RepeatMode repeatMode,
    List<int>? shuffleIndices,
    String? radioTitle,
    String? radioStreamUrl,
    String? radioImageUrl,
    String? radioNowPlaying,
    String? errorMessage,
  });

  $QueueSourceCopyWith<$Res>? get source;
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res, $Val extends PlayerState>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tracks = null,
    Object? currentIndex = null,
    Object? source = freezed,
    Object? status = null,
    Object? position = null,
    Object? bufferedPosition = null,
    Object? totalDuration = null,
    Object? shuffleEnabled = null,
    Object? repeatMode = null,
    Object? shuffleIndices = freezed,
    Object? radioTitle = freezed,
    Object? radioStreamUrl = freezed,
    Object? radioImageUrl = freezed,
    Object? radioNowPlaying = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            mode: null == mode
                ? _value.mode
                : mode // ignore: cast_nullable_to_non_nullable
                      as PlaybackMode,
            tracks: null == tracks
                ? _value.tracks
                : tracks // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
            currentIndex: null == currentIndex
                ? _value.currentIndex
                : currentIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            source: freezed == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as QueueSource?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PlayerStatus,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as Duration,
            bufferedPosition: null == bufferedPosition
                ? _value.bufferedPosition
                : bufferedPosition // ignore: cast_nullable_to_non_nullable
                      as Duration,
            totalDuration: null == totalDuration
                ? _value.totalDuration
                : totalDuration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            shuffleEnabled: null == shuffleEnabled
                ? _value.shuffleEnabled
                : shuffleEnabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            repeatMode: null == repeatMode
                ? _value.repeatMode
                : repeatMode // ignore: cast_nullable_to_non_nullable
                      as RepeatMode,
            shuffleIndices: freezed == shuffleIndices
                ? _value.shuffleIndices
                : shuffleIndices // ignore: cast_nullable_to_non_nullable
                      as List<int>?,
            radioTitle: freezed == radioTitle
                ? _value.radioTitle
                : radioTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            radioStreamUrl: freezed == radioStreamUrl
                ? _value.radioStreamUrl
                : radioStreamUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            radioImageUrl: freezed == radioImageUrl
                ? _value.radioImageUrl
                : radioImageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            radioNowPlaying: freezed == radioNowPlaying
                ? _value.radioNowPlaying
                : radioNowPlaying // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueSourceCopyWith<$Res>? get source {
    if (_value.source == null) {
      return null;
    }

    return $QueueSourceCopyWith<$Res>(_value.source!, (value) {
      return _then(_value.copyWith(source: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStateImplCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$$PlayerStateImplCopyWith(
    _$PlayerStateImpl value,
    $Res Function(_$PlayerStateImpl) then,
  ) = __$$PlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PlaybackMode mode,
    List<Track> tracks,
    int currentIndex,
    QueueSource? source,
    PlayerStatus status,
    Duration position,
    Duration bufferedPosition,
    Duration totalDuration,
    bool shuffleEnabled,
    RepeatMode repeatMode,
    List<int>? shuffleIndices,
    String? radioTitle,
    String? radioStreamUrl,
    String? radioImageUrl,
    String? radioNowPlaying,
    String? errorMessage,
  });

  @override
  $QueueSourceCopyWith<$Res>? get source;
}

/// @nodoc
class __$$PlayerStateImplCopyWithImpl<$Res>
    extends _$PlayerStateCopyWithImpl<$Res, _$PlayerStateImpl>
    implements _$$PlayerStateImplCopyWith<$Res> {
  __$$PlayerStateImplCopyWithImpl(
    _$PlayerStateImpl _value,
    $Res Function(_$PlayerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mode = null,
    Object? tracks = null,
    Object? currentIndex = null,
    Object? source = freezed,
    Object? status = null,
    Object? position = null,
    Object? bufferedPosition = null,
    Object? totalDuration = null,
    Object? shuffleEnabled = null,
    Object? repeatMode = null,
    Object? shuffleIndices = freezed,
    Object? radioTitle = freezed,
    Object? radioStreamUrl = freezed,
    Object? radioImageUrl = freezed,
    Object? radioNowPlaying = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$PlayerStateImpl(
        mode: null == mode
            ? _value.mode
            : mode // ignore: cast_nullable_to_non_nullable
                  as PlaybackMode,
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
        currentIndex: null == currentIndex
            ? _value.currentIndex
            : currentIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        source: freezed == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as QueueSource?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PlayerStatus,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as Duration,
        bufferedPosition: null == bufferedPosition
            ? _value.bufferedPosition
            : bufferedPosition // ignore: cast_nullable_to_non_nullable
                  as Duration,
        totalDuration: null == totalDuration
            ? _value.totalDuration
            : totalDuration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        shuffleEnabled: null == shuffleEnabled
            ? _value.shuffleEnabled
            : shuffleEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        repeatMode: null == repeatMode
            ? _value.repeatMode
            : repeatMode // ignore: cast_nullable_to_non_nullable
                  as RepeatMode,
        shuffleIndices: freezed == shuffleIndices
            ? _value._shuffleIndices
            : shuffleIndices // ignore: cast_nullable_to_non_nullable
                  as List<int>?,
        radioTitle: freezed == radioTitle
            ? _value.radioTitle
            : radioTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        radioStreamUrl: freezed == radioStreamUrl
            ? _value.radioStreamUrl
            : radioStreamUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        radioImageUrl: freezed == radioImageUrl
            ? _value.radioImageUrl
            : radioImageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        radioNowPlaying: freezed == radioNowPlaying
            ? _value.radioNowPlaying
            : radioNowPlaying // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PlayerStateImpl implements _PlayerState {
  const _$PlayerStateImpl({
    this.mode = PlaybackMode.music,
    final List<Track> tracks = const [],
    this.currentIndex = 0,
    this.source,
    this.status = PlayerStatus.idle,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.shuffleEnabled = false,
    this.repeatMode = RepeatMode.off,
    final List<int>? shuffleIndices,
    this.radioTitle,
    this.radioStreamUrl,
    this.radioImageUrl,
    this.radioNowPlaying,
    this.errorMessage,
  }) : _tracks = tracks,
       _shuffleIndices = shuffleIndices;

  // Playback mode
  @override
  @JsonKey()
  final PlaybackMode mode;
  // Queue (Music)
  final List<Track> _tracks;
  // Queue (Music)
  @override
  @JsonKey()
  List<Track> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  @override
  @JsonKey()
  final int currentIndex;
  @override
  final QueueSource? source;
  // Playback
  @override
  @JsonKey()
  final PlayerStatus status;
  @override
  @JsonKey()
  final Duration position;
  @override
  @JsonKey()
  final Duration bufferedPosition;
  @override
  @JsonKey()
  final Duration totalDuration;
  // Shuffle & Repeat
  @override
  @JsonKey()
  final bool shuffleEnabled;
  @override
  @JsonKey()
  final RepeatMode repeatMode;
  final List<int>? _shuffleIndices;
  @override
  List<int>? get shuffleIndices {
    final value = _shuffleIndices;
    if (value == null) return null;
    if (_shuffleIndices is EqualUnmodifiableListView) return _shuffleIndices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  // Radio
  @override
  final String? radioTitle;
  @override
  final String? radioStreamUrl;
  @override
  final String? radioImageUrl;
  @override
  final String? radioNowPlaying;
  // "Artist - Song Name" from ICY metadata
  // Error
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PlayerState(mode: $mode, tracks: $tracks, currentIndex: $currentIndex, source: $source, status: $status, position: $position, bufferedPosition: $bufferedPosition, totalDuration: $totalDuration, shuffleEnabled: $shuffleEnabled, repeatMode: $repeatMode, shuffleIndices: $shuffleIndices, radioTitle: $radioTitle, radioStreamUrl: $radioStreamUrl, radioImageUrl: $radioImageUrl, radioNowPlaying: $radioNowPlaying, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            (identical(other.mode, mode) || other.mode == mode) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.bufferedPosition, bufferedPosition) ||
                other.bufferedPosition == bufferedPosition) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.shuffleEnabled, shuffleEnabled) ||
                other.shuffleEnabled == shuffleEnabled) &&
            (identical(other.repeatMode, repeatMode) ||
                other.repeatMode == repeatMode) &&
            const DeepCollectionEquality().equals(
              other._shuffleIndices,
              _shuffleIndices,
            ) &&
            (identical(other.radioTitle, radioTitle) ||
                other.radioTitle == radioTitle) &&
            (identical(other.radioStreamUrl, radioStreamUrl) ||
                other.radioStreamUrl == radioStreamUrl) &&
            (identical(other.radioImageUrl, radioImageUrl) ||
                other.radioImageUrl == radioImageUrl) &&
            (identical(other.radioNowPlaying, radioNowPlaying) ||
                other.radioNowPlaying == radioNowPlaying) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    mode,
    const DeepCollectionEquality().hash(_tracks),
    currentIndex,
    source,
    status,
    position,
    bufferedPosition,
    totalDuration,
    shuffleEnabled,
    repeatMode,
    const DeepCollectionEquality().hash(_shuffleIndices),
    radioTitle,
    radioStreamUrl,
    radioImageUrl,
    radioNowPlaying,
    errorMessage,
  );

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      __$$PlayerStateImplCopyWithImpl<_$PlayerStateImpl>(this, _$identity);
}

abstract class _PlayerState implements PlayerState {
  const factory _PlayerState({
    final PlaybackMode mode,
    final List<Track> tracks,
    final int currentIndex,
    final QueueSource? source,
    final PlayerStatus status,
    final Duration position,
    final Duration bufferedPosition,
    final Duration totalDuration,
    final bool shuffleEnabled,
    final RepeatMode repeatMode,
    final List<int>? shuffleIndices,
    final String? radioTitle,
    final String? radioStreamUrl,
    final String? radioImageUrl,
    final String? radioNowPlaying,
    final String? errorMessage,
  }) = _$PlayerStateImpl;

  // Playback mode
  @override
  PlaybackMode get mode; // Queue (Music)
  @override
  List<Track> get tracks;
  @override
  int get currentIndex;
  @override
  QueueSource? get source; // Playback
  @override
  PlayerStatus get status;
  @override
  Duration get position;
  @override
  Duration get bufferedPosition;
  @override
  Duration get totalDuration; // Shuffle & Repeat
  @override
  bool get shuffleEnabled;
  @override
  RepeatMode get repeatMode;
  @override
  List<int>? get shuffleIndices; // Radio
  @override
  String? get radioTitle;
  @override
  String? get radioStreamUrl;
  @override
  String? get radioImageUrl;
  @override
  String? get radioNowPlaying; // "Artist - Song Name" from ICY metadata
  // Error
  @override
  String? get errorMessage;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
