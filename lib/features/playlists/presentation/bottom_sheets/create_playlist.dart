import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';

void showCreatePlaylistBottomSheet({
  required BuildContext context,
  required Future<void> Function(String name) onSave,
}) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BottomSheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create a playlist',
              style: context.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  final name = controller.text.trim();
                  if (name.isEmpty) return;
                  Navigator.pop(context);
                  onSave(name);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: DSColors.blue,
                ),
                icon: SvgPicture.asset('assets/icons/check_lime.svg'),
                label: Text(
                  'Create',
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
