import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_sport/design_system/components/icons/ds_notification_icon.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/scheduled_program.dart';

class ScheduleTile extends StatefulWidget {
  final ScheduledProgram program;
  final bool isLive;

  const ScheduleTile({
    super.key,
    required this.program,
    this.isLive = false,
  });

  @override
  State<ScheduleTile> createState() => _ScheduleTileState();
}

class _ScheduleTileState extends State<ScheduleTile> {
  bool _isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    final program = widget.program;
    final String startTime =
        "${program.startDate.hour}:${program.startDate.minute.toString().padLeft(2, '0')}";
    final String endTime =
        "${program.endDate.hour}:${program.endDate.minute.toString().padLeft(2, '0')}";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
                  size: 28,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

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
                if (widget.isLive) ...[
                  const SizedBox(width: 6),
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

          const SizedBox(width: 8),

          Text(
            '$startTime - $endTime',
            style: context.bodyL?.copyWith(color: DSColors.gray50),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: () => setState(() => _isSubscribed = !_isSubscribed),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: DSNotificationIcon(
                color: DSColors.blue,
                isFilled: _isSubscribed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
