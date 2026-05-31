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
  $Res call({List<Artist> artists});
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
  $Res call({Object? artists = null}) {
    return _then(
      _value.copyWith(
            artists: null == artists
                ? _value.artists
                : artists // ignore: cast_nullable_to_non_nullable
                      as List<Artist>,
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
  $Res call({List<Artist> artists});
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
  $Res call({Object? artists = null}) {
    return _then(
      _$MyArtistsStateImpl(
        artists: null == artists
            ? _value._artists
            : artists // ignore: cast_nullable_to_non_nullable
                  as List<Artist>,
      ),
    );
  }
}

/// @nodoc

class _$MyArtistsStateImpl implements _MyArtistsState {
  const _$MyArtistsStateImpl({final List<Artist> artists = const []})
    : _artists = artists;

  final List<Artist> _artists;
  @override
  @JsonKey()
  List<Artist> get artists {
    if (_artists is EqualUnmodifiableListView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_artists);
  }

  @override
  String toString() {
    return 'MyArtistsState(artists: $artists)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyArtistsStateImpl &&
            const DeepCollectionEquality().equals(other._artists, _artists));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_artists));

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
  const factory _MyArtistsState({final List<Artist> artists}) =
      _$MyArtistsStateImpl;

  @override
  List<Artist> get artists;

  /// Create a copy of MyArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyArtistsStateImplCopyWith<_$MyArtistsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
