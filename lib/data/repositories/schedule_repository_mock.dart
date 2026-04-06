import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryMock implements ScheduleRepository {
  final Map<DateTime, List<ScheduledProgram>> _scheduleByDate = {};

  ScheduleRepositoryMock() {
    _generateMock();
  }

  void _generateMock() {
    final now = DateTime.now();

    int globalIndex = 0;

    for (int day = 0; day < 10; day++) {
      final date = DateTime(now.year, now.month, now.day + day);

      final List<ScheduledProgram> dailyPrograms = [];

      // Start at 06:00
      DateTime currentStart = DateTime(date.year, date.month, date.day, 6, 0);

      for (int i = 0; i < 14; i++) {
        final duration = Duration(minutes: 30 + (i % 3) * 15);

        final startDate = currentStart;
        final endDate = startDate.add(duration);

        dailyPrograms.add(
          ScheduledProgram(
            id:
                String.fromCharCode(65 + (globalIndex % 26)) +
                globalIndex.toString(),
            title: 'Program ${globalIndex + 1}',
            imageUrl: globalIndex < 10
                ? 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop'
                : null,
            startDate: startDate,
            duration: duration,
          ),
        );

        currentStart = endDate;
        globalIndex++;
      }

      _scheduleByDate[date] = dailyPrograms;
    }
  }

  DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Future<List<DateTime>> getAllDates() async {
    await Future.delayed(const Duration(milliseconds: 300));

    return _scheduleByDate.keys.toList();
  }

  @override
  Future<List<ScheduledProgram>> getScheduleByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final normalizedDate = _normalize(date);

    return _scheduleByDate[normalizedDate] ?? [];
  }
}
