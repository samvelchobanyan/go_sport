import 'package:go_sport/domain/entities/story.dart'; // Updated import to your Story entity

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    // Falls back to formats if the top-level url isn't found (common in Strapi)
    final formats = json['formats'] as Map<String, dynamic>?;
    final largeFormat = formats?['large'] as Map<String, dynamic>?;

    final url =
        json['url'] as String? ??
        largeFormat?['url'] as String? ??
        (json['attributes'] != null
            ? json['attributes']['url'] as String?
            : null);

    return _CoverDto(url: url ?? '');
  }
}

class StoriesDto {
  final String documentId;
  final String title;
  final String body;
  final _CoverDto? cover;
  final DateTime? publishedAt;

  StoriesDto({
    required this.documentId,
    required this.title,
    required this.body,
    required this.cover,
    this.publishedAt,
    this.ctaLabel,
    this.ctaUrl,
  });

  factory StoriesDto.fromJson(Map<String, dynamic> json) {
    // Safely parsing the publishedAt date string
    final rawDate =
        json['publishedAt'] as String? ?? json['published_at'] as String?;
    final parsedDate = rawDate != null ? DateTime.tryParse(rawDate) : null;

    return StoriesDto(
      documentId:
          (json['documentId'] ?? json['id']?.toString() ?? '') as String,
      title: (json['Title'] as String?) ?? '',
      body: (json['Body'] as String?) ?? '',
      cover: json['Cover'] != null
          ? _CoverDto.fromJson(json['Cover'] as Map<String, dynamic>)
          : null,
      publishedAt: parsedDate,
      ctaLabel:
          (json['Button'] as String?) ?? (json['button'] as String?) ?? '',
      ctaUrl:
          (json['URL'] as String?) ??
          (json['Url'] as String?) ??
          (json['url'] as String?) ??
          ((json['CTA'] is Map) ? (json['CTA']['url'] as String?) : null) ??
          '',
    );
  }

  /// Maps the DTO data directly to your Freezed [Story] entity
  Story toDomain() {
    return Story(
      id: documentId,
      title: title,
      text: body,
      imageUrl: cover?.url ?? '',
      isViewed:
          false, // Defaulted as per your Freezed definition or local tracking
      ctaLabel: ctaLabel ?? '',
      ctaTargetType: (ctaUrl != null && ctaUrl!.isNotEmpty) ? 'external' : '',
      ctaTargetId: ctaUrl ?? '',
    );
  }

  // Optional CTA fields parsed from the API
  final String? ctaLabel;
  final String? ctaUrl;
}
