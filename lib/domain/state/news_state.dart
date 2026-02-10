import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/news_article.dart';
import '../repositories/news_repository.dart';
import '../../core/di/repository_providers.dart';

part 'news_state.freezed.dart';

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    @Default({}) Map<String, NewsArticle> articles,
    @Default(false) bool isLoading,
    String? error,
  }) = _NewsState;
}

extension NewsStateX on NewsState {
  List<NewsArticle> get articlesList => articles.values.toList();
  
  NewsArticle? getArticle(String id) => articles[id];
}

class NewsNotifier extends Notifier<NewsState> {
  late final NewsRepository _repository;

  @override
  NewsState build() {
    _repository = ref.watch(newsRepositoryProvider);
    Future.microtask(() => loadNews());
    return const NewsState();
  }

  Future<void> loadNews({int page = 1, int pageSize = 20}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final articles = await _repository.getNews(page: page, pageSize: pageSize);
      final articlesMap = {
        ...state.articles,
        for (final article in articles) article.id: article,
      };
      state = state.copyWith(articles: articlesMap, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadArticle(String id) async {
    // Если уже есть в кеше, не загружаем
    if (state.articles.containsKey(id)) return;

    try {
      final article = await _repository.getArticle(id);
      state = state.copyWith(
        articles: {...state.articles, article.id: article},
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> toggleLike(String id) async {
    final article = state.articles[id];
    if (article == null) return;

    // Optimistic update
    final updatedArticle = article.copyWith(
      isLiked: !article.isLiked,
      likesCount: article.isLiked ? article.likesCount - 1 : article.likesCount + 1,
    );
    state = state.copyWith(
      articles: {...state.articles, id: updatedArticle},
    );

    try {
      await _repository.toggleLike(id);
    } catch (e) {
      // Rollback on error
      state = state.copyWith(
        articles: {...state.articles, id: article},
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    state = state.copyWith(articles: {});
    await loadNews();
  }
}

final newsStateProvider = NotifierProvider<NewsNotifier, NewsState>(
  NewsNotifier.new,
);
