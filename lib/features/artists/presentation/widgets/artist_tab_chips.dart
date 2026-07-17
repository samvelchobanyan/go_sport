import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/artists/presentation/artist/artist_controller.dart';

/// Pill chips switching the artist screen tabs. Only the tabs the artist
/// actually has content for are passed in [tabs].
class ArtistTabChips extends StatelessWidget {
  final List<ArtistTab> tabs;
  final ArtistTab selected;
  final ValueChanged<ArtistTab> onTap;

  const ArtistTabChips({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: DSSpacing.s18, // 20px vertical padding
        left: DSSpacing.m, // 20px horizontal padding
        right: DSSpacing.m, // 20px horizontal padding
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < tabs.length; i++) ...[
            Expanded(
              child: _Chip(
                tab: tabs[i],
                isActive: tabs[i] == selected,
                onTap: () => onTap(tabs[i]),
              ),
            ),
            if (i < tabs.length - 1) const SizedBox(width: DSSpacing.s8),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final ArtistTab tab;
  final bool isActive;
  final VoidCallback onTap;

  const _Chip({required this.tab, required this.isActive, required this.onTap});

  String get _label => switch (tab) {
    ArtistTab.tracks => 'Tracks',
    ArtistTab.albums => 'Albums',
    ArtistTab.singles => 'Singles',
  };

  String get _iconAsset => switch (tab) {
    ArtistTab.tracks => 'assets/icons/music_tab.svg',
    ArtistTab.albums => 'assets/icons/albums_tab.svg',
    ArtistTab.singles => 'assets/icons/singles_tab.svg',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DSSpacing.xs,
          vertical: DSSpacing.s10,
        ),
        decoration: BoxDecoration(
          color: isActive ? DSColors.blue10 : DSColors.white,
          border: isActive ? null : Border.all(color: DSColors.blue20),
          borderRadius: BorderRadius.circular(DSRadius.circular),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              _iconAsset,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                DSColors.blue,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: DSSpacing.s6),
            Text(
              _label,
              style: context.subtitleM?.copyWith(color: DSColors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
