import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/news_article.dart';

part 'news_list_controller.freezed.dart';

@freezed
sealed class NewsListState with _$NewsListState {
  const factory NewsListState.loading() = _NewsListLoading;

  const factory NewsListState.data({
    required List<NewsArticle> articles,
    required bool hasMore,
    required bool isLoadingMore,
  }) = _NewsListData;

  const factory NewsListState.error({
    required String message,
  }) = _NewsListError;
}

class NewsListController extends AutoDisposeNotifier<NewsListState> {
  static const int _pageSize = 20;
  int _currentPage = 1;
  List<NewsArticle> _allArticles = [];

  @override
  NewsListState build() {
    Future.microtask(() => loadInitial());
    return const NewsListState.loading();
  }

  Future<void> loadInitial() async {
    state = const NewsListState.loading();
    _currentPage = 1;
    _allArticles = [];

    try {
      final articles = await ref.read(newsRepositoryProvider).getNews(
        page: _currentPage,
        pageSize: _pageSize,
      );

      _allArticles = articles;
      state = NewsListState.data(
        articles: _allArticles,
        hasMore: articles.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = NewsListState.error(message: e.toString());
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! _NewsListData) return;
    if (!currentState.hasMore || currentState.isLoadingMore) return;

    state = currentState.copyWith(isLoadingMore: true);

    try {
      _currentPage++;
      final newArticles = await ref.read(newsRepositoryProvider).getNews(
        page: _currentPage,
        pageSize: _pageSize,
      );

      _allArticles = [..._allArticles, ...newArticles];
      state = NewsListState.data(
        articles: _allArticles,
        hasMore: newArticles.length >= _pageSize,
        isLoadingMore: false,
      );
    } catch (e) {
      state = currentState.copyWith(isLoadingMore: false);
    }
  }
}

final newsListControllerProvider =
    NotifierProvider.autoDispose<NewsListController, NewsListState>(
  NewsListController.new,
);
