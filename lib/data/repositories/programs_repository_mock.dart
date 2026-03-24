import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

class ProgramsRepositoryMock implements ProgramsRepository {
  final List<Program> _mockData = [
    const Program(
      id: '1',
      title: 'Advanced Fitness Training',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'A comprehensive fitness training program',
      episodeCount: 12,
      isLiked: true,
    ),
    const Program(
      id: '2',
      title: 'Nutrition Mastery',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Learn nutrition science and meal planning',
      episodeCount: 8,
      isLiked: true,
    ),
    const Program(
      id: '3',
      title: 'Mental Strength Program',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Build mental resilience and confidence',
      episodeCount: 15,
      isLiked: false,
    ),
    const Program(
      id: '4',
      title: 'Recovery & Wellness',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Complete recovery and wellness program',
      episodeCount: 10,
      isLiked: false,
    ),
    const Program(
      id: '5',
      title: 'Athletic Performance',
      imageUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
      description: 'Optimize your athletic performance',
      episodeCount: 20,
      isLiked: false,
    ),
  ];

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
  Future<void> toggleLike(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // В реальном API здесь будет HTTP запрос
    // Состояние обновляется в domain state (optimistic update)
  }
}
