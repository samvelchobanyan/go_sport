import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/episodes/presentation/episodes_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/track_tile.dart';

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
    final List<Track> episodes = state.episodesList;
    final isLoading = state.isLoading && episodes.isEmpty;
    final hasError = state.error != null;
    final errorMessage = state.error;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : (hasError && episodes.isEmpty)
          ? Center(
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
                      onPressed: () =>
                          ref.read(episodesStateProvider.notifier).refresh(),
                      child: const Text('Повторить запрос'),
                    ),
                  ],
                ),
              ),
            )
          : (episodes.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No episodes yet', style: context.subtitleLBold),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () =>
                        ref.read(episodesStateProvider.notifier).refresh(),
                    child: const Text('Обновить'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: () =>
                  ref.read(episodesStateProvider.notifier).refresh(),
              child: Stack(
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
                  CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      MyCategoriesTop(
                        iconPath: 'assets/icons/dynamic_bg.svg',
                        title: 'New Episodes',
                        subtitle: 'episodes',
                        itemCount: episodes.length,
                        actionIcon: SvgPicture.asset(
                          'assets/icons/play_blue.svg',
                        ),
                        onActionIconTap: () =>
                            _onPlayTap(ref, episodes, 'New Episodes', ''),
                      ),

                      // 🔹 Episodes list
                      if (episodes.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'No episodes yet',
                              style: context.subtitleLBold,
                            ),
                          ),
                        )
                      else
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
                  ),
                ],
              ),
            ),
    );
  }

  void _onTrackTap(WidgetRef ref, List<Track> episodes, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.episodes(
            id: index.toString(),
            title: 'My Episodes',
            imageUrl: '',
          ),
          startIndex: index,
        );
  }

  void _onPlayTap(
    WidgetRef ref,
    List<Track> episodes,
    String title,
    String imageUrl,
  ) {
    if (episodes.isEmpty) return;
    final randomIndex = Random().nextInt(episodes.length);
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.episodes(
            id: 'episodes', //todo change to real id later
            title: title,
            imageUrl: imageUrl,
          ),
          startIndex: randomIndex,
        );
  }

  List<Widget> _buildEpisodesSliver(List<Track> episodes) {
    // Build children list: separators and items
    final children = <Widget>[];

    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

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

      final trackIndex = i; // Capture index by value
      final isCurrentTrack = episode.id == playingTrackId;
      final bool? trackPlayingState = isCurrentTrack
          ? playerState.isPlaying && playerState.isRadioMode == false
          : null;
      children.add(
        TrackTile(
          type: 'episode',
          track: episode,
          isPlaying: trackPlayingState,
          onTap: () => _onTrackTap(ref, episodes, trackIndex),
          onMenuTap: () => debugPrint('Episode icon tapped for: ${episode.id}'),
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
