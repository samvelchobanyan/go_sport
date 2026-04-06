import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/repositories/schedule_repository.dart';

part 'schedule_controller.freezed.dart';

@freezed
sealed class ScheduleState with _$ScheduleState {
  const factory ScheduleState.loading() = _Loading;

  const factory ScheduleState.data({
    required List<ScheduledProgram> programs,
  }) = _Data;

  const factory ScheduleState.error({
    required String message,
  }) = _Error;
}

class ScheduleController
    extends AutoDisposeFamilyNotifier<ScheduleState, DateTime> {
  late final ScheduleRepository _scheduleRepository;
  late final DateTime date;

  @override
  ScheduleState build(DateTime date) {
    this.date = date;
    _scheduleRepository = ref.watch(scheduleRepositoryProvider);

    Future.microtask(() => load());

    return const ScheduleState.loading();
  }

  Future<void> load() async {
    state = const ScheduleState.loading();

    try {
      final programs = await _scheduleRepository.getScheduleByDate(date);

      state = ScheduleState.data(programs: programs);
    } catch (e) {
      state = ScheduleState.error(message: e.toString());
    }
  }
}

final scheduleControllerProvider = NotifierProvider.autoDispose
    .family<ScheduleController, ScheduleState, DateTime>(
  ScheduleController.new,
);