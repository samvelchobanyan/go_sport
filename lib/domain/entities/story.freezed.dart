// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Story {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  bool get isViewed => throw _privateConstructorUsedError;
  String get ctaLabel => throw _privateConstructorUsedError;
  String get ctaTargetType => throw _privateConstructorUsedError;
  String get ctaTargetId => throw _privateConstructorUsedError;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call({
    String id,
    String title,
    String text,
    String imageUrl,
    bool isViewed,
    String ctaLabel,
    String ctaTargetType,
    String ctaTargetId,
  });
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? imageUrl = null,
    Object? isViewed = null,
    Object? ctaLabel = null,
    Object? ctaTargetType = null,
    Object? ctaTargetId = null,
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
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            isViewed: null == isViewed
                ? _value.isViewed
                : isViewed // ignore: cast_nullable_to_non_nullable
                      as bool,
            ctaLabel: null == ctaLabel
                ? _value.ctaLabel
                : ctaLabel // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaTargetType: null == ctaTargetType
                ? _value.ctaTargetType
                : ctaTargetType // ignore: cast_nullable_to_non_nullable
                      as String,
            ctaTargetId: null == ctaTargetId
                ? _value.ctaTargetId
                : ctaTargetId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryImplCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$StoryImplCopyWith(
    _$StoryImpl value,
    $Res Function(_$StoryImpl) then,
  ) = __$$StoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String text,
    String imageUrl,
    bool isViewed,
    String ctaLabel,
    String ctaTargetType,
    String ctaTargetId,
  });
}

/// @nodoc
class __$$StoryImplCopyWithImpl<$Res>
    extends _$StoryCopyWithImpl<$Res, _$StoryImpl>
    implements _$$StoryImplCopyWith<$Res> {
  __$$StoryImplCopyWithImpl(
    _$StoryImpl _value,
    $Res Function(_$StoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? text = null,
    Object? imageUrl = null,
    Object? isViewed = null,
    Object? ctaLabel = null,
    Object? ctaTargetType = null,
    Object? ctaTargetId = null,
  }) {
    return _then(
      _$StoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        isViewed: null == isViewed
            ? _value.isViewed
            : isViewed // ignore: cast_nullable_to_non_nullable
                  as bool,
        ctaLabel: null == ctaLabel
            ? _value.ctaLabel
            : ctaLabel // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaTargetType: null == ctaTargetType
            ? _value.ctaTargetType
            : ctaTargetType // ignore: cast_nullable_to_non_nullable
                  as String,
        ctaTargetId: null == ctaTargetId
            ? _value.ctaTargetId
            : ctaTargetId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$StoryImpl implements _Story {
  const _$StoryImpl({
    required this.id,
    required this.title,
    required this.text,
    required this.imageUrl,
    this.isViewed = false,
    required this.ctaLabel,
    required this.ctaTargetType,
    required this.ctaTargetId,
  });

  @override
  final String id;
  @override
  final String title;
  @override
  final String text;
  @override
  final String imageUrl;
  @override
  @JsonKey()
  final bool isViewed;
  @override
  final String ctaLabel;
  @override
  final String ctaTargetType;
  @override
  final String ctaTargetId;

  @override
  String toString() {
    return 'Story(id: $id, title: $title, text: $text, imageUrl: $imageUrl, isViewed: $isViewed, ctaLabel: $ctaLabel, ctaTargetType: $ctaTargetType, ctaTargetId: $ctaTargetId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isViewed, isViewed) ||
                other.isViewed == isViewed) &&
            (identical(other.ctaLabel, ctaLabel) ||
                other.ctaLabel == ctaLabel) &&
            (identical(other.ctaTargetType, ctaTargetType) ||
                other.ctaTargetType == ctaTargetType) &&
            (identical(other.ctaTargetId, ctaTargetId) ||
                other.ctaTargetId == ctaTargetId));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    text,
    imageUrl,
    isViewed,
    ctaLabel,
    ctaTargetType,
    ctaTargetId,
  );

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      __$$StoryImplCopyWithImpl<_$StoryImpl>(this, _$identity);
}

abstract class _Story implements Story {
  const factory _Story({
    required final String id,
    required final String title,
    required final String text,
    required final String imageUrl,
    final bool isViewed,
    required final String ctaLabel,
    required final String ctaTargetType,
    required final String ctaTargetId,
  }) = _$StoryImpl;

  @override
  String get id;
  @override
  String get title;
  @override
  String get text;
  @override
  String get imageUrl;
  @override
  bool get isViewed;
  @override
  String get ctaLabel;
  @override
  String get ctaTargetType;
  @override
  String get ctaTargetId;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
