// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_list_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FavoritesListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> songs) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> songs)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> songs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FavoritesListLoading value) loading,
    required TResult Function(_FavoritesListData value) data,
    required TResult Function(_FavoritesListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FavoritesListLoading value)? loading,
    TResult? Function(_FavoritesListData value)? data,
    TResult? Function(_FavoritesListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FavoritesListLoading value)? loading,
    TResult Function(_FavoritesListData value)? data,
    TResult Function(_FavoritesListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavoritesListStateCopyWith<$Res> {
  factory $FavoritesListStateCopyWith(
    FavoritesListState value,
    $Res Function(FavoritesListState) then,
  ) = _$FavoritesListStateCopyWithImpl<$Res, FavoritesListState>;
}

/// @nodoc
class _$FavoritesListStateCopyWithImpl<$Res, $Val extends FavoritesListState>
    implements $FavoritesListStateCopyWith<$Res> {
  _$FavoritesListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$FavoritesListLoadingImplCopyWith<$Res> {
  factory _$$FavoritesListLoadingImplCopyWith(
    _$FavoritesListLoadingImpl value,
    $Res Function(_$FavoritesListLoadingImpl) then,
  ) = __$$FavoritesListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FavoritesListLoadingImplCopyWithImpl<$Res>
    extends _$FavoritesListStateCopyWithImpl<$Res, _$FavoritesListLoadingImpl>
    implements _$$FavoritesListLoadingImplCopyWith<$Res> {
  __$$FavoritesListLoadingImplCopyWithImpl(
    _$FavoritesListLoadingImpl _value,
    $Res Function(_$FavoritesListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FavoritesListLoadingImpl implements _FavoritesListLoading {
  const _$FavoritesListLoadingImpl();

  @override
  String toString() {
    return 'FavoritesListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> songs) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> songs)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> songs)? data,
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
    required TResult Function(_FavoritesListLoading value) loading,
    required TResult Function(_FavoritesListData value) data,
    required TResult Function(_FavoritesListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FavoritesListLoading value)? loading,
    TResult? Function(_FavoritesListData value)? data,
    TResult? Function(_FavoritesListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FavoritesListLoading value)? loading,
    TResult Function(_FavoritesListData value)? data,
    TResult Function(_FavoritesListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _FavoritesListLoading implements FavoritesListState {
  const factory _FavoritesListLoading() = _$FavoritesListLoadingImpl;
}

/// @nodoc
abstract class _$$FavoritesListDataImplCopyWith<$Res> {
  factory _$$FavoritesListDataImplCopyWith(
    _$FavoritesListDataImpl value,
    $Res Function(_$FavoritesListDataImpl) then,
  ) = __$$FavoritesListDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Track> songs});
}

/// @nodoc
class __$$FavoritesListDataImplCopyWithImpl<$Res>
    extends _$FavoritesListStateCopyWithImpl<$Res, _$FavoritesListDataImpl>
    implements _$$FavoritesListDataImplCopyWith<$Res> {
  __$$FavoritesListDataImplCopyWithImpl(
    _$FavoritesListDataImpl _value,
    $Res Function(_$FavoritesListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? songs = null}) {
    return _then(
      _$FavoritesListDataImpl(
        songs: null == songs
            ? _value._songs
            : songs // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }
}

/// @nodoc

class _$FavoritesListDataImpl implements _FavoritesListData {
  const _$FavoritesListDataImpl({required final List<Track> songs})
    : _songs = songs;

  final List<Track> _songs;
  @override
  List<Track> get songs {
    if (_songs is EqualUnmodifiableListView) return _songs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_songs);
  }

  @override
  String toString() {
    return 'FavoritesListState.data(songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesListDataImpl &&
            const DeepCollectionEquality().equals(other._songs, _songs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_songs));

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesListDataImplCopyWith<_$FavoritesListDataImpl> get copyWith =>
      __$$FavoritesListDataImplCopyWithImpl<_$FavoritesListDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> songs) data,
    required TResult Function(String message) error,
  }) {
    return data(songs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> songs)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(songs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> songs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(songs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_FavoritesListLoading value) loading,
    required TResult Function(_FavoritesListData value) data,
    required TResult Function(_FavoritesListError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FavoritesListLoading value)? loading,
    TResult? Function(_FavoritesListData value)? data,
    TResult? Function(_FavoritesListError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FavoritesListLoading value)? loading,
    TResult Function(_FavoritesListData value)? data,
    TResult Function(_FavoritesListError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _FavoritesListData implements FavoritesListState {
  const factory _FavoritesListData({required final List<Track> songs}) =
      _$FavoritesListDataImpl;

  List<Track> get songs;

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritesListDataImplCopyWith<_$FavoritesListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FavoritesListErrorImplCopyWith<$Res> {
  factory _$$FavoritesListErrorImplCopyWith(
    _$FavoritesListErrorImpl value,
    $Res Function(_$FavoritesListErrorImpl) then,
  ) = __$$FavoritesListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$FavoritesListErrorImplCopyWithImpl<$Res>
    extends _$FavoritesListStateCopyWithImpl<$Res, _$FavoritesListErrorImpl>
    implements _$$FavoritesListErrorImplCopyWith<$Res> {
  __$$FavoritesListErrorImplCopyWithImpl(
    _$FavoritesListErrorImpl _value,
    $Res Function(_$FavoritesListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$FavoritesListErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$FavoritesListErrorImpl implements _FavoritesListError {
  const _$FavoritesListErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'FavoritesListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FavoritesListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FavoritesListErrorImplCopyWith<_$FavoritesListErrorImpl> get copyWith =>
      __$$FavoritesListErrorImplCopyWithImpl<_$FavoritesListErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<Track> songs) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Track> songs)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Track> songs)? data,
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
    required TResult Function(_FavoritesListLoading value) loading,
    required TResult Function(_FavoritesListData value) data,
    required TResult Function(_FavoritesListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_FavoritesListLoading value)? loading,
    TResult? Function(_FavoritesListData value)? data,
    TResult? Function(_FavoritesListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_FavoritesListLoading value)? loading,
    TResult Function(_FavoritesListData value)? data,
    TResult Function(_FavoritesListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _FavoritesListError implements FavoritesListState {
  const factory _FavoritesListError({required final String message}) =
      _$FavoritesListErrorImpl;

  String get message;

  /// Create a copy of FavoritesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FavoritesListErrorImplCopyWith<_$FavoritesListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
