import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

import '../../../../domain/entities/program.dart';
import '../../../../domain/state/like_registry.dart';

part 'my_programs_controller.freezed.dart';

@freezed
class MyProgramsState with _$MyProgramsState {
  const factory MyProgramsState({
    @Default([]) List<Program> programs,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int currentPage,
    @Default(true) bool hasMore,
    String? error,
  }) = _MyProgramsState;
}

class MyProgramsNotifier extends Notifier<MyProgramsState> {
  late final ProgramsRepository _repository;

  @override
  MyProgramsState build() {
    _repository = ref.watch(programsRepositoryProvider);
    ref.listen(
      likeRegistryProvider.select((s) => s.programLikes),
      (_, next) {
        if (state.programs.isEmpty) return;
        final kept = state.programs.where((p) => next.containsKey(p.id)).toList();
        if (kept.length != state.programs.length) {
          state = state.copyWith(programs: kept);
        }
      },
    );
    Future.microtask(() => loadFavorites());
    return const MyProgramsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _repository.getFavoritePrograms(page: 1);

      state = state.copyWith(
        programs: result.items,
        currentPage: 1,
        hasMore: result.hasMore,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(
      programs: [],
      currentPage: 1,
      hasMore: true,
    );
    await loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore || !state.hasMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = state.currentPage + 1;
      final result = await _repository.getFavoritePrograms(page: nextPage);
      state = state.copyWith(
        programs: [...state.programs, ...result.items],
        currentPage: nextPage,
        hasMore: result.hasMore,
        isLoadingMore: false,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }
}

final myProgramsStateProvider =
    NotifierProvider<MyProgramsNotifier, MyProgramsState>(
  MyProgramsNotifier.new,
);
