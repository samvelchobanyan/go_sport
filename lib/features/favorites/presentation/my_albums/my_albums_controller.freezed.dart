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
  $Res call({List<Album> albums});
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
  $Res call({Object? albums = null}) {
    return _then(
      _value.copyWith(
            albums: null == albums
                ? _value.albums
                : albums // ignore: cast_nullable_to_non_nullable
                      as List<Album>,
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
  $Res call({List<Album> albums});
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
  $Res call({Object? albums = null}) {
    return _then(
      _$MyAlbumsStateImpl(
        albums: null == albums
            ? _value._albums
            : albums // ignore: cast_nullable_to_non_nullable
                  as List<Album>,
      ),
    );
  }
}

/// @nodoc

class _$MyAlbumsStateImpl implements _MyAlbumsState {
  const _$MyAlbumsStateImpl({final List<Album> albums = const []})
    : _albums = albums;

  final List<Album> _albums;
  @override
  @JsonKey()
  List<Album> get albums {
    if (_albums is EqualUnmodifiableListView) return _albums;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_albums);
  }

  @override
  String toString() {
    return 'MyAlbumsState(albums: $albums)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyAlbumsStateImpl &&
            const DeepCollectionEquality().equals(other._albums, _albums));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_albums));

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyAlbumsStateImplCopyWith<_$MyAlbumsStateImpl> get copyWith =>
      __$$MyAlbumsStateImplCopyWithImpl<_$MyAlbumsStateImpl>(this, _$identity);
}

abstract class _MyAlbumsState implements MyAlbumsState {
  const factory _MyAlbumsState({final List<Album> albums}) =
      _$MyAlbumsStateImpl;

  @override
  List<Album> get albums;

  /// Create a copy of MyAlbumsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyAlbumsStateImplCopyWith<_$MyAlbumsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
