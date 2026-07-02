import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/domain/entities/program.dart';
import 'package:go_sport/domain/entities/track.dart';
import 'package:go_sport/domain/state/featured_playlists_state.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/features/playlists/presentation/bottom_sheets/add_to_playlist_bottom_sheet.dart';
import 'package:go_sport/features/search/presentation/search/search_controller.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/artist_tile.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/track_options.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/playlist_tile.dart';
import 'package:go_sport/features/shared_widgets/program_tile.dart';
import 'package:go_sport/features/shared_widgets/track_tile.dart';

void showSearchBottomSheet(BuildContext context) {
  final view = View.of(context);
  final mq = MediaQueryData.fromView(view);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    barrierColor: DSColors.gray30,
    enableDrag: true,
    builder: (_) => MediaQuery(data: mq, child: const _SearchSheet()),
  );
}

class _SearchSheet extends ConsumerStatefulWidget {
  const _SearchSheet();

  @override
  ConsumerState<_SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends ConsumerState<_SearchSheet> {
  late final TextEditingController _textController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(searchControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.transparent,
        body: Stack(
          children: [
            Container(color: DSColors.white),
            SafeArea(
              child: Column(
                children: [
                  _Header(controller: _textController),
                  Expanded(
                    child: _Body(
                      state: state,
                      scrollController: _scrollController,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  final TextEditingController controller;

  const _Header({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        DSSpacing.s8,
        DSSpacing.s8,
        DSSpacing.m,
        DSSpacing.s8,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: DSIconSize.s24,
              color: DSColors.black,
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              autofocus: true,
              style: Theme.of(context).textTheme.bodyMedium,
              onChanged: (value) => ref
                  .read(searchControllerProvider.notifier)
                  .onQueryChanged(value),
              decoration: InputDecoration(
                hintText: 'Search tracks, albums, etc...',
                filled: true,
                fillColor: const Color.fromRGBO(64, 74, 195, 0.07),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                suffixIcon: _SuffixIcon(controller: controller),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SuffixIcon extends ConsumerWidget {
  final TextEditingController controller;

  const _SuffixIcon({required this.controller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasQuery = ref.watch(
      searchControllerProvider.select((s) => s.query.isNotEmpty),
    );

    if (hasQuery) {
      return IconButton(
        icon: const Icon(
          Icons.close,
          color: DSColors.black,
          size: DSIconSize.s20,
        ),
        onPressed: () {
          controller.clear();
          ref.read(searchControllerProvider.notifier).onQueryChanged('');
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(DSSpacing.s12),
      child: SvgPicture.asset(
        'assets/icons/search.svg',
        width: 20,
        height: 20,
        colorFilter: const ColorFilter.mode(DSColors.blue, BlendMode.srcIn),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final SearchState state;
  final ScrollController scrollController;

  const _Body({required this.state, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.query.isEmpty) {
      return const _FeaturedPlaylistsContent();
    }

    return Column(
      children: [
        const _CategoryChips(),
        Expanded(
          child: _Results(state: state, scrollController: scrollController),
        ),
      ],
    );
  }
}

class _FeaturedPlaylistsContent extends ConsumerWidget {
  const _FeaturedPlaylistsContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playlistsState = ref.watch(featuredPlaylistsStateProvider);
    final playlists = playlistsState.playlistsList;

    if (playlistsState.isLoading && playlists.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.separated(
      padding: const EdgeInsets.only(top: DSSpacing.s8, bottom: DSSpacing.l),
      itemCount: playlists.length + 1,
      separatorBuilder: (context, index) {
        if (index == 0 || index >= playlists.length) {
          return const SizedBox.shrink();
        }
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
          child: DottedDivider(),
        );
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(
              DSSpacing.m,
              DSSpacing.s8,
              DSSpacing.m,
              DSSpacing.m,
            ),
            child: Text('Featured Playlists', style: context.h2),
          );
        }
        final playlist = playlists[index - 1];
        return PlaylistTile(
          playlist: playlist,
          onTap: () {
            context.push(
              '/music/playlist/${playlist.id}?type=${playlist.type.name}',
              extra: playlist,
            );
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}

class _CategoryChips extends ConsumerWidget {
  const _CategoryChips();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(
      searchControllerProvider.select((s) => s.category),
    );

    const entries = <(SearchCategory, String)>[
      (SearchCategory.all, 'All'),
      (SearchCategory.tracks, 'Tracks'),
      (SearchCategory.albums, 'Albums'),
      (SearchCategory.artists, 'Artists'),
      (SearchCategory.programs, 'Programs'),
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.m,
          vertical: DSSpacing.s8,
        ),
        itemCount: entries.length,
        separatorBuilder: (_, __) => const SizedBox(width: DSSpacing.s8),
        itemBuilder: (context, index) {
          final (category, label) = entries[index];
          final isActive = category == selected;
          return _Chip(
            label: label,
            isActive: isActive,
            onTap: () => ref
                .read(searchControllerProvider.notifier)
                .setCategory(category),
          );
        },
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.m,
          vertical: DSSpacing.s6,
        ),
        decoration: BoxDecoration(
          color: isActive ? DSColors.blue10 : DSColors.white,
          border: isActive ? null : Border.all(color: DSColors.blue20),
          borderRadius: BorderRadius.circular(DSRadius.circular),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: context.subtitleM?.copyWith(color: DSColors.blue),
        ),
      ),
    );
  }
}

class _Results extends ConsumerWidget {
  final SearchState state;
  final ScrollController scrollController;

  const _Results({required this.state, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && !state.hasResults) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(DSSpacing.l),
          child: Text(
            'Search failed. Please try again.',
            style: context.subtitleM?.copyWith(color: DSColors.gray60),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (!state.hasResults) {
      return Center(
        child: Text(
          'Nothing found',
          style: context.subtitleLBold?.copyWith(color: DSColors.gray60),
        ),
      );
    }

    if (state.category == SearchCategory.all) {
      return _AllSections(state: state);
    }

    return _CategoryList(state: state, scrollController: scrollController);
  }
}

class _AllSections extends ConsumerWidget {
  final SearchState state;

  const _AllSections({required this.state});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.only(bottom: DSSpacing.l),
      children: [
        // if (state.tracks.isNotEmpty)
        _Section(
          title: 'Tracks',
          children: state.tracks
              .map((t) => _TrackRow(track: t, queue: state.tracks))
              .toList(),
        ),
        // if (state.albums.isNotEmpty)
        _Section(
          title: 'Albums',
          children: state.albums.map((a) => _AlbumRow(album: a)).toList(),
        ),
        // if (state.artists.isNotEmpty)
        _Section(
          title: 'Artists',
          children: state.artists
              .map(
                (a) => ArtistTile(
                  artist: a,
                  onTap: () {
                    context.push('/music/artist/${a.id}', extra: a);
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList(),
        ),
        // if (state.playlists.isNotEmpty)
        _Section(
          title: 'Playlists',
          children: state.playlists
              .map(
                (p) => PlaylistTile(
                  playlist: p,
                  onTap: () {
                    context.push(
                      '/music/playlist/${p.id}?type=${p.type.name}',
                      extra: p,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              )
              .toList(),
        ),
        // if (state.programs.isNotEmpty)
        _Section(
          title: 'Programs',
          children: state.programs.map((p) => _ProgramRow(program: p)).toList(),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _Section({required this.title, required this.children});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            DSSpacing.m,
            DSSpacing.m,
            DSSpacing.m,
            DSSpacing.s8,
          ),
          child: Text(title, style: context.h3),
        ),
        if (children.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: DSSpacing.m,
              vertical: DSSpacing.s8,
            ),
            child: Text(
              'No ${title.toLowerCase()} found',
              style: context.subtitleM,
            ),
          )
        else
          for (var i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                child: DottedDivider(),
              ),
          ],
      ],
    );
  }
}

class _CategoryList extends ConsumerWidget {
  final SearchState state;
  final ScrollController scrollController;

  const _CategoryList({required this.state, required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = _itemsForCategory(state);
    final showSpinner = state.isLoadingMore;

    if (items.isEmpty && !showSpinner) {
      return Center(
        child: Text(
          'Nothing found',
          style: context.subtitleLBold?.copyWith(color: DSColors.gray60),
        ),
      );
    }

    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.only(top: DSSpacing.s8, bottom: DSSpacing.l),
      itemCount: items.length + (showSpinner ? 1 : 0),
      separatorBuilder: (context, index) {
        if (index >= items.length - 1) {
          return const SizedBox.shrink();
        }
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
          child: DottedDivider(),
        );
      },
      itemBuilder: (context, index) {
        if (index >= items.length) {
          return const Padding(
            padding: EdgeInsets.all(DSSpacing.m),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        return _rowFor(context, items[index], state);
      },
    );
  }

  List<dynamic> _itemsForCategory(SearchState s) {
    switch (s.category) {
      case SearchCategory.tracks:
        return s.tracks;
      case SearchCategory.albums:
        return s.albums;
      case SearchCategory.artists:
        return s.artists;
      case SearchCategory.programs:
        return s.programs;
      case SearchCategory.all:
        return const [];
    }
  }

  Widget _rowFor(BuildContext context, dynamic item, SearchState s) {
    if (item is Track) {
      return _TrackRow(track: item, queue: s.tracks);
    }
    if (item is Album) {
      return _AlbumRow(album: item);
    }
    if (item is Artist) {
      return ArtistTile(
        artist: item,
        onTap: () {
          context.push('/music/artist/${item.id}', extra: item);
          Navigator.of(context).pop();
        },
      );
    }
    if (item is Program) {
      return _ProgramRow(program: item);
    }
    if (item is Playlist) {
      return PlaylistTile(
        playlist: item,
        onTap: () {
          context.push(
            '/music/playlist/${item.id}?type=${item.type.name}',
            extra: item,
          );
          Navigator.of(context).pop();
        },
      );
    }
    return const SizedBox.shrink();
  }
}

class _TrackRow extends ConsumerWidget {
  final Track track;
  final List<Track> queue;

  const _TrackRow({required this.track, required this.queue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final isCurrentTrack = playerState.currentTrack?.id == track.id;
    final bool? isPlaying = isCurrentTrack
        ? playerState.isPlaying && !playerState.isRadioMode
        : null;

    return TrackTile(
      track: track,
      isPlaying: isPlaying,
      onTap: () {
        final startIndex = queue.indexWhere((t) => t.id == track.id);
        ref
            .read(playerStateProvider.notifier)
            .playQueue(
              queue,
              source: QueueSource.favorites(
                id: 'search',
                title: 'Search',
                imageUrl: '',
              ),
              startIndex: startIndex < 0 ? 0 : startIndex,
            );
      },
      onMenuTap: (t) => showTrackOptionsBottomSheet(
        context: context,
        track: t,
        onAddToPlaylist: () =>
            showAddToPlaylistBottomSheet(context: context, track: t),
      ),
    );
  }
}

class _AlbumRow extends StatelessWidget {
  final Album album;

  const _AlbumRow({required this.album});

  @override
  Widget build(BuildContext context) {
    return AlbumTile(
      imageUrl: album.imageUrl,
      albumName: album.title,
      artistName: album.artist,
      releaseYear: album.releaseYear,
      onTap: () {
        context.push('/music/album/${album.id}', extra: album);
        Navigator.of(context).pop();
      },
    );
  }
}

class _ProgramRow extends StatelessWidget {
  final Program program;

  const _ProgramRow({required this.program});

  @override
  Widget build(BuildContext context) {
    return ProgramTile(
      imageUrl: program.imageUrl,
      title: program.title,
      episodeCount: program.episodeCount,
      onTap: () {
        context.push('/music/program/${program.id}', extra: program);
        Navigator.of(context).pop();
      },
    );
  }
}
