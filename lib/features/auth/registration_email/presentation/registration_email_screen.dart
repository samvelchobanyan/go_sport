import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/auth/login/presentation/login/login_controller.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class RegistrationEmailScreen extends ConsumerStatefulWidget {
  const RegistrationEmailScreen({super.key});

  @override
  ConsumerState<RegistrationEmailScreen> createState() =>
      _RegistrationEmailScreenState();
}

class _RegistrationEmailScreenState
    extends ConsumerState<RegistrationEmailScreen> {
  // 1. Create the controller
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final email = _emailController.text.trim();

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
    ref.read(registrationControllerProvider.notifier).registerEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final state = ref.watch(registrationControllerProvider);

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isSuccess) {
        context.go('/confirm-email');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.go('/'); // Navigate to home
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
                              Icon(Icons.person_rounded, color: DSColors.blue),
                              SizedBox(width: 8),
                              Text('Registration', style: context.h2),
                            ],
                          ),

                          SizedBox(height: 14),
                          Text(
                            'Create your account to get started and unlock all features',
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

                          const SizedBox(height: 50),

                          // Continue Button
                          ElevatedButton.icon(
                            // Disable button if loading
                            onPressed: state.isLoading ? null : _onContinue,
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
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
                          const SizedBox(height: 14),

                          // Google Login Button
                          TextButton(
                            onPressed: () {
                              ref.read(loginControllerProvider.notifier).loginWithGoogle();
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: DSColors.blue.withOpacity(0.05),
                              // This ensures no border is drawn
                              side: BorderSide.none,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xl,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/google_logo.svg',
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Login with Google',
                                  style: context.subtitleLBold?.copyWith(
                                    color: DSColors.gray60,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
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
