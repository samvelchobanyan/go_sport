// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScheduleState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledProgram> programs) data,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledProgram> programs)? data,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledProgram> programs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScheduleStateLoading value) loading,
    required TResult Function(ScheduleStateData value) data,
    required TResult Function(ScheduleStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScheduleStateLoading value)? loading,
    TResult? Function(ScheduleStateData value)? data,
    TResult? Function(ScheduleStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScheduleStateLoading value)? loading,
    TResult Function(ScheduleStateData value)? data,
    TResult Function(ScheduleStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleStateCopyWith<$Res> {
  factory $ScheduleStateCopyWith(
    ScheduleState value,
    $Res Function(ScheduleState) then,
  ) = _$ScheduleStateCopyWithImpl<$Res, ScheduleState>;
}

/// @nodoc
class _$ScheduleStateCopyWithImpl<$Res, $Val extends ScheduleState>
    implements $ScheduleStateCopyWith<$Res> {
  _$ScheduleStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ScheduleStateLoadingImplCopyWith<$Res> {
  factory _$$ScheduleStateLoadingImplCopyWith(
    _$ScheduleStateLoadingImpl value,
    $Res Function(_$ScheduleStateLoadingImpl) then,
  ) = __$$ScheduleStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ScheduleStateLoadingImplCopyWithImpl<$Res>
    extends _$ScheduleStateCopyWithImpl<$Res, _$ScheduleStateLoadingImpl>
    implements _$$ScheduleStateLoadingImplCopyWith<$Res> {
  __$$ScheduleStateLoadingImplCopyWithImpl(
    _$ScheduleStateLoadingImpl _value,
    $Res Function(_$ScheduleStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ScheduleStateLoadingImpl implements ScheduleStateLoading {
  const _$ScheduleStateLoadingImpl();

  @override
  String toString() {
    return 'ScheduleState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledProgram> programs) data,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledProgram> programs)? data,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledProgram> programs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScheduleStateLoading value) loading,
    required TResult Function(ScheduleStateData value) data,
    required TResult Function(ScheduleStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScheduleStateLoading value)? loading,
    TResult? Function(ScheduleStateData value)? data,
    TResult? Function(ScheduleStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScheduleStateLoading value)? loading,
    TResult Function(ScheduleStateData value)? data,
    TResult Function(ScheduleStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ScheduleStateLoading implements ScheduleState {
  const factory ScheduleStateLoading() = _$ScheduleStateLoadingImpl;
}

/// @nodoc
abstract class _$$ScheduleStateDataImplCopyWith<$Res> {
  factory _$$ScheduleStateDataImplCopyWith(
    _$ScheduleStateDataImpl value,
    $Res Function(_$ScheduleStateDataImpl) then,
  ) = __$$ScheduleStateDataImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<ScheduledProgram> programs});
}

/// @nodoc
class __$$ScheduleStateDataImplCopyWithImpl<$Res>
    extends _$ScheduleStateCopyWithImpl<$Res, _$ScheduleStateDataImpl>
    implements _$$ScheduleStateDataImplCopyWith<$Res> {
  __$$ScheduleStateDataImplCopyWithImpl(
    _$ScheduleStateDataImpl _value,
    $Res Function(_$ScheduleStateDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? programs = null}) {
    return _then(
      _$ScheduleStateDataImpl(
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as List<ScheduledProgram>,
      ),
    );
  }
}

/// @nodoc

class _$ScheduleStateDataImpl implements ScheduleStateData {
  const _$ScheduleStateDataImpl({
    required final List<ScheduledProgram> programs,
  }) : _programs = programs;

  final List<ScheduledProgram> _programs;
  @override
  List<ScheduledProgram> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  @override
  String toString() {
    return 'ScheduleState.data(programs: $programs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleStateDataImpl &&
            const DeepCollectionEquality().equals(other._programs, _programs));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_programs));

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleStateDataImplCopyWith<_$ScheduleStateDataImpl> get copyWith =>
      __$$ScheduleStateDataImplCopyWithImpl<_$ScheduleStateDataImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledProgram> programs) data,
    required TResult Function(String message) error,
  }) {
    return data(programs);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledProgram> programs)? data,
    TResult? Function(String message)? error,
  }) {
    return data?.call(programs);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledProgram> programs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(programs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScheduleStateLoading value) loading,
    required TResult Function(ScheduleStateData value) data,
    required TResult Function(ScheduleStateError value) error,
  }) {
    return data(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScheduleStateLoading value)? loading,
    TResult? Function(ScheduleStateData value)? data,
    TResult? Function(ScheduleStateError value)? error,
  }) {
    return data?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScheduleStateLoading value)? loading,
    TResult Function(ScheduleStateData value)? data,
    TResult Function(ScheduleStateError value)? error,
    required TResult orElse(),
  }) {
    if (data != null) {
      return data(this);
    }
    return orElse();
  }
}

abstract class ScheduleStateData implements ScheduleState {
  const factory ScheduleStateData({
    required final List<ScheduledProgram> programs,
  }) = _$ScheduleStateDataImpl;

  List<ScheduledProgram> get programs;

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleStateDataImplCopyWith<_$ScheduleStateDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ScheduleStateErrorImplCopyWith<$Res> {
  factory _$$ScheduleStateErrorImplCopyWith(
    _$ScheduleStateErrorImpl value,
    $Res Function(_$ScheduleStateErrorImpl) then,
  ) = __$$ScheduleStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ScheduleStateErrorImplCopyWithImpl<$Res>
    extends _$ScheduleStateCopyWithImpl<$Res, _$ScheduleStateErrorImpl>
    implements _$$ScheduleStateErrorImplCopyWith<$Res> {
  __$$ScheduleStateErrorImplCopyWithImpl(
    _$ScheduleStateErrorImpl _value,
    $Res Function(_$ScheduleStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ScheduleStateErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ScheduleStateErrorImpl implements ScheduleStateError {
  const _$ScheduleStateErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ScheduleState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleStateErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleStateErrorImplCopyWith<_$ScheduleStateErrorImpl> get copyWith =>
      __$$ScheduleStateErrorImplCopyWithImpl<_$ScheduleStateErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(List<ScheduledProgram> programs) data,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<ScheduledProgram> programs)? data,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<ScheduledProgram> programs)? data,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ScheduleStateLoading value) loading,
    required TResult Function(ScheduleStateData value) data,
    required TResult Function(ScheduleStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ScheduleStateLoading value)? loading,
    TResult? Function(ScheduleStateData value)? data,
    TResult? Function(ScheduleStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ScheduleStateLoading value)? loading,
    TResult Function(ScheduleStateData value)? data,
    TResult Function(ScheduleStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ScheduleStateError implements ScheduleState {
  const factory ScheduleStateError({required final String message}) =
      _$ScheduleStateErrorImpl;

  String get message;

  /// Create a copy of ScheduleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduleStateErrorImplCopyWith<_$ScheduleStateErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
