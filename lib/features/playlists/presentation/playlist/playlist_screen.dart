import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

import 'custom_playlist_controller.dart';
import 'playlist_controller.dart';
import '../bottom_sheets/add_to_playlist_bottom_sheet.dart';
import '../bottom_sheets/add_tracks_bottom_sheet.dart';
import '../bottom_sheets/playlist_options.dart';
import '../../../shared_widgets/bottom_pop_ups/delete_confirm.dart';
import '../bottom_sheets/rename_playlist.dart';
import '../widgets/playlist_hero.dart';
import '../widgets/playlist_screen_skeleton.dart';
import '../../../shared_widgets/bottom_pop_ups/track_options.dart';
import '../../../shared_widgets/track_tile.dart';
import '../edit_playlist/edit_playlist_screen.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  final String playlistId;
  final PlaylistType type;
  final Playlist? playlist;

  const PlaylistScreen({
    super.key,
    required this.playlistId,
    this.type = PlaylistType.featured,
    this.playlist,
  });

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.type == PlaylistType.featured) {
        ref
            .read(playlistControllerProvider(widget.playlistId).notifier)
            .init(widget.playlist);
      } else {
        ref
            .read(customPlaylistControllerProvider(widget.playlistId).notifier)
            .init(widget.playlist);
      }
    });
  }

  void _onTrackTap(
    WidgetRef ref,
    List<Track> tracks,
    int index,
    String playlistTitle,
    String playlistImageUrl,
  ) {
    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.playlist(
            id: widget.playlistId,
            title: playlistTitle,
            imageUrl: playlistImageUrl,
          ),
          startIndex: index,
        );
  }

  void _onTrackMenuTap(Track track) {
    showTrackOptionsBottomSheet(
      context: context,
      imageUrl: track.imageUrl ?? '',
      title: track.title,
      subtitle: track.artistName,
      onAddToPlaylist: () => showAddToPlaylistBottomSheet(
        context: context,
        track: track,
      ),
      onRemoveFromPlaylist: widget.type == PlaylistType.custom
          ? () => showDeleteConfirmBottomSheet(
                context: context,
                text: 'Are you sure you want to delete this track from the playlist?',
                onConfirm: () {
                  ref
                      .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                      .removeTrack(track.id);
                  ref
                      .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                      .save();
                },
              )
          : null,
    );
  }

  void _onPlayTap(
    WidgetRef ref,
    List<Track> tracks,
    String playlistTitle,
    String playlistImageUrl,
  ) {
    // skip if empty
    if (tracks.isEmpty) return;

    ref
        .read(playerStateProvider.notifier)
        .playQueue(
          tracks,
          source: QueueSource.playlist(
            id: widget.playlistId,
            title: playlistTitle,
            imageUrl: playlistImageUrl,
          ),
        );
  }

  void _onLikeTap(WidgetRef ref, String? likeId) {
    ref
        .read(playlistControllerProvider(widget.playlistId).notifier)
        .toggleLike(likeId);
  }

  @override
  Widget build(BuildContext context) {
    final tracksState = widget.type == PlaylistType.featured
        ? ref.watch(playlistControllerProvider(widget.playlistId))
        : ref.watch(customPlaylistControllerProvider(widget.playlistId));

    final currentPlaylist = tracksState.mapOrNull(
          data: (data) => data.playlist,
        ) ??
        widget.playlist;

    if (currentPlaylist == null) {
      if (tracksState is PlaylistDetailsLoading) {
        return const Scaffold(
          backgroundColor: DSColors.white,
          body: PlaylistScreenSkeleton(),
        );
      }
      return Scaffold(
        backgroundColor: DSColors.white,
        appBar: AppBar(
          backgroundColor: DSColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(child: Text('Playlist not found')),
      );
    }

    final pl = currentPlaylist;
    final screenHeight = MediaQuery.of(context).size.height;
    final expandedHeight = screenHeight * 0.5;

    return Scaffold(
      backgroundColor: DSColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: expandedHeight,
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: DSColors.gray90,
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DSColors.gray30,
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
              if (widget.type == PlaylistType.custom)
                IconButton(
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: DSColors.gray30,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.settings,
                      color: DSColors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () {
                    final pl = currentPlaylist;
                    final currentTracks = tracksState.mapOrNull(data: (d) => d.tracks) ?? [];
                    showPlaylistBottomSheet(
                      context: context,
                      onAddTracks: () => showAddTracksBottomSheet(
                        context: context,
                        onSave: (tracks) => ref
                            .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                            .addTracks(tracks),
                      ),
                      onRename: () => showRenamePlaylistBottomSheet(
                        context: context,
                        initialName: pl.title,
                        onSave: (newName) => ref
                            .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                            .rename(newName),
                      ),
                      onEdit: () {
                        context.pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditPlaylistScreen(
                              playlist: pl,
                              tracks: currentTracks,
                            ),
                          ),
                        );
                      },
                      onDelete: () => showDeleteConfirmBottomSheet(
                        context: context,
                        text: 'Are you sure you want to delete this playlist?',
                        onConfirm: () async {
                          await ref
                              .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                              .delete();
                          if (context.mounted) context.pop();
                        },
                      ),
                    );
                  },
                )
              else
                IconButton(
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: DSColors.gray30,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.share,
                      color: DSColors.white,
                      size: 20,
                    ),
                  ),
                  onPressed: () {
                    // TODO: Share playlist
                  },
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: PlaylistHero(
                playlist: pl,
                showPlayButton: tracksState.mapOrNull(
                      data: (data) => data.tracks.isNotEmpty,
                    ) ??
                    false,
                onActionTap: widget.type == PlaylistType.custom
                    ? () => showAddTracksBottomSheet(
                          context: context,
                          onSave: (tracks) => ref
                              .read(customPlaylistControllerProvider(widget.playlistId)
                                  .notifier)
                              .addTracks(tracks),
                        )
                    : () => _onLikeTap(ref, pl.likeId),
                onPlayTap: () {
                  final tracksValue = tracksState.mapOrNull(
                    data: (data) => data.tracks,
                  );
                  if (tracksValue != null) {
                    _onPlayTap(
                      ref,
                      tracksValue,
                      pl.title,
                      pl.imageUrl,
                    );
                  }
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(24),
              child: Container(
                height: 24,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
              ),
            ),
          ),
          tracksState.when(
            loading: () => const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 24),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
            error: (message) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: $message',
                      style: const TextStyle(color: DSColors.black),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.type == PlaylistType.featured) {
                          ref
                              .read(playlistControllerProvider(widget.playlistId).notifier)
                              .loadFull();
                        } else {
                          ref
                              .read(customPlaylistControllerProvider(widget.playlistId).notifier)
                              .loadFull();
                        }
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (playlistData, tracks) {
              if (tracks.isEmpty && widget.type == PlaylistType.custom) {
                return SliverFillRemaining(
                  hasScrollBody: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assets/images/empty_playlist.png',
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 40,
                          left: 0,
                          right: 0,
                          child: Text(
                            'Start adding songs\nthey\'ll appear here.',
                            textAlign: TextAlign.center,
                            style: context.subtitleMBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              final playerState = ref.watch(playerStateProvider);
              final playingTrackId = playerState.currentTrack?.id;

              return SliverPadding(
                padding: const EdgeInsets.only(bottom: 100, top: 0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final track = tracks[index];
                    final isCurrentTrack = track.id == playingTrackId;
                    final bool? trackPlayingState = isCurrentTrack
                        ? playerState.isPlaying &&
                              playerState.isRadioMode == false
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
                            pl.title,
                            pl.imageUrl,
                          ),
                          onMenuTap: _onTrackMenuTap,
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
    );
  }
}
