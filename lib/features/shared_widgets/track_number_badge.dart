import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class TrackNumberBadge extends StatelessWidget {
  final int index;

  const TrackNumberBadge({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: DSColors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(DSRadius.s),
      ),
      child: Center(
        child: Text(
          '$index',
          style: context.subtitleM?.copyWith(color: DSColors.blue),
        ),
      ),
    );
  }
}
