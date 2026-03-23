import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/features/favorite_albums/presentation/albums_controller.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class FavoriteAlbumsListScreen extends ConsumerStatefulWidget {
  const FavoriteAlbumsListScreen({super.key});

  @override
  ConsumerState<FavoriteAlbumsListScreen> createState() =>
      _FavoriteAlbumsListScreenState();
}

class _FavoriteAlbumsListScreenState
    extends ConsumerState<FavoriteAlbumsListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  void _onScroll() {
    final state = ref.read(albumsStateProvider);
    if (state.isLoading || state.isLoadingMore) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(albumsStateProvider.notifier).loadMore();
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
    final state = ref.watch(albumsStateProvider);
    final albums = state.albums;

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
                  iconPath: 'assets/icons/nota_bg.svg',
                  title: 'My Albums',
                  subtitle: 'Albums',
                  itemCount: albums.length,
                ),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: state.isLoading && albums.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            ) //todo add skeleton loading later
                          : state.error != null && albums.isEmpty
                          ? _buildErrorWidget(state)
                          : _buildAlbumsList(ref, albums, state.isLoadingMore),
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

  Widget _buildAlbumsList(
    WidgetRef ref,
    List<Album> albums,
    bool isLoadingMore,
  ) {
    if (albums.isEmpty) {
      return Center(
        child: Text('No favorite albums yet', style: context.subtitleLBold),
      );
    }

    return ListView.separated(
      controller: _scrollController,
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      itemCount: albums.length + (isLoadingMore ? 1 : 0),
      separatorBuilder: (context, index) {
        if (index >= albums.length - 1) {
          return const SizedBox.shrink();
        }

        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: DottedDivider(),
        );
      },
      itemBuilder: (context, index) {
        if (index >= albums.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final album = albums[index];
        return AlbumTile(
          imageUrl: album.imageUrl,
          albumName: album.title,
          artistName: album.artist,
          releaseYear: album.releaseYear,
          onTap: () => debugPrint('Album tapped: ${album.id}'),
        );
      },
    );
  }

  Widget _buildErrorWidget(AlbumsState state) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Failed to load favorite albums', style: context.subtitleLBold),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => ref.read(albumsStateProvider.notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
