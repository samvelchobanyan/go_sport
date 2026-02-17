import 'package:go_sport/domain/entities/episode.dart';

class EpisodesRepositoryMock {
  static List<Episode> getMockEpisodes() {
    return [
      Episode(
        id: '1',
        title: 'The Future of Sports Technology',
        subtitle: 'Podcast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Exploring the latest innovations in sports tech',
        duration: 45,
        releaseDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Episode(
        id: '2',
        title: 'Training Like a Champion',
        subtitle: 'Training Series',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Learn professional training techniques',
        duration: 52,
        releaseDate: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Episode(
        id: '3',
        title: 'Mental Resilience in Sports',
        subtitle: 'Podcast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Building mental toughness for competition',
        duration: 38,
        releaseDate: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Episode(
        id: '4',
        title: 'Nutrition for Athletes',
        subtitle: 'Health Series',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Optimal nutrition strategies for peak performance',
        duration: 41,
        releaseDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Episode(
        id: '5',
        title: 'Recovery and Rest',
        subtitle: 'Wellness',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Why recovery is crucial for athletic performance',
        duration: 36,
        releaseDate: DateTime.now().subtract(const Duration(days: 12)),
      ),
      Episode(
        id: '6',
        title: 'Interview with Olympic Champion',
        subtitle: 'Interviews',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Exclusive interview with Olympic gold medalist',
        duration: 58,
        releaseDate: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];
  }
}
