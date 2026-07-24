import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_media.freezed.dart';

@freezed
class SocialLinks with _$SocialLinks {
  const factory SocialLinks({
    String? youtubeUrl,
    String? facebookUrl,
    String? instagramUrl,
  }) = _SocialLinks;
}