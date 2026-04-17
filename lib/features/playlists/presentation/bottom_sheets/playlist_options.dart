import 'package:flutter/material.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/bottom_pop_ups/action_button.dart';

void showPlaylistBottomSheet({required BuildContext context}) {
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
            // Add to playlist
            ActionButton(
              icon: 'assets/icons/plus_bg.svg',
              label: 'Add tracks',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Add to playlist tapped');
              },
            ),
            const SizedBox(height: 10),

            // Edit playlist
            ActionButton(
              icon: 'assets/icons/edit.svg',
              label: 'Edit playlist',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Edit tapped');
              },
            ),
            const SizedBox(height: 10),

            // Rename playlist
            ActionButton(
              icon: 'assets/icons/edit.svg',
              label: 'Rename playlist',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Rename tapped');
              },
            ),

            const SizedBox(height: 10),

            // Delete playlist
            ActionButton(
              icon: 'assets/icons/delete_bg.svg',
              label: 'Delete playlist',
              onTap: () {
                Navigator.pop(context);
                debugPrint('Delete tapped');
              },
            ),
          ],
        ),
      ),
    ),
  );
}
