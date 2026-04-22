import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';
import 'package:go_sport/domain/state/program_reminders_state.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/schedule_tile.dart';

class ScheduleList extends ConsumerWidget {
  final List<ScheduledProgram> programs;
  final String title;
  final String? currentProgramId;

  const ScheduleList({
    required this.programs,
    required this.title,
    this.currentProgramId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscribedIds = ref.watch(programRemindersProvider);

    return SliverPadding(
      padding: const EdgeInsets.only(top: 22, bottom: 22, left: 16, right: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index == 0) {
              return Text(title, style: context.h2);
            }

            if (index == 1) {
              return const SizedBox(height: 16);
            }

            final programIndex = index - 2;
            final program = programs[programIndex];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScheduleTile(
                  program: program,
                  isLive: currentProgramId != null &&
                      program.id == currentProgramId,
                  isSubscribed: subscribedIds.contains(program.id),
                  onSubscribeToggle: () => ref
                      .read(programRemindersProvider.notifier)
                      .toggle(program),
                ),
                if (programIndex < programs.length - 1) DottedDivider(),
              ],
            );
          },
          childCount: programs.length + 2,
        ),
      ),
    );
  }
}
