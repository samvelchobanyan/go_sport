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
mixin _$PlaylistTracksState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> tracks) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistTracksLoading value) loading,
    required TResult Function(PlaylistTracksData value) data,
    required TResult Function(PlaylistTracksError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistTracksLoading value)? loading,
    TResult? Function(PlaylistTracksData value)? data,
    TResult? Function(PlaylistTracksError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistTracksLoading value)? loading,
    TResult Function(PlaylistTracksData value)? data,
    TResult Function(PlaylistTracksError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlaylistTracksStateCopyWith<$Res> {
  factory $PlaylistTracksStateCopyWith(
    PlaylistTracksState value,
    $Res Function(PlaylistTracksState) then,
  ) = _$PlaylistTracksStateCopyWithImpl<$Res, PlaylistTracksState>;
}

/// @nodoc
class _$PlaylistTracksStateCopyWithImpl<$Res, $Val extends PlaylistTracksState>
    implements $PlaylistTracksStateCopyWith<$Res> {
  _$PlaylistTracksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PlaylistTracksLoadingImplCopyWith<$Res> {
  factory _$$PlaylistTracksLoadingImplCopyWith(
    _$PlaylistTracksLoadingImpl value,
    $Res Function(_$PlaylistTracksLoadingImpl) then,
  ) = __$$PlaylistTracksLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PlaylistTracksLoadingImplCopyWithImpl<$Res>
    extends _$PlaylistTracksStateCopyWithImpl<$Res, _$PlaylistTracksLoadingImpl>
    implements _$$PlaylistTracksLoadingImplCopyWith<$Res> {
  __$$PlaylistTracksLoadingImplCopyWithImpl(
    _$PlaylistTracksLoadingImpl _value,
    $Res Function(_$PlaylistTracksLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PlaylistTracksLoadingImpl implements PlaylistTracksLoading {
  const _$PlaylistTracksLoadingImpl();

  @override
  String toString() {
    return 'PlaylistTracksState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistTracksLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> tracks)? data,
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
    required TResult Function(PlaylistTracksLoading value) loading,
    required TResult Function(PlaylistTracksData value) data,
    required TResult Function(PlaylistTracksError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistTracksLoading value)? loading,
    TResult? Function(PlaylistTracksData value)? data,
    TResult? Function(PlaylistTracksError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistTracksLoading value)? loading,
    TResult Function(PlaylistTracksData value)? data,
    TResult Function(PlaylistTracksError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PlaylistTracksLoading implements PlaylistTracksState {
  const factory PlaylistTracksLoading() = _$PlaylistTracksLoadingImpl;
}

/// @nodoc
abstract class _$$PlaylistTracksDataImplCopyWith<$Res> {
  factory _$$PlaylistTracksDataImplCopyWith(
    _$PlaylistTracksDataImpl value,
    $Res Function(_$PlaylistTracksDataImpl) then,
  ) = __$$PlaylistTracksDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Track> tracks});
}

/// @nodoc
class __$$PlaylistTracksDataImplCopyWithImpl<$Res>
    extends _$PlaylistTracksStateCopyWithImpl<$Res, _$PlaylistTracksDataImpl>
    implements _$$PlaylistTracksDataImplCopyWith<$Res> {
  __$$PlaylistTracksDataImplCopyWithImpl(
    _$PlaylistTracksDataImpl _value,
    $Res Function(_$PlaylistTracksDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tracks = null}) {
    return _then(
      _$PlaylistTracksDataImpl(
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }
}

/// @nodoc

class _$PlaylistTracksDataImpl implements PlaylistTracksData {
  const _$PlaylistTracksDataImpl({required final List<Track> tracks})
    : _tracks = tracks;

  final List<Track> _tracks;
  @override
  List<Track> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  @override
  String toString() {
    return 'PlaylistTracksState.data(tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistTracksDataImpl &&
            const DeepCollectionEquality().equals(other._tracks, _tracks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tracks));

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistTracksDataImplCopyWith<_$PlaylistTracksDataImpl> get copyWith =>
      __$$PlaylistTracksDataImplCopyWithImpl<_$PlaylistTracksDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return data(tracks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(tracks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> tracks)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(tracks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PlaylistTracksLoading value) loading,
    required TResult Function(PlaylistTracksData value) data,
    required TResult Function(PlaylistTracksError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistTracksLoading value)? loading,
    TResult? Function(PlaylistTracksData value)? data,
    TResult? Function(PlaylistTracksError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistTracksLoading value)? loading,
    TResult Function(PlaylistTracksData value)? data,
    TResult Function(PlaylistTracksError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class PlaylistTracksData implements PlaylistTracksState {
  const factory PlaylistTracksData({required final List<Track> tracks}) =
      _$PlaylistTracksDataImpl;

  List<Track> get tracks;

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistTracksDataImplCopyWith<_$PlaylistTracksDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlaylistTracksErrorImplCopyWith<$Res> {
  factory _$$PlaylistTracksErrorImplCopyWith(
    _$PlaylistTracksErrorImpl value,
    $Res Function(_$PlaylistTracksErrorImpl) then,
  ) = __$$PlaylistTracksErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PlaylistTracksErrorImplCopyWithImpl<$Res>
    extends _$PlaylistTracksStateCopyWithImpl<$Res, _$PlaylistTracksErrorImpl>
    implements _$$PlaylistTracksErrorImplCopyWith<$Res> {
  __$$PlaylistTracksErrorImplCopyWithImpl(
    _$PlaylistTracksErrorImpl _value,
    $Res Function(_$PlaylistTracksErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$PlaylistTracksErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PlaylistTracksErrorImpl implements PlaylistTracksError {
  const _$PlaylistTracksErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'PlaylistTracksState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlaylistTracksErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlaylistTracksErrorImplCopyWith<_$PlaylistTracksErrorImpl> get copyWith =>
      __$$PlaylistTracksErrorImplCopyWithImpl<_$PlaylistTracksErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> tracks) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> tracks)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> tracks)? data,
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
    required TResult Function(PlaylistTracksLoading value) loading,
    required TResult Function(PlaylistTracksData value) data,
    required TResult Function(PlaylistTracksError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PlaylistTracksLoading value)? loading,
    TResult? Function(PlaylistTracksData value)? data,
    TResult? Function(PlaylistTracksError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PlaylistTracksLoading value)? loading,
    TResult Function(PlaylistTracksData value)? data,
    TResult Function(PlaylistTracksError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PlaylistTracksError implements PlaylistTracksState {
  const factory PlaylistTracksError({required final String message}) =
      _$PlaylistTracksErrorImpl;

  String get message;

  /// Create a copy of PlaylistTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlaylistTracksErrorImplCopyWith<_$PlaylistTracksErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
