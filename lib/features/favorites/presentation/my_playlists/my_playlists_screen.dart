import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/state/my_playlists_state.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/create_playlist.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/features/shared_widgets/playlist_tile.dart';

class MyPlaylistsScreen extends ConsumerWidget {
  const MyPlaylistsScreen({super.key});

  void _onCreatePlaylist(BuildContext context, WidgetRef ref) {
    showCreatePlaylistBottomSheet(
      context: context,
      onSave: (name) async {
        final repo = ref.read(customPlaylistRepositoryProvider);
        final playlist = await repo.createCustomPlaylist(name);
        ref.read(myPlaylistsStateProvider.notifier).addPlaylist(playlist);
        if (context.mounted) {
          context.push('/music/playlist/${playlist.id}?type=custom', extra: playlist);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(myPlaylistsStateProvider);
    final playlists = state.playlists;

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
                  iconPath: 'assets/icons/playlists_bg.svg',
                  title: 'My Playlists',
                  subtitle: 'Playlists',
                  itemCount: playlists.length,
                  actionIcon: SvgPicture.asset(
                    'assets/icons/plus.svg',
                    width: 20,
                    height: 20,
                  ),
                  onActionIconTap: () => _onCreatePlaylist(context, ref),
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
                          ? const Center(child: CircularProgressIndicator())
                          : state.error != null && playlists.isEmpty
                          ? _buildErrorWidget(context, ref, state)
                          : _buildPlaylistsList(context, playlists),
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

  Widget _buildPlaylistsList(BuildContext context, List<Playlist> playlists) {
    if (playlists.isEmpty) {
      return Center(
        child: Text('No favorite playlists yet', style: context.subtitleLBold),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: playlists.length,
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DottedDivider(),
      ),
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        return PlaylistTile(
          playlist: playlist,
        );
      },
    );
  }

  Widget _buildErrorWidget(
    BuildContext context,
    WidgetRef ref,
    MyPlaylistsState state,
  ) {
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
                ref.read(myPlaylistsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
