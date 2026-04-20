import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';

class ConfirmPhoneScreen extends ConsumerWidget {
  const ConfirmPhoneScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/images/confirm_email_bg.png',
              width: screenWidth,
              height: screenHeight * 0.7,
              fit: BoxFit.cover,
            ),

            // Main Content Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.45, // Increased slightly for spacing
                width: screenWidth,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Row
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/authorization.svg',
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Please check your phone',
                                style: context.h2,
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'We have sent a confirmation code to',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          Text(
                            '+999999999', // TODO: dynamic
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // 5-Digit Auth Number Input Blocks
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(5, (index) {
                              return _AuthNumberBox(isLast: index == 4);
                            }),
                          ),

                          const SizedBox(height: 40),

                          // Continue Button
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push('/registration-phone');
                            },
                            icon: Icon(
                              Icons.arrow_forward,
                              color: DSColors.lime,
                            ),
                            label: Text(
                              'Continue',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xl,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // Resend Code Button
                          TextButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.email_rounded, color: DSColors.blue),
                                const SizedBox(width: 8),
                                Text(
                                  'Resend Code',
                                  style: context.subtitleMBold?.copyWith(
                                    color: DSColors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Private helper widget for the single block input
class _AuthNumberBox extends StatelessWidget {
  final bool isLast;
  const _AuthNumberBox({required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          (MediaQuery.of(context).size.width - 80) / 5, // Auto-calculates width
      height: 56,
      decoration: BoxDecoration(
        color: DSColors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(DSRadius.m),
      ),
      alignment: Alignment.center,
      child: TextField(
        onChanged: (value) {
          if (value.length == 1 && !isLast) {
            FocusScope.of(context).nextFocus(); // Auto-move to next block
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus(); // Auto-move back on delete
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
          contentPadding: EdgeInsets.all(14),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
