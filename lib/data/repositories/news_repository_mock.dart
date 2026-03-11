import '../../domain/repositories/news_repository.dart';
import '../../domain/entities/news_article.dart';

class MockNewsRepository implements NewsRepository {
  final List<NewsArticle> _mockData = [
    NewsArticle(
      id: '1',
      title:
          'No panic - but is this Liverpool\'s transitional season coming a year late?',
      subtitle:
          'Last year was not a Team transition it was a Coach transition. Klopp\'s team knew how to play together.',
      author: 'Alexandr Hovhannisyan',
      imageUrl:
          'https://images.unsplash.com/photo-1431324155629-1a6deb1dec8d?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 12),
      content:
          'He could then make tactical suggestions when things weren\'t working. They listened, knew how to execute together and won the League.',
      likesCount: 35,
      isLiked: false,
    ),
    NewsArticle(
      id: '2',
      title:
          'Premier League news conferences: Newcastle\'s Tonali touch and go for Fulham fixture',
      subtitle: 'Newcastle injury updates',
      author: 'James Peterson',
      imageUrl:
          'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 10),
      content:
          'have failed to establish that the most serious categories of alleged unlawful information gathering (UIG) – phone hacking and phone tapping – took place at Associated at all, and their allegation of burglary to order was struck out by the court.There can be little doubt that journalists and executives across the Mail titles engaged in or were complicit in the culture of unlawful information gathering that wrecked the lives of so many.Over the next nine weeks, several members of the group of claimants – which also include campaigner Doreen Lawrence, actress Sadie Frost and former politician Simon Hughes – are expected to give evidence.Harry is expected to provide his testimony on Thursday, according to a draft trial timetable. It will be the second time he has appeared in the witness box. He previously became the first senior British royal to give evidence on a witness stand in more than 130 years in a different lawsuit in 2023.Hes not expected to make any other formal public appearances.',
      likesCount: 12,
      isLiked: false,
    ),
    NewsArticle(
      id: '3',
      title: 'Can Arsenal\'s defence lead them to title glory?',
      subtitle: 'Arsenal defensive analysis',
      author: 'Sarah Williams',
      imageUrl:
          'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 8),
      content:
          'Arsenal\'s defensive record this season has been exceptional...',
      likesCount: 28,
      isLiked: true,
    ),
    NewsArticle(
      id: '4',
      title:
          'Manchester United\'s youth academy continues to produce world-class talent',
      subtitle: 'Future stars emerging from Old Trafford',
      author: 'Michael Roberts',
      imageUrl:
          'https://images.unsplash.com/photo-1522778119026-d647f0596c20?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 7),
      content:
          'Manchester United academy has been a breeding ground for exceptional talent...',
      likesCount: 42,
      isLiked: false,
    ),
    NewsArticle(
      id: '5',
      title: 'Champions League final: Tactical preview and key battles',
      subtitle: 'Breaking down the big game',
      author: 'Emma Thompson',
      imageUrl:
          'https://images.unsplash.com/photo-1517466787929-bc90951d0974?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 6),
      content:
          'The Champions League final promises to be an exciting tactical battle...',
      likesCount: 67,
      isLiked: true,
    ),
    NewsArticle(
      id: '6',
      title: 'Transfer window opens: Top targets for Premier League clubs',
      subtitle: 'Summer 2025 transfer speculation',
      author: 'David Miller',
      imageUrl:
          'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 5),
      content:
          'Premier League clubs are eyeing several high-profile targets...',
      likesCount: 89,
      isLiked: false,
    ),
    NewsArticle(
      id: '7',
      title: 'Women\'s football continues record-breaking growth worldwide',
      subtitle: 'Historic attendance figures across Europe',
      author: 'Lisa Anderson',
      imageUrl:
          'https://images.unsplash.com/photo-1579952363873-27f3bade9f55?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 4),
      content:
          'Women\'s football has seen unprecedented growth in recent years...',
      likesCount: 54,
      isLiked: false,
    ),
    NewsArticle(
      id: '8',
      title: 'VAR controversy reignites debate about technology in football',
      subtitle: 'Fans and pundits divided over recent decisions',
      author: 'Tom Harris',
      imageUrl:
          'https://images.unsplash.com/photo-1574629810360-7efbbe195018?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 3),
      content:
          'VAR continues to be a topic of heated discussion in football...',
      likesCount: 103,
      isLiked: true,
    ),
    NewsArticle(
      id: '9',
      title: 'Barcelona\'s financial recovery: How they turned it around',
      subtitle: 'From crisis to stability in 18 months',
      author: 'Carlos Martinez',
      imageUrl:
          'https://images.unsplash.com/photo-1529900748604-07564a03e7a6?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 2),
      content:
          'Barcelona has made remarkable strides in their financial recovery...',
      likesCount: 71,
      isLiked: false,
    ),
    NewsArticle(
      id: '10',
      title: 'International break: World Cup qualifying matches preview',
      subtitle: 'Key fixtures across all confederations',
      author: 'Ahmed Hassan',
      imageUrl:
          'https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 5, 1),
      content:
          'World Cup qualifying continues with crucial matches this week...',
      likesCount: 45,
      isLiked: false,
    ),
    NewsArticle(
      id: '11',
      title: 'Bundesliga title race goes down to the wire',
      subtitle: 'Three teams separated by just two points',
      author: 'Hans Schmidt',
      imageUrl:
          'https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 30),
      content:
          'The Bundesliga title race is one of the tightest in recent memory...',
      likesCount: 58,
      isLiked: true,
    ),
    NewsArticle(
      id: '12',
      title: 'Serie A: AC Milan\'s resurgence under new management',
      subtitle: 'Rossoneri back among Europe\'s elite',
      author: 'Marco Rossi',
      imageUrl:
          'https://images.unsplash.com/photo-1577471488278-16eec37ffcc2?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 29),
      content: 'AC Milan has returned to the top tier of European football...',
      likesCount: 37,
      isLiked: false,
    ),
    NewsArticle(
      id: '13',
      title: 'La Liga spotlight: Real Madrid\'s youth revolution',
      subtitle: 'Galácticos replaced by homegrown talent',
      author: 'Pablo Garcia',
      imageUrl:
          'https://images.unsplash.com/photo-1553778263-73a83bab9b0c?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 28),
      content: 'Real Madrid has shifted focus to developing young talent...',
      likesCount: 62,
      isLiked: false,
    ),
    NewsArticle(
      id: '14',
      title: 'MLS expansion: Three new franchises announced for 2026',
      subtitle: 'American soccer continues rapid growth',
      author: 'John Williams',
      imageUrl:
          'https://images.unsplash.com/photo-1459865264687-595d652de67e?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 27),
      content:
          'Major League Soccer continues its expansion with three new teams...',
      likesCount: 41,
      isLiked: false,
    ),
    NewsArticle(
      id: '15',
      title: 'Ligue 1: PSG faces tough challenge from resurgent Monaco',
      subtitle: 'Title race heats up in France',
      author: 'Pierre Dubois',
      imageUrl:
          'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 26),
      content: 'Monaco is mounting a serious challenge to PSG\'s dominance...',
      likesCount: 33,
      isLiked: true,
    ),
    NewsArticle(
      id: '16',
      title: 'UEFA announces new European competition format',
      subtitle: 'Revolutionary changes coming in 2026',
      author: 'Anna Kowalski',
      imageUrl:
          'https://images.unsplash.com/photo-1518091043644-c1d4457512c6?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 25),
      content:
          'UEFA has unveiled plans for a new European competition structure...',
      likesCount: 78,
      isLiked: false,
    ),
    NewsArticle(
      id: '17',
      title: 'Copa America preparations: Teams finalizing rosters',
      subtitle: 'South American showpiece approaches',
      author: 'Roberto Silva',
      imageUrl:
          'https://images.unsplash.com/photo-1526948531399-320e7e40f0ca?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 24),
      content: 'National teams are finalizing their squads for Copa America...',
      likesCount: 51,
      isLiked: false,
    ),
    NewsArticle(
      id: '18',
      title:
          'Premier League broadcasting rights: Record-breaking deal announced',
      subtitle: 'Biggest TV deal in sports history',
      author: 'Richard Taylor',
      imageUrl:
          'https://images.unsplash.com/photo-1487466365202-1afdb86c764e?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 23),
      content:
          'The Premier League has secured a record-breaking broadcasting deal...',
      likesCount: 94,
      isLiked: true,
    ),
    NewsArticle(
      id: '19',
      title: 'Sustainability in football: Clubs go green',
      subtitle: 'Environmental initiatives across European leagues',
      author: 'Sophie Green',
      imageUrl:
          'https://images.unsplash.com/photo-1472887256648-e7d1c0f56a5e?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 22),
      content:
          'Football clubs are embracing sustainability and environmental responsibility...',
      likesCount: 29,
      isLiked: false,
    ),
    NewsArticle(
      id: '20',
      title: 'African Cup of Nations: Historic tournament concludes',
      subtitle: 'New champions crowned in thrilling final',
      author: 'Kwame Mensah',
      imageUrl:
          'https://images.unsplash.com/photo-1575361204480-aadea25e6e68?auto=format&fit=crop&w=800&q=80',
      publishedAt: DateTime(2025, 4, 21),
      content: 'The African Cup of Nations concluded with a memorable final...',
      likesCount: 66,
      isLiked: false,
    ),
  ];

  @override
  Future<List<NewsArticle>> getNews({
    required int page,
    required int pageSize,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<NewsArticle> getArticle(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockData.firstWhere(
      (article) => article.id == id,
      orElse: () => throw Exception('Article not found: $id'),
    );
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
  }
}
