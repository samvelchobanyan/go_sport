import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/album.dart';
import 'package:go_sport/features/favorites/presentation/my_albums/my_albums_controller.dart';
import 'package:go_sport/features/shared_widgets/album_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class MyAlbumsScreen extends ConsumerWidget {
  const MyAlbumsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(myAlbumsStateProvider).albums;

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
                      child: _buildAlbumsList(ref, albums),
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

  Widget _buildAlbumsList(WidgetRef ref, List<Album> albums) {
    if (albums.isEmpty) {
      return Builder(
        builder: (context) => Center(
          child: Text('No favorite albums yet', style: context.subtitleLBold),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(myAlbumsStateProvider.notifier).refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        itemCount: albums.length,
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
          final album = albums[index];
          return AlbumTile(
            imageUrl: album.imageUrl,
            albumName: album.title,
            artistName: album.artist,
            releaseYear: album.releaseYear,
            onTap: () => context.push(
              '/music/album/${album.id}',
              extra: album,
            ),
          );
        },
      ),
    );
  }
}
