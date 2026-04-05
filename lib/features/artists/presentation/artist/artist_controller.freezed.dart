// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artist_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ArtistAlbumsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Album> albums) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Album> albums)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ArtistAlbumsLoading value) loading,
    required TResult Function(_ArtistAlbumsData value) data,
    required TResult Function(_ArtistAlbumsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistAlbumsLoading value)? loading,
    TResult? Function(_ArtistAlbumsData value)? data,
    TResult? Function(_ArtistAlbumsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistAlbumsLoading value)? loading,
    TResult Function(_ArtistAlbumsData value)? data,
    TResult Function(_ArtistAlbumsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistAlbumsStateCopyWith<$Res> {
  factory $ArtistAlbumsStateCopyWith(
    ArtistAlbumsState value,
    $Res Function(ArtistAlbumsState) then,
  ) = _$ArtistAlbumsStateCopyWithImpl<$Res, ArtistAlbumsState>;
}

/// @nodoc
class _$ArtistAlbumsStateCopyWithImpl<$Res, $Val extends ArtistAlbumsState>
    implements $ArtistAlbumsStateCopyWith<$Res> {
  _$ArtistAlbumsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ArtistAlbumsLoadingImplCopyWith<$Res> {
  factory _$$ArtistAlbumsLoadingImplCopyWith(
    _$ArtistAlbumsLoadingImpl value,
    $Res Function(_$ArtistAlbumsLoadingImpl) then,
  ) = __$$ArtistAlbumsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArtistAlbumsLoadingImplCopyWithImpl<$Res>
    extends _$ArtistAlbumsStateCopyWithImpl<$Res, _$ArtistAlbumsLoadingImpl>
    implements _$$ArtistAlbumsLoadingImplCopyWith<$Res> {
  __$$ArtistAlbumsLoadingImplCopyWithImpl(
    _$ArtistAlbumsLoadingImpl _value,
    $Res Function(_$ArtistAlbumsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArtistAlbumsLoadingImpl implements _ArtistAlbumsLoading {
  const _$ArtistAlbumsLoadingImpl();

  @override
  String toString() {
    return 'ArtistAlbumsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistAlbumsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Album> albums)? data,
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
    required TResult Function(_ArtistAlbumsLoading value) loading,
    required TResult Function(_ArtistAlbumsData value) data,
    required TResult Function(_ArtistAlbumsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistAlbumsLoading value)? loading,
    TResult? Function(_ArtistAlbumsData value)? data,
    TResult? Function(_ArtistAlbumsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistAlbumsLoading value)? loading,
    TResult Function(_ArtistAlbumsData value)? data,
    TResult Function(_ArtistAlbumsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ArtistAlbumsLoading implements ArtistAlbumsState {
  const factory _ArtistAlbumsLoading() = _$ArtistAlbumsLoadingImpl;
}

/// @nodoc
abstract class _$$ArtistAlbumsDataImplCopyWith<$Res> {
  factory _$$ArtistAlbumsDataImplCopyWith(
    _$ArtistAlbumsDataImpl value,
    $Res Function(_$ArtistAlbumsDataImpl) then,
  ) = __$$ArtistAlbumsDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Album> albums});
}

/// @nodoc
class __$$ArtistAlbumsDataImplCopyWithImpl<$Res>
    extends _$ArtistAlbumsStateCopyWithImpl<$Res, _$ArtistAlbumsDataImpl>
    implements _$$ArtistAlbumsDataImplCopyWith<$Res> {
  __$$ArtistAlbumsDataImplCopyWithImpl(
    _$ArtistAlbumsDataImpl _value,
    $Res Function(_$ArtistAlbumsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? albums = null}) {
    return _then(
      _$ArtistAlbumsDataImpl(
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
      ),
    );
  }
}

/// @nodoc

class _$ArtistAlbumsDataImpl implements _ArtistAlbumsData {
  const _$ArtistAlbumsDataImpl({required final List<Album> albums})
    : _albums = albums;

  final List<Album> _albums;
  @override
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  String toString() {
    return 'ArtistAlbumsState.data(albums: $albums)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistAlbumsDataImpl &&
            const DeepCollectionEquality().equals(other._albums, _albums));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_albums));

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistAlbumsDataImplCopyWith<_$ArtistAlbumsDataImpl> get copyWith =>
      __$$ArtistAlbumsDataImplCopyWithImpl<_$ArtistAlbumsDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return data(albums);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(albums);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Album> albums)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(albums);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ArtistAlbumsLoading value) loading,
    required TResult Function(_ArtistAlbumsData value) data,
    required TResult Function(_ArtistAlbumsError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistAlbumsLoading value)? loading,
    TResult? Function(_ArtistAlbumsData value)? data,
    TResult? Function(_ArtistAlbumsError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistAlbumsLoading value)? loading,
    TResult Function(_ArtistAlbumsData value)? data,
    TResult Function(_ArtistAlbumsError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ArtistAlbumsData implements ArtistAlbumsState {
  const factory _ArtistAlbumsData({required final List<Album> albums}) =
      _$ArtistAlbumsDataImpl;

  List<Album> get albums;

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistAlbumsDataImplCopyWith<_$ArtistAlbumsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArtistAlbumsErrorImplCopyWith<$Res> {
  factory _$$ArtistAlbumsErrorImplCopyWith(
    _$ArtistAlbumsErrorImpl value,
    $Res Function(_$ArtistAlbumsErrorImpl) then,
  ) = __$$ArtistAlbumsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ArtistAlbumsErrorImplCopyWithImpl<$Res>
    extends _$ArtistAlbumsStateCopyWithImpl<$Res, _$ArtistAlbumsErrorImpl>
    implements _$$ArtistAlbumsErrorImplCopyWith<$Res> {
  __$$ArtistAlbumsErrorImplCopyWithImpl(
    _$ArtistAlbumsErrorImpl _value,
    $Res Function(_$ArtistAlbumsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ArtistAlbumsErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArtistAlbumsErrorImpl implements _ArtistAlbumsError {
  const _$ArtistAlbumsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ArtistAlbumsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistAlbumsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistAlbumsErrorImplCopyWith<_$ArtistAlbumsErrorImpl> get copyWith =>
      __$$ArtistAlbumsErrorImplCopyWithImpl<_$ArtistAlbumsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Album> albums)? data,
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
    required TResult Function(_ArtistAlbumsLoading value) loading,
    required TResult Function(_ArtistAlbumsData value) data,
    required TResult Function(_ArtistAlbumsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistAlbumsLoading value)? loading,
    TResult? Function(_ArtistAlbumsData value)? data,
    TResult? Function(_ArtistAlbumsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistAlbumsLoading value)? loading,
    TResult Function(_ArtistAlbumsData value)? data,
    TResult Function(_ArtistAlbumsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ArtistAlbumsError implements ArtistAlbumsState {
  const factory _ArtistAlbumsError({required final String message}) =
      _$ArtistAlbumsErrorImpl;

  String get message;

  /// Create a copy of ArtistAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistAlbumsErrorImplCopyWith<_$ArtistAlbumsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
