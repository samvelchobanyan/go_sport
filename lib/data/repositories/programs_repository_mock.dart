import 'package:go_sport/domain/entities/program.dart';

class ProgramsRepositoryMock {
  static List<Program> getMockPrograms() {
    return [
      const Program(
        id: '1',
        title: 'Advanced Fitness Training',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'A comprehensive fitness training program',
        episodeCount: 12,
      ),
      const Program(
        id: '2',
        title: 'Nutrition Mastery',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Learn nutrition science and meal planning',
        episodeCount: 8,
      ),
      const Program(
        id: '3',
        title: 'Mental Strength Program',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Build mental resilience and confidence',
        episodeCount: 15,
      ),
      const Program(
        id: '4',
        title: 'Recovery & Wellness',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Complete recovery and wellness program',
        episodeCount: 10,
      ),
      const Program(
        id: '5',
        title: 'Athletic Performance',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Optimize your athletic performance',
        episodeCount: 20,
      ),
    ];
  }
}
