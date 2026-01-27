// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Track {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get artistName => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  DateTime? get releaseDate => throw _privateConstructorUsedError;
  bool get isLiked => throw _privateConstructorUsedError;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrackCopyWith<Track> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrackCopyWith<$Res> {
  factory $TrackCopyWith(Track value, $Res Function(Track) then) =
      _$TrackCopyWithImpl<$Res, Track>;
  @useResult
  $Res call({
    String id,
    String title,
    String artistName,
    String imageUrl,
    Duration duration,
    String audioUrl,
    DateTime? releaseDate,
    bool isLiked,
  });
}

/// @nodoc
class _$TrackCopyWithImpl<$Res, $Val extends Track>
    implements $TrackCopyWith<$Res> {
  _$TrackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artistName = null,
    Object? imageUrl = null,
    Object? duration = null,
    Object? audioUrl = null,
    Object? releaseDate = freezed,
    Object? isLiked = null,
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
            artistName: null == artistName
                ? _value.artistName
                : artistName // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            audioUrl: null == audioUrl
                ? _value.audioUrl
                : audioUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            releaseDate: freezed == releaseDate
                ? _value.releaseDate
                : releaseDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isLiked: null == isLiked
                ? _value.isLiked
                : isLiked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrackImplCopyWith<$Res> implements $TrackCopyWith<$Res> {
  factory _$$TrackImplCopyWith(
    _$TrackImpl value,
    $Res Function(_$TrackImpl) then,
  ) = __$$TrackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String artistName,
    String imageUrl,
    Duration duration,
    String audioUrl,
    DateTime? releaseDate,
    bool isLiked,
  });
}

/// @nodoc
class __$$TrackImplCopyWithImpl<$Res>
    extends _$TrackCopyWithImpl<$Res, _$TrackImpl>
    implements _$$TrackImplCopyWith<$Res> {
  __$$TrackImplCopyWithImpl(
    _$TrackImpl _value,
    $Res Function(_$TrackImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artistName = null,
    Object? imageUrl = null,
    Object? duration = null,
    Object? audioUrl = null,
    Object? releaseDate = freezed,
    Object? isLiked = null,
  }) {
    return _then(
      _$TrackImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        artistName: null == artistName
            ? _value.artistName
            : artistName // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        audioUrl: null == audioUrl
            ? _value.audioUrl
            : audioUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        releaseDate: freezed == releaseDate
            ? _value.releaseDate
            : releaseDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isLiked: null == isLiked
            ? _value.isLiked
            : isLiked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$TrackImpl implements _Track {
  const _$TrackImpl({
    required this.id,
    required this.title,
    required this.artistName,
    required this.imageUrl,
    required this.duration,
    required this.audioUrl,
    this.releaseDate,
    this.isLiked = false,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String artistName;
  @override
  final String imageUrl;
  @override
  final Duration duration;
  @override
  final String audioUrl;
  @override
  final DateTime? releaseDate;
  @override
  @JsonKey()
  final bool isLiked;

  @override
  String toString() {
    return 'Track(id: $id, title: $title, artistName: $artistName, imageUrl: $imageUrl, duration: $duration, audioUrl: $audioUrl, releaseDate: $releaseDate, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrackImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artistName, artistName) ||
                other.artistName == artistName) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.releaseDate, releaseDate) ||
                other.releaseDate == releaseDate) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    artistName,
    imageUrl,
    duration,
    audioUrl,
    releaseDate,
    isLiked,
  );

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrackImplCopyWith<_$TrackImpl> get copyWith =>
      __$$TrackImplCopyWithImpl<_$TrackImpl>(this, _$identity);
}

abstract class _Track implements Track {
  const factory _Track({
    required final String id,
    required final String title,
    required final String artistName,
    required final String imageUrl,
    required final Duration duration,
    required final String audioUrl,
    final DateTime? releaseDate,
    final bool isLiked,
  }) = _$TrackImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get artistName;
  @override
  String get imageUrl;
  @override
  Duration get duration;
  @override
  String get audioUrl;
  @override
  DateTime? get releaseDate;
  @override
  bool get isLiked;

  /// Create a copy of Track
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrackImplCopyWith<_$TrackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
