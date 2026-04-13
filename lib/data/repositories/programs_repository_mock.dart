import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

class ProgramsRepositoryMock implements ProgramsRepository {
  final List<Program> _mockData = [
    Program(
      id: '1',
      title: 'Advanced Fitness Training',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      episodeCount: 12,
      isLiked: true,
    ),
    Program(
      id: '2',
      title: 'Nutrition Mastery',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      episodeCount: 8,
      isLiked: true,
    ),
    Program(
      id: '3',
      title: 'Mental Strength Program',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      episodeCount: 15,
      isLiked: false,
    ),
    Program(
      id: '4',
      title: 'Recovery & Wellness',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      episodeCount: 10,
      isLiked: false,
    ),
    Program(
      id: '5',
      title: 'Athletic Performance',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      episodeCount: 20,
      isLiked: false,
    ),
  ];

  final Map<String, List<Track>> _episodesByProgramId = {
    '1': [
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
    ],
    '2': [
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
    ],
    '3': [
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        releaseDate: DateTime(2026, 2, 22),
        isLiked: true,
      ),
    ],
    '4': [
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        releaseDate: DateTime(2026, 2, 22),
        isLiked: true,
      ),
    ],
    '5': [
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
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
        audioUrl:
            'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
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
    ],
  };

  final Map<DateTime, List<Program>> _programsByDate = {
    DateTime(2026, 9, 11): [
      Program(
        id: '1',
        title: 'Morning Fitness',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        episodeCount: 1,
        isLiked: true,
      ),
      Program(
        id: '2',
        title: 'Evening Yoga',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        episodeCount: 1,
        isLiked: false,
      ),
    ],

    DateTime(2026, 9, 12): [
      Program(
        id: '3',
        title: 'HIIT Blast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        episodeCount: 1,
        isLiked: false,
      ),
    ],
  };

  @override
  Future<List<Program>> getAllPrograms() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<List<Program>> getFeaturedPrograms() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<({List<Program> items, bool hasMore})> getFavoritePrograms({
    int page = 1,
    int pageSize = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    final all = _mockData.where((p) => p.isLiked).toList();
    final total = all.length;
    final pageCount = total == 0 ? 1 : (total / pageSize).ceil();
    final start = (page - 1) * pageSize;
    if (start >= total) {
      return (items: <Program>[], hasMore: false);
    }
    final end = (start + pageSize).clamp(0, total);
    return (
      items: all.sublist(start, end),
      hasMore: page < pageCount,
    );
  }

  @override
  Future<List<Track>> getProgramEpisodes(String programId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _episodesByProgramId[programId] ?? [];
  }

  @override
  Future<List<Program>> getProgramsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final normalizedDate = DateTime(date.year, date.month, date.day);

    return _programsByDate[normalizedDate] ?? [];
  }

  @override
  Future<String?> toggleLike(String programId, [String? likeId]) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
    return likeId == null ? 'mock-like-${DateTime.now().millisecondsSinceEpoch}' : null;
  }
}
