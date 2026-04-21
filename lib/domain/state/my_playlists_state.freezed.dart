// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_playlists_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyPlaylistsState {
  List<Playlist> get playlists => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of MyPlaylistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyPlaylistsStateCopyWith<MyPlaylistsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyPlaylistsStateCopyWith<$Res> {
  factory $MyPlaylistsStateCopyWith(
    MyPlaylistsState value,
    $Res Function(MyPlaylistsState) then,
  ) = _$MyPlaylistsStateCopyWithImpl<$Res, MyPlaylistsState>;
  @useResult
  $Res call({List<Playlist> playlists, bool isLoading, String? error});
}

/// @nodoc
class _$MyPlaylistsStateCopyWithImpl<$Res, $Val extends MyPlaylistsState>
    implements $MyPlaylistsStateCopyWith<$Res> {
  _$MyPlaylistsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyPlaylistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlists = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            playlists: null == playlists
                ? _value.playlists
                : playlists // ignore: cast_nullable_to_non_nullable
                      as List<Playlist>,
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
}

/// @nodoc
abstract class _$$MyPlaylistsStateImplCopyWith<$Res>
    implements $MyPlaylistsStateCopyWith<$Res> {
  factory _$$MyPlaylistsStateImplCopyWith(
    _$MyPlaylistsStateImpl value,
    $Res Function(_$MyPlaylistsStateImpl) then,
  ) = __$$MyPlaylistsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Playlist> playlists, bool isLoading, String? error});
}

/// @nodoc
class __$$MyPlaylistsStateImplCopyWithImpl<$Res>
    extends _$MyPlaylistsStateCopyWithImpl<$Res, _$MyPlaylistsStateImpl>
    implements _$$MyPlaylistsStateImplCopyWith<$Res> {
  __$$MyPlaylistsStateImplCopyWithImpl(
    _$MyPlaylistsStateImpl _value,
    $Res Function(_$MyPlaylistsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyPlaylistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? playlists = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$MyPlaylistsStateImpl(
        playlists: null == playlists
            ? _value._playlists
            : playlists // ignore: cast_nullable_to_non_nullable
                  as List<Playlist>,
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

class _$MyPlaylistsStateImpl implements _MyPlaylistsState {
  const _$MyPlaylistsStateImpl({
    final List<Playlist> playlists = const [],
    this.isLoading = false,
    this.error,
  }) : _playlists = playlists;

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
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'MyPlaylistsState(playlists: $playlists, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyPlaylistsStateImpl &&
            const DeepCollectionEquality().equals(
              other._playlists,
              _playlists,
            ) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_playlists),
    isLoading,
    error,
  );

  /// Create a copy of MyPlaylistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyPlaylistsStateImplCopyWith<_$MyPlaylistsStateImpl> get copyWith =>
      __$$MyPlaylistsStateImplCopyWithImpl<_$MyPlaylistsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MyPlaylistsState implements MyPlaylistsState {
  const factory _MyPlaylistsState({
    final List<Playlist> playlists,
    final bool isLoading,
    final String? error,
  }) = _$MyPlaylistsStateImpl;

  @override
  List<Playlist> get playlists;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of MyPlaylistsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyPlaylistsStateImplCopyWith<_$MyPlaylistsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
