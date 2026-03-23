import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/features/favorite_playlists/presentation/playlists_controller.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/features/shared_widgets/playlist_tile.dart';

class FavoritePlaylistsListScreen extends ConsumerStatefulWidget {
  const FavoritePlaylistsListScreen({super.key});

  @override
  ConsumerState<FavoritePlaylistsListScreen> createState() =>
      _FavoritePlaylistsListScreenState();
}

class _FavoritePlaylistsListScreenState
    extends ConsumerState<FavoritePlaylistsListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(playlistsStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(playlistsStateProvider.notifier).loadMore();
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
    final state = ref.watch(playlistsStateProvider);
    final playlists = state.playlists;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            // 🔹 Background image
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
                  iconPath: 'assets/icons/playlists_bg.svg',
                  title: 'My Playlists',
                  subtitle: 'Playlists',
                  itemCount: playlists.length,
                ),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: state.isLoading && playlists.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            ) //todo add skeleton loading later
                          : state.error != null && playlists.isEmpty
                          ? _buildErrorWidget(state)
                          : _buildPlaylistsList(
                              ref,
                              playlists,
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

  Widget _buildPlaylistsList(
    WidgetRef ref,
    List<Playlist> playlists,
    bool isLoadingMore,
  ) {
    if (playlists.isEmpty) {
      return Center(
        child: Text('No favorite playlists yet', style: context.subtitleLBold),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: playlists.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (context, index) {
        if (index >= playlists.length - 1) {
          return const SizedBox.shrink();
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DottedDivider(),
        );
      },
      itemBuilder: (context, index) {
        if (index >= playlists.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final playlist = playlists[index];
        return PlaylistTile(
          id: playlist.id,
          imageUrl: playlist.imageUrl,
          title: playlist.title,
          trackCount: playlist.trackCount,
        );
      },
    );
  }

  Widget _buildErrorWidget(PlaylistsState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Failed to load favorite playlists',
            style: context.subtitleLBold,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () =>
                ref.read(playlistsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
