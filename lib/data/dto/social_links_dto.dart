import 'package:go_sport/domain/entities/social_media.dart';

class SocialLinksDto {
  final String? facebook;
  final String? youtube;
  final String? instagram;

  SocialLinksDto({this.facebook, this.youtube, this.instagram});

  factory SocialLinksDto.fromJson(Map<String, dynamic> json) {
    // Strapi wraps the response inside a "data" object
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return SocialLinksDto(
      facebook: data['Facebook'] as String?,
      youtube: data['Youtube'] as String?,
      instagram: data['Instagram'] as String?,
    );
  }

  SocialLinks toDomain() {
    return SocialLinks(
      facebookUrl: facebook,
      youtubeUrl: youtube,
      instagramUrl: instagram,
    );
  }
}
