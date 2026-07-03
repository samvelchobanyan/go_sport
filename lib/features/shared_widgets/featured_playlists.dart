import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/entities/playlist.dart';
import 'package:go_sport/features/shared_widgets/playlist_card.dart';
import 'package:go_sport/features/shared_widgets/wave_section_header.dart';

class FeaturedPlaylistsSection extends StatelessWidget {
  final List<Playlist> playlists;

  const FeaturedPlaylistsSection({super.key, required this.playlists});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: DSColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: DSSpacing.m),
              child: WaveSectionHeader(
                title: 'Featured playlists',
                showAnimation: true,
              ),
            ),
            if (playlists.isNotEmpty)
              SizedBox(
                height: 230,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: DSSpacing.m),
                  itemCount: playlists.length,
                  itemBuilder: (context, index) {
                    final playlist = playlists[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: DSSpacing.s12),
                      child: PlaylistCard(playlist: playlist),
                    );
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'No featured playlists available.',
                  style: TextStyle(color: DSColors.gray60),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
