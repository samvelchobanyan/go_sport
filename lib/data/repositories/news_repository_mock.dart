import '../../domain/repositories/news_repository.dart';
import '../../domain/entities/news_article.dart';

class MockNewsRepository implements NewsRepository {
  
  final List<NewsArticle> _mockData = [
    NewsArticle(
      id: '1',
      title: 'Complete Schedule Released for International Championship Matches Across Multiple Leagues This Season',
      subtitle: 'La liga, Premier league, Bundesliga',
      imageUrl: 'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 12),
      content: 'Here is the full schedule for the upcoming matches...',
    ),
    NewsArticle(
      id: '2',
      title: 'Legendary Rock Band Announces Massive World Tour with Stadium Shows in Major Cities',
      subtitle: 'Coldplay world tour 2025 dates',
      imageUrl: 'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 10),
      content: 'Coldplay has officially announced their 2025 World Tour...',
    ),
    NewsArticle(
      id: '3',
      title: 'Award-Winning Artist Drops Highly Anticipated New Album Featuring Exclusive Collaborations and Fresh Sound',
      subtitle: 'The Weeknd drops new tracks',
      imageUrl: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 08),
      content: 'The long-awaited album is finally here...',
    ),
  ];

  @override
  Future<List<NewsArticle>> getNews({required int page, required int pageSize}) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<NewsArticle> getArticle(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData.firstWhere(
      (article) => article.id == id,
      orElse: () => _mockData[0],
    );
  }
}