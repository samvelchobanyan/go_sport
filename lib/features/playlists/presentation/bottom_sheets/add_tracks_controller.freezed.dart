// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_tracks_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddTracksState {
  List<Track> get tracks => throw _privateConstructorUsedError;
  Set<String> get selectedTrackIds => throw _privateConstructorUsedError;
  String get query => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  int get currentPage => throw _privateConstructorUsedError;

  /// Create a copy of AddTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddTracksStateCopyWith<AddTracksState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTracksStateCopyWith<$Res> {
  factory $AddTracksStateCopyWith(
    AddTracksState value,
    $Res Function(AddTracksState) then,
  ) = _$AddTracksStateCopyWithImpl<$Res, AddTracksState>;
  @useResult
  $Res call({
    List<Track> tracks,
    Set<String> selectedTrackIds,
    String query,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    int currentPage,
  });
}

/// @nodoc
class _$AddTracksStateCopyWithImpl<$Res, $Val extends AddTracksState>
    implements $AddTracksStateCopyWith<$Res> {
  _$AddTracksStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tracks = null,
    Object? selectedTrackIds = null,
    Object? query = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(
      _value.copyWith(
            tracks: null == tracks
                ? _value.tracks
                : tracks // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
            selectedTrackIds: null == selectedTrackIds
                ? _value.selectedTrackIds
                : selectedTrackIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            query: null == query
                ? _value.query
                : query // ignore: cast_nullable_to_non_nullable
                      as String,
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
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddTracksStateImplCopyWith<$Res>
    implements $AddTracksStateCopyWith<$Res> {
  factory _$$AddTracksStateImplCopyWith(
    _$AddTracksStateImpl value,
    $Res Function(_$AddTracksStateImpl) then,
  ) = __$$AddTracksStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Track> tracks,
    Set<String> selectedTrackIds,
    String query,
    bool isLoading,
    bool isLoadingMore,
    bool hasMore,
    int currentPage,
  });
}

/// @nodoc
class __$$AddTracksStateImplCopyWithImpl<$Res>
    extends _$AddTracksStateCopyWithImpl<$Res, _$AddTracksStateImpl>
    implements _$$AddTracksStateImplCopyWith<$Res> {
  __$$AddTracksStateImplCopyWithImpl(
    _$AddTracksStateImpl _value,
    $Res Function(_$AddTracksStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddTracksState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tracks = null,
    Object? selectedTrackIds = null,
    Object? query = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMore = null,
    Object? currentPage = null,
  }) {
    return _then(
      _$AddTracksStateImpl(
        tracks: null == tracks
            ? _value._tracks
            : tracks // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
        selectedTrackIds: null == selectedTrackIds
            ? _value._selectedTrackIds
            : selectedTrackIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        query: null == query
            ? _value.query
            : query // ignore: cast_nullable_to_non_nullable
                  as String,
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
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$AddTracksStateImpl extends _AddTracksState {
  const _$AddTracksStateImpl({
    final List<Track> tracks = const [],
    final Set<String> selectedTrackIds = const {},
    this.query = '',
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.currentPage = 1,
  }) : _tracks = tracks,
       _selectedTrackIds = selectedTrackIds,
       super._();

  final List<Track> _tracks;
  @override
  @JsonKey()
  List<Track> get tracks {
    if (_tracks is EqualUnmodifiableListView) return _tracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tracks);
  }

  final Set<String> _selectedTrackIds;
  @override
  @JsonKey()
  Set<String> get selectedTrackIds {
    if (_selectedTrackIds is EqualUnmodifiableSetView) return _selectedTrackIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedTrackIds);
  }

  @override
  @JsonKey()
  final String query;
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
  @JsonKey()
  final int currentPage;

  @override
  String toString() {
    return 'AddTracksState(tracks: $tracks, selectedTrackIds: $selectedTrackIds, query: $query, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentPage: $currentPage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTracksStateImpl &&
            const DeepCollectionEquality().equals(other._tracks, _tracks) &&
            const DeepCollectionEquality().equals(
              other._selectedTrackIds,
              _selectedTrackIds,
            ) &&
            (identical(other.query, query) || other.query == query) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_tracks),
    const DeepCollectionEquality().hash(_selectedTrackIds),
    query,
    isLoading,
    isLoadingMore,
    hasMore,
    currentPage,
  );

  /// Create a copy of AddTracksState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTracksStateImplCopyWith<_$AddTracksStateImpl> get copyWith =>
      __$$AddTracksStateImplCopyWithImpl<_$AddTracksStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AddTracksState extends AddTracksState {
  const factory _AddTracksState({
    final List<Track> tracks,
    final Set<String> selectedTrackIds,
    final String query,
    final bool isLoading,
    final bool isLoadingMore,
    final bool hasMore,
    final int currentPage,
  }) = _$AddTracksStateImpl;
  const _AddTracksState._() : super._();

  @override
  List<Track> get tracks;
  @override
  Set<String> get selectedTrackIds;
  @override
  String get query;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMore;
  @override
  int get currentPage;

  /// Create a copy of AddTracksState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTracksStateImplCopyWith<_$AddTracksStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
