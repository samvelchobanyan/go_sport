import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';

class ActionRow extends StatelessWidget {
  final Widget icon;
  final String text;
  final VoidCallback onTap;

  const ActionRow({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(child: Text(text, style: context.subtitleMBold)),
          ],
        ),
      ),
    );
  }
}
