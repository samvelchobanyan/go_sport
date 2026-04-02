// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() guest,
    required TResult Function(String name, String avatarUrl) authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? guest,
    TResult? Function(String name, String avatarUrl)? authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? guest,
    TResult Function(String name, String avatarUrl)? authenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthorized value) unauthorized,
    required TResult Function(AuthGuest value) guest,
    required TResult Function(AuthAuthenticated value) authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUnauthorized value)? unauthorized,
    TResult? Function(AuthGuest value)? guest,
    TResult? Function(AuthAuthenticated value)? authenticated,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthorized value)? unauthorized,
    TResult Function(AuthGuest value)? guest,
    TResult Function(AuthAuthenticated value)? authenticated,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res, AuthState>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res, $Val extends AuthState>
    implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthUnauthorizedImplCopyWith<$Res> {
  factory _$$AuthUnauthorizedImplCopyWith(
    _$AuthUnauthorizedImpl value,
    $Res Function(_$AuthUnauthorizedImpl) then,
  ) = __$$AuthUnauthorizedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthUnauthorizedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthUnauthorizedImpl>
    implements _$$AuthUnauthorizedImplCopyWith<$Res> {
  __$$AuthUnauthorizedImplCopyWithImpl(
    _$AuthUnauthorizedImpl _value,
    $Res Function(_$AuthUnauthorizedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthUnauthorizedImpl implements AuthUnauthorized {
  const _$AuthUnauthorizedImpl();

  @override
  String toString() {
    return 'AuthState.unauthorized()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthUnauthorizedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() guest,
    required TResult Function(String name, String avatarUrl) authenticated,
  }) {
    return unauthorized();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? guest,
    TResult? Function(String name, String avatarUrl)? authenticated,
  }) {
    return unauthorized?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? guest,
    TResult Function(String name, String avatarUrl)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthorized value) unauthorized,
    required TResult Function(AuthGuest value) guest,
    required TResult Function(AuthAuthenticated value) authenticated,
  }) {
    return unauthorized(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUnauthorized value)? unauthorized,
    TResult? Function(AuthGuest value)? guest,
    TResult? Function(AuthAuthenticated value)? authenticated,
  }) {
    return unauthorized?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthorized value)? unauthorized,
    TResult Function(AuthGuest value)? guest,
    TResult Function(AuthAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthorized != null) {
      return unauthorized(this);
    }
    return orElse();
  }
}

abstract class AuthUnauthorized implements AuthState {
  const factory AuthUnauthorized() = _$AuthUnauthorizedImpl;
}

/// @nodoc
abstract class _$$AuthGuestImplCopyWith<$Res> {
  factory _$$AuthGuestImplCopyWith(
    _$AuthGuestImpl value,
    $Res Function(_$AuthGuestImpl) then,
  ) = __$$AuthGuestImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthGuestImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthGuestImpl>
    implements _$$AuthGuestImplCopyWith<$Res> {
  __$$AuthGuestImplCopyWithImpl(
    _$AuthGuestImpl _value,
    $Res Function(_$AuthGuestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthGuestImpl implements AuthGuest {
  const _$AuthGuestImpl();

  @override
  String toString() {
    return 'AuthState.guest()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthGuestImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() guest,
    required TResult Function(String name, String avatarUrl) authenticated,
  }) {
    return guest();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? guest,
    TResult? Function(String name, String avatarUrl)? authenticated,
  }) {
    return guest?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? guest,
    TResult Function(String name, String avatarUrl)? authenticated,
    required TResult orElse(),
  }) {
    if (guest != null) {
      return guest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthorized value) unauthorized,
    required TResult Function(AuthGuest value) guest,
    required TResult Function(AuthAuthenticated value) authenticated,
  }) {
    return guest(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUnauthorized value)? unauthorized,
    TResult? Function(AuthGuest value)? guest,
    TResult? Function(AuthAuthenticated value)? authenticated,
  }) {
    return guest?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthorized value)? unauthorized,
    TResult Function(AuthGuest value)? guest,
    TResult Function(AuthAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (guest != null) {
      return guest(this);
    }
    return orElse();
  }
}

abstract class AuthGuest implements AuthState {
  const factory AuthGuest() = _$AuthGuestImpl;
}

/// @nodoc
abstract class _$$AuthAuthenticatedImplCopyWith<$Res> {
  factory _$$AuthAuthenticatedImplCopyWith(
    _$AuthAuthenticatedImpl value,
    $Res Function(_$AuthAuthenticatedImpl) then,
  ) = __$$AuthAuthenticatedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, String avatarUrl});
}

/// @nodoc
class __$$AuthAuthenticatedImplCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res, _$AuthAuthenticatedImpl>
    implements _$$AuthAuthenticatedImplCopyWith<$Res> {
  __$$AuthAuthenticatedImplCopyWithImpl(
    _$AuthAuthenticatedImpl _value,
    $Res Function(_$AuthAuthenticatedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null, Object? avatarUrl = null}) {
    return _then(
      _$AuthAuthenticatedImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthAuthenticatedImpl implements AuthAuthenticated {
  const _$AuthAuthenticatedImpl({required this.name, required this.avatarUrl});

  @override
  final String name;
  @override
  final String avatarUrl;

  @override
  String toString() {
    return 'AuthState.authenticated(name: $name, avatarUrl: $avatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthAuthenticatedImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, avatarUrl);

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      __$$AuthAuthenticatedImplCopyWithImpl<_$AuthAuthenticatedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unauthorized,
    required TResult Function() guest,
    required TResult Function(String name, String avatarUrl) authenticated,
  }) {
    return authenticated(name, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? unauthorized,
    TResult? Function()? guest,
    TResult? Function(String name, String avatarUrl)? authenticated,
  }) {
    return authenticated?.call(name, avatarUrl);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unauthorized,
    TResult Function()? guest,
    TResult Function(String name, String avatarUrl)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(name, avatarUrl);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthUnauthorized value) unauthorized,
    required TResult Function(AuthGuest value) guest,
    required TResult Function(AuthAuthenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthUnauthorized value)? unauthorized,
    TResult? Function(AuthGuest value)? guest,
    TResult? Function(AuthAuthenticated value)? authenticated,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthUnauthorized value)? unauthorized,
    TResult Function(AuthGuest value)? guest,
    TResult Function(AuthAuthenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class AuthAuthenticated implements AuthState {
  const factory AuthAuthenticated({
    required final String name,
    required final String avatarUrl,
  }) = _$AuthAuthenticatedImpl;

  String get name;
  String get avatarUrl;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthAuthenticatedImplCopyWith<_$AuthAuthenticatedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
