import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/icons/ds_notification_icon.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_icon_size.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';

class ScheduleTile extends StatelessWidget {
  final ScheduledProgram program;
  final bool isLive;
  final bool isSubscribed;
  final VoidCallback onSubscribeToggle;

  const ScheduleTile({
    super.key,
    required this.program,
    required this.isSubscribed,
    required this.onSubscribeToggle,
    this.isLive = false,
  });

  @override
  Widget build(BuildContext context) {
    final String startTime =
        "${program.startDate.hour}:${program.startDate.minute.toString().padLeft(2, '0')}";
    final String endTime =
        "${program.endDate.hour}:${program.endDate.minute.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DSSpacing.s8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(DSRadius.xs),
            child: CachedNetworkImage(
              imageUrl: program.imageUrl ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 40, height: 40, color: DSColors.divider),
              errorWidget: (context, url, error) => Container(
                width: 40,
                height: 40,
                color: DSColors.gray20,
                child: const Icon(
                  Icons.error,
                  color: DSColors.gray50,
                  size: DSIconSize.s28,
                ),
              ),
            ),
          ),
          const SizedBox(width: DSSpacing.s12),

          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    program.title,
                    style: context.subtitleMBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (isLive) ...[
                  const SizedBox(width: DSSpacing.s6),
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: DSColors.orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(width: DSSpacing.s8),

          Text(
            '$startTime - $endTime',
            style: context.bodyL?.copyWith(color: DSColors.gray50),
          ),
          const SizedBox(width: DSSpacing.xs),
          GestureDetector(
            onTap: onSubscribeToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(DSSpacing.xs),
              child: DSNotificationIcon(
                color: DSColors.blue,
                isFilled: isSubscribed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
