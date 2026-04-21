import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';

enum CountBadgeType {
  tracks,
  programs,
}

class CountBadge extends StatelessWidget {
  final int count;
  final CountBadgeType type;

  const CountBadge({
    super.key,
    required this.count,
    required this.type,
  });

  String get _label {
    switch (type) {
      case CountBadgeType.tracks:
        return '$count tracks';
      case CountBadgeType.programs:
        return '$count episodes';
    }
  }

  Color get _textColor {
    switch (type) {
      case CountBadgeType.tracks:
        return DSColors.orange;
      case CountBadgeType.programs:
        return DSColors.blue;
    }
  }

  Color get _borderColor {
    return _textColor.withValues(alpha: 0.3);
  }

  Color get _backgroundColor {
    return _textColor.withValues(alpha: 0.05);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: _backgroundColor,
        border: Border.all(color: _borderColor, width: 1),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Text(
        _label,
        style: context.label?.copyWith(color: _textColor),
      ),
    );
  }
}
