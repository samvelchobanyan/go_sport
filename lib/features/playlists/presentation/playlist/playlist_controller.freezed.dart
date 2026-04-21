// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'playlist_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PlaylistDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Playlist playlist, List<Track> tracks) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Playlist playlist, List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Playlist playlist, List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistDetailsLoading value) loading,
    required TResult Function(PlaylistDetailsData value) data,
    required TResult Function(PlaylistDetailsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistDetailsLoading value)? loading,
    TResult? Function(PlaylistDetailsData value)? data,
    TResult? Function(PlaylistDetailsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistDetailsLoading value)? loading,
    TResult Function(PlaylistDetailsData value)? data,
    TResult Function(PlaylistDetailsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistDetailsStateCopyWith<$Res> {
  factory $PlaylistDetailsStateCopyWith(
    PlaylistDetailsState value,
    $Res Function(PlaylistDetailsState) then,
  ) = _$PlaylistDetailsStateCopyWithImpl<$Res, PlaylistDetailsState>;
}

/// @nodoc
class _$PlaylistDetailsStateCopyWithImpl<
  $Res,
  $Val extends PlaylistDetailsState
>
    implements $PlaylistDetailsStateCopyWith<$Res> {
  _$PlaylistDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PlaylistDetailsLoadingImplCopyWith<$Res> {
  factory _$$PlaylistDetailsLoadingImplCopyWith(
    _$PlaylistDetailsLoadingImpl value,
    $Res Function(_$PlaylistDetailsLoadingImpl) then,
  ) = __$$PlaylistDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlaylistDetailsLoadingImplCopyWithImpl<$Res>
    extends
        _$PlaylistDetailsStateCopyWithImpl<$Res, _$PlaylistDetailsLoadingImpl>
    implements _$$PlaylistDetailsLoadingImplCopyWith<$Res> {
  __$$PlaylistDetailsLoadingImplCopyWithImpl(
    _$PlaylistDetailsLoadingImpl _value,
    $Res Function(_$PlaylistDetailsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlaylistDetailsLoadingImpl implements PlaylistDetailsLoading {
  const _$PlaylistDetailsLoadingImpl();

  @override
  String toString() {
    return 'PlaylistDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Playlist playlist, List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Playlist playlist, List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Playlist playlist, List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistDetailsLoading value) loading,
    required TResult Function(PlaylistDetailsData value) data,
    required TResult Function(PlaylistDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistDetailsLoading value)? loading,
    TResult? Function(PlaylistDetailsData value)? data,
    TResult? Function(PlaylistDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistDetailsLoading value)? loading,
    TResult Function(PlaylistDetailsData value)? data,
    TResult Function(PlaylistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PlaylistDetailsLoading implements PlaylistDetailsState {
  const factory PlaylistDetailsLoading() = _$PlaylistDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$PlaylistDetailsDataImplCopyWith<$Res> {
  factory _$$PlaylistDetailsDataImplCopyWith(
    _$PlaylistDetailsDataImpl value,
    $Res Function(_$PlaylistDetailsDataImpl) then,
  ) = __$$PlaylistDetailsDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Playlist playlist, List<Track> tracks});

  $PlaylistCopyWith<$Res> get playlist;
}

/// @nodoc
class __$$PlaylistDetailsDataImplCopyWithImpl<$Res>
    extends _$PlaylistDetailsStateCopyWithImpl<$Res, _$PlaylistDetailsDataImpl>
    implements _$$PlaylistDetailsDataImplCopyWith<$Res> {
  __$$PlaylistDetailsDataImplCopyWithImpl(
    _$PlaylistDetailsDataImpl _value,
    $Res Function(_$PlaylistDetailsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? playlist = null, Object? tracks = null}) {
    return _then(
      _$PlaylistDetailsDataImpl(
        playlist: null == playlist
            ? _value.playlist
            : playlist // ignore: cast_nullable_to_non_nullable
                  as Playlist,
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlaylistCopyWith<$Res> get playlist {
    return $PlaylistCopyWith<$Res>(_value.playlist, (value) {
      return _then(_value.copyWith(playlist: value));
    });
  }
}

/// @nodoc

class _$PlaylistDetailsDataImpl implements PlaylistDetailsData {
  const _$PlaylistDetailsDataImpl({
    required this.playlist,
    required final List<Track> tracks,
  }) : _tracks = tracks;

  @override
  final Playlist playlist;
  final List<Track> _tracks;
  @override
  List<Track> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  @override
  String toString() {
    return 'PlaylistDetailsState.data(playlist: $playlist, tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistDetailsDataImpl &&
            (identical(other.playlist, playlist) ||
                other.playlist == playlist) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    playlist,
    const DeepCollectionEquality().hash(_tracks),
  );

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistDetailsDataImplCopyWith<_$PlaylistDetailsDataImpl> get copyWith =>
      __$$PlaylistDetailsDataImplCopyWithImpl<_$PlaylistDetailsDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Playlist playlist, List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return data(playlist, tracks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Playlist playlist, List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(playlist, tracks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Playlist playlist, List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(playlist, tracks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistDetailsLoading value) loading,
    required TResult Function(PlaylistDetailsData value) data,
    required TResult Function(PlaylistDetailsError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistDetailsLoading value)? loading,
    TResult? Function(PlaylistDetailsData value)? data,
    TResult? Function(PlaylistDetailsError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistDetailsLoading value)? loading,
    TResult Function(PlaylistDetailsData value)? data,
    TResult Function(PlaylistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class PlaylistDetailsData implements PlaylistDetailsState {
  const factory PlaylistDetailsData({
    required final Playlist playlist,
    required final List<Track> tracks,
  }) = _$PlaylistDetailsDataImpl;

  Playlist get playlist;
  List<Track> get tracks;

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistDetailsDataImplCopyWith<_$PlaylistDetailsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlaylistDetailsErrorImplCopyWith<$Res> {
  factory _$$PlaylistDetailsErrorImplCopyWith(
    _$PlaylistDetailsErrorImpl value,
    $Res Function(_$PlaylistDetailsErrorImpl) then,
  ) = __$$PlaylistDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PlaylistDetailsErrorImplCopyWithImpl<$Res>
    extends _$PlaylistDetailsStateCopyWithImpl<$Res, _$PlaylistDetailsErrorImpl>
    implements _$$PlaylistDetailsErrorImplCopyWith<$Res> {
  __$$PlaylistDetailsErrorImplCopyWithImpl(
    _$PlaylistDetailsErrorImpl _value,
    $Res Function(_$PlaylistDetailsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PlaylistDetailsErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PlaylistDetailsErrorImpl implements PlaylistDetailsError {
  const _$PlaylistDetailsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'PlaylistDetailsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistDetailsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistDetailsErrorImplCopyWith<_$PlaylistDetailsErrorImpl>
  get copyWith =>
      __$$PlaylistDetailsErrorImplCopyWithImpl<_$PlaylistDetailsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Playlist playlist, List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Playlist playlist, List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Playlist playlist, List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistDetailsLoading value) loading,
    required TResult Function(PlaylistDetailsData value) data,
    required TResult Function(PlaylistDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistDetailsLoading value)? loading,
    TResult? Function(PlaylistDetailsData value)? data,
    TResult? Function(PlaylistDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistDetailsLoading value)? loading,
    TResult Function(PlaylistDetailsData value)? data,
    TResult Function(PlaylistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PlaylistDetailsError implements PlaylistDetailsState {
  const factory PlaylistDetailsError({required final String message}) =
      _$PlaylistDetailsErrorImpl;

  String get message;

  /// Create a copy of PlaylistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistDetailsErrorImplCopyWith<_$PlaylistDetailsErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
