import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/state/news_state.dart';
import 'package:go_sport/domain/state/stories_state.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/features/shared_widgets/featured_playlists.dart';
import '../../../../domain/entities/story.dart';

import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/search_button.dart';
import '../../../shared_widgets/dotted_divider.dart';

import 'widgets/hero_banner.dart';
import 'widgets/story_item.dart';
import 'widgets/news_item.dart';
import 'widgets/home_skeleton.dart';
import '../story/story_overlay.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _handleStoryAction(
    BuildContext context,
    String targetType,
    String targetId,
  ) {
    switch (targetType) {
      case 'program':
        context.push('/program/$targetId');
        break;
      case 'album':
        context.push('/album/$targetId');
        break;
      case 'artist':
        context.push('/artist/$targetId');
        break;
      case 'playlist':
        context.push('/playlist/$targetId');
        break;
      case 'radio':
        context.push('/radio');
        break;
      default:
        debugPrint('Unknown story action target type: $targetType');
    }
  }

  void _openStoryOverlay(BuildContext context, WidgetRef ref, Story story) {
    // Mark story as viewed
    ref.read(storiesStateProvider.notifier).markAsViewed(story.id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.gray90,
      enableDrag: true,
      builder: (modalContext) => MediaQuery(
        data: MediaQuery.of(context),
        child: StoryOverlay(
          story: story,
          onClose: () => Navigator.of(modalContext).pop(),
          onAction: (targetType, targetId) {
            Navigator.of(modalContext).pop();
            _handleStoryAction(context, targetType, targetId);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsState = ref.watch(newsStateProvider);
    final storiesState = ref.watch(storiesStateProvider);
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);

    // Check if any data is still loading (initial load)
    final isLoading =
        (newsState.isLoading && newsState.articles.isEmpty) ||
        (storiesState.isLoading && storiesState.stories.isEmpty) ||
        (playlistsState.isLoading && playlistsState.playlists.isEmpty);

    // Check for errors
    final hasError =
        newsState.error != null ||
        storiesState.error != null ||
        playlistsState.error != null;
    final errorMessage =
        newsState.error ?? storiesState.error ?? playlistsState.error;

    // Get data from states
    final stories = storiesState.storiesList;
    final news = newsState.articlesList;
    final playlists = playlistsState.playlistsList;

    return Scaffold(
      backgroundColor: DSColors.white,
      body: _buildBody(
        context,
        ref,
        isLoading: isLoading,
        hasError: hasError,
        errorMessage: errorMessage,
        stories: stories,
        news: news,
        playlists: playlists,
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref, {
    required bool isLoading,
    required bool hasError,
    required String? errorMessage,
    required List<Story> stories,
    required List news,
    required List<Playlist> playlists,
  }) {
    if (isLoading) {
      return const HomeSkeleton();
    }

    if (hasError && stories.isEmpty && news.isEmpty && playlists.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: DSColors.errorColor,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage ?? 'Error loading data',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _refresh(ref),
                child: const Text('Повторить запрос'),
              ),
            ],
          ),
        ),
      );
    }

    if (stories.isEmpty && news.isEmpty && playlists.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Контента пока нет'),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => _refresh(ref),
              child: const Text('Обновить'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: DSColors.white,
            elevation: 0,
            pinned: true,
            floating: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16),
              child: UserAvatarButton(
                imageUrl: null,
                onTap: () {
                  context.push(AppRoutes.profile);
                },
              ),
            ),
            title: SvgPicture.asset('assets/icons/app_logo.svg', height: 40),
            centerTitle: true,
            actions: [
              SearchButton(
                onTap: () {
                  // TODO: открыть поиск
                },
              ),
            ],
          ),

          // Stories Row
          if (stories.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                height: 90,
                margin: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: StoryItem(
                        story: story,
                        onTap: () => _openStoryOverlay(context, ref, story),
                      ),
                    );
                  },
                ),
              ),
            ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 32),
              child: PodcastBanner(
                onTap: () {
                  // TODO: навигация
                },
              ),
            ),
          ),

          // Featured playlists header
          FeaturedPlaylistsSection(playlists: playlists),

          // News section header
          if (news.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    context.push('/news');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Text('News', style: context.h2),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: DSColors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // News list (3 items)
          if (news.isNotEmpty)
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final article = news[index];
                final isLast = index == 2 || index == news.length - 1;

                return Column(
                  children: [
                    NewsItem(
                      article: article,
                      onTap: () {
                        context.push('/news/${article.id}');
                      },
                    ),
                    if (!isLast) ...[
                      const SizedBox(height: 10),

                      const DottedDivider(),

                      const SizedBox(height: 10),
                    ],
                  ],
                );
              }, childCount: news.length > 3 ? 3 : news.length),
            ),
        ],
      ),
    );
  }

  Future<void> _refresh(WidgetRef ref) async {
    await Future.wait([
      ref.read(newsStateProvider.notifier).refresh(),
      ref.read(storiesStateProvider.notifier).refresh(),
      ref.read(featuredPlaylistsStateProvider.notifier).refresh(),
    ]);
  }
}
