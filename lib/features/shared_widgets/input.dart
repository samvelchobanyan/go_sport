import 'package:flutter/material.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String? hintText;
  final bool? prefix;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomInput({
    super.key,
    required this.label,
    this.hintText,
    this.prefix,
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
        Text(label, style: context.fieldLabel),
        SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: DSColors.blue.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(DSRadius.s),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (prefix == true)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    '+374',
                    style: context.subtitleM?.copyWith(
                      color: DSColors.blue.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: context.subtitleM,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: context.subtitleM?.copyWith(
                      color: DSColors.gray70,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
