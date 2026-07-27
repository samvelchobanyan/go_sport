import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/shared_widgets/artist_selection_tile.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';

void showArtistsBottomSheet(
  BuildContext context,
  List<Artist> artists,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => Container(
      decoration: BoxDecoration(
        color: DSColors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(DSRadius.l),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Padding(
            padding: const EdgeInsets.only(
              top: DSSpacing.s12,
              bottom: DSSpacing.m,
            ),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: DSColors.gray20,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // List of artists
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: artists.length,
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(horizontal: DSSpacing.m),
                child: DottedDivider(),
              ),
              itemBuilder: (context, index) {
                final artist = artists[index];
                return ArtistSelectionTile(
                  artist: artist,
                  onTap: () {
                    // Захватываем router и root-навигатор ДО pop —
                    // после pop контекст sheet становится defunct.
                    final router = GoRouter.of(context);
                    final rootNav = Navigator.of(context, rootNavigator: true);
                    rootNav.pop(); // close artists sheet
                    rootNav.pop(); // close full-player
                    router.push('/music/artist/${artist.id}');
                  },
                );
              },
            ),
          ),
          // Bottom padding for safe area
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + DSSpacing.m,
          ),
        ],
      ),
    ),
  );
}
