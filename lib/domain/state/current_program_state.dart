import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/state/schedule_state.dart';

/// Emits DateTime.now() every second. AutoDispose so the timer stops
/// when nothing is listening.
final nowTickerProvider = StreamProvider.autoDispose<DateTime>((ref) {
  return Stream<DateTime>.periodic(
    const Duration(seconds: 1),
    (_) => DateTime.now(),
  );
});

/// The program currently airing on the radio, derived from today's schedule.
/// Recomputes each second via the ticker, but thanks to freezed value-equality
/// listeners only rebuild on actual program transitions.
final currentProgramProvider =
    Provider.autoDispose<ScheduledProgram?>((ref) {
  final now = ref.watch(nowTickerProvider).value ?? DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final scheduleState = ref.watch(scheduleControllerProvider(today));

  if (scheduleState is! ScheduleStateData) return null;

  for (final p in scheduleState.programs) {
    if (!p.startDate.isAfter(now) && now.isBefore(p.endDate)) {
      return p;
    }
  }
  return null;
});
