// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SearchState {
  String get query => throw _privateConstructorUsedError;
  SearchCategory get category => throw _privateConstructorUsedError;
  List<Track> get tracks => throw _privateConstructorUsedError;
  List<Album> get albums => throw _privateConstructorUsedError;
  List<Artist> get artists => throw _privateConstructorUsedError;
  List<Program> get programs => throw _privateConstructorUsedError;
  List<Playlist> get playlists => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchStateCopyWith<SearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
    SearchState value,
    $Res Function(SearchState) then,
  ) = _$SearchStateCopyWithImpl<$Res, SearchState>;
  @useResult
  $Res call({
    String query,
    SearchCategory category,
    List<Track> tracks,
    List<Album> albums,
    List<Artist> artists,
    List<Program> programs,
    List<Playlist> playlists,
    int currentPage,
    bool hasMore,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res, $Val extends SearchState>
    implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? category = null,
    Object? tracks = null,
    Object? albums = null,
    Object? artists = null,
    Object? programs = null,
    Object? playlists = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as SearchCategory,
            tracks: null == tracks
                ? _value.tracks
                : tracks // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
            albums: null == albums
                ? _value.albums
                : albums // ignore: cast_nullable_to_non_nullable
                      as List<Album>,
            artists: null == artists
                ? _value.artists
                : artists // ignore: cast_nullable_to_non_nullable
                      as List<Artist>,
            programs: null == programs
                ? _value.programs
                : programs // ignore: cast_nullable_to_non_nullable
                      as List<Program>,
            playlists: null == playlists
                ? _value.playlists
                : playlists // ignore: cast_nullable_to_non_nullable
                      as List<Playlist>,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$SearchStateImplCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$$SearchStateImplCopyWith(
    _$SearchStateImpl value,
    $Res Function(_$SearchStateImpl) then,
  ) = __$$SearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String query,
    SearchCategory category,
    List<Track> tracks,
    List<Album> albums,
    List<Artist> artists,
    List<Program> programs,
    List<Playlist> playlists,
    int currentPage,
    bool hasMore,
    bool isLoading,
    bool isLoadingMore,
    String? error,
  });
}

/// @nodoc
class __$$SearchStateImplCopyWithImpl<$Res>
    extends _$SearchStateCopyWithImpl<$Res, _$SearchStateImpl>
    implements _$$SearchStateImplCopyWith<$Res> {
  __$$SearchStateImplCopyWithImpl(
    _$SearchStateImpl _value,
    $Res Function(_$SearchStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? category = null,
    Object? tracks = null,
    Object? albums = null,
    Object? artists = null,
    Object? programs = null,
    Object? playlists = null,
    Object? currentPage = null,
    Object? hasMore = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$SearchStateImpl(
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as SearchCategory,
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
        artists: null == artists
            ? _value._artists
            : artists // ignore: cast_nullable_to_non_nullable
                  as List<Artist>,
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as List<Program>,
        playlists: null == playlists
            ? _value._playlists
            : playlists // ignore: cast_nullable_to_non_nullable
                  as List<Playlist>,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
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

class _$SearchStateImpl extends _SearchState {
  const _$SearchStateImpl({
    this.query = '',
    this.category = SearchCategory.all,
    final List<Track> tracks = const [],
    final List<Album> albums = const [],
    final List<Artist> artists = const [],
    final List<Program> programs = const [],
    final List<Playlist> playlists = const [],
    this.currentPage = 1,
    this.hasMore = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  }) : _tracks = tracks,
       _albums = albums,
       _artists = artists,
       _programs = programs,
       _playlists = playlists,
       super._();

  @override
  @JsonKey()
  final String query;
  @override
  @JsonKey()
  final SearchCategory category;
  final List<Track> _tracks;
  @override
  @JsonKey()
  List<Track> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  final List<Album> _albums;
  @override
  @JsonKey()
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  final List<Artist> _artists;
  @override
  @JsonKey()
  List<Artist> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  final List<Program> _programs;
  @override
  @JsonKey()
  List<Program> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  final List<Playlist> _playlists;
  @override
  @JsonKey()
  List<Playlist> get playlists {
    if (_playlists is EqualUnmodifiableListView) return _playlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlists);
  }

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final bool hasMore;
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
    return 'SearchState(query: $query, category: $category, tracks: $tracks, albums: $albums, artists: $artists, programs: $programs, playlists: $playlists, currentPage: $currentPage, hasMore: $hasMore, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchStateImpl &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            const DeepCollectionEquality().equals(other._albums, _albums) &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            const DeepCollectionEquality().equals(other._programs, _programs) &&
            const DeepCollectionEquality().equals(
              other._playlists,
              _playlists,
            ) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    query,
    category,
    const DeepCollectionEquality().hash(_tracks),
    const DeepCollectionEquality().hash(_albums),
    const DeepCollectionEquality().hash(_artists),
    const DeepCollectionEquality().hash(_programs),
    const DeepCollectionEquality().hash(_playlists),
    currentPage,
    hasMore,
    isLoading,
    isLoadingMore,
    error,
  );

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      __$$SearchStateImplCopyWithImpl<_$SearchStateImpl>(this, _$identity);
}

abstract class _SearchState extends SearchState {
  const factory _SearchState({
    final String query,
    final SearchCategory category,
    final List<Track> tracks,
    final List<Album> albums,
    final List<Artist> artists,
    final List<Program> programs,
    final List<Playlist> playlists,
    final int currentPage,
    final bool hasMore,
    final bool isLoading,
    final bool isLoadingMore,
    final String? error,
  }) = _$SearchStateImpl;
  const _SearchState._() : super._();

  @override
  String get query;
  @override
  SearchCategory get category;
  @override
  List<Track> get tracks;
  @override
  List<Album> get albums;
  @override
  List<Artist> get artists;
  @override
  List<Program> get programs;
  @override
  List<Playlist> get playlists;
  @override
  int get currentPage;
  @override
  bool get hasMore;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchStateImplCopyWith<_$SearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
