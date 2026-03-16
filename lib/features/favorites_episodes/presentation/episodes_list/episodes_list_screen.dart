import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/favorites_episodes/presentation/episodes_list/episodes_controller.dart';
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

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
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
                  Column(
                    children: [
                      MyCategoriesHeader(
                        iconPath: 'assets/icons/dynamic_bg.svg',
                        title: 'My Episodes',
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
                        Center(
                          child: Text(
                            'No favorites yet',
                            style: context.subtitleLBold,
                          ),
                        )
                      else
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(DSRadius.m),
                              topRight: Radius.circular(DSRadius.m),
                            ),
                            child: Container(
                              color: DSColors.white,
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount:
                                    episodes.length +
                                    (state.isLoadingMore ? 1 : 0),
                                separatorBuilder: (context, index) =>
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: DottedDivider(),
                                    ),
                                itemBuilder: (context, index) {
                                  if (index >= episodes.length) {
                                    // bottom loading indicator
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  final episode = episodes[index];
                                  final playerState = ref.watch(
                                    playerStateProvider,
                                  );
                                  final playingTrackId =
                                      playerState.currentTrack?.id;
                                  final isCurrentTrack =
                                      episode.id == playingTrackId;
                                  final bool? trackPlayingState = isCurrentTrack
                                      ? playerState.isPlaying &&
                                            playerState.isRadioMode == false
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
                                      child: TrackTile(
                                        type: 'episode',
                                        track: episode,
                                        isPlaying: trackPlayingState,
                                        onTap: () =>
                                            _onTrackTap(ref, episodes, index),
                                        onMenuTap: () => debugPrint(
                                          'Episode icon tapped for: ${episode.id}',
                                        ),
                                      ),
                                    ),
                                  );
                                },
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
