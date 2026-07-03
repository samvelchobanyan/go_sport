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
      final articles = await _repository.getNews(
        page: page,
        pageSize: pageSize,
      );
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

  // Future<void> toggleLike(String id) async {
  //   final article = state.articles[id];
  //   if (article == null) return;

  //   // Optimistic update
  //   final updatedArticle = article.copyWith(
  //     isLiked: !article.isLiked,
  //     likesCount: article.isLiked ? article.likesCount - 1 : article.likesCount + 1,
  //   );
  //   state = state.copyWith(
  //     articles: {...state.articles, id: updatedArticle},
  //   );

  //   try {
  //     await _repository.toggleLike(id);
  //   } catch (e) {
  //     // Rollback on error
  //     state = state.copyWith(
  //       articles: {...state.articles, id: article},
  //       error: e.toString(),
  //     );
  //   }
  // }

  Future<void> toggleLike(String id) async {
    final article = state.articles[id];
    if (article == null) {
      print('⚠️ [toggleLike] Article with ID $id not found in state cache!');
      return;
    }

    final previousArticle = article;
    final previousArticles = state.articles;

    if (article.isLiked) {
      print('=== [UNLIKE ACTION STARTED] ===');
      print(
        'Target Article ID: $id | Current likeId on entity: ${article.likeId}',
      );

      final updatedArticle = article.copyWith(
        isLiked: false,
        likesCount: article.likesCount > 0 ? article.likesCount - 1 : 0,
        likeId: null,
      );

      state = state.copyWith(
        articles: {...previousArticles, id: updatedArticle},
      );
      print('➔ [UNLIKE] Optimistic UI state updated to UNLIKED.');

      try {
        print('➔ [UNLIKE] Calling Repository API...');
        await _repository.toggleLike(id, article.likeId);
        print('✅ [UNLIKE] Repository API completed successfully.');
      } catch (e, stack) {
        print('❌ [UNLIKE] API failed! Rolling back state.');
        print('Error context: $e');
        print('Stacktrace: $stack');
        state = state.copyWith(
          articles: {...previousArticles, id: previousArticle},
          error: e.toString(),
        );
      }
      return;
    }

    // --- LIKE ACTIONS ---
    print('=== [LIKE ACTION STARTED] ===');
    print('Target Article ID: $id');

    final updatedArticle = article.copyWith(
      isLiked: true,
      likesCount: article.likesCount + 1,
    );

    state = state.copyWith(articles: {...previousArticles, id: updatedArticle});
    print('➔ [LIKE] Optimistic UI state updated to LIKED.');

    try {
      print('➔ [LIKE] Calling Repository API...');
      final newLikeId = await _repository.toggleLike(id);
      print('➔ [LIKE] Repository API returned fresh newLikeId: "$newLikeId"');

      if (newLikeId != null && newLikeId.isNotEmpty) {
        final updatedMap = Map<String, NewsArticle>.from(state.articles);
        updatedMap[id] = updatedArticle.copyWith(likeId: newLikeId);

        state = state.copyWith(articles: updatedMap);
        print('✅ [LIKE] State finalized successfully with saved likeId.');
      } else {
        print(
          '⚠️ [LIKE] API ran successfully, but returned an empty or null likeId token!',
        );
      }
    } catch (e, stack) {
      print(
        '❌ [LIKE] API failed or state parsing crashed! Rolling back state.',
      );
      print('Error context: $e');
      print('Stacktrace: $stack');
      state = state.copyWith(
        articles: {...previousArticles, id: previousArticle},
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
