import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';

class ContactInfoItem extends StatelessWidget {
  final SvgPicture icon;
  final String text;

  const ContactInfoItem({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon,
        const SizedBox(width: DSSpacing.s10),
        Expanded(child: Text(text, style: context.subtitleM)),
      ],
    );
  }
}
