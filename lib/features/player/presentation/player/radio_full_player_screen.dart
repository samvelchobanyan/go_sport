import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/player_state_selectors.dart';

import 'widgets/player_fluid_background.dart';
import 'widgets/radio_player_upper_content.dart';
import 'widgets/radio_player_up_next_panel.dart';

class RadioFullPlayerScreen extends ConsumerWidget {
  const RadioFullPlayerScreen({super.key});

  /// Opens the radio full player as a modal bottom sheet.
  static void show(BuildContext context) {
    final view = View.of(context);
    final mq = MediaQueryData.fromView(view);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: DSColors.transparent,
      barrierColor: DSColors.black.withValues(alpha: 0.3),
      enableDrag: true,
      builder: (_) => MediaQuery(
        data: mq,
        child: const RadioFullPlayerScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radioTitle =
        ref.watch(playerInfoProvider.select((info) => info.radioTitle)) ??
            'Radio Go Sport Live';

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.transparent,
        body: Stack(
          children: [
            Container(color: DSColors.white),
            const PlayerFluidBackground(scale: 1.7, opacity: 0.65),

            SafeArea(
              child: Column(
                children: [
                  _TopBar(title: radioTitle),
                  const Expanded(child: RadioPlayerUpperContent()),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: const RadioPlayerUpNextPanel(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: DSSpacing.l,
        vertical: DSSpacing.m,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down),
            color: DSColors.black,
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: context.subtitleLSemi?.copyWith(color: DSColors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const SizedBox(width: 48), // balances the leading IconButton
        ],
      ),
    );
  }
}
