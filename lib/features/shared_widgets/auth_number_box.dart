import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';

class AuthNumberBox extends StatelessWidget {
  final TextEditingController controller;
  final bool isLast;

  const AuthNumberBox({
    super.key,
    required this.controller,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    // horizontal padding (32) + total gaps (5 gaps * 8px = 40) = 72
    final availableWidth = MediaQuery.of(context).size.width - 72;
    final boxWidth = availableWidth / 6;

    return Container(
      width: boxWidth,
      height: 56,
      decoration: BoxDecoration(
        color: DSColors.blue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(DSRadius.m),
      ),
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            if (!isLast) {
              FocusScope.of(context).nextFocus();
            } else {
              FocusScope.of(context).unfocus();
            }
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        style: context.subtitleM?.copyWith(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: const InputDecoration(
          contentPadding: EdgeInsets
              .zero, // Use zero to avoid vertical jumping in small boxes
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
