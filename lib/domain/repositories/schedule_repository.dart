import 'package:go_sport/domain/entities/scheduled_program.dart';

abstract interface class ScheduleRepository {
  Future<List<DateTime>> getAllDates();
  Future<List<ScheduledProgram>> getScheduleByDate(DateTime date);

}
