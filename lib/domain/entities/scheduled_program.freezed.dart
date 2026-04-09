// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduled_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ScheduledProgram {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  Duration get duration => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of ScheduledProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScheduledProgramCopyWith<ScheduledProgram> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduledProgramCopyWith<$Res> {
  factory $ScheduledProgramCopyWith(
    ScheduledProgram value,
    $Res Function(ScheduledProgram) then,
  ) = _$ScheduledProgramCopyWithImpl<$Res, ScheduledProgram>;
  @useResult
  $Res call({
    String id,
    String title,
    DateTime startDate,
    Duration duration,
    String? imageUrl,
  });
}

/// @nodoc
class _$ScheduledProgramCopyWithImpl<$Res, $Val extends ScheduledProgram>
    implements $ScheduledProgramCopyWith<$Res> {
  _$ScheduledProgramCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScheduledProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? duration = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            duration: null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                      as Duration,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScheduledProgramImplCopyWith<$Res>
    implements $ScheduledProgramCopyWith<$Res> {
  factory _$$ScheduledProgramImplCopyWith(
    _$ScheduledProgramImpl value,
    $Res Function(_$ScheduledProgramImpl) then,
  ) = __$$ScheduledProgramImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    DateTime startDate,
    Duration duration,
    String? imageUrl,
  });
}

/// @nodoc
class __$$ScheduledProgramImplCopyWithImpl<$Res>
    extends _$ScheduledProgramCopyWithImpl<$Res, _$ScheduledProgramImpl>
    implements _$$ScheduledProgramImplCopyWith<$Res> {
  __$$ScheduledProgramImplCopyWithImpl(
    _$ScheduledProgramImpl _value,
    $Res Function(_$ScheduledProgramImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ScheduledProgram
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? startDate = null,
    Object? duration = null,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$ScheduledProgramImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        duration: null == duration
            ? _value.duration
            : duration // ignore: cast_nullable_to_non_nullable
                  as Duration,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ScheduledProgramImpl extends _ScheduledProgram {
  const _$ScheduledProgramImpl({
    required this.id,
    required this.title,
    required this.startDate,
    required this.duration,
    this.imageUrl,
  }) : super._();

  @override
  final String id;
  @override
  final String title;
  @override
  final DateTime startDate;
  @override
  final Duration duration;
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'ScheduledProgram(id: $id, title: $title, startDate: $startDate, duration: $duration, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduledProgramImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, startDate, duration, imageUrl);

  /// Create a copy of ScheduledProgram
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduledProgramImplCopyWith<_$ScheduledProgramImpl> get copyWith =>
      __$$ScheduledProgramImplCopyWithImpl<_$ScheduledProgramImpl>(
        this,
        _$identity,
      );
}

abstract class _ScheduledProgram extends ScheduledProgram {
  const factory _ScheduledProgram({
    required final String id,
    required final String title,
    required final DateTime startDate,
    required final Duration duration,
    final String? imageUrl,
  }) = _$ScheduledProgramImpl;
  const _ScheduledProgram._() : super._();

  @override
  String get id;
  @override
  String get title;
  @override
  DateTime get startDate;
  @override
  Duration get duration;
  @override
  String? get imageUrl;

  /// Create a copy of ScheduledProgram
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScheduledProgramImplCopyWith<_$ScheduledProgramImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
