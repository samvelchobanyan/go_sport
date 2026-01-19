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
  List<String> get trackIds => throw _privateConstructorUsedError;

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
    List<String> trackIds,
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
    Object? trackIds = null,
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
            trackIds: null == trackIds
                ? _value.trackIds
                : trackIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
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
    List<String> trackIds,
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
    Object? trackIds = null,
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
        trackIds: null == trackIds
            ? _value._trackIds
            : trackIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
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
    final List<String> trackIds = const [],
  }) : _trackIds = trackIds;

  @override
  final String id;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final int trackCount;
  final List<String> _trackIds;
  @override
  @JsonKey()
  List<String> get trackIds {
    if (_trackIds is EqualUnmodifiableListView) return _trackIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackIds);
  }

  @override
  String toString() {
    return 'Playlist(id: $id, title: $title, imageUrl: $imageUrl, trackCount: $trackCount, trackIds: $trackIds)';
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
            const DeepCollectionEquality().equals(other._trackIds, _trackIds));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    imageUrl,
    trackCount,
    const DeepCollectionEquality().hash(_trackIds),
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
    final List<String> trackIds,
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
  List<String> get trackIds;

  /// Create a copy of Playlist
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistImplCopyWith<_$PlaylistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
