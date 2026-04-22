import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/current_program_state.dart';
import 'package:go_sport/domain/state/schedule_state.dart';
import 'package:go_sport/features/shared_widgets/schedule_list.dart';

class RadioPlayerUpNextPanel extends ConsumerWidget {
  const RadioPlayerUpNextPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final scheduleState = ref.watch(scheduleControllerProvider(today));
    final currentProgram = ref.watch(currentProgramProvider);

    return Container(
      decoration: const BoxDecoration(
        color: DSColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DSRadius.m),
        ),
      ),
      child: scheduleState.when(
        loading: () => const _Skeleton(),
        error: (message) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              message,
              style: context.bodyL?.copyWith(color: DSColors.gray60),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        data: (programs) {
          final upcoming =
              programs.where((p) => p.endDate.isAfter(now)).toList();

          if (upcoming.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No upcoming programs',
                  style: context.bodyL?.copyWith(color: DSColors.gray60),
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              ScheduleList(
                programs: upcoming,
                title: 'Up next',
                currentProgramId: currentProgram?.id,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Skeleton extends StatelessWidget {
  const _Skeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22, bottom: 22, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              color: DSColors.gray10,
              borderRadius: BorderRadius.circular(DSRadius.xs),
            ),
          ),
          const SizedBox(height: 16),
          for (var i = 0; i < 5; i++) ...[
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: DSColors.gray10,
                    borderRadius: BorderRadius.circular(DSRadius.xs),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: DSColors.gray10,
                      borderRadius: BorderRadius.circular(DSRadius.xs),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}
