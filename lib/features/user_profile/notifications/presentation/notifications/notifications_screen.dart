import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/user_profile/notifications/presentation/notifications/widgets/notification_tile.dart';

class NotificationModel {
  final String title;
  final String subtitle;
  final String image;

  NotificationModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationModel> dummyNotifications = [
      NotificationModel(
        title: 'New Training Session',
        subtitle: 'A new football session has been added to your local club.',
        image: 'assets/images/login_bg.png',
      ),
      NotificationModel(
        title: 'Booking Confirmed',
        subtitle:
            'Your tennis court reservation for tomorrow at 6 PM is ready.',
        image: 'assets/images/login_bg.png',
      ),
      NotificationModel(
        title: 'Special Offer',
        subtitle: 'Get 20% off on all gym memberships this weekend only!',
        image: 'assets/images/login_bg.png',
      ),
      NotificationModel(
        title: 'Profile Updated',
        subtitle: 'Your payment method has been successfully updated.',
        image: 'assets/images/login_bg.png',
      ),
    ];

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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                ...dummyNotifications.asMap().entries.map((entry) {
                  int index = entry.key;
                  var item = entry.value;

                  return Column(
                    children: [
                      NotificationTile(
                        title: item.title,
                        subtitle: item.subtitle,
                        imagePath: item.image,
                        onTap: () {},
                      ),
                      if (index != dummyNotifications.length - 1)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: DottedDivider(),
                        ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
