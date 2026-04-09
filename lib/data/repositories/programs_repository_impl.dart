import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/program_dto.dart';
import 'package:go_sport/domain/entities/program.dart';
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
  Future<List<Program>> getAllPrograms() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Program>> getFavoritePrograms() async {
    throw UnimplementedError();
  }

  @override
  Future<List<Program>> getProgramsByDate(DateTime date) async {
    throw UnimplementedError();
  }

  @override
  Future<Program> getProgram(String programId) async {
    throw UnimplementedError();
  }

  @override
  Future<void> toggleLike(String id) async {
    throw UnimplementedError();
  }
}
