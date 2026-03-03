import 'package:go_sport/domain/entities/track.dart';

class EpisodesRepositoryMock {
  static List<Track> getMockEpisodes() {
    return [
      Track(
        id: '1',
        title: 'The Future of Sports Technology',
        artistName: 'Tech Talk',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 45),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 24),
      ),
      Track(
        id: '2',
        title: 'Training Like a Champion',
        artistName: 'Fitness Weekly',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 52),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 22),
      ),
      Track(
        id: '3',
        title: 'Mental Resilience in Sports',
        artistName: 'Mindset Matters',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 38),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 20),
      ),
      Track(
        id: '4',
        title: 'Nutrition for Athletes',
        artistName: 'Health Hub',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 41),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 17),
      ),
      Track(
        id: '5',
        title: 'Recovery and Rest',
        artistName: 'Wellness Weekly',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 36),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 15),
      ),
      Track(
        id: '6',
        title: 'Interview with Olympic Champion',
        artistName: 'Champions Corner',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        duration: const Duration(minutes: 58),
        audioUrl: '',
        releaseDate: DateTime(2026, 2, 13),
      ),
    ];
  }
}
