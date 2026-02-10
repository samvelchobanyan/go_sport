import '../entities/news_article.dart';

abstract class NewsRepository {
  /// Получить список новостей
  Future<List<NewsArticle>> getNews({
    required int page,
    required int pageSize,
  });

  /// Получить детальную информацию о статье
  Future<NewsArticle> getArticle(String id);

  /// Переключить лайк на статье
  Future<void> toggleLike(String id);
}