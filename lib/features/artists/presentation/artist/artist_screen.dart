import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/artists/presentation/artist/artist_controller.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_screen_skeleton.dart';
import 'package:go_sport/features/artists/presentation/widgets/artist_hero.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/search_button.dart';
import 'package:go_sport/features/shared_widgets/wave_section_header.dart';

class ArtistScreen extends ConsumerStatefulWidget {
  final Artist artist;

  const ArtistScreen({super.key, required this.artist});

  @override
  ConsumerState<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends ConsumerState<ArtistScreen> {
  late bool _isLiked;
  late String? _likeId;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.artist.isLiked;
    _likeId = widget.artist.likeId;
  }

  void _onLikeTap() {
    final previousIsLiked = _isLiked;
    final previousLikeId = _likeId;

    setState(() => _isLiked = !_isLiked);

    final notifier = ref.read(
      artistControllerProvider(widget.artist.id).notifier,
    );

    notifier
        .toggleLike(widget.artist.id, previousIsLiked ? previousLikeId : null)
        .then((newLikeId) {
          setState(() => _likeId = newLikeId);
        })
        .catchError((_) {
          setState(() {
            _isLiked = previousIsLiked;
            _likeId = previousLikeId;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final albumsState = ref.watch(artistControllerProvider(widget.artist.id));
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
            backgroundColor: DSColors.black.withValues(alpha: 0.9),
            leading: IconButton(
              icon: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: DSColors.black.withValues(alpha: 0.3),
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
                    color: DSColors.black.withValues(alpha: 0.3),
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
              SearchButton(
                decoration: true,
                onTap: () {
                  // TODO: открыть поиск
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ArtistHero(
                artist: widget.artist.copyWith(isLiked: _isLiked),
                onLikeTap: _onLikeTap,
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
          albumsState.when(
            loading: () => const SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 16),
                    child: WaveSectionHeader(title: 'Albums'),
                  ),
                ),
                ArtistScreenSkeleton(),
              ],
            ),
            error: (message) => SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: $message'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => ref
                          .read(
                            artistControllerProvider(widget.artist.id).notifier,
                          )
                          .loadAlbums(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (albums) => SliverMainAxisGroup(
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 16),
                    child: WaveSectionHeader(title: 'Albums'),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final album = albums[index];

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AlbumTile(
                            imageUrl: album.imageUrl,
                            albumName: album.title,
                            artistName: album.artist,
                            releaseYear: album.releaseYear,
                            onTap: () => context.push(
                              '/music/album/${album.id}',
                              extra: album,
                            ),
                          ),
                          if (index < albums.length - 1)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              child: DottedDivider(),
                            ),
                        ],
                      );
                    }, childCount: albums.length),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
