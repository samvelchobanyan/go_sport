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
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String imageUrl) album,
    required TResult Function(String id, String title, String imageUrl)
    playlist,
    required TResult Function(String id, String title, String imageUrl) program,
    required TResult Function(String title, String streamUrl, String imageUrl)
    radio,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String title, String streamUrl, String imageUrl)? radio,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String title, String streamUrl, String imageUrl)? radio,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceRadio value) radio,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceRadio value)? radio,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceRadio value)? radio,
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
  $Res call({String title, String imageUrl});
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
  $Res call({Object? title = null, Object? imageUrl = null}) {
    return _then(
      _value.copyWith(
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
    required TResult Function(String title, String streamUrl, String imageUrl)
    radio,
  }) {
    return album(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String title, String streamUrl, String imageUrl)? radio,
  }) {
    return album?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String title, String streamUrl, String imageUrl)? radio,
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
    required TResult Function(QueueSourceRadio value) radio,
  }) {
    return album(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceRadio value)? radio,
  }) {
    return album?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceRadio value)? radio,
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
    required TResult Function(String title, String streamUrl, String imageUrl)
    radio,
  }) {
    return playlist(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String title, String streamUrl, String imageUrl)? radio,
  }) {
    return playlist?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String title, String streamUrl, String imageUrl)? radio,
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
    required TResult Function(QueueSourceRadio value) radio,
  }) {
    return playlist(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceRadio value)? radio,
  }) {
    return playlist?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceRadio value)? radio,
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
    required TResult Function(String title, String streamUrl, String imageUrl)
    radio,
  }) {
    return program(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String title, String streamUrl, String imageUrl)? radio,
  }) {
    return program?.call(id, title, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String title, String streamUrl, String imageUrl)? radio,
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
    required TResult Function(QueueSourceRadio value) radio,
  }) {
    return program(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceRadio value)? radio,
  }) {
    return program?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceRadio value)? radio,
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
abstract class _$$QueueSourceRadioImplCopyWith<$Res>
    implements $QueueSourceCopyWith<$Res> {
  factory _$$QueueSourceRadioImplCopyWith(
    _$QueueSourceRadioImpl value,
    $Res Function(_$QueueSourceRadioImpl) then,
  ) = __$$QueueSourceRadioImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String streamUrl, String imageUrl});
}

/// @nodoc
class __$$QueueSourceRadioImplCopyWithImpl<$Res>
    extends _$QueueSourceCopyWithImpl<$Res, _$QueueSourceRadioImpl>
    implements _$$QueueSourceRadioImplCopyWith<$Res> {
  __$$QueueSourceRadioImplCopyWithImpl(
    _$QueueSourceRadioImpl _value,
    $Res Function(_$QueueSourceRadioImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? streamUrl = null,
    Object? imageUrl = null,
  }) {
    return _then(
      _$QueueSourceRadioImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        streamUrl: null == streamUrl
            ? _value.streamUrl
            : streamUrl // ignore: cast_nullable_to_non_nullable
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

class _$QueueSourceRadioImpl implements QueueSourceRadio {
  const _$QueueSourceRadioImpl({
    required this.title,
    required this.streamUrl,
    required this.imageUrl,
  });

  @override
  final String title;
  @override
  final String streamUrl;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'QueueSource.radio(title: $title, streamUrl: $streamUrl, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSourceRadioImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, streamUrl, imageUrl);

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSourceRadioImplCopyWith<_$QueueSourceRadioImpl> get copyWith =>
      __$$QueueSourceRadioImplCopyWithImpl<_$QueueSourceRadioImpl>(
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
    required TResult Function(String title, String streamUrl, String imageUrl)
    radio,
  }) {
    return radio(title, streamUrl, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String imageUrl)? album,
    TResult? Function(String id, String title, String imageUrl)? playlist,
    TResult? Function(String id, String title, String imageUrl)? program,
    TResult? Function(String title, String streamUrl, String imageUrl)? radio,
  }) {
    return radio?.call(title, streamUrl, imageUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String imageUrl)? album,
    TResult Function(String id, String title, String imageUrl)? playlist,
    TResult Function(String id, String title, String imageUrl)? program,
    TResult Function(String title, String streamUrl, String imageUrl)? radio,
    required TResult orElse(),
  }) {
    if (radio != null) {
      return radio(title, streamUrl, imageUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(QueueSourceAlbum value) album,
    required TResult Function(QueueSourcePlaylist value) playlist,
    required TResult Function(QueueSourceProgram value) program,
    required TResult Function(QueueSourceRadio value) radio,
  }) {
    return radio(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(QueueSourceAlbum value)? album,
    TResult? Function(QueueSourcePlaylist value)? playlist,
    TResult? Function(QueueSourceProgram value)? program,
    TResult? Function(QueueSourceRadio value)? radio,
  }) {
    return radio?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(QueueSourceAlbum value)? album,
    TResult Function(QueueSourcePlaylist value)? playlist,
    TResult Function(QueueSourceProgram value)? program,
    TResult Function(QueueSourceRadio value)? radio,
    required TResult orElse(),
  }) {
    if (radio != null) {
      return radio(this);
    }
    return orElse();
  }
}

abstract class QueueSourceRadio implements QueueSource {
  const factory QueueSourceRadio({
    required final String title,
    required final String streamUrl,
    required final String imageUrl,
  }) = _$QueueSourceRadioImpl;

  @override
  String get title;
  String get streamUrl;
  @override
  String get imageUrl;

  /// Create a copy of QueueSource
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSourceRadioImplCopyWith<_$QueueSourceRadioImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlayerState {
  // Queue (Music)
  List<Track> get tracks => throw _privateConstructorUsedError;
  int get currentIndex => throw _privateConstructorUsedError;
  QueueSource? get source =>
      throw _privateConstructorUsedError; // Saved music source (when switching to radio)
  QueueSource? get savedMusicSource =>
      throw _privateConstructorUsedError; // Playback
  PlayerStatus get status => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  Duration get bufferedPosition => throw _privateConstructorUsedError;
  Duration get totalDuration => throw _privateConstructorUsedError; // Error
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
    List<Track> tracks,
    int currentIndex,
    QueueSource? source,
    QueueSource? savedMusicSource,
    PlayerStatus status,
    Duration position,
    Duration bufferedPosition,
    Duration totalDuration,
    String? errorMessage,
  });

  $QueueSourceCopyWith<$Res>? get source;
  $QueueSourceCopyWith<$Res>? get savedMusicSource;
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
    Object? tracks = null,
    Object? currentIndex = null,
    Object? source = freezed,
    Object? savedMusicSource = freezed,
    Object? status = null,
    Object? position = null,
    Object? bufferedPosition = null,
    Object? totalDuration = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            savedMusicSource: freezed == savedMusicSource
                ? _value.savedMusicSource
                : savedMusicSource // ignore: cast_nullable_to_non_nullable
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

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueSourceCopyWith<$Res>? get savedMusicSource {
    if (_value.savedMusicSource == null) {
      return null;
    }

    return $QueueSourceCopyWith<$Res>(_value.savedMusicSource!, (value) {
      return _then(_value.copyWith(savedMusicSource: value) as $Val);
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
    List<Track> tracks,
    int currentIndex,
    QueueSource? source,
    QueueSource? savedMusicSource,
    PlayerStatus status,
    Duration position,
    Duration bufferedPosition,
    Duration totalDuration,
    String? errorMessage,
  });

  @override
  $QueueSourceCopyWith<$Res>? get source;
  @override
  $QueueSourceCopyWith<$Res>? get savedMusicSource;
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
    Object? tracks = null,
    Object? currentIndex = null,
    Object? source = freezed,
    Object? savedMusicSource = freezed,
    Object? status = null,
    Object? position = null,
    Object? bufferedPosition = null,
    Object? totalDuration = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$PlayerStateImpl(
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
        savedMusicSource: freezed == savedMusicSource
            ? _value.savedMusicSource
            : savedMusicSource // ignore: cast_nullable_to_non_nullable
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
    final List<Track> tracks = const [],
    this.currentIndex = 0,
    this.source,
    this.savedMusicSource,
    this.status = PlayerStatus.idle,
    this.position = Duration.zero,
    this.bufferedPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.errorMessage,
  }) : _tracks = tracks;

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
  // Saved music source (when switching to radio)
  @override
  final QueueSource? savedMusicSource;
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
  // Error
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'PlayerState(tracks: $tracks, currentIndex: $currentIndex, source: $source, savedMusicSource: $savedMusicSource, status: $status, position: $position, bufferedPosition: $bufferedPosition, totalDuration: $totalDuration, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            (identical(other.currentIndex, currentIndex) ||
                other.currentIndex == currentIndex) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.savedMusicSource, savedMusicSource) ||
                other.savedMusicSource == savedMusicSource) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.bufferedPosition, bufferedPosition) ||
                other.bufferedPosition == bufferedPosition) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tracks),
    currentIndex,
    source,
    savedMusicSource,
    status,
    position,
    bufferedPosition,
    totalDuration,
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
    final List<Track> tracks,
    final int currentIndex,
    final QueueSource? source,
    final QueueSource? savedMusicSource,
    final PlayerStatus status,
    final Duration position,
    final Duration bufferedPosition,
    final Duration totalDuration,
    final String? errorMessage,
  }) = _$PlayerStateImpl;

  // Queue (Music)
  @override
  List<Track> get tracks;
  @override
  int get currentIndex;
  @override
  QueueSource? get source; // Saved music source (when switching to radio)
  @override
  QueueSource? get savedMusicSource; // Playback
  @override
  PlayerStatus get status;
  @override
  Duration get position;
  @override
  Duration get bufferedPosition;
  @override
  Duration get totalDuration; // Error
  @override
  String? get errorMessage;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
