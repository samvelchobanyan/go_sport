import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

void showDeleteBottomSheet({
  required BuildContext context,
  required String text,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        color: DSColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DSRadius.l),
          topRight: Radius.circular(DSRadius.l),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 20),
            SvgPicture.asset('assets/icons/note_orange.svg'),
            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
                bottom: 24,
              ),
              child: Text(text, style: context.h2, textAlign: TextAlign.center),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      debugPrint('Delete tapped');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DSColors.gray5,
                      elevation: 0,
                    ),
                    icon: SvgPicture.asset('assets/icons/delete.svg'),
                    label: Text('Yes, delete', style: context.subtitleLBold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      debugPrint('No keep tapped');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DSColors.blue,
                    ),
                    child: Text(
                      'No, keep',
                      style: context.subtitleLBold?.copyWith(
                        color: DSColors.lime,
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
  );
}
