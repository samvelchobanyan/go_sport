import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/radio_page/presentation/radio/radio_dashboard_controller.dart';
import 'package:go_sport/features/radio_page/presentation/widgets/program_card.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/episode_tile.dart';
import 'package:go_sport/features/shared_widgets/live_banner.dart';
import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/wave_section_header.dart';

class RadioPageScreen extends ConsumerWidget {
  const RadioPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioDashboardState = ref.watch(radioStateProvider);

    final featuredPrograms = radioDashboardState.featuredPrograms;
    final featuredEpisodes = radioDashboardState.featuredEpisodes;

    final isLoading = radioDashboardState.isLoading;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    pinned: true,
                    floating: true,

                    leading: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                      ),
                      child: UserAvatarButton(
                        imageUrl: null,
                        onTap: () {
                          // TODO: navigate to profile
                        },
                      ),
                    ),
                    title: Text('Radio', style: context.h2),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: GestureDetector(
                          onTap: () => {},
                          child: SvgPicture.asset('assets/icons/calendar.svg'),
                        ),
                      ),
                    ],
                  ),

                  // orange banner
                  LiveBanner(),

                  // featured programs
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 26),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WaveSectionHeader(
                            title: 'Featured programs',
                            showAnimation: true,
                          ),
                          SizedBox(height: 10),
                          if (featuredPrograms.isNotEmpty)
                            SizedBox(
                              height: 210,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                itemCount: featuredPrograms.length,
                                itemBuilder: (programContext, index) {
                                  final program = featuredPrograms[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: ProgramCard(
                                      id: program.id,
                                      title: program.title,
                                      imageUrl: program.imageUrl ,
                                    ),
                                  );
                                },
                              ),
                            )
                          else
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Text(
                                'No featured playlists available.',
                                style: TextStyle(color: DSColors.gray60),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: WaveSectionHeader(
                      title: 'Featured episodes',
                      showAnimation: true,
                    ),
                  ),
                  _buildEpisodesList(ref, featuredEpisodes, context),
                ],
              ),
      ),
    );
  }

  Widget _buildEpisodesList(WidgetRef ref, List<Track> episodes, context) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    if (episodes.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'No featured episodes yet',
              style: context.subtitleLBold,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final episode = episodes[index];
        final isCurrentTrack = episode.id == playingTrackId;

        final bool? trackPlayingState = isCurrentTrack
            ? playerState.isPlaying && playerState.isRadioMode == false
            : null;

        return Column(
          children: [
            EpisodeTile(
              episode: episode,
              isPlaying: trackPlayingState,
              onTap: () => _onTrackTap(ref, episodes, index),
              onMenuTap: () =>
                  debugPrint('Episode icon tapped for: ${episode.id}'),
            ),

            if (index < episodes.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DottedDivider(),
              ),
          ],
        );
      }, childCount: episodes.length),
    );
  }

  void _onTrackTap(WidgetRef ref, List<Track> episodes, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          episodes,
          source: QueueSource.episodes(
            id: index.toString(),
            title: 'New Episodes',
            imageUrl: '',
          ),
          startIndex: index,
        );
  }
}
