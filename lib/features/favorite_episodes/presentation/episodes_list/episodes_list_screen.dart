import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/favorite_episodes/presentation/episodes_list/episodes_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/episode_tile.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class FavoriteEpisodesListScreen extends ConsumerStatefulWidget {
  const FavoriteEpisodesListScreen({super.key});

  @override
  ConsumerState<FavoriteEpisodesListScreen> createState() =>
      _FavoriteEpisodesListScreenState();
}

class _FavoriteEpisodesListScreenState
    extends ConsumerState<FavoriteEpisodesListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(episodesStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(episodesStateProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(episodesStateProvider);
    final List<Track> episodes = state.episodes;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
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
            Column(
              children: [
                MyCategoriesHeader(
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'My Episodes',
                  subtitle: 'Episodes',
                  itemCount: episodes.length,
                  actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
                  onActionIconTap: () =>
                      _onPlayTap(ref, episodes, 'New Episodes', ''),
                ),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: state.isLoading && state.episodes.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            ) //todo add skeleton loading later
                          : state.error != null && state.episodes.isEmpty
                          ? _buildErrorWidget(state)
                          : _buildEpisodesList(
                              ref,
                              episodes,
                              state.isLoadingMore,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(EpisodesState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Failed to load episodes', style: context.subtitleLBold),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => ref.read(episodesStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEpisodesList(
    WidgetRef ref,
    List<Track> episodes,
    bool isLoadingMore,
  ) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    if (episodes.isEmpty) {
      return Center(
        child: Text('No favorites yet', style: context.subtitleLBold),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      itemCount: episodes.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (context, index) {
        if (index >= episodes.length - 1) {
          return const SizedBox.shrink();
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DottedDivider(),
        );
      },
      itemBuilder: (context, index) {
        if (index >= episodes.length) {
          // bottom loading indicator
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final episode = episodes[index];
        final isCurrentTrack = episode.id == playingTrackId;
        final bool? trackPlayingState = isCurrentTrack
            ? playerState.isPlaying && playerState.isRadioMode == false
            : null;

        return ClipRRect(
          borderRadius: index == 0
              ? const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                )
              : BorderRadius.zero,
          child: Container(
            color: DSColors.white,
            child: EpisodeTile(
              episode: episode,
              isPlaying: trackPlayingState,
              onTap: () => _onTrackTap(ref, episodes, index),
              onMenuTap: () =>
                  debugPrint('Episode icon tapped for: ${episode.id}'),
            ),
          ),
        );
      },
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
}
