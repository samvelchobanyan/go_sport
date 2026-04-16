import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

void showCreatePlaylistBottomSheet({
  required BuildContext context,
  required Future<void> Function(String name) onSave,
}) {
  final controller = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: DSColors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
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
                    'Save',
                    style: context.subtitleLBold?.copyWith(color: DSColors.lime),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
