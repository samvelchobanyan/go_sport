import 'package:freezed_annotation/freezed_annotation.dart';

part 'scheduled_program.freezed.dart';

@freezed
class ScheduledProgram with _$ScheduledProgram {
  const ScheduledProgram._(); // letting to add custom logic like calculating enddate
  // enddate is not stored but calculated on the fly based on startdate and duration

  const factory ScheduledProgram({
    required String id,
    required String title,
    required DateTime startDate,
    required Duration duration,
    String? imageUrl,
  }) = _ScheduledProgram;

  DateTime get endDate => startDate.add(duration);
}
