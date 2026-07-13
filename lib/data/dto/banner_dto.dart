import 'package:go_sport/domain/entities/banner.dart';

class BannerDto {
  final int id;
  final String redirectUrl;
  final String imageUrl;

  BannerDto({
    required this.id,
    required this.redirectUrl,
    required this.imageUrl,
  });

  factory BannerDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    final imageJson = data['Image'] as Map<String, dynamic>?;
    final formats = imageJson?['formats'] as Map<String, dynamic>?;
    final fallbackUrl = imageJson?['url'] as String? ?? '';

    // Choose the best size format matching your project's visual priority
    final String bestImageUrl =
        formats?['large']?['url'] as String? ??
        formats?['medium']?['url'] as String? ??
        fallbackUrl;

    return BannerDto(
      id: data['id'] as int? ?? 0,
      redirectUrl: data['URL'] as String? ?? '',
      imageUrl: bestImageUrl,
    );
  }

  HeroBanner toDomain() {
    return HeroBanner(id: id, redirectUrl: redirectUrl, imageUrl: imageUrl);
  }
}
