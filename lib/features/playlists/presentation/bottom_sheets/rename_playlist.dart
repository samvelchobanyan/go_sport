import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';

void showRenamePlaylistBottomSheet({
  required BuildContext context,
  required String initialName,
  required void Function(String newName) onSave,
}) {
  final controller = TextEditingController(text: initialName);

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
            Text('Rename Playlist', style: context.h2),
            const SizedBox(height: DSSpacing.m),
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
            const SizedBox(height: DSSpacing.s20),
            SafeArea(
              top: false,
              left: false,
              right: false,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: DSColors.gray5,
                        elevation: 0,
                      ),
                      child: Text('Cancel', style: context.subtitleLBold),
                    ),
                  ),
                  const SizedBox(width: DSSpacing.s10),
                  Expanded(
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
                        'Save',
                        style: context.subtitleLBold?.copyWith(
                          color: DSColors.lime,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: DSSpacing.s10),
          ],
        ),
      ),
    ),
  );
}
