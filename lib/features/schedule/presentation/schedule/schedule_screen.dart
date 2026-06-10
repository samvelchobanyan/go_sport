import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/program_details/presentation/widgets/youtube_banner.dart';
import 'package:go_sport/features/schedule/presentation/widgets/dates_carousel.dart';
import 'package:go_sport/domain/state/schedule_state.dart';
import 'package:go_sport/features/shared_widgets/schedule_list.dart';
import 'schedule_controller.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // final state = ref.watch(scheduleControllerProvider(today));

    final selectedDate = ref.watch(selectedDateProvider);
    final state = ref.watch(scheduleControllerProvider(selectedDate));

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
                  color: DSColors.black,
                ),
                onPressed: () => context.pop(),
              ),

              title: Text('Radio Schedule', style: context.subtitleLSemi),
              centerTitle: true,
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            DatesCarousel(today: today),

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
                title:
                    '${_getFullMonth(selectedDate.month)} ${selectedDate.day}, ${_getDayOfWeek(selectedDate.weekday)}',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to get month abbreviations
  String _getFullMonth(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  String _getDayOfWeek(int weekday) {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }
}
