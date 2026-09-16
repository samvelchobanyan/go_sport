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
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
  }) = _ProgramEpisodesData;

  const factory ProgramEpisodesState.error({
    required String message,
  }) = _ProgramEpisodesError;
}

class ProgramDetailsController
    extends AutoDisposeFamilyNotifier<ProgramEpisodesState, String> {
  /// Guards against a stale response landing after a retry or a next-page
  /// request that raced it.
  int _requestId = 0;

  @override
  ProgramEpisodesState build(String programId) {
    Future.microtask(() => loadEpisodes());
    return const ProgramEpisodesState.loading();
  }

  Future<void> loadEpisodes() async {
    final reqId = ++_requestId;
    state = const ProgramEpisodesState.loading();

    try {
      final details = await ref
          .read(programsRepositoryProvider)
          .getProgramDetails(arg);
      if (reqId != _requestId) return;
      state = ProgramEpisodesState.data(
        program: details.program,
        episodes: details.episodes,
        hasMore: details.hasMore,
      );
    } catch (e) {
      if (reqId != _requestId) return;
      state = ProgramEpisodesState.error(message: e.toString());
    }
  }

  /// Appends the next page of episodes. No-op until the first page has
  /// landed, once the server reports no more, and while a page is in flight.
  /// A failed page leaves the list as it is — the next scroll retries.
  Future<void> loadMore() async {
    final current = state;
    if (current is! _ProgramEpisodesData) return;
    if (!current.hasMore || current.isLoadingMore) return;

    final reqId = ++_requestId;
    final nextPage = current.page + 1;
    state = current.copyWith(isLoadingMore: true);

    try {
      final details = await ref
          .read(programsRepositoryProvider)
          .getProgramDetails(arg, page: nextPage);
      if (reqId != _requestId) return;
      state = current.copyWith(
        episodes: [...current.episodes, ...details.episodes],
        page: nextPage,
        hasMore: details.hasMore,
        isLoadingMore: false,
      );
    } catch (_) {
      if (reqId != _requestId) return;
      state = current.copyWith(isLoadingMore: false);
    }
  }
}

final programDetailsControllerProvider = NotifierProvider.autoDispose
    .family<ProgramDetailsController, ProgramEpisodesState, String>(
      ProgramDetailsController.new,
    );
