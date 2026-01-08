import '../../domain/repositories/story_repository.dart';
import '../../domain/entities/story.dart';

class StoryRepositoryMock implements StoryRepository {
  
  final List<Story> _mockStories = [
    const Story(
      id: 's1',
      title: 'Coldplay', // Имя, которое отображается под кружком
      imageUrl: 'https://images.unsplash.com/photo-1621360841013-c768371e93cf?auto=format&fit=crop&w=800&q=80', // Фото артиста
      text: 'Check out our new single "Good Feelings" available now everywhere!', // Текст внутри сторис
      isViewed: false, // Будет цветная обводка
      ctaLabel: 'Listen now',
      ctaTargetType: 'track',
      ctaTargetId: 'track_coldplay_1',
    ),
    const Story(
      id: 's2',
      title: 'Radio Go Sport',
      imageUrl: 'https://images.unsplash.com/photo-1593697821252-0c9137d9fc45?auto=format&fit=crop&w=800&q=80',
      text: 'Live interview with the champions starts in 10 minutes.',
      isViewed: true, // Будет серая обводка
      ctaLabel: 'Tune in',
      ctaTargetType: 'radio',
      ctaTargetId: 'radio_main',
    ),
    const Story(
      id: 's3',
      title: 'Billie Eilish',
      imageUrl: 'https://images.unsplash.com/photo-1517260739837-ca63e20bd36b?auto=format&fit=crop&w=800&q=80',
      text: 'Behind the scenes of the new music video.',
      isViewed: false,
      ctaLabel: 'Watch',
      ctaTargetType: 'video',
      ctaTargetId: 'video_billie_1',
    ),
  ];

  @override
  Future<List<Story>> getStories() async {
    // Имитируем быструю загрузку
    await Future.delayed(const Duration(milliseconds: 400));
    return _mockStories;
  }
}