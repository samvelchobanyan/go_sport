import '../entities/story.dart';

abstract class StoryRepository {
  /// Получить список активных историй для отображения на Home
  Future<List<Story>> getStories();
}