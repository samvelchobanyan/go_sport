import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';

class ContactInfoItem extends StatelessWidget {
  final SvgPicture icon;
  final String text;
  final VoidCallback? onTap;

  const ContactInfoItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon,
          const SizedBox(width: DSSpacing.s10),
          Expanded(child: Text(text, style: context.subtitleM)),
        ],
      ),
    );
  }
}
