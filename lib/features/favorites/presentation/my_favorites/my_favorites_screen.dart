import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/favorites/presentation/my_favorites/my_favorites_controller.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_to_playlist_bottom_sheet.dart';
import 'package:go_sport/features/shared_widgets/track_tile.dart';

class MyFavoritesScreen extends ConsumerWidget {
  const MyFavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(myFavoritesStateProvider).favorites;

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
                  iconPath: 'assets/icons/heart_bg.svg',
                  title: 'My Favorites',
                  subtitle: 'Tracks',
                  itemCount: favorites.length,
                  actionIcon: SvgPicture.asset(
                    'assets/icons/play.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      DSColors.lime,
                      BlendMode.srcIn,
                    ),
                  ),
                  onActionIconTap: favorites.isEmpty
                      ? null
                      : () => _onPlayTap(ref, favorites, 'My Favorites', ''),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: _buildSongsList(context, ref, favorites),
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

  Widget _buildSongsList(
    BuildContext context,
    WidgetRef ref,
    List<Track> songs,
  ) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    if (songs.isEmpty) {
      return Center(
        child: Text('No favorites yet', style: context.subtitleLBold),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(myFavoritesStateProvider.notifier).refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: songs.length,
        separatorBuilder: (context, index) {
          if (index >= songs.length - 1) {
            return const SizedBox.shrink();
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          );
        },
        itemBuilder: (context, index) {
          final track = songs[index];
          final isCurrentTrack = track.id == playingTrackId;
          final bool? trackPlayingState = isCurrentTrack
              ? playerState.isPlaying && playerState.isRadioMode == false
              : null;

          return TrackTile(
            track: track,
            isPlaying: trackPlayingState,
            onTap: () => _onTrackTap(ref, songs, index),
            onMenuTap: (track) => showTrackOptionsBottomSheet(
              context: context,
              track: track,
              onAddToPlaylist: () => showAddToPlaylistBottomSheet(
                context: context,
                track: track,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPlayTap(
    WidgetRef ref,
    List<Track> favorites,
    String title,
    String imageUrl,
  ) {
    if (favorites.isEmpty) return;
    final randomIndex = Random().nextInt(favorites.length);
    ref.read(playerStateProvider.notifier).playQueue(
          favorites,
          source: QueueSource.favorites(
            id: 'favorites',
            title: title,
            imageUrl: imageUrl,
          ),
          startIndex: randomIndex,
        );
  }

  void _onTrackTap(WidgetRef ref, List<Track> favorites, int index) {
    ref.read(playerStateProvider.notifier).playQueue(
          favorites,
          source: QueueSource.favorites(
            id: index.toString(),
            title: 'My Favorites',
            imageUrl: '',
          ),
          startIndex: index,
        );
  }
}
