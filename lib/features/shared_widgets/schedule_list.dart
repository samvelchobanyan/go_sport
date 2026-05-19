import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/schedule_tile.dart';

class ScheduleList extends ConsumerWidget {
  final List<ScheduledProgram> programs;
  final String title;

  const ScheduleList({required this.programs, required this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            // First item is the title
            if (index == 0) {
              return Text(title, style: context.h2);
            }

            // Second item is spacing
            if (index == 1) {
              return const SizedBox(height: 10);
            }

            // Remaining items are programs
            final programIndex = index - 2;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScheduleTile(program: programs[programIndex]),
                if (programIndex < programs.length - 1) DottedDivider(),
              ],
            );
          },
          childCount: programs.length + 2, // +2 for title and spacing
        ),
      ),
    );
  }
}
