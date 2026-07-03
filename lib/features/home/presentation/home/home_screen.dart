import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/state/news_state.dart';
import 'package:go_sport/domain/state/stories_state.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/domain/state/user_state.dart';
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

  void _openStoryOverlay(BuildContext context, int initialIndex) {
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
          initialIndex: initialIndex,
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
    final avatarUrl = ref.watch(
      userStateProvider.select((s) => s.user?.avatar),
    );

    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        backgroundColor: DSColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // pinned: true,
        // floating: true,
        leading: Padding(
          padding: const EdgeInsets.only(
            top: DSSpacing.s8,
            bottom: DSSpacing.s8,
            left: DSSpacing.m,
          ),
          child: UserAvatarButton(
            imageUrl: avatarUrl,
            onTap: () {
              context.push(AppRoutes.profile);
            },
          ),
        ),
        title: SvgPicture.asset('assets/icons/app_logo.svg', height: 40),
        centerTitle: true,
        actions: [const SearchButton()],
      ),
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
          padding: const EdgeInsets.all(DSSpacing.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: DSColors.errorColor,
                size: DSIconSize.s48,
              ),
              const SizedBox(height: DSSpacing.m),
              Text(
                errorMessage ?? 'Error loading data',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: DSSpacing.l),
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
            const SizedBox(height: DSSpacing.m),
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
          // Stories Row
          if (stories.isNotEmpty)
            SliverToBoxAdapter(
              child: Container(
                height: 72,
                margin: const EdgeInsets.only(top: DSSpacing.s18),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
                  itemCount: stories.length,
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: DSSpacing.s8),
                      child: StoryItem(
                        story: story,
                        onTap: () => _openStoryOverlay(context, index),
                      ),
                    );
                  },
                ),
              ),
            ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: DSSpacing.l,
                bottom: DSSpacing.xl,
              ),
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
                padding: const EdgeInsets.only(
                  top: DSSpacing.xl,
                  bottom: DSSpacing.s10,
                ),
                child: GestureDetector(
                  onTap: () {
                    context.push('/news');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DSSpacing.m,
                    ),
                    child: Row(
                      children: [
                        Text('News', style: context.h2),
                        const SizedBox(width: DSSpacing.s8),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: DSIconSize.s16,
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
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: DSSpacing.m,
                          // vertical: DSSpacing.s10,
                        ),
                        child: DottedDivider(),
                      ),
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
