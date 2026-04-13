// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_albums_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyAlbumsState {
  List<Album> get albums => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyAlbumsStateCopyWith<MyAlbumsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAlbumsStateCopyWith<$Res> {
  factory $MyAlbumsStateCopyWith(
    MyAlbumsState value,
    $Res Function(MyAlbumsState) then,
  ) = _$MyAlbumsStateCopyWithImpl<$Res, MyAlbumsState>;
  @useResult
  $Res call({
    List<Album> albums,
    bool isLoading,
    bool isLoadingMore,
    int currentPage,
    bool hasMore,
    String? error,
  });
}

/// @nodoc
class _$MyAlbumsStateCopyWithImpl<$Res, $Val extends MyAlbumsState>
    implements $MyAlbumsStateCopyWith<$Res> {
  _$MyAlbumsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albums = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            albums: null == albums
                ? _value.albums
                : albums // ignore: cast_nullable_to_non_nullable
                      as List<Album>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
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
abstract class _$$MyAlbumsStateImplCopyWith<$Res>
    implements $MyAlbumsStateCopyWith<$Res> {
  factory _$$MyAlbumsStateImplCopyWith(
    _$MyAlbumsStateImpl value,
    $Res Function(_$MyAlbumsStateImpl) then,
  ) = __$$MyAlbumsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Album> albums,
    bool isLoading,
    bool isLoadingMore,
    int currentPage,
    bool hasMore,
    String? error,
  });
}

/// @nodoc
class __$$MyAlbumsStateImplCopyWithImpl<$Res>
    extends _$MyAlbumsStateCopyWithImpl<$Res, _$MyAlbumsStateImpl>
    implements _$$MyAlbumsStateImplCopyWith<$Res> {
  __$$MyAlbumsStateImplCopyWithImpl(
    _$MyAlbumsStateImpl _value,
    $Res Function(_$MyAlbumsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? albums = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$MyAlbumsStateImpl(
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isLoadingMore: null == isLoadingMore
            ? _value.isLoadingMore
            : isLoadingMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$MyAlbumsStateImpl implements _MyAlbumsState {
  const _$MyAlbumsStateImpl({
    final List<Album> albums = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.hasMore = true,
    this.error,
  }) : _albums = albums;

  final List<Album> _albums;
  @override
  @JsonKey()
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? error;

  @override
  String toString() {
    return 'MyAlbumsState(albums: $albums, isLoading: $isLoading, isLoadingMore: $isLoadingMore, currentPage: $currentPage, hasMore: $hasMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyAlbumsStateImpl &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_albums),
    isLoading,
    isLoadingMore,
    currentPage,
    hasMore,
    error,
  );

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyAlbumsStateImplCopyWith<_$MyAlbumsStateImpl> get copyWith =>
      __$$MyAlbumsStateImplCopyWithImpl<_$MyAlbumsStateImpl>(this, _$identity);
}

abstract class _MyAlbumsState implements MyAlbumsState {
  const factory _MyAlbumsState({
    final List<Album> albums,
    final bool isLoading,
    final bool isLoadingMore,
    final int currentPage,
    final bool hasMore,
    final String? error,
  }) = _$MyAlbumsStateImpl;

  @override
  List<Album> get albums;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  int get currentPage;
  @override
  bool get hasMore;
  @override
  String? get error;

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyAlbumsStateImplCopyWith<_$MyAlbumsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
