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
mixin _$PagedList<T> {
  List<T> get items => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;

  /// Create a copy of PagedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PagedListCopyWith<T, PagedList<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PagedListCopyWith<T, $Res> {
  factory $PagedListCopyWith(
    PagedList<T> value,
    $Res Function(PagedList<T>) then,
  ) = _$PagedListCopyWithImpl<T, $Res, PagedList<T>>;
  @useResult
  $Res call({List<T> items, int page, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class _$PagedListCopyWithImpl<T, $Res, $Val extends PagedList<T>>
    implements $PagedListCopyWith<T, $Res> {
  _$PagedListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PagedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<T>,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            isLoadingMore: null == isLoadingMore
                ? _value.isLoadingMore
                : isLoadingMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PagedListImplCopyWith<T, $Res>
    implements $PagedListCopyWith<T, $Res> {
  factory _$$PagedListImplCopyWith(
    _$PagedListImpl<T> value,
    $Res Function(_$PagedListImpl<T>) then,
  ) = __$$PagedListImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({List<T> items, int page, bool hasMore, bool isLoadingMore});
}

/// @nodoc
class __$$PagedListImplCopyWithImpl<T, $Res>
    extends _$PagedListCopyWithImpl<T, $Res, _$PagedListImpl<T>>
    implements _$$PagedListImplCopyWith<T, $Res> {
  __$$PagedListImplCopyWithImpl(
    _$PagedListImpl<T> _value,
    $Res Function(_$PagedListImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of PagedList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? hasMore = null,
    Object? isLoadingMore = null,
  }) {
    return _then(
      _$PagedListImpl<T>(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<T>,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
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

class _$PagedListImpl<T> implements _PagedList<T> {
  const _$PagedListImpl({
    final List<T> items = const [],
    this.page = 1,
    this.hasMore = false,
    this.isLoadingMore = false,
  }) : _items = items;

  final List<T> _items;
  @override
  @JsonKey()
  List<T> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  @JsonKey()
  final bool isLoadingMore;

  @override
  String toString() {
    return 'PagedList<$T>(items: $items, page: $page, hasMore: $hasMore, isLoadingMore: $isLoadingMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PagedListImpl<T> &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    page,
    hasMore,
    isLoadingMore,
  );

  /// Create a copy of PagedList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PagedListImplCopyWith<T, _$PagedListImpl<T>> get copyWith =>
      __$$PagedListImplCopyWithImpl<T, _$PagedListImpl<T>>(this, _$identity);
}

abstract class _PagedList<T> implements PagedList<T> {
  const factory _PagedList({
    final List<T> items,
    final int page,
    final bool hasMore,
    final bool isLoadingMore,
  }) = _$PagedListImpl<T>;

  @override
  List<T> get items;
  @override
  int get page;
  @override
  bool get hasMore;
  @override
  bool get isLoadingMore;

  /// Create a copy of PagedList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PagedListImplCopyWith<T, _$PagedListImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ArtistState {
  /// Loaded on demand for id-only opens (player); list/search opens render
  /// the hero from the navigation hint instead.
  Artist? get artist => throw _privateConstructorUsedError;
  ArtistTab get selectedTab => throw _privateConstructorUsedError;
  PagedList<Track> get tracks => throw _privateConstructorUsedError;
  PagedList<Album> get albums => throw _privateConstructorUsedError;

  /// Album-less tracks, rendered as one-track pseudo-albums by the screen.
  PagedList<Track> get singles => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtistStateCopyWith<ArtistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtistStateCopyWith<$Res> {
  factory $ArtistStateCopyWith(
    ArtistState value,
    $Res Function(ArtistState) then,
  ) = _$ArtistStateCopyWithImpl<$Res, ArtistState>;
  @useResult
  $Res call({
    Artist? artist,
    ArtistTab selectedTab,
    PagedList<Track> tracks,
    PagedList<Album> albums,
    PagedList<Track> singles,
    bool isLoading,
    String? error,
  });

  $ArtistCopyWith<$Res>? get artist;
  $PagedListCopyWith<Track, $Res> get tracks;
  $PagedListCopyWith<Album, $Res> get albums;
  $PagedListCopyWith<Track, $Res> get singles;
}

/// @nodoc
class _$ArtistStateCopyWithImpl<$Res, $Val extends ArtistState>
    implements $ArtistStateCopyWith<$Res> {
  _$ArtistStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artist = freezed,
    Object? selectedTab = null,
    Object? tracks = null,
    Object? albums = null,
    Object? singles = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            artist: freezed == artist
                ? _value.artist
                : artist // ignore: cast_nullable_to_non_nullable
                      as Artist?,
            selectedTab: null == selectedTab
                ? _value.selectedTab
                : selectedTab // ignore: cast_nullable_to_non_nullable
                      as ArtistTab,
            tracks: null == tracks
                ? _value.tracks
                : tracks // ignore: cast_nullable_to_non_nullable
                      as PagedList<Track>,
            albums: null == albums
                ? _value.albums
                : albums // ignore: cast_nullable_to_non_nullable
                      as PagedList<Album>,
            singles: null == singles
                ? _value.singles
                : singles // ignore: cast_nullable_to_non_nullable
                      as PagedList<Track>,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtistCopyWith<$Res>? get artist {
    if (_value.artist == null) {
      return null;
    }

    return $ArtistCopyWith<$Res>(_value.artist!, (value) {
      return _then(_value.copyWith(artist: value) as $Val);
    });
  }

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagedListCopyWith<Track, $Res> get tracks {
    return $PagedListCopyWith<Track, $Res>(_value.tracks, (value) {
      return _then(_value.copyWith(tracks: value) as $Val);
    });
  }

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagedListCopyWith<Album, $Res> get albums {
    return $PagedListCopyWith<Album, $Res>(_value.albums, (value) {
      return _then(_value.copyWith(albums: value) as $Val);
    });
  }

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PagedListCopyWith<Track, $Res> get singles {
    return $PagedListCopyWith<Track, $Res>(_value.singles, (value) {
      return _then(_value.copyWith(singles: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArtistStateImplCopyWith<$Res>
    implements $ArtistStateCopyWith<$Res> {
  factory _$$ArtistStateImplCopyWith(
    _$ArtistStateImpl value,
    $Res Function(_$ArtistStateImpl) then,
  ) = __$$ArtistStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    Artist? artist,
    ArtistTab selectedTab,
    PagedList<Track> tracks,
    PagedList<Album> albums,
    PagedList<Track> singles,
    bool isLoading,
    String? error,
  });

  @override
  $ArtistCopyWith<$Res>? get artist;
  @override
  $PagedListCopyWith<Track, $Res> get tracks;
  @override
  $PagedListCopyWith<Album, $Res> get albums;
  @override
  $PagedListCopyWith<Track, $Res> get singles;
}

/// @nodoc
class __$$ArtistStateImplCopyWithImpl<$Res>
    extends _$ArtistStateCopyWithImpl<$Res, _$ArtistStateImpl>
    implements _$$ArtistStateImplCopyWith<$Res> {
  __$$ArtistStateImplCopyWithImpl(
    _$ArtistStateImpl _value,
    $Res Function(_$ArtistStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artist = freezed,
    Object? selectedTab = null,
    Object? tracks = null,
    Object? albums = null,
    Object? singles = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ArtistStateImpl(
        artist: freezed == artist
            ? _value.artist
            : artist // ignore: cast_nullable_to_non_nullable
                  as Artist?,
        selectedTab: null == selectedTab
            ? _value.selectedTab
            : selectedTab // ignore: cast_nullable_to_non_nullable
                  as ArtistTab,
        tracks: null == tracks
            ? _value.tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as PagedList<Track>,
        albums: null == albums
            ? _value.albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as PagedList<Album>,
        singles: null == singles
            ? _value.singles
            : singles // ignore: cast_nullable_to_non_nullable
                  as PagedList<Track>,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
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

class _$ArtistStateImpl implements _ArtistState {
  const _$ArtistStateImpl({
    this.artist,
    this.selectedTab = ArtistTab.tracks,
    this.tracks = const PagedList<Track>(),
    this.albums = const PagedList<Album>(),
    this.singles = const PagedList<Track>(),
    this.isLoading = true,
    this.error,
  });

  /// Loaded on demand for id-only opens (player); list/search opens render
  /// the hero from the navigation hint instead.
  @override
  final Artist? artist;
  @override
  @JsonKey()
  final ArtistTab selectedTab;
  @override
  @JsonKey()
  final PagedList<Track> tracks;
  @override
  @JsonKey()
  final PagedList<Album> albums;

  /// Album-less tracks, rendered as one-track pseudo-albums by the screen.
  @override
  @JsonKey()
  final PagedList<Track> singles;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'ArtistState(artist: $artist, selectedTab: $selectedTab, tracks: $tracks, albums: $albums, singles: $singles, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtistStateImpl &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.tracks, tracks) || other.tracks == tracks) &&
            (identical(other.albums, albums) || other.albums == albums) &&
            (identical(other.singles, singles) || other.singles == singles) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    artist,
    selectedTab,
    tracks,
    albums,
    singles,
    isLoading,
    error,
  );

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtistStateImplCopyWith<_$ArtistStateImpl> get copyWith =>
      __$$ArtistStateImplCopyWithImpl<_$ArtistStateImpl>(this, _$identity);
}

abstract class _ArtistState implements ArtistState {
  const factory _ArtistState({
    final Artist? artist,
    final ArtistTab selectedTab,
    final PagedList<Track> tracks,
    final PagedList<Album> albums,
    final PagedList<Track> singles,
    final bool isLoading,
    final String? error,
  }) = _$ArtistStateImpl;

  /// Loaded on demand for id-only opens (player); list/search opens render
  /// the hero from the navigation hint instead.
  @override
  Artist? get artist;
  @override
  ArtistTab get selectedTab;
  @override
  PagedList<Track> get tracks;
  @override
  PagedList<Album> get albums;

  /// Album-less tracks, rendered as one-track pseudo-albums by the screen.
  @override
  PagedList<Track> get singles;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of ArtistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtistStateImplCopyWith<_$ArtistStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
