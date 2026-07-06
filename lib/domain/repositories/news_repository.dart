import '../entities/news_article.dart';

abstract class NewsRepository {
  /// Получить список новостей
  Future<List<NewsArticle>> getNews({required int page, required int pageSize});

  /// Получить детальную информацию о статье
  Future<NewsArticle> getArticle(String id);

  /// Получить карту лайкнутых текущим пользователем статей:
  /// id статьи -> id записи лайка (нужен для снятия лайка).
  Future<Map<String, String>> getLikedArticles();

  /// Переключить лайк на статье
  Future<String?> toggleLike(String id, [String? likeId]);
}
