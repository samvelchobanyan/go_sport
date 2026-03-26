import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/radio_page/presentation/radio/radio_dashboard_controller.dart';
import 'package:go_sport/features/shared_widgets/count_badge.dart';
import 'package:go_sport/features/shared_widgets/media_card_shell.dart';
import '../../../shared_widgets/user_avatar_button.dart';
import '../../../shared_widgets/wave_section_header.dart';

class RadioPageScreen extends ConsumerStatefulWidget {
  const RadioPageScreen({super.key});

  @override
  ConsumerState<RadioPageScreen> createState() => _RadioPageScreenState();
}

class _RadioPageScreenState extends ConsumerState<RadioPageScreen> {
  double appBarOpacity = 0;

  @override
  Widget build(BuildContext context) {
    // final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    // final playlists = playlistsState.playlistsList;

    // final musicDashboardState = ref.watch(musicStateProvider);
    // final featuredArtists = musicDashboardState.featuredArtists;
    // final featuredAlbums = musicDashboardState.featuredAlbums;
    // final artistsCount = musicDashboardState.artistsCount;
    // final albumsCount = musicDashboardState.albumsCount;
    // final playlistsCount = musicDashboardState.playlistsCount;
    // final episodesCount = musicDashboardState.episodesCount;
    // final programsCount = musicDashboardState.programsCount;
    // final favoritesCount = musicDashboardState.favoritesCount;
    final radioDashboardState = ref.watch(radioStateProvider);

    final featuredPrograms = radioDashboardState.featuredPrograms;

    // Quick action cards data

    // final isLoading = playlistsState.isLoading && playlists.isEmpty;

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: DSColors.white,
      body:
          // isLoading
          //     ? const Center(child: CircularProgressIndicator())
          //     :
          CustomScrollView(
            // controller: _scrollController,
            slivers: [
              /// 🔹 AppBar
              SliverAppBar(
                backgroundColor: Colors.white.withOpacity(appBarOpacity),
                elevation: 0,
                pinned: true,
                floating: true,

                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                  GestureDetector(
                    onTap: () => {},
                    child: SvgPicture.asset('assets/icons/calendar.svg'),
                  ),
                ],
              ),

              // add orange thing
              SliverToBoxAdapter(
                child: Container(
                  color: DSColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: WaveSectionHeader(
                          title: 'Featured playlists',
                          showAnimation: true,
                        ),
                      ),
                      if (featuredPrograms.isNotEmpty)
                        SizedBox(
                          height: 210,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: featuredPrograms.length,
                            itemBuilder: (programContext, index) {
                              final program = featuredPrograms[index];
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: _programCard(
                                  context,
                                  program.id,
                                  program.title,
                                  program.imageUrl ?? '',
                                  program.episodeCount,
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
            ],
          ),
    );
  }
}

Widget _programCard(
  BuildContext context,
  String id,
  String title,
  String imageUrl,
  int episodeCount,
) {
  return GestureDetector(
    // onTap: () => context.push('/music/playlist/$id'),
    child: SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MediaCardShell(
            child: Hero(
              tag: 'playlist-image-$id',
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: DSColors.gray20),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: context.subtitleM,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          CountBadge(count: 8, type: CountBadgeType.programs),
        ],
      ),
    ),
  );
}
