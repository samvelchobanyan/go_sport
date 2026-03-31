import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';

import 'program_details_controller.dart';
import '../widgets/program_hero.dart';
import '../../../shared_widgets/track_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

class ProgramDetailsScreen extends ConsumerWidget {
  final String programId;

  const ProgramDetailsScreen({super.key, required this.programId});

  void _onTrackTap(
    WidgetRef ref,
    List<Track> tracks,
    int index,
    String programTitle,
    String programImageUrl,
  ) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.program(
            id: programId,
            title: programTitle,
            imageUrl: programImageUrl,
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(int index) {
    debugPrint('Track menu tapped at index: $index');
  }

  void _onPlayTap(
    WidgetRef ref,
    List<Track> tracks,
    String programTitle,
    String programImageUrl,
  ) {
    if (tracks.isEmpty) return;

    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.program(
            id: programId,
            title: programTitle,
            imageUrl: programImageUrl,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(programDetailsControllerProvider(programId));
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: CustomScrollView(
          slivers: [
            // SliverAppBar with flexibleSpace
            SliverAppBar(
              expandedHeight: expandedHeight,
              pinned: true,
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: DSColors.black.withOpacity(0.9),
              leading: IconButton(
                icon: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: DSColors.black.withOpacity(0.3),
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
              actions: [
                IconButton(
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: DSColors.black.withOpacity(0.3),
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
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: state.map(
                  loading: (_) =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e) => Center(child: Text('Error: ${e.message}')),
                  data: (d) => ProgramHero(
                    program: d.program,
                    onNotificationTap: () {},
                    onPlayTap: () {
                      if (d.program.episodes.isNotEmpty) {
                        _onPlayTap(
                          ref,
                          d.program.episodes,
                          d.program.title,
                          d.program.imageUrl,
                        );
                      }
                    },
                  ),
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

            // Tracks list or loader/error
            state.map(
              loading: (_) => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e) => SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'Error: ${e.message}',
                    style: const TextStyle(color: DSColors.black),
                  ),
                ),
              ),
              data: (d) {
                final tracks = d.program.episodes;
                final playerState = ref.watch(playerStateProvider);
                final playingTrackId = playerState.currentTrack?.id;

                if (tracks.isEmpty) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No tracks available')),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 100, top: 0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final track = tracks[index];
                      final isCurrentTrack = track.id == playingTrackId;
                      final bool? trackPlayingState = isCurrentTrack
                          ? playerState.isPlaying && !playerState.isRadioMode
                          : null;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TrackTile(
                            track: track,
                            isPlaying: trackPlayingState,
                            onTap: () => _onTrackTap(
                              ref,
                              tracks,
                              index,
                              d.program.title,
                              d.program.imageUrl,
                            ),
                            onMenuTap: () => _onTrackMenuTap(index),
                          ),
                          if (index < tracks.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    }, childCount: tracks.length),
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
