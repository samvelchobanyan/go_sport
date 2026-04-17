import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/track_dto.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiClient _apiClient;

  SearchRepositoryImpl(this._apiClient);

  @override
  Future<({List<Track> items, bool hasMore})> searchTracks({
    required String query,
    int page = 1,
    int pageSize = 25,
  }) async {
    final response = await _apiClient.get(
      '/api/tracks',
      queryParameters: {
        'filters[Name][\$containsi]': query,
        'populate[Album][populate][Cover][populate]': '*',
        'populate[Artists][fields][0]': 'Name',
        'pagination[page]': page,
        'pagination[pageSize]': pageSize,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    final items = data
        .map((e) => TrackDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();

    final pageCount =
        response.data['meta']['pagination']['pageCount'] as int;
    return (items: items, hasMore: page < pageCount);
  }
}
