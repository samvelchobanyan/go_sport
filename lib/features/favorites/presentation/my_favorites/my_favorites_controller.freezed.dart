// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_favorites_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyFavoritesState {
  List<Track> get favorites => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MyFavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyFavoritesStateCopyWith<MyFavoritesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyFavoritesStateCopyWith<$Res> {
  factory $MyFavoritesStateCopyWith(
    MyFavoritesState value,
    $Res Function(MyFavoritesState) then,
  ) = _$MyFavoritesStateCopyWithImpl<$Res, MyFavoritesState>;
  @useResult
  $Res call({
    List<Track> favorites,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class _$MyFavoritesStateCopyWithImpl<$Res, $Val extends MyFavoritesState>
    implements $MyFavoritesStateCopyWith<$Res> {
  _$MyFavoritesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyFavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            favorites: null == favorites
                ? _value.favorites
                : favorites // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
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
abstract class _$$MyFavoritesStateImplCopyWith<$Res>
    implements $MyFavoritesStateCopyWith<$Res> {
  factory _$$MyFavoritesStateImplCopyWith(
    _$MyFavoritesStateImpl value,
    $Res Function(_$MyFavoritesStateImpl) then,
  ) = __$$MyFavoritesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Track> favorites,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class __$$MyFavoritesStateImplCopyWithImpl<$Res>
    extends _$MyFavoritesStateCopyWithImpl<$Res, _$MyFavoritesStateImpl>
    implements _$$MyFavoritesStateImplCopyWith<$Res> {
  __$$MyFavoritesStateImplCopyWithImpl(
    _$MyFavoritesStateImpl _value,
    $Res Function(_$MyFavoritesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyFavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? favorites = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$MyFavoritesStateImpl(
        favorites: null == favorites
            ? _value._favorites
            : favorites // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
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

class _$MyFavoritesStateImpl implements _MyFavoritesState {
  const _$MyFavoritesStateImpl({
    final List<Track> favorites = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  }) : _favorites = favorites;

  final List<Track> _favorites;
  @override
  @JsonKey()
  List<Track> get favorites {
    if (_favorites is EqualUnmodifiableListView) return _favorites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favorites);
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
    return 'MyFavoritesState(favorites: $favorites, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyFavoritesStateImpl &&
            const DeepCollectionEquality().equals(
              other._favorites,
              _favorites,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_favorites),
    isLoading,
    isLoadingMore,
    error,
  );

  /// Create a copy of MyFavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyFavoritesStateImplCopyWith<_$MyFavoritesStateImpl> get copyWith =>
      __$$MyFavoritesStateImplCopyWithImpl<_$MyFavoritesStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MyFavoritesState implements MyFavoritesState {
  const factory _MyFavoritesState({
    final List<Track> favorites,
    final bool isLoading,
    final bool isLoadingMore,
    final String? error,
  }) = _$MyFavoritesStateImpl;

  @override
  List<Track> get favorites;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error;

  /// Create a copy of MyFavoritesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyFavoritesStateImplCopyWith<_$MyFavoritesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
