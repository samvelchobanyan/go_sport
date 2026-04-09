import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryMock implements ScheduleRepository {
  final Map<DateTime, List<ScheduledProgram>> _scheduleByDate = {};

  ScheduleRepositoryMock() {
    _generateMock();
  }

  void _generateMock() {
    final now = DateTime.now();
    // Normalize "now" to midnight to avoid offset issues
    final today = DateTime(now.year, now.month, now.day);

    int globalIndex = 0;

    // Start from -2 to include 2 days ago (e.g., April 5th if today is April 7th)
    // Generate for 14 days to match the itemCount in your ListView
    for (int dayOffset = -2; dayOffset < 12; dayOffset++) {
      final date = today.add(Duration(days: dayOffset));

      final List<ScheduledProgram> dailyPrograms = [];

      // Start the radio broadcast at 06:00 AM for each specific day
      DateTime currentStart = DateTime(date.year, date.month, date.day, 6, 0);

      for (int i = 0; i < 14; i++) {
        final duration = Duration(minutes: 30 + (i % 3) * 15);
        final startDate = currentStart;
        
        dailyPrograms.add(
          ScheduledProgram(
            id: 'ID-${date.day}-${globalIndex}',
            title: 'Program ${globalIndex + 1}',
            imageUrl: 'https://picsum.photos/seed/${globalIndex}/300/300',
            startDate: startDate,
            duration: duration,
          ),
        );

        currentStart = startDate.add(duration);
        globalIndex++;
      }

      // Store using the normalized date (midnight) as the key
      _scheduleByDate[date] = dailyPrograms;
    }
  }

  DateTime _normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  @override
  Future<List<DateTime>> getAllDates() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _scheduleByDate.keys.toList()..sort();
  }

  @override
  Future<List<ScheduledProgram>> getScheduleByDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 300));
    
    final normalizedDate = _normalize(date);
    
    // Return programs if they exist, otherwise an empty list
    return _scheduleByDate[normalizedDate] ?? [];
  }
}