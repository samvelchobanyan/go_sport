import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/stories_dto.dart';

import '../../domain/repositories/story_repository.dart';
import '../../domain/entities/story.dart';

class StoryRepositoryImpl implements StoryRepository {
  final ApiClient _apiClient;

  StoryRepositoryImpl(this._apiClient);

  @override
  Future<List<Story>> getStories() async {
    final response = await _apiClient.get(
      '/api/stories',
      queryParameters: {'populate': '*'},
    );

    // 1. Cast the API response data as a List of dynamic maps
    final dataList = response.data['data'] as List<dynamic>;

    // 2. Map over each element, convert it to a DTO, and then convert to your domain entity
    return dataList.map((json) {
      return StoriesDto.fromJson(json as Map<String, dynamic>).toDomain();
    }).toList();
  }
}
