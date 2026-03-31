import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/icons/ds_notification_icon.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/domain/entities/program.dart';

class ProgramHero extends StatelessWidget {
  final Program program;
  final VoidCallback onNotificationTap;
  final VoidCallback onPlayTap;

  const ProgramHero({
    super.key,
    required this.program,
    required this.onNotificationTap,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image
        Hero(
          tag: 'program-image-${program.id}',
          child: Image.network(
            program.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: DSColors.gray40),
          ),
        ),

        // Gradient overlay
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                DSColors.transparent,
                Color.fromRGBO(0, 0, 0, 0.3),
                Color.fromRGBO(0, 0, 0, 0.7),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
        ),

        // Title and buttons
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 60, left: 24, right: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  program.title,
                  style: context.h1?.copyWith(color: DSColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Notification button
                    GestureDetector(
                      onTap: onNotificationTap,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: DSColors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: DSNotificationIcon(
                            color: DSColors.white,
                            size: 24,
                            isFilled: program.isLiked,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Play button
                    GestureDetector(
                      onTap: onPlayTap,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: const BoxDecoration(
                          color: DSColors.lime,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.play_arrow,
                            color: DSColors.black,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
