import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class PlayerTopBar extends ConsumerWidget {
	const PlayerTopBar({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final source = ref.watch(playerStateProvider.select((s) => s.source));

		final String title = source?.when(
			album: (id, title, imageUrl) => 'Album "$title"',
			playlist: (id, title, imageUrl) => 'Playlist "$title"',
			program: (id, title, imageUrl) => 'Program "$title"',
			favorites: (id, title, imageUrl) => title,
			episodes: (id, title, imageUrl) => title,
		) ?? '';

		return Padding(
			padding: const EdgeInsets.symmetric(horizontal: DSSpacing.xs, vertical: DSSpacing.m),
			child: Row(
				children: [
					IconButton(
						icon: const Icon(Icons.keyboard_arrow_down_rounded),
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
					const SizedBox(width: DSSpacing.xxl), // balances the leading IconButton
				],
			),
		);
	}
}