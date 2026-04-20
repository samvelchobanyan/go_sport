import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/schedule/presentation/schedule/schedule_controller.dart';

class DatesCarousel extends ConsumerWidget {
  final DateTime today;
  const DatesCarousel({super.key, required this.today});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);

    final startDate = today.subtract(const Duration(days: 2));

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 64,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: 14,
          itemBuilder: (context, index) {
            final date = startDate.add(Duration(days: index));

            final isSelected =
                date.year == selectedDate.year &&
                date.month == selectedDate.month &&
                date.day == selectedDate.day;

            return GestureDetector(
              onTap: () {
                ref.read(selectedDateProvider.notifier).updateDate(date);
              },
              child: Container(
                width: 64,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: isSelected ? DSColors.lime : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? DSColors.lime
                        : DSColors.blue.withValues(alpha: 0.3),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: DSColors.lime.withValues(alpha: 0.6),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day.toString(),
                      style: context.subtitleLBold?.copyWith(
                        color: DSColors.blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 21,
                      ),
                    ),
                    Text(
                      _getMonthAbbr(date.month),
                      style: context.subtitleLSemi?.copyWith(
                        color: DSColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getMonthAbbr(int month) {
    const months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec',
    ];
    return months[month - 1];
  }
}
