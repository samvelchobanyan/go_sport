// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radio_dashboard_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RadioDashboardState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  List<Program> get featuredPrograms => throw _privateConstructorUsedError;
  List<Track> get featuredEpisodes => throw _privateConstructorUsedError;

  /// Create a copy of RadioDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RadioDashboardStateCopyWith<RadioDashboardState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioDashboardStateCopyWith<$Res> {
  factory $RadioDashboardStateCopyWith(
    RadioDashboardState value,
    $Res Function(RadioDashboardState) then,
  ) = _$RadioDashboardStateCopyWithImpl<$Res, RadioDashboardState>;
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    List<Program> featuredPrograms,
    List<Track> featuredEpisodes,
  });
}

/// @nodoc
class _$RadioDashboardStateCopyWithImpl<$Res, $Val extends RadioDashboardState>
    implements $RadioDashboardStateCopyWith<$Res> {
  _$RadioDashboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RadioDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? featuredPrograms = null,
    Object? featuredEpisodes = null,
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
            featuredPrograms: null == featuredPrograms
                ? _value.featuredPrograms
                : featuredPrograms // ignore: cast_nullable_to_non_nullable
                      as List<Program>,
            featuredEpisodes: null == featuredEpisodes
                ? _value.featuredEpisodes
                : featuredEpisodes // ignore: cast_nullable_to_non_nullable
                      as List<Track>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RadioDashboardStateImplCopyWith<$Res>
    implements $RadioDashboardStateCopyWith<$Res> {
  factory _$$RadioDashboardStateImplCopyWith(
    _$RadioDashboardStateImpl value,
    $Res Function(_$RadioDashboardStateImpl) then,
  ) = __$$RadioDashboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    List<Program> featuredPrograms,
    List<Track> featuredEpisodes,
  });
}

/// @nodoc
class __$$RadioDashboardStateImplCopyWithImpl<$Res>
    extends _$RadioDashboardStateCopyWithImpl<$Res, _$RadioDashboardStateImpl>
    implements _$$RadioDashboardStateImplCopyWith<$Res> {
  __$$RadioDashboardStateImplCopyWithImpl(
    _$RadioDashboardStateImpl _value,
    $Res Function(_$RadioDashboardStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RadioDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? featuredPrograms = null,
    Object? featuredEpisodes = null,
  }) {
    return _then(
      _$RadioDashboardStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        featuredPrograms: null == featuredPrograms
            ? _value._featuredPrograms
            : featuredPrograms // ignore: cast_nullable_to_non_nullable
                  as List<Program>,
        featuredEpisodes: null == featuredEpisodes
            ? _value._featuredEpisodes
            : featuredEpisodes // ignore: cast_nullable_to_non_nullable
                  as List<Track>,
      ),
    );
  }
}

/// @nodoc

class _$RadioDashboardStateImpl implements _RadioDashboardState {
  const _$RadioDashboardStateImpl({
    this.isLoading = false,
    this.error,
    final List<Program> featuredPrograms = const [],
    final List<Track> featuredEpisodes = const [],
  }) : _featuredPrograms = featuredPrograms,
       _featuredEpisodes = featuredEpisodes;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  final List<Program> _featuredPrograms;
  @override
  @JsonKey()
  List<Program> get featuredPrograms {
    if (_featuredPrograms is EqualUnmodifiableListView)
      return _featuredPrograms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredPrograms);
  }

  final List<Track> _featuredEpisodes;
  @override
  @JsonKey()
  List<Track> get featuredEpisodes {
    if (_featuredEpisodes is EqualUnmodifiableListView)
      return _featuredEpisodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_featuredEpisodes);
  }

  @override
  String toString() {
    return 'RadioDashboardState(isLoading: $isLoading, error: $error, featuredPrograms: $featuredPrograms, featuredEpisodes: $featuredEpisodes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadioDashboardStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(
              other._featuredPrograms,
              _featuredPrograms,
            ) &&
            const DeepCollectionEquality().equals(
              other._featuredEpisodes,
              _featuredEpisodes,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    error,
    const DeepCollectionEquality().hash(_featuredPrograms),
    const DeepCollectionEquality().hash(_featuredEpisodes),
  );

  /// Create a copy of RadioDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RadioDashboardStateImplCopyWith<_$RadioDashboardStateImpl> get copyWith =>
      __$$RadioDashboardStateImplCopyWithImpl<_$RadioDashboardStateImpl>(
        this,
        _$identity,
      );
}

abstract class _RadioDashboardState implements RadioDashboardState {
  const factory _RadioDashboardState({
    final bool isLoading,
    final String? error,
    final List<Program> featuredPrograms,
    final List<Track> featuredEpisodes,
  }) = _$RadioDashboardStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  List<Program> get featuredPrograms;
  @override
  List<Track> get featuredEpisodes;

  /// Create a copy of RadioDashboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RadioDashboardStateImplCopyWith<_$RadioDashboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
