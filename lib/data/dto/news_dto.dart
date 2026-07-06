import 'package:go_sport/domain/entities/news_article.dart';

class _CoverDto {
  final String url;

  _CoverDto({required this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    final url =
        json['url'] as String? ??
        (json['attributes'] != null
            ? json['attributes']['url'] as String?
            : null);

    return _CoverDto(url: url ?? '');
  }
}

class NewsDto {
  final String documentId;
  final String title;
  final String teaser;
  final String body;
  final _CoverDto? cover;
  final int cnt;
  final String? likeId;
  final String? authorName; // Added field
  final DateTime? publishedAt; // Added field

  NewsDto({
    required this.documentId,
    required this.title,
    required this.teaser,
    required this.body,
    required this.cover,
    required this.cnt,
    this.likeId,
    this.authorName,
    this.publishedAt,
  });

  factory NewsDto.fromJson(Map<String, dynamic> json) {
    final likeJson = json['Like'] as Map<String, dynamic>?;

    // Strapi handling for Author relation (could be flat, or nested under an attributes key)
    final authorJson = json['Author'] as Map<String, dynamic>?;
    String? resolvedAuthor;
    if (authorJson != null) {
      resolvedAuthor =
          authorJson['Name'] as String? ??
          authorJson['name'] as String? ??
          (authorJson['attributes'] != null
              ? authorJson['attributes']['Name'] as String?
              : null);
    }

    // Safely parsing the publishedAt date string
    final rawDate =
        json['publishedAt'] as String? ?? json['published_at'] as String?;
    final parsedDate = rawDate != null ? DateTime.tryParse(rawDate) : null;

    return NewsDto(
      documentId:
          (json['documentId'] ?? json['id']?.toString() ?? '') as String,
      title: (json['Title'] as String?) ?? '',
      teaser: (json['Teaser'] as String?) ?? '',
      body: (json['Body'] as String?) ?? '',
      cover: json['Cover'] != null
          ? _CoverDto.fromJson(json['Cover'] as Map<String, dynamic>)
          : null,
      cnt: json['cnt'] is int
          ? json['cnt'] as int
          : int.tryParse(json['cnt']?.toString() ?? '0') ?? 0,
      likeId: likeJson?['documentId'] as String?,
      authorName: resolvedAuthor,
      publishedAt: parsedDate,
    );
  }

  NewsArticle toDomain() {
    return NewsArticle(
      id: documentId,
      title: title,
      subtitle: teaser,
      // If authorName is null or empty, defaults to 'Unknown'
      author: (authorName != null && authorName!.isNotEmpty)
          ? authorName!
          : 'Unknown',
      imageUrl: cover?.url ?? '',
      // If publishedAt is null from API, defaults back to current time
      publishedAt: publishedAt ?? DateTime.now(),
      content: body,
      likesCount: cnt,
      isLiked: likeId != null,
      likeId: likeId,
    );
  }
}
