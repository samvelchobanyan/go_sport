import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/program_details/presentation/widgets/youtube_banner.dart';
import 'package:go_sport/features/shared_widgets/schedule_list.dart';
import 'schedule_controller.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = DateTime(2026, 4, 6);

    final state = ref.watch(scheduleControllerProvider(date));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              floating: true,
              leading: IconButton(
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.black,
                ),
                onPressed: () => context.pop(),
              ),

              title: Text('Radio Schedule', style: context.subtitleLSemi),
              centerTitle: true,
            ),

            _buildDates(context),

            const SliverToBoxAdapter(child: SizedBox(height: 26)),
            // orange youtube banner
            YoutubeBanner(),

            state.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),

              error: (message) =>
                  SliverFillRemaining(child: Center(child: Text(message))),

              data: (programs) => ScheduleList(
                programs: programs,
                title: 'September 11, Thursday',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDates(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 80, // Total height including padding
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          itemCount: 14, // 2 weeks of dummy data
          itemBuilder: (context, index) {
            final date = DateTime(2026, 9, 11).add(Duration(days: index));
            final isSelected = index == 0; // Logic for selection state

            return Container(
              width: 64,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? DSColors.lime : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? DSColors.lime
                      : DSColors.blue.withOpacity(0.3),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(DSRadius.s),
                boxShadow: [
                  if (isSelected)
                    BoxShadow(
                      color: DSColors.lime.withOpacity(0.6),
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
                      fontSize: 21, //todo change later
                    ),
                  ),
                  Text(
                    _getMonthAbbr(date.month),
                    style: context.subtitleLSemi?.copyWith(
                      // Usually dates use a smaller font for the month
                      color: DSColors.blue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper to get month abbreviations
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
