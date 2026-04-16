// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Playlist {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get trackCount => throw _privateConstructorUsedError;
  PlaylistType get type => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;
  String? get likeId => throw _privateConstructorUsedError;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlaylistCopyWith<Playlist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistCopyWith<$Res> {
  factory $PlaylistCopyWith(Playlist value, $Res Function(Playlist) then) =
      _$PlaylistCopyWithImpl<$Res, Playlist>;
  @useResult
  $Res call({
    String id,
    String title,
    String imageUrl,
    int trackCount,
    PlaylistType type,
    bool isLiked,
    String? likeId,
  });
}

/// @nodoc
class _$PlaylistCopyWithImpl<$Res, $Val extends Playlist>
    implements $PlaylistCopyWith<$Res> {
  _$PlaylistCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? trackCount = null,
    Object? type = null,
    Object? isLiked = null,
    Object? likeId = freezed,
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
            trackCount: null == trackCount
                ? _value.trackCount
                : trackCount // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PlaylistType,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
            likeId: freezed == likeId
                ? _value.likeId
                : likeId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlaylistImplCopyWith<$Res>
    implements $PlaylistCopyWith<$Res> {
  factory _$$PlaylistImplCopyWith(
    _$PlaylistImpl value,
    $Res Function(_$PlaylistImpl) then,
  ) = __$$PlaylistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String imageUrl,
    int trackCount,
    PlaylistType type,
    bool isLiked,
    String? likeId,
  });
}

/// @nodoc
class __$$PlaylistImplCopyWithImpl<$Res>
    extends _$PlaylistCopyWithImpl<$Res, _$PlaylistImpl>
    implements _$$PlaylistImplCopyWith<$Res> {
  __$$PlaylistImplCopyWithImpl(
    _$PlaylistImpl _value,
    $Res Function(_$PlaylistImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? trackCount = null,
    Object? type = null,
    Object? isLiked = null,
    Object? likeId = freezed,
  }) {
    return _then(
      _$PlaylistImpl(
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
        trackCount: null == trackCount
            ? _value.trackCount
            : trackCount // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PlaylistType,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
        likeId: freezed == likeId
            ? _value.likeId
            : likeId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$PlaylistImpl implements _Playlist {
  const _$PlaylistImpl({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.trackCount,
    this.type = PlaylistType.featured,
    this.isLiked = false,
    this.likeId,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final int trackCount;
  @override
  @JsonKey()
  final PlaylistType type;
  @override
  @JsonKey()
  final bool isLiked;
  @override
  final String? likeId;

  @override
  String toString() {
    return 'Playlist(id: $id, title: $title, imageUrl: $imageUrl, trackCount: $trackCount, type: $type, isLiked: $isLiked, likeId: $likeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.trackCount, trackCount) ||
                other.trackCount == trackCount) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.likeId, likeId) || other.likeId == likeId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    imageUrl,
    trackCount,
    type,
    isLiked,
    likeId,
  );

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      __$$PlaylistImplCopyWithImpl<_$PlaylistImpl>(this, _$identity);
}

abstract class _Playlist implements Playlist {
  const factory _Playlist({
    required final String id,
    required final String title,
    required final String imageUrl,
    required final int trackCount,
    final PlaylistType type,
    final bool isLiked,
    final String? likeId,
  }) = _$PlaylistImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  int get trackCount;
  @override
  PlaylistType get type;
  @override
  bool get isLiked;
  @override
  String? get likeId;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
