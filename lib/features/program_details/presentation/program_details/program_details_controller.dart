import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';

part 'program_details_controller.freezed.dart';

@freezed
sealed class ProgramEpisodesState with _$ProgramEpisodesState {
  const factory ProgramEpisodesState.loading() = _ProgramEpisodesLoading;

  const factory ProgramEpisodesState.data({
    // Derived from the episodes response; null when the program has none.
    Program? program,
    required List<Track> episodes,
  }) = _ProgramEpisodesData;

  const factory ProgramEpisodesState.error({
    required String message,
  }) = _ProgramEpisodesError;
}

class ProgramDetailsController
    extends AutoDisposeFamilyNotifier<ProgramEpisodesState, String> {
  @override
  ProgramEpisodesState build(String programId) {
    Future.microtask(() => loadEpisodes());
    return const ProgramEpisodesState.loading();
  }

  Future<void> loadEpisodes() async {
    state = const ProgramEpisodesState.loading();

    try {
      final details = await ref
          .read(programsRepositoryProvider)
          .getProgramDetails(arg);
      state = ProgramEpisodesState.data(
        program: details.program,
        episodes: details.episodes,
      );
    } catch (e) {
      state = ProgramEpisodesState.error(message: e.toString());
    }
  }
}

final programDetailsControllerProvider = NotifierProvider.autoDispose
    .family<ProgramDetailsController, ProgramEpisodesState, String>(
      ProgramDetailsController.new,
    );
