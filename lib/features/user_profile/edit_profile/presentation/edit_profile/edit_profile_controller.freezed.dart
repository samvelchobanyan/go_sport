// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_profile_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EditProfileState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get isAuthenticated => throw _privateConstructorUsedError;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EditProfileStateCopyWith<EditProfileState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EditProfileStateCopyWith<$Res> {
  factory $EditProfileStateCopyWith(
    EditProfileState value,
    $Res Function(EditProfileState) then,
  ) = _$EditProfileStateCopyWithImpl<$Res, EditProfileState>;
  @useResult
  $Res call({bool isLoading, String? error, bool isAuthenticated});
}

/// @nodoc
class _$EditProfileStateCopyWithImpl<$Res, $Val extends EditProfileState>
    implements $EditProfileStateCopyWith<$Res> {
  _$EditProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? isAuthenticated = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAuthenticated: null == isAuthenticated
                ? _value.isAuthenticated
                : isAuthenticated // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EditProfileStateImplCopyWith<$Res>
    implements $EditProfileStateCopyWith<$Res> {
  factory _$$EditProfileStateImplCopyWith(
    _$EditProfileStateImpl value,
    $Res Function(_$EditProfileStateImpl) then,
  ) = __$$EditProfileStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? error, bool isAuthenticated});
}

/// @nodoc
class __$$EditProfileStateImplCopyWithImpl<$Res>
    extends _$EditProfileStateCopyWithImpl<$Res, _$EditProfileStateImpl>
    implements _$$EditProfileStateImplCopyWith<$Res> {
  __$$EditProfileStateImplCopyWithImpl(
    _$EditProfileStateImpl _value,
    $Res Function(_$EditProfileStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? isAuthenticated = null,
  }) {
    return _then(
      _$EditProfileStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAuthenticated: null == isAuthenticated
            ? _value.isAuthenticated
            : isAuthenticated // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$EditProfileStateImpl implements _EditProfileState {
  const _$EditProfileStateImpl({
    this.isLoading = false,
    this.error,
    this.isAuthenticated = false,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool isAuthenticated;

  @override
  String toString() {
    return 'EditProfileState(isLoading: $isLoading, error: $error, isAuthenticated: $isAuthenticated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EditProfileStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.isAuthenticated, isAuthenticated) ||
                other.isAuthenticated == isAuthenticated));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, error, isAuthenticated);

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EditProfileStateImplCopyWith<_$EditProfileStateImpl> get copyWith =>
      __$$EditProfileStateImplCopyWithImpl<_$EditProfileStateImpl>(
        this,
        _$identity,
      );
}

abstract class _EditProfileState implements EditProfileState {
  const factory _EditProfileState({
    final bool isLoading,
    final String? error,
    final bool isAuthenticated,
  }) = _$EditProfileStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get isAuthenticated;

  /// Create a copy of EditProfileState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EditProfileStateImplCopyWith<_$EditProfileStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
