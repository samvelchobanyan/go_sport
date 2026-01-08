import '../entities/news_article.dart';

abstract class NewsRepository {
/// Получить список новостей
  Future<List<NewsArticle>> getNews({
    required int page,
    required int pageSize,
  });

  /// Получить детальную информацию
  Future<NewsArticle> getArticle(String id);
}