import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/domain/entities/episode.dart';

part 'episodes_controller.freezed.dart';

@freezed
sealed class EpisodesListState with _$EpisodesListState {
  const factory EpisodesListState.loading() = _EpisodesListLoading;

  const factory EpisodesListState.data({
    required List<Episode> episodes,
    required bool hasMore,
    required bool isLoadingMore,
  }) = _EpisodesListData;

  const factory EpisodesListState.error({required String message}) =
      _EpisodesListError;
}

class EpisodesListController extends AutoDisposeNotifier<EpisodesListState> {
  static const int _pageSize = 20;
  List<Episode> _allEpisodes = [];

  @override
  EpisodesListState build() {
    Future.microtask(() => loadInitial());
    return const EpisodesListState.loading();
  }

  Future<void> loadInitial() async {
    state = const EpisodesListState.loading();
    _allEpisodes = [];

    try {
      // Mock data - replace with actual repository call when available
      _allEpisodes = _getMockEpisodes();
      state = EpisodesListState.data(
        episodes: _allEpisodes,
        hasMore: _allEpisodes.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = EpisodesListState.error(message: e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! _EpisodesListData) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    try {
      final newEpisodes = _getMockEpisodes();
      _allEpisodes = [..._allEpisodes, ...newEpisodes];
      state = EpisodesListState.data(
        episodes: _allEpisodes,
        hasMore: newEpisodes.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      final currentStateData = currentState;
      state = currentStateData.copyWith(isLoadingMore: false);
    }
  }

  List<Episode> _getMockEpisodes() {
    return [
      Episode(
        id: '1',
        title: 'The Future of Sports Technology',
        subtitle: 'Podcast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Exploring the latest innovations in sports tech',
        duration: 45,
        releaseDate: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Episode(
        id: '2',
        title: 'Training Like a Champion',
        subtitle: 'Training Series',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Learn professional training techniques',
        duration: 52,
        releaseDate: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Episode(
        id: '3',
        title: 'Mental Resilience in Sports',
        subtitle: 'Podcast',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Building mental toughness for competition',
        duration: 38,
        releaseDate: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Episode(
        id: '4',
        title: 'Nutrition for Athletes',
        subtitle: 'Health Series',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Optimal nutrition strategies for peak performance',
        duration: 41,
        releaseDate: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Episode(
        id: '5',
        title: 'Recovery and Rest',
        subtitle: 'Wellness',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Why recovery is crucial for athletic performance',
        duration: 36,
        releaseDate: DateTime.now().subtract(const Duration(days: 12)),
      ),
      Episode(
        id: '6',
        title: 'Interview with Olympic Champion',
        subtitle: 'Interviews',
        imageUrl:
            'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=300&h=300&fit=crop',
        description: 'Exclusive interview with Olympic gold medalist',
        duration: 58,
        releaseDate: DateTime.now().subtract(const Duration(days: 14)),
      ),
    ];
  }
}

final episodesListControllerProvider =
    NotifierProvider.autoDispose<EpisodesListController, EpisodesListState>(
      EpisodesListController.new,
    );
