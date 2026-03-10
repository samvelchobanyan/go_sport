import 'dart:math';

import 'package:flutter/material.dart';
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

class FavoritesListScreen extends ConsumerWidget {
  const FavoritesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    final state = ref.watch(favoritesStateProvider);

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        ref.read(favoritesStateProvider.notifier).loadMore();
      }
    });

    return Scaffold(
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
          _buildBody(context, ref, state, scrollController),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    FavoritesState state,
    ScrollController scrollController,
  ) {
    // Initial loading
    if (state.isLoading && state.favoritesList.isEmpty) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/heart_bg.svg',
            title: 'My Favorites',
            subtitle: 'tracks',
            itemCount: 0,
            actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
            onActionIconTap: null,
          ),
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      );
    }

    // Error with no data
    if (state.error != null && state.favoritesList.isEmpty) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/heart_bg.svg',
            title: 'My Favorites',
            subtitle: 'tracks',
            itemCount: 0,
            actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
            onActionIconTap: null,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
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
            ),
          ),
        ],
      );
    }

    final favorites = state.favoritesList;

    if (favorites.isEmpty) {
      return CustomScrollView(
        controller: scrollController,
        slivers: [
          MyCategoriesTop(
            iconPath: 'assets/icons/heart_bg.svg',
            title: 'My Favorites',
            subtitle: 'tracks',
            itemCount: 0,
            actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
            onActionIconTap: null,
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text('No favorites yet', style: context.subtitleLBold),
            ),
          ),
        ],
      );
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        MyCategoriesTop(
          iconPath: 'assets/icons/heart_bg.svg',
          title: 'My Favorites',
          subtitle: 'tracks',
          actionIcon: SvgPicture.asset('assets/icons/play_blue.svg'),
          itemCount: favorites.length,
          onActionIconTap: () => _onPlayTap(ref, favorites, 'My Favorites', ''),
        ),

        // 🔹 Songs list
        ..._buildSongsSliver(ref, favorites),

        // 🔹 Loading indicator at the bottom
        if (state.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
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

  List<Widget> _buildSongsSliver(WidgetRef ref, List<Track> songs) {
    final playerState = ref.watch(playerStateProvider);
    final playingTrackId = playerState.currentTrack?.id;

    // Build children list: separators and items
    final children = <Widget>[];

    for (int i = 0; i < songs.length; i++) {
      if (i > 0) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: DottedDivider(),
          ),
        );
      }
      final track = songs[i];
      final trackIndex = i; // Capture index by value
      final isCurrentTrack = track.id == playingTrackId;
      final bool? trackPlayingState = isCurrentTrack
          ? playerState.isPlaying && playerState.isRadioMode == false
          : null;

      children.add(
        TrackTile(
          track: track,
          isPlaying: trackPlayingState,
          onTap: () => _onTrackTap(ref, songs, trackIndex),
          onMenuTap: () => _onTrackMenuTap(trackIndex),
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
