import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/user_profile/notifications/presentation/notifications/notifications_controller.dart';
import 'package:go_sport/features/user_profile/notifications/presentation/notifications/widgets/notification_tile.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the API call immediately when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationsControllerProvider.notifier).getAllNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch the state of your notifications provider
    final state = ref.watch(notificationsControllerProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        appBar: AppBar(
          backgroundColor: DSColors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
          title: Text('Notifications', style: context.h2),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) {
            // 1. Loading State
            if (state.isLoading && state.items.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(color: DSColors.blue),
              );
            }

            // 2. Error State
            if (state.error != null && state.items.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(DSSpacing.m),
                  child: Text(
                    state.error ?? 'Something went wrong',
                    style: context.bodyL?.copyWith(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            // 3. Empty State
            if (state.items.isEmpty) {
              return Center(
                child: Text(
                  'No notifications yet',
                  style: context.bodyL?.copyWith(color: DSColors.gray50),
                ),
              );
            }

            // 4. Data State
            return RefreshIndicator(
              onRefresh: () => ref
                  .read(notificationsControllerProvider.notifier)
                  .getAllNotifications(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(DSSpacing.m),
                  child: Column(
                    children: [
                      ...state.items.asMap().entries.map((entry) {
                        int index = entry.key;
                        var item = entry.value;

                        return Column(
                          children: [
                            NotificationTile(
                              title: item.title,
                              subtitle: item.body,
                              // Replace placeholder image path with your design system path
                              imagePath: 'assets/images/login_bg.png',
                              onTap: () {
                                // Optional handle click interaction
                                ref
                                    .read(
                                      notificationsControllerProvider.notifier,
                                    )
                                    .getSingleNotification(item.id);
                              },
                            ),
                            if (index != state.items.length - 1)
                              const DottedDivider(),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
