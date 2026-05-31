import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/program.dart';
import '../../../../domain/state/like_registry.dart';

part 'my_programs_controller.freezed.dart';

@freezed
class MyProgramsState with _$MyProgramsState {
  const factory MyProgramsState({
    @Default([]) List<Program> programs,
  }) = _MyProgramsState;
}

class MyProgramsNotifier extends Notifier<MyProgramsState> {
  @override
  MyProgramsState build() {
    final programs = ref.watch(
      likeRegistryProvider.select((s) => s.likedPrograms),
    );
    return MyProgramsState(programs: programs);
  }

  Future<void> refresh() async {
    await ref.read(likeRegistryProvider.notifier).initSession();
  }
}

final myProgramsStateProvider =
    NotifierProvider<MyProgramsNotifier, MyProgramsState>(
  MyProgramsNotifier.new,
);
