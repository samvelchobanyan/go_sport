import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/design_system/components/icons/ds_heart_icon.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';

class HeroLikeButton extends ConsumerWidget {
  final bool isLiked;
  final VoidCallback onActionTap;

  const HeroLikeButton({
    super.key,
    required this.isLiked,
    required this.onActionTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    // Disable interactions if the user is a guest or unauthorized
    final isGuest = authState is! AuthAuthenticated;

    return GestureDetector(
      onTap: isGuest ? null : onActionTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          // Orange fill only for liked featured playlists. Custom playlists stay translucent.
          color: (isLiked)
              ? DSColors.orange
              : DSColors.white.withValues(alpha: 0.25),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: DSHeartIcon(
            color: DSColors.white,
            size: DSIconSize.s32,
            isFilled: isLiked,
          ),
        ),
      ),
    );
  }
}
