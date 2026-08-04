import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';

void showDeleteConfirmBottomSheet({
  required BuildContext context,
  required String text,
  required VoidCallback onConfirm,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/note_orange.svg'),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: 24,
            ),
            child: Text(text, style: context.h2, textAlign: TextAlign.center),
          ),
          SafeArea(
            top: false,
            left: false,
            right: false,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: DSColors.gray5,
                      elevation: 0,
                    ),
                    icon: SvgPicture.asset('assets/icons/delete.svg'),
                    label: Text('Yes, delete', style: context.subtitleLBold),
                  ),
                ),
                const SizedBox(width: DSSpacing.s10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
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
          ),
         SizedBox(height: DSSpacing.s10)
        ],
      ),
    ),
  );
}
