import '../../domain/repositories/news_repository.dart';
import '../../domain/entities/news_article.dart';

class MockNewsRepository implements NewsRepository {
  
  final List<NewsArticle> _mockData = [
    NewsArticle(
      id: '1',
      title: 'Matches schedule',
      subtitle: 'La liga, Premier league, Bundesliga',
      imageUrl: 'https://images.unsplash.com/photo-1522778119026-d647f0565c6a?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 12),
      content: 'Here is the full schedule for the upcoming matches...',
    ),
    NewsArticle(
      id: '2',
      title: 'Concert announced',
      subtitle: 'Coldplay world tour 2025 dates',
      imageUrl: 'https://images.unsplash.com/photo-1459749411177-0473ef71607b?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 10),
      content: 'Coldplay has officially announced their 2025 World Tour...',
    ),
    NewsArticle(
      id: '3',
      title: 'New Album Release',
      subtitle: 'The Weeknd drops new tracks',
      imageUrl: 'https://images.unsplash.com/photo-1493225255756-d9584f8606e9?auto=format&fit=crop&w=800&q=80',
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