import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/favorites/presentation/my_artists/my_artists_controller.dart';
import 'package:go_sport/features/shared_widgets/artist_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/my_categories_top.dart';

class MyArtistsScreen extends ConsumerWidget {
  const MyArtistsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artists = ref.watch(myArtistsStateProvider).artists;

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
                  iconPath: 'assets/icons/dynamic_bg.svg',
                  title: 'My Artists',
                  subtitle: 'Artists',
                  itemCount: artists.length,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(DSRadius.m),
                      topRight: Radius.circular(DSRadius.m),
                    ),
                    child: Container(
                      color: DSColors.white,
                      child: _buildArtistsList(ref, artists),
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

  Widget _buildArtistsList(WidgetRef ref, List<Artist> artists) {
    if (artists.isEmpty) {
      return Builder(
        builder: (context) => Center(
          child: Text('No favorite artists yet', style: context.subtitleLBold),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(myArtistsStateProvider.notifier).refresh(),
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: DSSpacing.m),
        itemCount: artists.length,
        separatorBuilder: (context, index) {
          if (index >= artists.length - 1) {
            return const SizedBox.shrink();
          }
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
            child: DottedDivider(),
          );
        },
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ArtistTile(
            artist: artist,
            topPadding: index == 0 ? 20 : 8,
          );
        },
      ),
    );
  }
}
