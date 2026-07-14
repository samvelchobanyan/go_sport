import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends ConsumerWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    final isGuest = authState is! AuthAuthenticated;

    return GestureDetector(
      onTap: isGuest ? null : onTap,
      behavior: HitTestBehavior.opaque, // Makes the entire empty area tappable
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 32, height: 32),
          const SizedBox(width: DSSpacing.s10),
          Text(
            label,
            style: context.subtitleMBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // ),
    );
  }
}
