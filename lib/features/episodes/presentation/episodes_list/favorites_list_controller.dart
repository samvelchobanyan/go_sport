import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/news_article.dart';

part 'favorites_list_controller.freezed.dart';

@freezed
sealed class FavoritesListState with _$FavoritesListState {
  const factory FavoritesListState.loading() = _FavoritesListLoading;

  const factory FavoritesListState.data({
    required List<NewsArticle> articles,
    required bool hasMore,
    required bool isLoadingMore,
  }) = _FavoritesListData;

  const factory FavoritesListState.error({required String message}) =
      _FavoritesListError;
}

class FavoritesListController extends AutoDisposeNotifier<FavoritesListState> {
  static const int _pageSize = 20;
  int _currentPage = 1;
  List<NewsArticle> _allArticles = [];

  @override
  FavoritesListState build() {
    Future.microtask(() => loadInitial());
    return const FavoritesListState.loading();
  }

  Future<void> loadInitial() async {
    state = const FavoritesListState.loading();
    _currentPage = 1;
    _allArticles = [];

    try {
      final articles = await ref
          .read(newsRepositoryProvider)
          .getNews(page: _currentPage, pageSize: _pageSize);

      _allArticles = articles;
      state = FavoritesListState.data(
        articles: _allArticles,
        hasMore: articles.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = FavoritesListState.error(message: e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! _FavoritesListData) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    try {
      _currentPage++;
      final newArticles = await ref
          .read(newsRepositoryProvider)
          .getNews(page: _currentPage, pageSize: _pageSize);

      _allArticles = [..._allArticles, ...newArticles];
      state = FavoritesListState.data(
        articles: _allArticles,
        hasMore: newArticles.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = currentState.copyWith(isLoadingMore: false);
    }
  }
}

final favoritesListControllerProvider =
    NotifierProvider.autoDispose<FavoritesListController, FavoritesListState>(
      FavoritesListController.new,
    );
