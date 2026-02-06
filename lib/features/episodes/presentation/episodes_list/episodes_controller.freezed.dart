// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'episodes_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EpisodesListState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<Episode> episodes,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EpisodesListLoading value) loading,
    required TResult Function(_EpisodesListData value) data,
    required TResult Function(_EpisodesListError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EpisodesListLoading value)? loading,
    TResult? Function(_EpisodesListData value)? data,
    TResult? Function(_EpisodesListError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EpisodesListLoading value)? loading,
    TResult Function(_EpisodesListData value)? data,
    TResult Function(_EpisodesListError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodesListStateCopyWith<$Res> {
  factory $EpisodesListStateCopyWith(
    EpisodesListState value,
    $Res Function(EpisodesListState) then,
  ) = _$EpisodesListStateCopyWithImpl<$Res, EpisodesListState>;
}

/// @nodoc
class _$EpisodesListStateCopyWithImpl<$Res, $Val extends EpisodesListState>
    implements $EpisodesListStateCopyWith<$Res> {
  _$EpisodesListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EpisodesListLoadingImplCopyWith<$Res> {
  factory _$$EpisodesListLoadingImplCopyWith(
    _$EpisodesListLoadingImpl value,
    $Res Function(_$EpisodesListLoadingImpl) then,
  ) = __$$EpisodesListLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EpisodesListLoadingImplCopyWithImpl<$Res>
    extends _$EpisodesListStateCopyWithImpl<$Res, _$EpisodesListLoadingImpl>
    implements _$$EpisodesListLoadingImplCopyWith<$Res> {
  __$$EpisodesListLoadingImplCopyWithImpl(
    _$EpisodesListLoadingImpl _value,
    $Res Function(_$EpisodesListLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EpisodesListLoadingImpl implements _EpisodesListLoading {
  const _$EpisodesListLoadingImpl();

  @override
  String toString() {
    return 'EpisodesListState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodesListLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<Episode> episodes,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
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
    required TResult Function(_EpisodesListLoading value) loading,
    required TResult Function(_EpisodesListData value) data,
    required TResult Function(_EpisodesListError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EpisodesListLoading value)? loading,
    TResult? Function(_EpisodesListData value)? data,
    TResult? Function(_EpisodesListError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EpisodesListLoading value)? loading,
    TResult Function(_EpisodesListData value)? data,
    TResult Function(_EpisodesListError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _EpisodesListLoading implements EpisodesListState {
  const factory _EpisodesListLoading() = _$EpisodesListLoadingImpl;
}

/// @nodoc
abstract class _$$EpisodesListDataImplCopyWith<$Res> {
  factory _$$EpisodesListDataImplCopyWith(
    _$EpisodesListDataImpl value,
    $Res Function(_$EpisodesListDataImpl) then,
  ) = __$$EpisodesListDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<Episode> episodes, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class __$$EpisodesListDataImplCopyWithImpl<$Res>
    extends _$EpisodesListStateCopyWithImpl<$Res, _$EpisodesListDataImpl>
    implements _$$EpisodesListDataImplCopyWith<$Res> {
  __$$EpisodesListDataImplCopyWithImpl(
    _$EpisodesListDataImpl _value,
    $Res Function(_$EpisodesListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? episodes = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$EpisodesListDataImpl(
        episodes: null == episodes
            ? _value._episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                  as List<Episode>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$EpisodesListDataImpl implements _EpisodesListData {
  const _$EpisodesListDataImpl({
    required final List<Episode> episodes,
    required this.hasMore,
    required this.isLoadingMore,
  }) : _episodes = episodes;

  final List<Episode> _episodes;
  @override
  List<Episode> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  final bool hasMore;
  @override
  final bool isLoadingMore;

  @override
  String toString() {
    return 'EpisodesListState.data(episodes: $episodes, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodesListDataImpl &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_episodes),
    hasMore,
    isLoadingMore,
  );

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodesListDataImplCopyWith<_$EpisodesListDataImpl> get copyWith =>
      __$$EpisodesListDataImplCopyWithImpl<_$EpisodesListDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<Episode> episodes,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return data(episodes, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(episodes, hasMore, isLoadingMore);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(episodes, hasMore, isLoadingMore);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EpisodesListLoading value) loading,
    required TResult Function(_EpisodesListData value) data,
    required TResult Function(_EpisodesListError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EpisodesListLoading value)? loading,
    TResult? Function(_EpisodesListData value)? data,
    TResult? Function(_EpisodesListError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EpisodesListLoading value)? loading,
    TResult Function(_EpisodesListData value)? data,
    TResult Function(_EpisodesListError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class _EpisodesListData implements EpisodesListState {
  const factory _EpisodesListData({
    required final List<Episode> episodes,
    required final bool hasMore,
    required final bool isLoadingMore,
  }) = _$EpisodesListDataImpl;

  List<Episode> get episodes;
  bool get hasMore;
  bool get isLoadingMore;

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodesListDataImplCopyWith<_$EpisodesListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EpisodesListErrorImplCopyWith<$Res> {
  factory _$$EpisodesListErrorImplCopyWith(
    _$EpisodesListErrorImpl value,
    $Res Function(_$EpisodesListErrorImpl) then,
  ) = __$$EpisodesListErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EpisodesListErrorImplCopyWithImpl<$Res>
    extends _$EpisodesListStateCopyWithImpl<$Res, _$EpisodesListErrorImpl>
    implements _$$EpisodesListErrorImplCopyWith<$Res> {
  __$$EpisodesListErrorImplCopyWithImpl(
    _$EpisodesListErrorImpl _value,
    $Res Function(_$EpisodesListErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$EpisodesListErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EpisodesListErrorImpl implements _EpisodesListError {
  const _$EpisodesListErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'EpisodesListState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodesListErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodesListErrorImplCopyWith<_$EpisodesListErrorImpl> get copyWith =>
      __$$EpisodesListErrorImplCopyWithImpl<_$EpisodesListErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
      List<Episode> episodes,
      bool hasMore,
      bool isLoadingMore,
    )
    data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<Episode> episodes, bool hasMore, bool isLoadingMore)?
    data,
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
    required TResult Function(_EpisodesListLoading value) loading,
    required TResult Function(_EpisodesListData value) data,
    required TResult Function(_EpisodesListError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EpisodesListLoading value)? loading,
    TResult? Function(_EpisodesListData value)? data,
    TResult? Function(_EpisodesListError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EpisodesListLoading value)? loading,
    TResult Function(_EpisodesListData value)? data,
    TResult Function(_EpisodesListError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _EpisodesListError implements EpisodesListState {
  const factory _EpisodesListError({required final String message}) =
      _$EpisodesListErrorImpl;

  String get message;

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodesListErrorImplCopyWith<_$EpisodesListErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
