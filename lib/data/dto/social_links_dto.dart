import 'package:go_sport/domain/entities/social_media.dart';

class SocialLinksDto {
  final String? facebook;
  final String? youtube;
  final String? instagram;
  final String? phone;
  final String? email;
  final String? address;
  final String? website;

  SocialLinksDto({
    this.facebook,
    this.youtube,
    this.instagram,
    this.phone,
    this.email,
    this.address,
    this.website,
  });

  factory SocialLinksDto.fromJson(Map<String, dynamic> json) {
    // Strapi wraps the response inside a "data" object
    final data = json['data'] as Map<String, dynamic>? ?? {};

    return SocialLinksDto(
      facebook: data['Facebook'] as String?,
      youtube: data['Youtube'] as String?,
      instagram: data['Instagram'] as String?,
      phone: _nonEmpty(data['Phone']),
      email: _nonEmpty(data['Email']),
      address: _nonEmpty(data['Address']),
      website: _nonEmpty(data['Website']),
    );
  }

  /// A cleared text field can come back as "" — treat it as absent.
  static String? _nonEmpty(Object? value) {
    final text = (value as String?)?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  SocialLinks toDomain() {
    return SocialLinks(
      facebookUrl: facebook,
      youtubeUrl: youtube,
      instagramUrl: instagram,
      phone: phone,
      email: email,
      address: address,
      websiteUrl: website,
    );
  }
}
