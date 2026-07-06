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

  /// id статьи -> id записи лайка. Читается один раз с /api/user-articles,
  /// используется чтобы проставить isLiked/likeId загруженным статьям.
  Map<String, String> _likedIds = {};
  Future<void>? _likedIdsLoaded;

  @override
  NewsState build() {
    _repository = ref.watch(newsRepositoryProvider);
    Future.microtask(() => loadNews());
    return const NewsState();
  }

  Future<void> _ensureLikedIds() => _likedIdsLoaded ??= _loadLikedIds();

  Future<void> _loadLikedIds() async {
    try {
      _likedIds = await _repository.getLikedArticles();
    } catch (_) {
      // молча игнорируем — обогащение просто оставит статьи нелайкнутыми
    }
  }

  /// Проставляет статье isLiked/likeId по загруженному набору лайков.
  NewsArticle _withLike(NewsArticle article) {
    final likeId = _likedIds[article.id];
    return likeId != null
        ? article.copyWith(isLiked: true, likeId: likeId)
        : article;
  }

  Future<void> loadNews({int page = 1, int pageSize = 20}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _ensureLikedIds();
      final articles = await _repository.getNews(
        page: page,
        pageSize: pageSize,
      );
      final articlesMap = {
        ...state.articles,
        for (final article in articles) article.id: _withLike(article),
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
      await _ensureLikedIds();
      final article = await _repository.getArticle(id);
      state = state.copyWith(
        articles: {...state.articles, article.id: _withLike(article)},
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> toggleLike(String id) async {
    final article = state.articles[id];
    if (article == null) return;

    final previousArticle = article;
    final previousArticles = state.articles;

    if (article.isLiked) {
      // Unlike — optimistic remove + repo DELETE + rollback on error
      final updatedArticle = article.copyWith(
        isLiked: false,
        likesCount: article.likesCount > 0 ? article.likesCount - 1 : 0,
        likeId: null,
      );

      state = state.copyWith(
        articles: {...previousArticles, id: updatedArticle},
      );

      try {
        await _repository.toggleLike(id, article.likeId);
        _likedIds.remove(id);
      } catch (e) {
        state = state.copyWith(
          articles: {...previousArticles, id: previousArticle},
          error: e.toString(),
        );
      }
      return;
    }

    // Like — optimistic add + repo POST + store returned likeId + rollback on error
    final updatedArticle = article.copyWith(
      isLiked: true,
      likesCount: article.likesCount + 1,
    );

    state = state.copyWith(articles: {...previousArticles, id: updatedArticle});

    try {
      final newLikeId = await _repository.toggleLike(id);
      if (newLikeId != null && newLikeId.isNotEmpty) {
        _likedIds[id] = newLikeId;
        state = state.copyWith(
          articles: {
            ...state.articles,
            id: updatedArticle.copyWith(likeId: newLikeId),
          },
        );
      }
    } catch (e) {
      state = state.copyWith(
        articles: {...previousArticles, id: previousArticle},
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    _likedIdsLoaded = null;
    state = state.copyWith(articles: {});
    await loadNews();
  }
}

final newsStateProvider = NotifierProvider<NewsNotifier, NewsState>(
  NewsNotifier.new,
);
