// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_episodes_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NewEpisodesState {
  List<Track> get episodes => throw _privateConstructorUsedError;

  /// Create a copy of NewEpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewEpisodesStateCopyWith<NewEpisodesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewEpisodesStateCopyWith<$Res> {
  factory $NewEpisodesStateCopyWith(
    NewEpisodesState value,
    $Res Function(NewEpisodesState) then,
  ) = _$NewEpisodesStateCopyWithImpl<$Res, NewEpisodesState>;
  @useResult
  $Res call({List<Track> episodes});
}

/// @nodoc
class _$NewEpisodesStateCopyWithImpl<$Res, $Val extends NewEpisodesState>
    implements $NewEpisodesStateCopyWith<$Res> {
  _$NewEpisodesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewEpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? episodes = null}) {
    return _then(
      _value.copyWith(
            episodes: null == episodes
                ? _value.episodes
                : episodes // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NewEpisodesStateImplCopyWith<$Res>
    implements $NewEpisodesStateCopyWith<$Res> {
  factory _$$NewEpisodesStateImplCopyWith(
    _$NewEpisodesStateImpl value,
    $Res Function(_$NewEpisodesStateImpl) then,
  ) = __$$NewEpisodesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Track> episodes});
}

/// @nodoc
class __$$NewEpisodesStateImplCopyWithImpl<$Res>
    extends _$NewEpisodesStateCopyWithImpl<$Res, _$NewEpisodesStateImpl>
    implements _$$NewEpisodesStateImplCopyWith<$Res> {
  __$$NewEpisodesStateImplCopyWithImpl(
    _$NewEpisodesStateImpl _value,
    $Res Function(_$NewEpisodesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NewEpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? episodes = null}) {
    return _then(
      _$NewEpisodesStateImpl(
        episodes: null == episodes
            ? _value._episodes
            : episodes // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }
}

/// @nodoc

class _$NewEpisodesStateImpl implements _NewEpisodesState {
  const _$NewEpisodesStateImpl({final List<Track> episodes = const []})
    : _episodes = episodes;

  final List<Track> _episodes;
  @override
  @JsonKey()
  List<Track> get episodes {
    if (_episodes is EqualUnmodifiableListView) return _episodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_episodes);
  }

  @override
  String toString() {
    return 'NewEpisodesState(episodes: $episodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewEpisodesStateImpl &&
            const DeepCollectionEquality().equals(other._episodes, _episodes));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_episodes));

  /// Create a copy of NewEpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewEpisodesStateImplCopyWith<_$NewEpisodesStateImpl> get copyWith =>
      __$$NewEpisodesStateImplCopyWithImpl<_$NewEpisodesStateImpl>(
        this,
        _$identity,
      );
}

abstract class _NewEpisodesState implements NewEpisodesState {
  const factory _NewEpisodesState({final List<Track> episodes}) =
      _$NewEpisodesStateImpl;

  @override
  List<Track> get episodes;

  /// Create a copy of NewEpisodesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewEpisodesStateImplCopyWith<_$NewEpisodesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
