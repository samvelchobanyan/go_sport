import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType
  keyboardType; // Defines which keyboard pops up on the user's phone. with numbers/text etc.
  final bool obscureText; //  set this to true for password fields
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Text(
          label,
          style: context.fieldLabel, // Using your requested style
        ),

        const SizedBox(height: 4), // Space between label and input
        // Input Field Container
        Container(
          decoration: BoxDecoration(
            color: DSColors.blue.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(DSRadius.s),
            border: Border.all(
              color: Colors.transparent,
              width: 0,
            ), // Explicitly no border
          ),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: context.subtitleM, // Input text style
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: context.subtitleM,
              // Remove default Material borders
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              // Apply the symmetric padding
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
