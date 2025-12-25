class NewsArticle {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime publishedAt;
  final String content;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });
}