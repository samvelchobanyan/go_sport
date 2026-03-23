import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';

class EpisodesRepositoryMock implements EpisodesRepository {
  final List<Track> _mockData = [
    Track(
      id: '1',
      title: 'The Future of Sports Technology',
      artistName: 'Tech Talk',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 45),
      audioUrl:
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      releaseDate: DateTime(2026, 2, 24),
      isLiked: true,
    ),
    Track(
      id: '2',
      title: 'Training Like a Champion',
      artistName: 'Fitness Weekly',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 52),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      releaseDate: DateTime(2026, 2, 22),
      isLiked: true,
    ),
    Track(
      id: '3',
      title: 'Mental Resilience in Sports',
      artistName: 'Mindset Matters',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 38),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      releaseDate: DateTime(2026, 2, 20),
      isLiked: true,
    ),
    Track(
      id: '4',
      title: 'Nutrition for Athletes',
      artistName: 'Health Hub',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 41),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      releaseDate: DateTime(2026, 2, 17),
      isLiked: true,
    ),
    Track(
      id: '5',
      title: 'Recovery and Rest',
      artistName: 'Wellness Weekly',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 36),
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      releaseDate: DateTime(2026, 2, 15),
      isLiked: true,
    ),
    Track(
      id: '6',
      title: 'Interview with Olympic Champion',
      artistName: 'Champions Corner',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      duration: const Duration(minutes: 58),
      audioUrl:
          'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      releaseDate: DateTime(2026, 2, 13),
      isLiked: true,
    ),
  ];

  @override
  Future<List<Track>> getFeaturedEpisodes() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<List<Track>> getFavoriteEpisodes() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData.where((e) => e.isLiked).toList();
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
