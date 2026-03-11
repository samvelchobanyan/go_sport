import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/features/favorites/presentation/favorites_list/favorites_controller.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/features/shared_widgets/track_tile.dart';

class FavoritesListScreen extends ConsumerStatefulWidget {
  const FavoritesListScreen({super.key});

  @override
  ConsumerState<FavoritesListScreen> createState() =>
      _FavoritesListScreenState();
}

class _FavoritesListScreenState extends ConsumerState<FavoritesListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(favoritesStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(favoritesStateProvider.notifier).loadMore();
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
    final state = ref.watch(favoritesStateProvider);
    final favorites = state.favoritesList;

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
                  subtitle: 'tracks',
                  itemCount: favorites.length,
                  actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
                  onActionIconTap: favorites.isEmpty
                      ? null
                      : () => _onPlayTap(ref, favorites, 'My Favorites', ''),
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: _buildBody(context, ref, state),
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

  Widget _buildBody(BuildContext context, WidgetRef ref, FavoritesState state) {
    if (state.isLoading && state.favoritesList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.favoritesList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error loading favorites', style: context.subtitleLSemi),
            const SizedBox(height: 8),
            Text(
              state.error!,
              style: context.textL?.copyWith(color: DSColors.gray60),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(favoritesStateProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final favorites = state.favoritesList;

    if (favorites.isEmpty) {
      return Center(
        child: Text('No favorites yet', style: context.subtitleLBold),
      );
    }

    return _buildSongsList(ref, favorites, state.isLoadingMore);
  }

  void _onPlayTap(
    WidgetRef ref,
    List<Track> favorites,
    String title,
    String imageUrl,
  ) {
    if (favorites.isEmpty) return;
    final randomIndex = Random().nextInt(favorites.length);
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          favorites,
          source: QueueSource.favorites(
            id: 'favorites', //todo change to real id later
            title: title,
            imageUrl: imageUrl,
          ),
          startIndex: randomIndex,
        );
  }

  void _onTrackTap(WidgetRef ref, List<Track> favorites, int index) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          favorites,
          source: QueueSource.favorites(
            id: index.toString(),
            title: 'My Favorites',
            imageUrl: '',
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(int index) {
    // TODO: Show track menu
    debugPrint('Track menu tapped at index: $index');
  }

  Widget _buildSongsList(WidgetRef ref, List<Track> songs, bool isLoadingMore) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    return ListView.separated(
      controller: _scrollController,
      padding: EdgeInsets.only(bottom: isLoadingMore ? 16 : 100),
      itemCount: songs.length + (isLoadingMore ? 1 : 0),
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
        if (index == songs.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final track = songs[index];
        final isCurrentTrack = track.id == playingTrackId;
        final bool? trackPlayingState = isCurrentTrack
            ? playerState.isPlaying && playerState.isRadioMode == false
            : null;

        return TrackTile(
          track: track,
          isPlaying: trackPlayingState,
          onTap: () => _onTrackTap(ref, songs, index),
          onMenuTap: () => _onTrackMenuTap(index),
        );
      },
    );
  }
}
