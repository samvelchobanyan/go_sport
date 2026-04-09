// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_artists_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyArtistsState {
  List<Artist> get artists => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyArtistsStateCopyWith<MyArtistsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyArtistsStateCopyWith<$Res> {
  factory $MyArtistsStateCopyWith(
    MyArtistsState value,
    $Res Function(MyArtistsState) then,
  ) = _$MyArtistsStateCopyWithImpl<$Res, MyArtistsState>;
  @useResult
  $Res call({
    List<Artist> artists,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class _$MyArtistsStateCopyWithImpl<$Res, $Val extends MyArtistsState>
    implements $MyArtistsStateCopyWith<$Res> {
  _$MyArtistsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            artists: null == artists
                ? _value.artists
                : artists // ignore: cast_nullable_to_non_nullable
                      as List<Artist>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
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
abstract class _$$MyArtistsStateImplCopyWith<$Res>
    implements $MyArtistsStateCopyWith<$Res> {
  factory _$$MyArtistsStateImplCopyWith(
    _$MyArtistsStateImpl value,
    $Res Function(_$MyArtistsStateImpl) then,
  ) = __$$MyArtistsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Artist> artists,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class __$$MyArtistsStateImplCopyWithImpl<$Res>
    extends _$MyArtistsStateCopyWithImpl<$Res, _$MyArtistsStateImpl>
    implements _$$MyArtistsStateImplCopyWith<$Res> {
  __$$MyArtistsStateImplCopyWithImpl(
    _$MyArtistsStateImpl _value,
    $Res Function(_$MyArtistsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$MyArtistsStateImpl(
        artists: null == artists
            ? _value._artists
            : artists // ignore: cast_nullable_to_non_nullable
                  as List<Artist>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
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

class _$MyArtistsStateImpl implements _MyArtistsState {
  const _$MyArtistsStateImpl({
    final List<Artist> artists = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  }) : _artists = artists;

  final List<Artist> _artists;
  @override
  @JsonKey()
  List<Artist> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  final String? error;

  @override
  String toString() {
    return 'MyArtistsState(artists: $artists, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyArtistsStateImpl &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_artists),
    isLoading,
    isLoadingMore,
    error,
  );

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyArtistsStateImplCopyWith<_$MyArtistsStateImpl> get copyWith =>
      __$$MyArtistsStateImplCopyWithImpl<_$MyArtistsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MyArtistsState implements MyArtistsState {
  const factory _MyArtistsState({
    final List<Artist> artists,
    final bool isLoading,
    final bool isLoadingMore,
    final String? error,
  }) = _$MyArtistsStateImpl;

  @override
  List<Artist> get artists;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error;

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyArtistsStateImplCopyWith<_$MyArtistsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
