import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/episode_dto.dart';
import 'package:go_sport/data/dto/program_dto.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

class ProgramsRepositoryImpl implements ProgramsRepository {
  final ApiClient _apiClient;

  ProgramsRepositoryImpl(this._apiClient);

  @override
  Future<List<Program>> getFeaturedPrograms() async {
    final response = await _apiClient.get(
      '/api/programs',
      queryParameters: {
        'populate': '*',
        'filters[Featured][\$eq]': true,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => ProgramDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<List<Track>> getProgramEpisodes(String programId) async {
    final response = await _apiClient.get(
      '/api/episodes',
      queryParameters: {
        'populate[File][populate]': '*',
        'populate[Program][populate][Cover][populate]': '*',
        'filters[Program][documentId][\$eq]': programId,
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) => EpisodeDto.fromJson(e as Map<String, dynamic>).toDomain())
        .toList();
  }

  @override
  Future<String?> toggleLike(String programId, [String? likeId]) async {
    if (likeId != null) {
      await _apiClient.delete('/api/user-programs/$likeId');
      return null;
    }

    final response = await _apiClient.post(
      '/api/user-programs',
      data: {
        'data': {'Program': programId},
      },
    );
    return response.data['data']['documentId'] as String;
  }

  @override
  Future<List<Program>> getAllPrograms() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Program>> getFavoritePrograms() async {
    final response = await _apiClient.get(
      '/api/user-programs',
      queryParameters: {
        'populate[Program][populate][Cover][populate]': '*',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data.map((e) {
      final entry = e as Map<String, dynamic>;
      final programJson = entry['Program'] as Map<String, dynamic>;
      programJson['Like'] = {'documentId': entry['documentId']};
      programJson['cnt'] = entry['cnt'];
      return ProgramDto.fromJson(programJson).toDomain();
    }).toList();
  }

  @override
  Future<List<Program>> getProgramsByDate(DateTime date) async {
    throw UnimplementedError();
  }
}
