// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'album_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AlbumTracksState {
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
    required TResult Function(_AlbumTracksLoading value) loading,
    required TResult Function(_AlbumTracksData value) data,
    required TResult Function(_AlbumTracksError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumTracksLoading value)? loading,
    TResult? Function(_AlbumTracksData value)? data,
    TResult? Function(_AlbumTracksError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumTracksLoading value)? loading,
    TResult Function(_AlbumTracksData value)? data,
    TResult Function(_AlbumTracksError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlbumTracksStateCopyWith<$Res> {
  factory $AlbumTracksStateCopyWith(
    AlbumTracksState value,
    $Res Function(AlbumTracksState) then,
  ) = _$AlbumTracksStateCopyWithImpl<$Res, AlbumTracksState>;
}

/// @nodoc
class _$AlbumTracksStateCopyWithImpl<$Res, $Val extends AlbumTracksState>
    implements $AlbumTracksStateCopyWith<$Res> {
  _$AlbumTracksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AlbumTracksLoadingImplCopyWith<$Res> {
  factory _$$AlbumTracksLoadingImplCopyWith(
    _$AlbumTracksLoadingImpl value,
    $Res Function(_$AlbumTracksLoadingImpl) then,
  ) = __$$AlbumTracksLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AlbumTracksLoadingImplCopyWithImpl<$Res>
    extends _$AlbumTracksStateCopyWithImpl<$Res, _$AlbumTracksLoadingImpl>
    implements _$$AlbumTracksLoadingImplCopyWith<$Res> {
  __$$AlbumTracksLoadingImplCopyWithImpl(
    _$AlbumTracksLoadingImpl _value,
    $Res Function(_$AlbumTracksLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AlbumTracksLoadingImpl implements _AlbumTracksLoading {
  const _$AlbumTracksLoadingImpl();

  @override
  String toString() {
    return 'AlbumTracksState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AlbumTracksLoadingImpl);
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
    required TResult Function(_AlbumTracksLoading value) loading,
    required TResult Function(_AlbumTracksData value) data,
    required TResult Function(_AlbumTracksError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumTracksLoading value)? loading,
    TResult? Function(_AlbumTracksData value)? data,
    TResult? Function(_AlbumTracksError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumTracksLoading value)? loading,
    TResult Function(_AlbumTracksData value)? data,
    TResult Function(_AlbumTracksError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AlbumTracksLoading implements AlbumTracksState {
  const factory _AlbumTracksLoading() = _$AlbumTracksLoadingImpl;
}

/// @nodoc
abstract class _$$AlbumTracksDataImplCopyWith<$Res> {
  factory _$$AlbumTracksDataImplCopyWith(
    _$AlbumTracksDataImpl value,
    $Res Function(_$AlbumTracksDataImpl) then,
  ) = __$$AlbumTracksDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Track> tracks});
}

/// @nodoc
class __$$AlbumTracksDataImplCopyWithImpl<$Res>
    extends _$AlbumTracksStateCopyWithImpl<$Res, _$AlbumTracksDataImpl>
    implements _$$AlbumTracksDataImplCopyWith<$Res> {
  __$$AlbumTracksDataImplCopyWithImpl(
    _$AlbumTracksDataImpl _value,
    $Res Function(_$AlbumTracksDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tracks = null}) {
    return _then(
      _$AlbumTracksDataImpl(
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }
}

/// @nodoc

class _$AlbumTracksDataImpl implements _AlbumTracksData {
  const _$AlbumTracksDataImpl({required final List<Track> tracks})
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
    return 'AlbumTracksState.data(tracks: $tracks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumTracksDataImpl &&
            const DeepCollectionEquality().equals(other._tracks, _tracks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_tracks));

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumTracksDataImplCopyWith<_$AlbumTracksDataImpl> get copyWith =>
      __$$AlbumTracksDataImplCopyWithImpl<_$AlbumTracksDataImpl>(
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
    required TResult Function(_AlbumTracksLoading value) loading,
    required TResult Function(_AlbumTracksData value) data,
    required TResult Function(_AlbumTracksError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumTracksLoading value)? loading,
    TResult? Function(_AlbumTracksData value)? data,
    TResult? Function(_AlbumTracksError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumTracksLoading value)? loading,
    TResult Function(_AlbumTracksData value)? data,
    TResult Function(_AlbumTracksError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _AlbumTracksData implements AlbumTracksState {
  const factory _AlbumTracksData({required final List<Track> tracks}) =
      _$AlbumTracksDataImpl;

  List<Track> get tracks;

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumTracksDataImplCopyWith<_$AlbumTracksDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AlbumTracksErrorImplCopyWith<$Res> {
  factory _$$AlbumTracksErrorImplCopyWith(
    _$AlbumTracksErrorImpl value,
    $Res Function(_$AlbumTracksErrorImpl) then,
  ) = __$$AlbumTracksErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AlbumTracksErrorImplCopyWithImpl<$Res>
    extends _$AlbumTracksStateCopyWithImpl<$Res, _$AlbumTracksErrorImpl>
    implements _$$AlbumTracksErrorImplCopyWith<$Res> {
  __$$AlbumTracksErrorImplCopyWithImpl(
    _$AlbumTracksErrorImpl _value,
    $Res Function(_$AlbumTracksErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$AlbumTracksErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AlbumTracksErrorImpl implements _AlbumTracksError {
  const _$AlbumTracksErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'AlbumTracksState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AlbumTracksErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AlbumTracksErrorImplCopyWith<_$AlbumTracksErrorImpl> get copyWith =>
      __$$AlbumTracksErrorImplCopyWithImpl<_$AlbumTracksErrorImpl>(
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
    required TResult Function(_AlbumTracksLoading value) loading,
    required TResult Function(_AlbumTracksData value) data,
    required TResult Function(_AlbumTracksError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_AlbumTracksLoading value)? loading,
    TResult? Function(_AlbumTracksData value)? data,
    TResult? Function(_AlbumTracksError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AlbumTracksLoading value)? loading,
    TResult Function(_AlbumTracksData value)? data,
    TResult Function(_AlbumTracksError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AlbumTracksError implements AlbumTracksState {
  const factory _AlbumTracksError({required final String message}) =
      _$AlbumTracksErrorImpl;

  String get message;

  /// Create a copy of AlbumTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AlbumTracksErrorImplCopyWith<_$AlbumTracksErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
