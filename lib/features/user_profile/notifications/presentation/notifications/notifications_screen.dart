import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/domain/state/notifications_state.dart';
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
    print('state nooooooooooot: ${state.items}');
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
              // TODO: replace SingleChildScrollView + Column with
              // ListView.separated — lazy build for long lists, and DottedDivider
              // as the separator drops the manual `index != length - 1` check.
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
                              imagePath: item.coverUrl,
                              isSeen: item.isRead,
                              onTap: () {
                                final String target = item.targetId ?? '';
                                final String type = item.type ?? '';

                                // 1. Capture the router instance safely right away
                                final router = GoRouter.of(context);

                                if (type == 'episode') {
                                  router.go(
                                    '/music/program/$target?from=/profile/notifications',
                                  );
                                } else if (type == 'article') {
                                  router.go(
                                    '/news/$target?from=/profile/notifications',
                                  );
                                } else if (type == 'album') {
                                  router.go(
                                    '/music/album/$target?from=/profile/notifications',
                                  );
                                } else if (type == 'playlist') {
                                  // done check!! doesnt have playlist by that documentId
                                  router.go(
                                    '/music/playlist/$target?from=/profile/notifications',
                                  );
                                }

                                ref
                                    .read(
                                      notificationsControllerProvider.notifier,
                                    )
                                    .readNotification(item.documentId);
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
