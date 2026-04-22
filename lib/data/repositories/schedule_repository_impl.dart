import 'dart:developer';

import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/scheduled_program_dto.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ApiClient _apiClient;

  ScheduleRepositoryImpl(this._apiClient);

  @override
  Future<List<DateTime>> getAllDates() async {
    final response = await _apiClient.get(
      '/api/schedules',
      queryParameters: {
        'fields[0]': 'Day',
        'sort[0]': 'Day:asc',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    return data
        .map((e) {
          final dayStr = (e as Map<String, dynamic>)['Day'] as String? ?? '';
          final parsed = DateTime.tryParse(dayStr);
          if (parsed == null) {
            log(
              'Skipped schedule entry with invalid Day: "$dayStr"',
              name: 'ScheduleRepository',
            );
          }
          return parsed;
        })
        .whereType<DateTime>()
        .toList();
  }

  @override
  Future<List<ScheduledProgram>> getScheduleByDate(DateTime date) async {
    // Форматируем дату в YYYY-MM-DD для фильтра Strapi
    final year = date.year.toString().padLeft(4, '0');
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final dateString = '$year-$month-$day';

    final response = await _apiClient.get(
      '/api/schedules',
      queryParameters: {
        'filters[Day][\$eq]': dateString,
        'populate[Slots][populate][Icon][populate]': '*',
      },
    );

    final data = response.data['data'] as List<dynamic>;
    
    // Если на эту дату расписания нет, возвращаем пустой список
    if (data.isEmpty) {
      return [];
    }

    // Берём первый день, так как мы фильтровали по точной дате
    final dayEntry = data.first as Map<String, dynamic>;
    final parentDate = dayEntry['Day'] as String? ?? '';
    
    // Извлекаем слоты
    final slots = dayEntry['Slots'] as List<dynamic>? ?? [];

    return slots
        .map((e) {
          final slotJson = e as Map<String, dynamic>;

          // Подмешиваем родительскую дату прямо в JSON слота
          slotJson['parentDate'] = parentDate;

          // Передаем "обогащенный" JSON в DTO и сразу просим сущность
          return ScheduledProgramDto.fromJson(slotJson).toDomain();
        })
        .whereType<ScheduledProgram>()
        .toList();
  }
}
