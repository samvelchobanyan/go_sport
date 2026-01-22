import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import '../../../../domain/entities/story.dart';
import '../../../shared_widgets/wave_section_header.dart';
import 'home_controller.dart';

// Импорты твоих виджетов (проверь пути, если они лежат в другом месте)
import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/search_button.dart';
import '../../../shared_widgets/playlist_card.dart';
import '../../../shared_widgets/dotted_divider.dart';

import 'widgets/hero_banner.dart';
import 'widgets/story_item.dart';
import 'widgets/news_item.dart';
import 'widgets/home_skeleton.dart';
import '../story/story_overlay.dart';

import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _handleStoryAction(BuildContext context, String targetType, String targetId) {
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

  void _openStoryOverlay(BuildContext context, Story story) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.black.withOpacity(0.9),
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
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      backgroundColor: DSColors.white,
      body: state.when(
        loading: () => const HomeSkeleton(),
        data: (stories, news, playlists) => RefreshIndicator(
          onRefresh: () => ref.read(homeControllerProvider.notifier).load(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: DSColors.white,
                elevation: 0,
                pinned: true,
                floating: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: UserAvatarButton(
                    imageUrl: null, // TODO: добавить URL аватара из state
                    onTap: () {
                      // TODO: навигация в профиль
                    },
                  ),
                ),
                title: SvgPicture.asset(
                  'assets/icons/app_logo.svg',
                  height: 40,
                ),
                centerTitle: true,
                actions: [
                  SearchButton(
                    onTap: () {
                      // TODO: открыть поиск
                    },
                  ),
                ],
              ),

              // Stories Row - показываем только если есть stories
              if (stories.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    height: 90,
                    // color: Colors.red,
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
                            onTap: () => _openStoryOverlay(context, story),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: PodcastBanner(
                      onTap: () {
                        // TODO: навигация
                      },
                    ),
                  ),
                ),

                // Featured playlists заголовок
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 32, bottom: 16),
                    child: WaveSectionHeader(
                      title: 'Featured playlists',
                      showAnimation: true,
                    ),
                  ),
                ),

                // Featured playlists carousel
                if (playlists.isNotEmpty)
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: playlists.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: PlaylistCard(
                              title: playlists[index].title,
                              imageUrl: playlists[index].imageUrl,
                              trackCount: playlists[index].trackCount,
                              onTap: () {
                                // TODO: навигация на экран плейлиста
                                print('Playlist tapped: ${playlists[index].id}');
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                // News section header
                if (news.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32, bottom: 16),
                      child: GestureDetector(
                        onTap: () {
                          context.push('/news');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            children: [
                              Text(
                                'News',
                                style: context.h2,
                              ),
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
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
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
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: DottedDivider(),
                              ),
                              const SizedBox(height: 10),
                            ],
                          ],
                        );
                      },
                      childCount: news.length > 3 ? 3 : news.length,
                    ),
                  ),
            ],
          ),
        ),

        empty: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Контента пока нет'),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => ref.read(homeControllerProvider.notifier).load(),
                child: const Text('Обновить'),
              ),
            ],
          ),
        ),

        error: (message) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: DSColors.errorColor, size: 48),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => ref.read(homeControllerProvider.notifier).load(),
                  child: const Text('Повторить запрос'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}