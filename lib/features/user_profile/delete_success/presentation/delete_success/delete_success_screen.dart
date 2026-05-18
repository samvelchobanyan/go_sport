import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/auth_state.dart';

class DeleteSuccessScreen extends ConsumerWidget {
  const DeleteSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Added WidgetRef here
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        // Removed leading arrow because the account is gone
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false, // Prevents default back button
          title: SvgPicture.asset('assets/icons/app_logo.svg', height: 36),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/delete_success.png',
              width: screenWidth,
              height: screenHeight * 0.5,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.6,
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 33,
                ),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  children: [
                    Text('Account Deleted', style: context.h2),
                    const SizedBox(height: 12),
                    Text(
                      'Your account has been deleted.\nWe will miss you.',
                      textAlign: TextAlign.center,
                      style: context.subtitleMBold?.copyWith(
                        color: DSColors.gray70,
                      ),
                    ),
                    const Spacer(),
                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: SvgPicture.asset('assets/icons/login.svg'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DSColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DSRadius.xl),
                          ),
                        ),
                        onPressed: () async {
                          await ref.read(authProvider.notifier).logout();
                          if (context.mounted) context.go('/login');
                        },
                        label: Text(
                          "Back to Login",
                          style: context.subtitleLBold?.copyWith(
                            color: DSColors.lime,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
