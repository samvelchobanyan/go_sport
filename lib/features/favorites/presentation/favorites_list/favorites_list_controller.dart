import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/track.dart';

part 'favorites_list_controller.freezed.dart';

@freezed
sealed class FavoritesListState with _$FavoritesListState {
  const factory FavoritesListState.loading() = _FavoritesListLoading;

  const factory FavoritesListState.data({required List<Track> songs}) =
      _FavoritesListData;

  const factory FavoritesListState.error({required String message}) =
      _FavoritesListError;
}

class FavoritesListController extends AutoDisposeNotifier<FavoritesListState> {
  @override
  FavoritesListState build() {
    Future.microtask(() => loadFavoriteSongs());
    return const FavoritesListState.loading();
  }

  Future<void> loadFavoriteSongs() async {
    state = const FavoritesListState.loading();

    try {
      final songs = await ref.read(tracksRepositoryProvider).getFeaturedTracks();

      state = FavoritesListState.data(songs: songs);
    } catch (e) {
      state = FavoritesListState.error(message: e.toString());
    }
  }
}

final favoritesListControllerProvider =
    NotifierProvider.autoDispose<FavoritesListController, FavoritesListState>(
      FavoritesListController.new,
    );
