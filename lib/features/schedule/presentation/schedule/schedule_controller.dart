import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

part 'schedule_controller.freezed.dart';

@freezed
sealed class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = _Loading;

  const factory ScheduleState.data({required List<ScheduledProgram> programs}) =
      _Data;

  const factory ScheduleState.error({required String message}) = _Error;
}

class ScheduleController
    extends AutoDisposeFamilyNotifier<ScheduleState, DateTime> {
  @override
  ScheduleState build(DateTime arg) {
    // 1. Normalize the date immediately to midnight.
    // This ensures that 2026-04-07 14:30 and 2026-04-07 09:00
    // are treated as the exact same provider key.
    final normalizedDate = DateTime(arg.year, arg.month, arg.day);

    final repository = ref.watch(scheduleRepositoryProvider);

    // 2. Use a microtask or a simple Future to trigger the initial load
    Future.microtask(() => _fetchSchedule(normalizedDate, repository));

    return const ScheduleState.loading();
  }

  Future<void> _fetchSchedule(DateTime date, ScheduleRepository repo) async {
    try {
      final programs = await repo.getScheduleByDate(date);

      // Check if the provider is still mounted before updating state
      if (state is! _Loading) return;

      state = ScheduleState.data(programs: programs);
    } catch (e) {
      state = ScheduleState.error(message: "Could not load schedule: $e");
    }
  }

  // Optional: Add a refresh method if the user pulls to refresh
  Future<void> refresh() async {
    final repository = ref.read(scheduleRepositoryProvider);
    await _fetchSchedule(arg, repository);
  }
}

final scheduleControllerProvider = NotifierProvider.autoDispose
    .family<ScheduleController, ScheduleState, DateTime>(
      ScheduleController.new,
    );


// The state for "Which date is currently clicked"
class SelectedDateNotifier extends AutoDisposeNotifier<DateTime> {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day); // Default to today
  }

  void updateDate(DateTime date) {
    state = DateTime(date.year, date.month, date.day);
  }
}

final selectedDateProvider = NotifierProvider.autoDispose<SelectedDateNotifier, DateTime>(
  SelectedDateNotifier.new,
);