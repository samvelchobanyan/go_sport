// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'featured_artists_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeaturedArtistsState {
  Map<String, Artist> get artists => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of FeaturedArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeaturedArtistsStateCopyWith<FeaturedArtistsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeaturedArtistsStateCopyWith<$Res> {
  factory $FeaturedArtistsStateCopyWith(
    FeaturedArtistsState value,
    $Res Function(FeaturedArtistsState) then,
  ) = _$FeaturedArtistsStateCopyWithImpl<$Res, FeaturedArtistsState>;
  @useResult
  $Res call({Map<String, Artist> artists, bool isLoading, String? error});
}

/// @nodoc
class _$FeaturedArtistsStateCopyWithImpl<
  $Res,
  $Val extends FeaturedArtistsState
>
    implements $FeaturedArtistsStateCopyWith<$Res> {
  _$FeaturedArtistsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeaturedArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            artists: null == artists
                ? _value.artists
                : artists // ignore: cast_nullable_to_non_nullable
                      as Map<String, Artist>,
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
abstract class _$$FeaturedArtistsStateImplCopyWith<$Res>
    implements $FeaturedArtistsStateCopyWith<$Res> {
  factory _$$FeaturedArtistsStateImplCopyWith(
    _$FeaturedArtistsStateImpl value,
    $Res Function(_$FeaturedArtistsStateImpl) then,
  ) = __$$FeaturedArtistsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Artist> artists, bool isLoading, String? error});
}

/// @nodoc
class __$$FeaturedArtistsStateImplCopyWithImpl<$Res>
    extends _$FeaturedArtistsStateCopyWithImpl<$Res, _$FeaturedArtistsStateImpl>
    implements _$$FeaturedArtistsStateImplCopyWith<$Res> {
  __$$FeaturedArtistsStateImplCopyWithImpl(
    _$FeaturedArtistsStateImpl _value,
    $Res Function(_$FeaturedArtistsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeaturedArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? artists = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$FeaturedArtistsStateImpl(
        artists: null == artists
            ? _value._artists
            : artists // ignore: cast_nullable_to_non_nullable
                  as Map<String, Artist>,
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

class _$FeaturedArtistsStateImpl implements _FeaturedArtistsState {
  const _$FeaturedArtistsStateImpl({
    final Map<String, Artist> artists = const {},
    this.isLoading = false,
    this.error,
  }) : _artists = artists;

  final Map<String, Artist> _artists;
  @override
  @JsonKey()
  Map<String, Artist> get artists {
    if (_artists is EqualUnmodifiableMapView) return _artists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_artists);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'FeaturedArtistsState(artists: $artists, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeaturedArtistsStateImpl &&
            const DeepCollectionEquality().equals(other._artists, _artists) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_artists),
    isLoading,
    error,
  );

  /// Create a copy of FeaturedArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeaturedArtistsStateImplCopyWith<_$FeaturedArtistsStateImpl>
  get copyWith =>
      __$$FeaturedArtistsStateImplCopyWithImpl<_$FeaturedArtistsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FeaturedArtistsState implements FeaturedArtistsState {
  const factory _FeaturedArtistsState({
    final Map<String, Artist> artists,
    final bool isLoading,
    final String? error,
  }) = _$FeaturedArtistsStateImpl;

  @override
  Map<String, Artist> get artists;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of FeaturedArtistsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeaturedArtistsStateImplCopyWith<_$FeaturedArtistsStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
