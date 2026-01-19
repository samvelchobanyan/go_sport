import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:async';

import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/news_article.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/story.dart';

part 'home_controller.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
	const factory HomeState.loading() = _HomeLoading;

	const factory HomeState.data({
		required List<Story> stories,
		required List<NewsArticle> news,
		required List<Playlist> playlists,
	}) = _HomeData;

	const factory HomeState.empty() = _HomeEmpty;

	const factory HomeState.error({
		required String message,
	}) = _HomeError;
}

class HomeController extends AutoDisposeNotifier<HomeState> {
	@override
	HomeState build() {
		Future.microtask(() => load());
		return const HomeState.loading();
	}

	Future<void> load() async {
		state = const HomeState.loading();

		try {
			final stories = await ref.read(storyRepositoryProvider).getStories();
			final news = await ref
					.read(newsRepositoryProvider)
					.getNews(page: 1, pageSize: 20);
			final playlists = await ref.read(playlistRepositoryProvider).getFeaturedPlaylists();

			if (stories.isEmpty && news.isEmpty) {
				state = const HomeState.empty();
				return;
			}

			state = HomeState.data(stories: stories, news: news, playlists: playlists);
		} catch (e) {
			state = HomeState.error(message: e.toString());
		}
	}
}

final homeControllerProvider =
		NotifierProvider.autoDispose<HomeController, HomeState>(HomeController.new);
