import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/news_article.dart';

part 'news_detail_controller.freezed.dart';

@freezed
sealed class NewsDetailState with _$NewsDetailState {
  const factory NewsDetailState.loading() = _NewsDetailLoading;

  const factory NewsDetailState.data({
    required NewsArticle article,
  }) = _NewsDetailData;

  const factory NewsDetailState.error({
    required String message,
  }) = _NewsDetailError;
}

class NewsDetailController extends AutoDisposeFamilyNotifier<NewsDetailState, String> {
  @override
  NewsDetailState build(String articleId) {
    final cached = ref.read(newsRepositoryProvider).getCachedArticle(articleId);
    if (cached != null) {
      return NewsDetailState.data(article: cached);
    }

    Future.microtask(load);
    return const NewsDetailState.loading();
  }

  Future<void> load() async {
    final hasData = state is _NewsDetailData;
    if (!hasData) {
      state = const NewsDetailState.loading();
    }

    try {
      final article = await ref.read(newsRepositoryProvider).getArticle(arg);
      state = NewsDetailState.data(article: article);
    } catch (e) {
      state = NewsDetailState.error(message: e.toString());
    }
  }

  Future<void> toggleLike() async {
    final currentState = state;
    if (currentState is! _NewsDetailData) return;

    // Оптимистичное обновление UI
    final currentArticle = currentState.article;
    state = NewsDetailState.data(
      article: currentArticle.copyWith(
        isLiked: !currentArticle.isLiked,
        likesCount: currentArticle.isLiked
            ? currentArticle.likesCount - 1
            : currentArticle.likesCount + 1,
      ),
    );

    try {
      await ref.read(newsRepositoryProvider).toggleLike(arg);
    } catch (e) {
      // В случае ошибки откатываем изменения
      state = NewsDetailState.data(article: currentArticle);
    }
  }
}

final newsDetailControllerProvider = NotifierProvider.autoDispose
    .family<NewsDetailController, NewsDetailState, String>(
  NewsDetailController.new,
);
