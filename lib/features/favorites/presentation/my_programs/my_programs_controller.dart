import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

import '../../../../domain/entities/program.dart';

part 'my_programs_controller.freezed.dart';

@freezed
class MyProgramsState with _$MyProgramsState {
  const factory MyProgramsState({
    @Default([]) List<Program> programs,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    String? error,
  }) = _MyProgramsState;
}

class MyProgramsNotifier extends Notifier<MyProgramsState> {
  late final ProgramsRepository _repository;

  @override
  MyProgramsState build() {
    _repository = ref.watch(programsRepositoryProvider);
    Future.microtask(() => loadFavorites());
    return const MyProgramsState();
  }

  /// Load favorites
  Future<void> loadFavorites() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final programs = await _repository.getFavoritePrograms();

      state = state.copyWith(programs: programs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(programs: []);
    await loadFavorites();
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newPrograms = await _repository.getFavoritePrograms();
      state = state.copyWith(
        programs: [...state.programs, ...newPrograms],
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
