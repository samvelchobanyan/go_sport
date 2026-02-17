import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/program.dart';
import '../../data/repositories/programs_repository_mock.dart';

part 'programs_state.freezed.dart';

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
  @override
  ProgramsState build() {
    Future.microtask(() => loadPrograms());
    return const ProgramsState();
  }

  Future<void> loadPrograms() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final programs = ProgramsRepositoryMock.getMockPrograms();
      final programsMap = {
        for (final program in programs) program.id: program,
      };
      state = state.copyWith(programs: programsMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadMore() async {
    if (state.isLoadingMore) return;

    state = state.copyWith(isLoadingMore: true);

    try {
      final newPrograms = ProgramsRepositoryMock.getMockPrograms();
      final programsMap = {
        ...state.programs,
        for (final program in newPrograms) program.id: program,
      };
      state = state.copyWith(programs: programsMap, isLoadingMore: false);
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(programs: {});
    await loadPrograms();
  }

}

final programsStateProvider = NotifierProvider<ProgramsNotifier, ProgramsState>(
  ProgramsNotifier.new,
);
