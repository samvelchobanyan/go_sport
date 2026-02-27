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
  List<Track> get episodes => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EpisodesListStateCopyWith<EpisodesListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EpisodesListStateCopyWith<$Res> {
  factory $EpisodesListStateCopyWith(
    EpisodesListState value,
    $Res Function(EpisodesListState) then,
  ) = _$EpisodesListStateCopyWithImpl<$Res, EpisodesListState>;
  @useResult
  $Res call({
    List<Track> episodes,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    String? error,
  });
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
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? episodes = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            episodes: null == episodes
                ? _value.episodes
                : episodes // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EpisodesListStateImplCopyWith<$Res>
    implements $EpisodesListStateCopyWith<$Res> {
  factory _$$EpisodesListStateImplCopyWith(
    _$EpisodesListStateImpl value,
    $Res Function(_$EpisodesListStateImpl) then,
  ) = __$$EpisodesListStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Track> episodes,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    String? error,
  });
}

/// @nodoc
class __$$EpisodesListStateImplCopyWithImpl<$Res>
    extends _$EpisodesListStateCopyWithImpl<$Res, _$EpisodesListStateImpl>
    implements _$$EpisodesListStateImplCopyWith<$Res> {
  __$$EpisodesListStateImplCopyWithImpl(
    _$EpisodesListStateImpl _value,
    $Res Function(_$EpisodesListStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? episodes = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$EpisodesListStateImpl(
        episodes: null == episodes
            ? _value._episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$EpisodesListStateImpl implements _EpisodesListState {
  const _$EpisodesListStateImpl({
    final List<Track> episodes = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.error,
  }) : _episodes = episodes;

  final List<Track> _episodes;
  @override
  @JsonKey()
  List<Track> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? error;

  @override
  String toString() {
    return 'EpisodesListState(episodes: $episodes, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EpisodesListStateImpl &&
            const DeepCollectionEquality().equals(other._episodes, _episodes) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_episodes),
    isLoading,
    isLoadingMore,
    hasMore,
    error,
  );

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EpisodesListStateImplCopyWith<_$EpisodesListStateImpl> get copyWith =>
      __$$EpisodesListStateImplCopyWithImpl<_$EpisodesListStateImpl>(
        this,
        _$identity,
      );
}

abstract class _EpisodesListState implements EpisodesListState {
  const factory _EpisodesListState({
    final List<Track> episodes,
    final bool isLoading,
    final bool isLoadingMore,
    final bool hasMore,
    final String? error,
  }) = _$EpisodesListStateImpl;

  @override
  List<Track> get episodes;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  String? get error;

  /// Create a copy of EpisodesListState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EpisodesListStateImplCopyWith<_$EpisodesListStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
