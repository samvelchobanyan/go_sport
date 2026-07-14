import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/network_image/ds_network_image.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_layout.dart';
import 'package:go_sport/domain/entities/artist.dart';
import 'package:go_sport/features/shared_widgets/hero_like_button.dart';

class ArtistHero extends StatelessWidget {
  final Artist artist;
  final bool isLiked;
  final VoidCallback onLikeTap;

  const ArtistHero({
    super.key,
    required this.artist,
    required this.isLiked,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        DSNetworkImage(imageUrl: artist.imageUrl),

        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(0, 0, 0, 1.0),
                DSColors.transparent,
                Color.fromRGBO(0, 0, 0, 1.0),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: DSLayout.heroContentBottom,
              left: DSSpacing.l,
              right: DSSpacing.l,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                HeroLikeButton(isLiked: isLiked, onActionTap: onLikeTap),
                const SizedBox(height: DSSpacing.m),
                Text(
                  artist.artistName,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
