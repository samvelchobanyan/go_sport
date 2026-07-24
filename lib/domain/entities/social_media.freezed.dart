// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SocialLinks {
  String? get youtubeUrl => throw _privateConstructorUsedError;
  String? get facebookUrl => throw _privateConstructorUsedError;
  String? get instagramUrl => throw _privateConstructorUsedError;

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SocialLinksCopyWith<SocialLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialLinksCopyWith<$Res> {
  factory $SocialLinksCopyWith(
    SocialLinks value,
    $Res Function(SocialLinks) then,
  ) = _$SocialLinksCopyWithImpl<$Res, SocialLinks>;
  @useResult
  $Res call({String? youtubeUrl, String? facebookUrl, String? instagramUrl});
}

/// @nodoc
class _$SocialLinksCopyWithImpl<$Res, $Val extends SocialLinks>
    implements $SocialLinksCopyWith<$Res> {
  _$SocialLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeUrl = freezed,
    Object? facebookUrl = freezed,
    Object? instagramUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            youtubeUrl: freezed == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            facebookUrl: freezed == facebookUrl
                ? _value.facebookUrl
                : facebookUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            instagramUrl: freezed == instagramUrl
                ? _value.instagramUrl
                : instagramUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SocialLinksImplCopyWith<$Res>
    implements $SocialLinksCopyWith<$Res> {
  factory _$$SocialLinksImplCopyWith(
    _$SocialLinksImpl value,
    $Res Function(_$SocialLinksImpl) then,
  ) = __$$SocialLinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? youtubeUrl, String? facebookUrl, String? instagramUrl});
}

/// @nodoc
class __$$SocialLinksImplCopyWithImpl<$Res>
    extends _$SocialLinksCopyWithImpl<$Res, _$SocialLinksImpl>
    implements _$$SocialLinksImplCopyWith<$Res> {
  __$$SocialLinksImplCopyWithImpl(
    _$SocialLinksImpl _value,
    $Res Function(_$SocialLinksImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? youtubeUrl = freezed,
    Object? facebookUrl = freezed,
    Object? instagramUrl = freezed,
  }) {
    return _then(
      _$SocialLinksImpl(
        youtubeUrl: freezed == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        facebookUrl: freezed == facebookUrl
            ? _value.facebookUrl
            : facebookUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        instagramUrl: freezed == instagramUrl
            ? _value.instagramUrl
            : instagramUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$SocialLinksImpl implements _SocialLinks {
  const _$SocialLinksImpl({
    this.youtubeUrl,
    this.facebookUrl,
    this.instagramUrl,
  });

  @override
  final String? youtubeUrl;
  @override
  final String? facebookUrl;
  @override
  final String? instagramUrl;

  @override
  String toString() {
    return 'SocialLinks(youtubeUrl: $youtubeUrl, facebookUrl: $facebookUrl, instagramUrl: $instagramUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SocialLinksImpl &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.facebookUrl, facebookUrl) ||
                other.facebookUrl == facebookUrl) &&
            (identical(other.instagramUrl, instagramUrl) ||
                other.instagramUrl == instagramUrl));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, youtubeUrl, facebookUrl, instagramUrl);

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SocialLinksImplCopyWith<_$SocialLinksImpl> get copyWith =>
      __$$SocialLinksImplCopyWithImpl<_$SocialLinksImpl>(this, _$identity);
}

abstract class _SocialLinks implements SocialLinks {
  const factory _SocialLinks({
    final String? youtubeUrl,
    final String? facebookUrl,
    final String? instagramUrl,
  }) = _$SocialLinksImpl;

  @override
  String? get youtubeUrl;
  @override
  String? get facebookUrl;
  @override
  String? get instagramUrl;

  /// Create a copy of SocialLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SocialLinksImplCopyWith<_$SocialLinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
