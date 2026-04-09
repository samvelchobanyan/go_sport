import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionButton extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 32, height: 32),
          const SizedBox(width: 10),
          Text(
            label,
            style: context.subtitleMBold,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
