// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_to_playlist_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AddToPlaylistState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  List<Playlist> get playlists => throw _privateConstructorUsedError;
  Set<String> get selectedIds => throw _privateConstructorUsedError;
  Set<String> get initialSelectedIds => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AddToPlaylistState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddToPlaylistStateCopyWith<AddToPlaylistState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddToPlaylistStateCopyWith<$Res> {
  factory $AddToPlaylistStateCopyWith(
    AddToPlaylistState value,
    $Res Function(AddToPlaylistState) then,
  ) = _$AddToPlaylistStateCopyWithImpl<$Res, AddToPlaylistState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    List<Playlist> playlists,
    Set<String> selectedIds,
    Set<String> initialSelectedIds,
    String? error,
  });
}

/// @nodoc
class _$AddToPlaylistStateCopyWithImpl<$Res, $Val extends AddToPlaylistState>
    implements $AddToPlaylistStateCopyWith<$Res> {
  _$AddToPlaylistStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddToPlaylistState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? playlists = null,
    Object? selectedIds = null,
    Object? initialSelectedIds = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            playlists: null == playlists
                ? _value.playlists
                : playlists // ignore: cast_nullable_to_non_nullable
                      as List<Playlist>,
            selectedIds: null == selectedIds
                ? _value.selectedIds
                : selectedIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
            initialSelectedIds: null == initialSelectedIds
                ? _value.initialSelectedIds
                : initialSelectedIds // ignore: cast_nullable_to_non_nullable
                      as Set<String>,
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
abstract class _$$AddToPlaylistStateImplCopyWith<$Res>
    implements $AddToPlaylistStateCopyWith<$Res> {
  factory _$$AddToPlaylistStateImplCopyWith(
    _$AddToPlaylistStateImpl value,
    $Res Function(_$AddToPlaylistStateImpl) then,
  ) = __$$AddToPlaylistStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    List<Playlist> playlists,
    Set<String> selectedIds,
    Set<String> initialSelectedIds,
    String? error,
  });
}

/// @nodoc
class __$$AddToPlaylistStateImplCopyWithImpl<$Res>
    extends _$AddToPlaylistStateCopyWithImpl<$Res, _$AddToPlaylistStateImpl>
    implements _$$AddToPlaylistStateImplCopyWith<$Res> {
  __$$AddToPlaylistStateImplCopyWithImpl(
    _$AddToPlaylistStateImpl _value,
    $Res Function(_$AddToPlaylistStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddToPlaylistState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? playlists = null,
    Object? selectedIds = null,
    Object? initialSelectedIds = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AddToPlaylistStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        playlists: null == playlists
            ? _value._playlists
            : playlists // ignore: cast_nullable_to_non_nullable
                  as List<Playlist>,
        selectedIds: null == selectedIds
            ? _value._selectedIds
            : selectedIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        initialSelectedIds: null == initialSelectedIds
            ? _value._initialSelectedIds
            : initialSelectedIds // ignore: cast_nullable_to_non_nullable
                  as Set<String>,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$AddToPlaylistStateImpl implements _AddToPlaylistState {
  const _$AddToPlaylistStateImpl({
    this.isLoading = true,
    this.isSaving = false,
    final List<Playlist> playlists = const [],
    final Set<String> selectedIds = const {},
    final Set<String> initialSelectedIds = const {},
    this.error,
  }) : _playlists = playlists,
       _selectedIds = selectedIds,
       _initialSelectedIds = initialSelectedIds;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  final List<Playlist> _playlists;
  @override
  @JsonKey()
  List<Playlist> get playlists {
    if (_playlists is EqualUnmodifiableListView) return _playlists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlists);
  }

  final Set<String> _selectedIds;
  @override
  @JsonKey()
  Set<String> get selectedIds {
    if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedIds);
  }

  final Set<String> _initialSelectedIds;
  @override
  @JsonKey()
  Set<String> get initialSelectedIds {
    if (_initialSelectedIds is EqualUnmodifiableSetView)
      return _initialSelectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_initialSelectedIds);
  }

  @override
  final String? error;

  @override
  String toString() {
    return 'AddToPlaylistState(isLoading: $isLoading, isSaving: $isSaving, playlists: $playlists, selectedIds: $selectedIds, initialSelectedIds: $initialSelectedIds, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddToPlaylistStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            const DeepCollectionEquality().equals(
              other._playlists,
              _playlists,
            ) &&
            const DeepCollectionEquality().equals(
              other._selectedIds,
              _selectedIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._initialSelectedIds,
              _initialSelectedIds,
            ) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSaving,
    const DeepCollectionEquality().hash(_playlists),
    const DeepCollectionEquality().hash(_selectedIds),
    const DeepCollectionEquality().hash(_initialSelectedIds),
    error,
  );

  /// Create a copy of AddToPlaylistState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddToPlaylistStateImplCopyWith<_$AddToPlaylistStateImpl> get copyWith =>
      __$$AddToPlaylistStateImplCopyWithImpl<_$AddToPlaylistStateImpl>(
        this,
        _$identity,
      );
}

abstract class _AddToPlaylistState implements AddToPlaylistState {
  const factory _AddToPlaylistState({
    final bool isLoading,
    final bool isSaving,
    final List<Playlist> playlists,
    final Set<String> selectedIds,
    final Set<String> initialSelectedIds,
    final String? error,
  }) = _$AddToPlaylistStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  List<Playlist> get playlists;
  @override
  Set<String> get selectedIds;
  @override
  Set<String> get initialSelectedIds;
  @override
  String? get error;

  /// Create a copy of AddToPlaylistState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddToPlaylistStateImplCopyWith<_$AddToPlaylistStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
