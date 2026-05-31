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
import 'package:go_sport/features/favorites/presentation/new_episodes/new_episodes_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/episode_tile.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class NewEpisodesScreen extends ConsumerWidget {
  const NewEpisodesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final episodes = ref.watch(newEpisodesStateProvider).episodes;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
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
            Column(
              children: [
                MyCategoriesHeader(
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'New Episodes',
                  subtitle: 'Episodes',
                  itemCount: episodes.length,
                  actionIcon: SvgPicture.asset(
                    'assets/icons/play.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      DSColors.lime,
                      BlendMode.srcIn,
                    ),
                  ),
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
                      child: _buildEpisodesList(context, ref, episodes),
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

  Widget _buildEpisodesList(
    BuildContext context,
    WidgetRef ref,
    List<Track> episodes,
  ) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    if (episodes.isEmpty) {
      return Center(
        child: Text('No episodes yet', style: context.subtitleLBold),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(newEpisodesStateProvider.notifier).refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: episodes.length,
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
      ),
    );
  }

  void _onTrackTap(WidgetRef ref, List<Track> episodes, int index) {
    ref.read(playerStateProvider.notifier).playQueue(
          episodes,
          source: QueueSource.episodes(
            id: index.toString(),
            title: 'New Episodes',
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
    ref.read(playerStateProvider.notifier).playQueue(
          episodes,
          source: QueueSource.episodes(
            id: 'episodes',
            title: title,
            imageUrl: imageUrl,
          ),
          startIndex: randomIndex,
        );
  }
}
