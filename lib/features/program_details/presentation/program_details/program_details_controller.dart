import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

part 'program_details_controller.freezed.dart';

@freezed
sealed class ProgramDetailsState with _$ProgramDetailsState {
  const factory ProgramDetailsState.loading() = _Loading;

  const factory ProgramDetailsState.data({required Program program}) = _Data;

  const factory ProgramDetailsState.error({required String message}) = _Error;
}

class ProgramDetailsController
    extends AutoDisposeFamilyNotifier<ProgramDetailsState, String> {
  late final ProgramsRepository _programsRepository;
  late final String _programId;

  @override
  ProgramDetailsState build(String programId) {
    _programId = programId; // <-- assign it here
    _programsRepository = ref.watch(programsRepositoryProvider);
    Future.microtask(() => load());

    return const ProgramDetailsState.loading();
  }

  Future<void> load() async {
    state = const ProgramDetailsState.loading();

    try {
      final program = await _programsRepository.getProgram(_programId);

      state = ProgramDetailsState.data(program: program);
    } catch (e) {
      state = ProgramDetailsState.error(message: e.toString());
    }
  }
}

final programDetailsControllerProvider = NotifierProvider.autoDispose
    .family<ProgramDetailsController, ProgramDetailsState, String>(
      ProgramDetailsController.new,
    );
