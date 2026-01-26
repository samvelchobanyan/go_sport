// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stories_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$StoriesState {
  Map<String, Story> get stories => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of StoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoriesStateCopyWith<StoriesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoriesStateCopyWith<$Res> {
  factory $StoriesStateCopyWith(
    StoriesState value,
    $Res Function(StoriesState) then,
  ) = _$StoriesStateCopyWithImpl<$Res, StoriesState>;
  @useResult
  $Res call({Map<String, Story> stories, bool isLoading, String? error});
}

/// @nodoc
class _$StoriesStateCopyWithImpl<$Res, $Val extends StoriesState>
    implements $StoriesStateCopyWith<$Res> {
  _$StoriesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stories = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            stories: null == stories
                ? _value.stories
                : stories // ignore: cast_nullable_to_non_nullable
                      as Map<String, Story>,
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
abstract class _$$StoriesStateImplCopyWith<$Res>
    implements $StoriesStateCopyWith<$Res> {
  factory _$$StoriesStateImplCopyWith(
    _$StoriesStateImpl value,
    $Res Function(_$StoriesStateImpl) then,
  ) = __$$StoriesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Story> stories, bool isLoading, String? error});
}

/// @nodoc
class __$$StoriesStateImplCopyWithImpl<$Res>
    extends _$StoriesStateCopyWithImpl<$Res, _$StoriesStateImpl>
    implements _$$StoriesStateImplCopyWith<$Res> {
  __$$StoriesStateImplCopyWithImpl(
    _$StoriesStateImpl _value,
    $Res Function(_$StoriesStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoriesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stories = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$StoriesStateImpl(
        stories: null == stories
            ? _value._stories
            : stories // ignore: cast_nullable_to_non_nullable
                  as Map<String, Story>,
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

class _$StoriesStateImpl implements _StoriesState {
  const _$StoriesStateImpl({
    final Map<String, Story> stories = const {},
    this.isLoading = false,
    this.error,
  }) : _stories = stories;

  final Map<String, Story> _stories;
  @override
  @JsonKey()
  Map<String, Story> get stories {
    if (_stories is EqualUnmodifiableMapView) return _stories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_stories);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'StoriesState(stories: $stories, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoriesStateImpl &&
            const DeepCollectionEquality().equals(other._stories, _stories) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_stories),
    isLoading,
    error,
  );

  /// Create a copy of StoriesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoriesStateImplCopyWith<_$StoriesStateImpl> get copyWith =>
      __$$StoriesStateImplCopyWithImpl<_$StoriesStateImpl>(this, _$identity);
}

abstract class _StoriesState implements StoriesState {
  const factory _StoriesState({
    final Map<String, Story> stories,
    final bool isLoading,
    final String? error,
  }) = _$StoriesStateImpl;

  @override
  Map<String, Story> get stories;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of StoriesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoriesStateImplCopyWith<_$StoriesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
