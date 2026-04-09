import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/shared_widgets/input.dart';

class RegistrationNameScreen extends ConsumerWidget {
  const RegistrationNameScreen({super.key});

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
                              SvgPicture.asset('assets/icons/user.svg'),
                              const SizedBox(width: 8),
                              Text('Your name and surname', style: context.h2),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Please use only letters, no numbers or special characters',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Name Input
                          const CustomInput(
                            label: 'Name',
                            hintText: 'Enter your name',
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 16),

                          // Surname Input
                          const CustomInput(
                            label: 'Surname',
                            hintText: 'Enter your surname',
                            keyboardType: TextInputType.text,
                          ),

                          const SizedBox(height: 16),

                          // Continue Button
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push('/home');
                            },
                            icon: Icon(
                              Icons.check_circle,
                              color: DSColors.lime,
                            ),
                            label: Text(
                              'Finish',
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

                          const SizedBox(height: 25),
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
