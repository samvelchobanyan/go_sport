import '../entities/news_article.dart';

abstract class NewsRepository {
  /// Получить список новостей
  Future<List<NewsArticle>> getNews({
    required int page,
    required int pageSize,
  });

  /// Получить статью из in-memory кеша.
  ///
  /// Возвращает `null`, если статья ещё не была загружена в текущей сессии.
  NewsArticle? getCachedArticle(String id);

  /// Получить детальную информацию
  Future<NewsArticle> getArticle(String id);

  /// Переключить лайк на статье
  Future<void> toggleLike(String id);
}