// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'programs_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ProgramsState {
  Map<String, Program> get programs => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramsStateCopyWith<ProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramsStateCopyWith<$Res> {
  factory $ProgramsStateCopyWith(ProgramsState value, $Res Function(ProgramsState) then) =
      _$ProgramsStateCopyWithImpl<$Res, ProgramsState>;
  @useResult
  $Res call({Map<String, Program> programs, bool isLoading, bool isLoadingMore, String? error});
}

/// @nodoc
class _$ProgramsStateCopyWithImpl<$Res, $Val extends ProgramsState>
    implements $ProgramsStateCopyWith<$Res> {
  _$ProgramsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            programs: null == programs
                ? _value.programs
                : programs // ignore: cast_nullable_to_non_nullable
                      as Map<String, Program>,
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
abstract class _$$ProgramsStateImplCopyWith<$Res>
    implements $ProgramsStateCopyWith<$Res> {
  factory _$$ProgramsStateImplCopyWith(
    _$ProgramsStateImpl value,
    $Res Function(_$ProgramsStateImpl) then,
  ) = __$$ProgramsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Program> programs, bool isLoading, bool isLoadingMore, String? error});
}

/// @nodoc
class __$$ProgramsStateImplCopyWithImpl<$Res>
    extends _$ProgramsStateCopyWithImpl<$Res, _$ProgramsStateImpl>
    implements _$$ProgramsStateImplCopyWith<$Res> {
  __$$ProgramsStateImplCopyWithImpl(
    _$ProgramsStateImpl _value,
    $Res Function(_$ProgramsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ProgramsStateImpl(
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as Map<String, Program>,
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

class _$ProgramsStateImpl implements _ProgramsState {
  const _$ProgramsStateImpl({
    final Map<String, Program> programs = const {},
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  }) : _programs = programs;

  final Map<String, Program> _programs;
  @override
  @JsonKey()
  Map<String, Program> get programs {
    if (_programs is EqualUnmodifiableMapView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_programs);
  }

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
    return 'ProgramsState(programs: $programs, isLoading: $isLoading, isLoadingMore: $isLoadingMore, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramsStateImpl &&
            const DeepCollectionEquality().equals(other._programs, _programs) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_programs),
    isLoading,
    isLoadingMore,
    error,
  );

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramsStateImplCopyWith<_$ProgramsStateImpl> get copyWith =>
      __$$ProgramsStateImplCopyWithImpl<_$ProgramsStateImpl>(this, _$identity);
}

abstract class _ProgramsState implements ProgramsState {
  const factory _ProgramsState({
    final Map<String, Program> programs,
    final bool isLoading,
    final bool isLoadingMore,
    final String? error,
  }) = _$ProgramsStateImpl;

  @override
  Map<String, Program> get programs;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  String? get error;

  /// Create a copy of ProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramsStateImplCopyWith<_$ProgramsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
