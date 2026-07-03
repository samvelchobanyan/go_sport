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
mixin _$ArtistDetailsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Artist artist, List<Album> albums) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Artist artist, List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Artist artist, List<Album> albums)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ArtistDetailsLoading value) loading,
    required TResult Function(_ArtistDetailsData value) data,
    required TResult Function(_ArtistDetailsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistDetailsLoading value)? loading,
    TResult? Function(_ArtistDetailsData value)? data,
    TResult? Function(_ArtistDetailsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistDetailsLoading value)? loading,
    TResult Function(_ArtistDetailsData value)? data,
    TResult Function(_ArtistDetailsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistDetailsStateCopyWith<$Res> {
  factory $ArtistDetailsStateCopyWith(
    ArtistDetailsState value,
    $Res Function(ArtistDetailsState) then,
  ) = _$ArtistDetailsStateCopyWithImpl<$Res, ArtistDetailsState>;
}

/// @nodoc
class _$ArtistDetailsStateCopyWithImpl<$Res, $Val extends ArtistDetailsState>
    implements $ArtistDetailsStateCopyWith<$Res> {
  _$ArtistDetailsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ArtistDetailsLoadingImplCopyWith<$Res> {
  factory _$$ArtistDetailsLoadingImplCopyWith(
    _$ArtistDetailsLoadingImpl value,
    $Res Function(_$ArtistDetailsLoadingImpl) then,
  ) = __$$ArtistDetailsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ArtistDetailsLoadingImplCopyWithImpl<$Res>
    extends _$ArtistDetailsStateCopyWithImpl<$Res, _$ArtistDetailsLoadingImpl>
    implements _$$ArtistDetailsLoadingImplCopyWith<$Res> {
  __$$ArtistDetailsLoadingImplCopyWithImpl(
    _$ArtistDetailsLoadingImpl _value,
    $Res Function(_$ArtistDetailsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ArtistDetailsLoadingImpl implements _ArtistDetailsLoading {
  const _$ArtistDetailsLoadingImpl();

  @override
  String toString() {
    return 'ArtistDetailsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistDetailsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Artist artist, List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Artist artist, List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Artist artist, List<Album> albums)? data,
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
    required TResult Function(_ArtistDetailsLoading value) loading,
    required TResult Function(_ArtistDetailsData value) data,
    required TResult Function(_ArtistDetailsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistDetailsLoading value)? loading,
    TResult? Function(_ArtistDetailsData value)? data,
    TResult? Function(_ArtistDetailsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistDetailsLoading value)? loading,
    TResult Function(_ArtistDetailsData value)? data,
    TResult Function(_ArtistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ArtistDetailsLoading implements ArtistDetailsState {
  const factory _ArtistDetailsLoading() = _$ArtistDetailsLoadingImpl;
}

/// @nodoc
abstract class _$$ArtistDetailsDataImplCopyWith<$Res> {
  factory _$$ArtistDetailsDataImplCopyWith(
    _$ArtistDetailsDataImpl value,
    $Res Function(_$ArtistDetailsDataImpl) then,
  ) = __$$ArtistDetailsDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Artist artist, List<Album> albums});

  $ArtistCopyWith<$Res> get artist;
}

/// @nodoc
class __$$ArtistDetailsDataImplCopyWithImpl<$Res>
    extends _$ArtistDetailsStateCopyWithImpl<$Res, _$ArtistDetailsDataImpl>
    implements _$$ArtistDetailsDataImplCopyWith<$Res> {
  __$$ArtistDetailsDataImplCopyWithImpl(
    _$ArtistDetailsDataImpl _value,
    $Res Function(_$ArtistDetailsDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? artist = null, Object? albums = null}) {
    return _then(
      _$ArtistDetailsDataImpl(
        artist: null == artist
            ? _value.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as Artist,
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
      ),
    );
  }

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtistCopyWith<$Res> get artist {
    return $ArtistCopyWith<$Res>(_value.artist, (value) {
      return _then(_value.copyWith(artist: value));
    });
  }
}

/// @nodoc

class _$ArtistDetailsDataImpl implements _ArtistDetailsData {
  const _$ArtistDetailsDataImpl({
    required this.artist,
    required final List<Album> albums,
  }) : _albums = albums;

  @override
  final Artist artist;
  final List<Album> _albums;
  @override
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  String toString() {
    return 'ArtistDetailsState.data(artist: $artist, albums: $albums)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistDetailsDataImpl &&
            (identical(other.artist, artist) || other.artist == artist) &&
            const DeepCollectionEquality().equals(other._albums, _albums));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    artist,
    const DeepCollectionEquality().hash(_albums),
  );

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistDetailsDataImplCopyWith<_$ArtistDetailsDataImpl> get copyWith =>
      __$$ArtistDetailsDataImplCopyWithImpl<_$ArtistDetailsDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Artist artist, List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return data(artist, albums);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Artist artist, List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(artist, albums);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Artist artist, List<Album> albums)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(artist, albums);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ArtistDetailsLoading value) loading,
    required TResult Function(_ArtistDetailsData value) data,
    required TResult Function(_ArtistDetailsError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistDetailsLoading value)? loading,
    TResult? Function(_ArtistDetailsData value)? data,
    TResult? Function(_ArtistDetailsError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistDetailsLoading value)? loading,
    TResult Function(_ArtistDetailsData value)? data,
    TResult Function(_ArtistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _ArtistDetailsData implements ArtistDetailsState {
  const factory _ArtistDetailsData({
    required final Artist artist,
    required final List<Album> albums,
  }) = _$ArtistDetailsDataImpl;

  Artist get artist;
  List<Album> get albums;

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistDetailsDataImplCopyWith<_$ArtistDetailsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ArtistDetailsErrorImplCopyWith<$Res> {
  factory _$$ArtistDetailsErrorImplCopyWith(
    _$ArtistDetailsErrorImpl value,
    $Res Function(_$ArtistDetailsErrorImpl) then,
  ) = __$$ArtistDetailsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ArtistDetailsErrorImplCopyWithImpl<$Res>
    extends _$ArtistDetailsStateCopyWithImpl<$Res, _$ArtistDetailsErrorImpl>
    implements _$$ArtistDetailsErrorImplCopyWith<$Res> {
  __$$ArtistDetailsErrorImplCopyWithImpl(
    _$ArtistDetailsErrorImpl _value,
    $Res Function(_$ArtistDetailsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ArtistDetailsErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ArtistDetailsErrorImpl implements _ArtistDetailsError {
  const _$ArtistDetailsErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ArtistDetailsState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistDetailsErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistDetailsErrorImplCopyWith<_$ArtistDetailsErrorImpl> get copyWith =>
      __$$ArtistDetailsErrorImplCopyWithImpl<_$ArtistDetailsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(Artist artist, List<Album> albums) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(Artist artist, List<Album> albums)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(Artist artist, List<Album> albums)? data,
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
    required TResult Function(_ArtistDetailsLoading value) loading,
    required TResult Function(_ArtistDetailsData value) data,
    required TResult Function(_ArtistDetailsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_ArtistDetailsLoading value)? loading,
    TResult? Function(_ArtistDetailsData value)? data,
    TResult? Function(_ArtistDetailsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ArtistDetailsLoading value)? loading,
    TResult Function(_ArtistDetailsData value)? data,
    TResult Function(_ArtistDetailsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ArtistDetailsError implements ArtistDetailsState {
  const factory _ArtistDetailsError({required final String message}) =
      _$ArtistDetailsErrorImpl;

  String get message;

  /// Create a copy of ArtistDetailsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistDetailsErrorImplCopyWith<_$ArtistDetailsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
