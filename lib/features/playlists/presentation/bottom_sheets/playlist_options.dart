import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/action_button.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/bottom_sheet_container.dart';

void showPlaylistBottomSheet({
  required BuildContext context,
  required VoidCallback onAddTracks,
  required VoidCallback onEdit,
  required VoidCallback onRename,
  required VoidCallback onDelete,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => BottomSheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionButton(
            icon: 'assets/icons/plus_bg.svg',
            label: 'Add tracks',
            onTap: () {
              Navigator.pop(context);
              onAddTracks();
            },
          ),
          const SizedBox(height: 10),
          ActionButton(
            icon: 'assets/icons/edit.svg',
            label: 'Edit playlist',
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
          const SizedBox(height: 10),
          ActionButton(
            icon: 'assets/icons/edit.svg',
            label: 'Rename playlist',
            onTap: () {
              Navigator.pop(context);
              onRename();
            },
          ),
          const SizedBox(height: 10),
          ActionButton(
            icon: 'assets/icons/delete_bg.svg',
            label: 'Delete playlist',
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          ),
        ],
      ),
    ),
  );
}
