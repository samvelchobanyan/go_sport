import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

void showCreatePlaylistBottomSheet({required BuildContext context}) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a playlist',
              style: context.h2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(64, 74, 195, 0.07),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DSRadius.s),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
            SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  debugPrint('No keep tapped');
                },
                style: ElevatedButton.styleFrom(backgroundColor: DSColors.blue),
                icon: SvgPicture.asset('assets/icons/check_lime.svg'),
                label: Text(
                  'Save',
                  style: context.subtitleLBold?.copyWith(color: DSColors.lime),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
