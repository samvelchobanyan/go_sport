import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';

part 'program_details_controller.freezed.dart';

@freezed
sealed class ProgramEpisodesState with _$ProgramEpisodesState {
  const factory ProgramEpisodesState.loading() = _ProgramEpisodesLoading;

  const factory ProgramEpisodesState.data({
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
    ref.listen(
      likeRegistryProvider.select((s) => s.episodeLikes),
      (_, next) {
        final currentEpisodes = state.mapOrNull(data: (d) => d.episodes);
        if (currentEpisodes == null) return;
        final updated = currentEpisodes.withLikes(next);
        if (!identical(updated, currentEpisodes)) {
          state = ProgramEpisodesState.data(episodes: updated);
        }
      },
    );
    Future.microtask(() => loadEpisodes());
    return const ProgramEpisodesState.loading();
  }

  Future<void> loadEpisodes() async {
    state = const ProgramEpisodesState.loading();

    try {
      final episodes = await ref
          .read(programsRepositoryProvider)
          .getProgramEpisodes(arg);
      state = ProgramEpisodesState.data(episodes: episodes);
    } catch (e) {
      state = ProgramEpisodesState.error(message: e.toString());
    }
  }

  Future<String?> toggleLike(String programId, [String? likeId]) async {
    return await ref
        .read(programsRepositoryProvider)
        .toggleLike(programId, likeId);
  }
}

final programDetailsControllerProvider = NotifierProvider.autoDispose
    .family<ProgramDetailsController, ProgramEpisodesState, String>(
      ProgramDetailsController.new,
    );
