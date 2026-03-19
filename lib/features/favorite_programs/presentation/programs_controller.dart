import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

import '../../../domain/entities/program.dart';

part 'programs_controller.freezed.dart';

@freezed
class ProgramsState with _$ProgramsState {
  const factory ProgramsState({
    @Default({}) Map<String, Program> programs,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _ProgramsState;
}

extension ProgramsStateX on ProgramsState {
  List<Program> get programsList => programs.values.toList();

  Program? getProgram(String id) => programs[id];
}

class ProgramsNotifier extends Notifier<ProgramsState> {
  late final ProgramsRepository _repository;

  @override
  ProgramsState build() {
    _repository = ref.watch(programsRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const ProgramsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final programs = await _repository.getFavoritePrograms();

      final programsMap = {for (final program in programs) program.id: program};

      state = state.copyWith(programs: programsMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Optimistic like toggle (like News)
  Future<void> toggleLike(String id) async {
    final program = state.programs[id];
    if (program == null) return;

    // Optimistic update
    final updated = program.copyWith(isLiked: !program.isLiked);

    state = state.copyWith(programs: {...state.programs, id: updated});

    try {
      await _repository.toggleLike(id);
    } catch (e) {
      // rollback
      state = state.copyWith(
        programs: {...state.programs, id: program},
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(programs: {});
    await loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newTracks = await _repository.getFavoritePrograms();
      final programsMap = <String, Program>{
        ...state.programs,
        for (final program in newTracks) program.id: program,
      };
      state = state.copyWith(programs: programsMap, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }
}

final programsStateProvider = NotifierProvider<ProgramsNotifier, ProgramsState>(
  ProgramsNotifier.new,
);
