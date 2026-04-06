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
      description: 'A comprehensive fitness training program',
      episodeCount: 12,
      isLiked: true,
      episodes: [
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
    ),
    Program(
      id: '2',
      title: 'Nutrition Mastery',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Learn nutrition science and meal planning',
      episodeCount: 8,
      isLiked: true,
      episodes: [
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
    ),
    Program(
      id: '3',
      title: 'Mental Strength Program',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Build mental resilience and confidence',
      episodeCount: 15,
      isLiked: false,
      episodes: [
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
    ),
    Program(
      id: '4',
      title: 'Recovery & Wellness',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Complete recovery and wellness program',
      episodeCount: 10,
      isLiked: false,
      episodes: [
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
    ),
    Program(
      id: '5',
      title: 'Athletic Performance',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Optimize your athletic performance',
      episodeCount: 20,
      isLiked: false,
      episodes: [
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
    ),
  ];

  final Map<DateTime, List<Program>> _programsByDate = {
    DateTime(2026, 9, 11): [
      Program(
        id: '1',
        title: 'Morning Fitness',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        description: 'Start your day strong',
        episodeCount: 1,
        isLiked: true,
        episodes: [
          Track(
            id: 't1',
            title: 'Wake Up Workout',
            artistName: 'Coach Alex',
            imageUrl:
                'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
            duration: const Duration(minutes: 20),
            audioUrl:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            releaseDate: DateTime(2026, 9, 11),
            isLiked: false,
          ),
        ],
      ),
      Program(
        id: '2',
        title: 'Evening Yoga',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        description: 'Relax and recover',
        episodeCount: 1,
        isLiked: false,
        episodes: [
          Track(
            id: 't2',
            title: 'Stretch & Relax',
            artistName: 'Yoga Flow',
            imageUrl:
                'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
            duration: const Duration(minutes: 30),
            audioUrl:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            releaseDate: DateTime(2026, 9, 11),
            isLiked: false,
          ),
        ],
      ),
    ],

    DateTime(2026, 9, 12): [
      Program(
        id: '3',
        title: 'HIIT Blast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
        description: 'High intensity training',
        episodeCount: 1,
        isLiked: false,
        episodes: [
          Track(
            id: 't3',
            title: 'Burn Calories Fast',
            artistName: 'HIIT Club',
            imageUrl:
                'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300',
            duration: const Duration(minutes: 25),
            audioUrl:
                'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            releaseDate: DateTime(2026, 9, 12),
            isLiked: false,
          ),
        ],
      ),
    ],
  };

  @override
  Future<List<Program>> getAllPrograms(
    //{ required int page,
    // required int pageSize, }
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<List<Program>> getFeaturedPrograms(
    //{ required int page,
    // required int pageSize, }
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData;
  }

  @override
  Future<List<Program>> getFavoritePrograms(
    //{ required int page,
    // required int pageSize, }
  ) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockData.where((p) => p.isLiked).toList();
  }

  @override
  Future<Program> getProgram(String programId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockData.firstWhere((p) => p.id == programId);
  }

  @override
  Future<List<Program>> getProgramsByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final normalizedDate = DateTime(date.year, date.month, date.day);

    return _programsByDate[normalizedDate] ?? [];
  }

  @override
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
  }
}
