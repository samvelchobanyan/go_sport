import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/auth_number_box.dart';

class ConfirmEmailScreen extends ConsumerStatefulWidget {
  const ConfirmEmailScreen({super.key});

  @override
  ConsumerState<ConfirmEmailScreen> createState() => _ConfirmEmailScreenState();
}

class _ConfirmEmailScreenState extends ConsumerState<ConfirmEmailScreen> {
  // Create a list of controllers for the 6-digit OTP
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onContinue() {
    // Join all digits to form the OTP string
    final otp = _controllers.map((c) => c.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code')),
      );
      return;
    }

    ref.read(registrationControllerProvider.notifier).verifyEmailOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Watch the global state for the email and loading/error status
    final registrationState = ref.watch(registrationControllerProvider);

    // Listen for success to navigate
    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isConfirmSuccess) {
        context.go('/registration-phone');
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
        backgroundColor: DSColors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/images/confirm_email_bg.png',
              width: screenWidth,
              height: screenHeight * 0.7,
              fit: BoxFit.cover,
              cacheHeight: (screenHeight * 0.7).toInt(),
              cacheWidth: screenWidth.toInt(),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, 
                crossAxisAlignment:
                    CrossAxisAlignment.start, 
                children: [
                  // 1. Back Button
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                    ), 
                    child: GestureDetector(
                      onTap: () => context.go('/registration-email'),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: DSColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 8),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: DSColors.blue,
                          size: 22,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30), 

                  // 2. The White Container
                  Container(
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
                              // Header Row
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/authorization.svg',
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Please check your e-mail',
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
                                registrationState.email ?? 'your email',
                                style: context.bodyL?.copyWith(
                                  color: DSColors.gray70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 32),

                              // 6-Digit Auth Number Input Blocks
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return AuthNumberBox(
                                    controller: _controllers[index],
                                    isLast: index == 5,
                                  );
                                }),
                              ),

                              const SizedBox(height: 40),

                              // Continue Button
                              ElevatedButton.icon(
                                onPressed: registrationState.isLoading
                                    ? null
                                    : _onContinue,
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
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
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
                                onPressed: registrationState.isLoading
                                    ? null
                                    : () => ref
                                          .read(
                                            registrationControllerProvider
                                                .notifier,
                                          )
                                          .registerEmail(
                                            registrationState.email!,
                                          ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.email_rounded,
                                      color: DSColors.blue,
                                    ),
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

                              const SizedBox(height: 20),
                            ],
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
    );
  }
}
