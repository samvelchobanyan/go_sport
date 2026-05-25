import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/forgot_password_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  // 1. Create the controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final email = _emailController.text.trim();

    print('click on continue');

    // 2. Simple Validation Logic
    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email cannot be empty')));
      return;
    }

    if (!email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }

    // 3. Trigger the controller
    ref
        .read(forgotPasswordControllerProvider.notifier)
        .forgotPasswordOtp(email);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final state = ref.watch(forgotPasswordControllerProvider);

    ref.listen<ForgotPasswordState>(forgotPasswordControllerProvider, (
      prev,
      next,
    ) {
      if (next.isSuccess) {
        context.go('/check-email');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            // Background Image (Top half)
            Image.asset(
              'assets/images/email_registration_bg.png',
              width: screenWidth,
              height: screenHeight * 0.7,
              fit: BoxFit.cover,
              cacheHeight: (screenHeight * 0.7).toInt(),
              cacheWidth: screenWidth.toInt(),
            ),

            // Main Content Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset('assets/icons/lock.svg'),
                              SizedBox(width: 8),
                              Text('Restore password', style: context.h2),
                            ],
                          ),

                          SizedBox(height: 14),
                          Text(
                            'We will send a password reset \nlink to your email',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          SizedBox(height: 20),

                          // Email Input
                          CustomInput(
                            controller: _emailController,
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 100),

                          // Continue Button
                          ElevatedButton.icon(
                            onPressed: () {
                              state.isLoading ? null : _onContinue();
                            },
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: DSColors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: DSColors.lime,
                                  ),
                            label: Text(
                              state.isLoading ? 'Processing...' : 'Continue',
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
                          const SizedBox(height: 24),
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
