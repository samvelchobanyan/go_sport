import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

part 'schedule_state.freezed.dart';

@freezed
sealed class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = ScheduleStateLoading;

  const factory ScheduleState.data({required List<ScheduledProgram> programs}) =
      ScheduleStateData;

  const factory ScheduleState.error({required String message}) =
      ScheduleStateError;
}

class ScheduleController
    extends AutoDisposeFamilyNotifier<ScheduleState, DateTime> {
  @override
  ScheduleState build(DateTime arg) {
    final normalizedDate = DateTime(arg.year, arg.month, arg.day);

    final repository = ref.watch(scheduleRepositoryProvider);

    Future.microtask(() => _fetchSchedule(normalizedDate, repository));

    return const ScheduleState.loading();
  }

  Future<void> _fetchSchedule(DateTime date, ScheduleRepository repo) async {
    try {
      final programs = await repo.getScheduleByDate(date);

      if (state is! ScheduleStateLoading) return;

      state = ScheduleState.data(programs: programs);
    } catch (e) {
      state = ScheduleState.error(message: "Could not load schedule: $e");
    }
  }

  Future<void> refresh() async {
    final repository = ref.read(scheduleRepositoryProvider);
    await _fetchSchedule(arg, repository);
  }
}

final scheduleControllerProvider = NotifierProvider.autoDispose
    .family<ScheduleController, ScheduleState, DateTime>(
      ScheduleController.new,
    );
