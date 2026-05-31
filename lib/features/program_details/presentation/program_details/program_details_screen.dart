import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/like_registry.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/program_details/presentation/widgets/program_episode_tile.dart';
import 'package:go_sport/features/program_details/presentation/widgets/program_screen_skeleton.dart';
import 'package:go_sport/features/program_details/presentation/widgets/youtube_banner.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'program_details_controller.dart';
import '../widgets/program_hero.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

class ProgramDetailsScreen extends ConsumerStatefulWidget {
  final Program program;

  const ProgramDetailsScreen({super.key, required this.program});

  @override
  ConsumerState<ProgramDetailsScreen> createState() =>
      _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends ConsumerState<ProgramDetailsScreen> {
  void _onTrackTap(List<Track> episodes, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.program(
            id: widget.program.id,
            title: widget.program.title,
            imageUrl: widget.program.imageUrl,
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(int index) {
    debugPrint('Track menu tapped at index: $index');
  }

  void _onPlayTap(List<Track> episodes) {
    if (episodes.isEmpty) return;

    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.program(
            id: widget.program.id,
            title: widget.program.title,
            imageUrl: widget.program.imageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final episodesState = ref.watch(
      programDetailsControllerProvider(widget.program.id),
    );
    final isLiked = ref.watch(
      likeRegistryProvider.select((s) => s.likedPrograms.any((p) => p.id == widget.program.id)),
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: expandedHeight,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: DSColors.black.withValues(alpha: 0.9),
              leading: IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: DSColors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: DSColors.white,
                    size: 20,
                  ),
                ),
                onPressed: () => context.pop(),
              ),

              // todo check why page doesnt work
              actions: [
                IconButton(
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: DSColors.black.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share,
                      color: DSColors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () {},
                ),
                const SearchButton(decoration: true),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: ProgramHero(
                  program: widget.program,
                  isLiked: isLiked,
                  onLikeTap: () => ref
                      .read(likeRegistryProvider.notifier)
                      .toggleProgramLike(widget.program),
                  onPlayTap: () {
                    final episodes = episodesState.mapOrNull(
                      data: (data) => data.episodes,
                    );
                    if (episodes != null) _onPlayTap(episodes);
                  },
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(24),
                child: Container(
                  height: 24,
                  decoration: const BoxDecoration(
                    color: DSColors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 18),
            // orange youtube banner
            const YoutubeBanner(),

            episodesState.when(
              loading: () => const ProgramScreenSkeleton(),
              error: (message) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: $message'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(
                              programDetailsControllerProvider(
                                widget.program.id,
                              ).notifier,
                            )
                            .loadEpisodes(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
              data: (episodes) {
                if (episodes.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No episodes available')),
                  );
                }

                final playerState = ref.watch(playerStateProvider);
                final playingTrackId = playerState.currentTrack?.id;

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final episode = episodes[index];
                      final isCurrentTrack = episode.id == playingTrackId;
                      final bool? trackPlayingState = isCurrentTrack
                          ? playerState.isPlaying && !playerState.isRadioMode
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProgramEpisodeTile(
                            episode: episode,
                            index: index + 1,
                            isPlaying: trackPlayingState,
                            onTap: () => _onTrackTap(episodes, index),
                            onMenuTap: () => _onTrackMenuTap(index),
                          ),
                          if (index < episodes.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    }, childCount: episodes.length),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
