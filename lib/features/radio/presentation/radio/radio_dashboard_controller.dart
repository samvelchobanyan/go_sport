import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/repositories/episodes_repository.dart';
import 'package:go_sport/domain/repositories/programs_repository.dart';

part 'radio_dashboard_controller.freezed.dart';

@freezed
class RadioDashboardState with _$RadioDashboardState {
  const factory RadioDashboardState({
    @Default(false) bool isLoading,
    String? error,
    @Default([]) List<Program> featuredPrograms,
    @Default([]) List<Track> featuredEpisodes,
  }) = _RadioDashboardState;
}

class RadioDashboardController
    extends AutoDisposeNotifier<RadioDashboardState> {
  late final EpisodesRepository _episodesRepository;
  late final ProgramsRepository _programsRepository;

  @override
  RadioDashboardState build() {
    _episodesRepository = ref.watch(episodesRepositoryProvider);
    _programsRepository = ref.watch(programsRepositoryProvider);
    Future.microtask(() => load());
    return const RadioDashboardState();
  }

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final (featuredPrograms, featuredEpisodes) = await (
        _programsRepository.getFeaturedPrograms(),
        _episodesRepository.getFeaturedEpisodes(),
      ).wait;

      state = state.copyWith(
        isLoading: false,
        featuredPrograms: featuredPrograms,
        featuredEpisodes: featuredEpisodes,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Pull-to-refresh: reloads without clearing, so current content stays
  /// visible while fetching and is replaced atomically when data arrives.
  Future<void> refresh() => load();
}

final radioStateProvider =
    NotifierProvider.autoDispose<RadioDashboardController, RadioDashboardState>(
      RadioDashboardController.new,
    );
