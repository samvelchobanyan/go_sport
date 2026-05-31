// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_programs_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$MyProgramsState {
  List<Program> get programs => throw _privateConstructorUsedError;

  /// Create a copy of MyProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MyProgramsStateCopyWith<MyProgramsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyProgramsStateCopyWith<$Res> {
  factory $MyProgramsStateCopyWith(
    MyProgramsState value,
    $Res Function(MyProgramsState) then,
  ) = _$MyProgramsStateCopyWithImpl<$Res, MyProgramsState>;
  @useResult
  $Res call({List<Program> programs});
}

/// @nodoc
class _$MyProgramsStateCopyWithImpl<$Res, $Val extends MyProgramsState>
    implements $MyProgramsStateCopyWith<$Res> {
  _$MyProgramsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MyProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? programs = null}) {
    return _then(
      _value.copyWith(
            programs: null == programs
                ? _value.programs
                : programs // ignore: cast_nullable_to_non_nullable
                      as List<Program>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MyProgramsStateImplCopyWith<$Res>
    implements $MyProgramsStateCopyWith<$Res> {
  factory _$$MyProgramsStateImplCopyWith(
    _$MyProgramsStateImpl value,
    $Res Function(_$MyProgramsStateImpl) then,
  ) = __$$MyProgramsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Program> programs});
}

/// @nodoc
class __$$MyProgramsStateImplCopyWithImpl<$Res>
    extends _$MyProgramsStateCopyWithImpl<$Res, _$MyProgramsStateImpl>
    implements _$$MyProgramsStateImplCopyWith<$Res> {
  __$$MyProgramsStateImplCopyWithImpl(
    _$MyProgramsStateImpl _value,
    $Res Function(_$MyProgramsStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MyProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? programs = null}) {
    return _then(
      _$MyProgramsStateImpl(
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as List<Program>,
      ),
    );
  }
}

/// @nodoc

class _$MyProgramsStateImpl implements _MyProgramsState {
  const _$MyProgramsStateImpl({final List<Program> programs = const []})
    : _programs = programs;

  final List<Program> _programs;
  @override
  @JsonKey()
  List<Program> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  @override
  String toString() {
    return 'MyProgramsState(programs: $programs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyProgramsStateImpl &&
            const DeepCollectionEquality().equals(other._programs, _programs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_programs));

  /// Create a copy of MyProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MyProgramsStateImplCopyWith<_$MyProgramsStateImpl> get copyWith =>
      __$$MyProgramsStateImplCopyWithImpl<_$MyProgramsStateImpl>(
        this,
        _$identity,
      );
}

abstract class _MyProgramsState implements MyProgramsState {
  const factory _MyProgramsState({final List<Program> programs}) =
      _$MyProgramsStateImpl;

  @override
  List<Program> get programs;

  /// Create a copy of MyProgramsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MyProgramsStateImplCopyWith<_$MyProgramsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
