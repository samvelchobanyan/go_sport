import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class RegistrationPhoneScreen extends ConsumerStatefulWidget {
  const RegistrationPhoneScreen({super.key});

  @override
  ConsumerState<RegistrationPhoneScreen> createState() =>
      _RegistrationPhoneScreenState();
}

class _RegistrationPhoneScreenState
    extends ConsumerState<RegistrationPhoneScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final phone = _phoneController.text.trim().replaceAll(RegExp(r'\D'), '');

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number cannot be empty')),
      );
      return;
    }

    ref
        .read(registrationControllerProvider.notifier)
        .registerPhone('+374$phone');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final state = ref.watch(registrationControllerProvider);

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isSuccess && !next.isSkipSuccess) {
    
        context.go('/confirm-phone');
      }

      if (next.isSkipSuccess) {
        context.go('/create-password');
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
              'assets/images/phone_registration_bg.png',
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
                // height: screenHeight * 0.4, // Adjust height as needed
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
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone_in_talk_rounded,
                                color: DSColors.blue,
                              ),
                              SizedBox(width: 8),
                              Text('Phone Number', style: context.h2),
                            ],
                          ),

                          SizedBox(height: 10),
                          Text(
                            'We will send a one time password to your phone number via SMS',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          SizedBox(height: 20),

                          // Phone Input
                          CustomInput(
                            controller: _phoneController,
                            label: 'Phone number',
                            hintText: 'Enter your phone number',
                            keyboardType: TextInputType.phone,
                            prefix: true,
                          ),

                          const SizedBox(height: 50),

                          // Continue Button
                          ElevatedButton.icon(
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

                          // Skip Button
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(registrationControllerProvider.notifier)
                                  .skipPhone();
                              context.push('/create-password');
                            },
                            style: TextButton.styleFrom(side: BorderSide.none),
                            child: Text(
                              'Skip',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.blue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
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
