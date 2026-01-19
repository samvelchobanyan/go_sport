import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_article.freezed.dart';

@freezed
class NewsArticle with _$NewsArticle {
  const factory NewsArticle({
    required String id,
    required String title,
    String? subtitle,
    required String imageUrl,
    required DateTime publishedAt,
    required String content,
  }) = _NewsArticle;
}