import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/state/episodes_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/episode_item_row.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class EpisodesListScreen extends ConsumerStatefulWidget {
  const EpisodesListScreen({super.key});

  @override
  ConsumerState<EpisodesListScreen> createState() => _EpisodesListScreenState();
}

class _EpisodesListScreenState extends ConsumerState<EpisodesListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(episodesStateProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(episodesStateProvider);

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background image (visible behind rounded list)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240,
            child: Image.asset(
              'assets/images/mine_cover.png',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Foreground content
          _buildBody(context, ref, state),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, EpisodesState state) {
    // Initial loading
    if (state.isLoading && state.episodesList.isEmpty) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/dynamic_bg.svg',
            title: 'New Episodes',
            subtitle: 'episodes',
            itemCount: 0,
            onTapIcon: _playAll,
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    // Error with no data
    if (state.error != null && state.episodesList.isEmpty) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/dynamic_bg.svg',
            title: 'New Episodes',
            subtitle: 'episodes',
            itemCount: 0,
            onTapIcon: _playAll,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading episodes', style: context.subtitleLSemi),
                  const SizedBox(height: 8),
                  Text(
                    state.error!,
                    style: context.textL?.copyWith(color: DSColors.gray60),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(episodesStateProvider.notifier).refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    final episodes = state.episodesList;

    if (episodes.isEmpty) {
      return CustomScrollView(
        controller: _scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/dynamic_bg.svg',
            title: 'New Episodes',
            subtitle: 'episodes',
            itemCount: 0,
            onTapIcon: _playAll,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('No episodes yet', style: context.subtitleLBold),
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        MyCategoriesTop(
          iconPath: 'assets/icons/dynamic_bg.svg',
          title: 'New Episodes',
          subtitle: 'episodes',
          itemCount: episodes.length,
          onTapIcon: _playAll,
        ),

        // 🔹 Episodes list
        ..._buildEpisodesSliver(episodes),

        // 🔹 Loading indicator at the bottom
        if (state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }

  void _playAll() {
    // TODO: Implement play-all episodes behavior
    debugPrint('Play all episodes pressed');
  }

  List<Widget> _buildEpisodesSliver(List<dynamic> episodes) {
    // Build children list: separators and items
    final children = <Widget>[];

    for (int i = 0; i < episodes.length; i++) {
      if (i > 0) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          ),
        );
      }
      final episode = episodes[i];
      children.add(
        EpisodeItemRow(
          imageUrl: episode.imageUrl ?? '',
          title: episode.title,
          releaseDate: episode.releaseDate,
          duration: episode.duration,
          onTap: () => debugPrint('Episode tapped: ${episode.id}'),
          onIconTap: () => debugPrint('Episode icon tapped for: ${episode.id}'),
        ),
      );
    }

    // Wrap in a single column inside a container
    return [
      SliverToBoxAdapter(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: Container(
            color: DSColors.white,
            child: Column(children: children),
          ),
        ),
      ),
    ];
  }
}
