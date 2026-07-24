import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/shared_widgets/auth_number_box.dart';
import 'package:go_sport/features/shared_widgets/round_back_button.dart';

const double _cardHeight = 371;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

class ConfirmPhoneScreen extends ConsumerStatefulWidget {
  const ConfirmPhoneScreen({super.key});

  @override
  ConsumerState<ConfirmPhoneScreen> createState() => _ConfirmPhoneScreenState();
}

class _ConfirmPhoneScreenState extends ConsumerState<ConfirmPhoneScreen> {
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
    final otp = _controllers.map((c) => c.text).join();

    if (otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code')),
      );
      return;
    }
    print('OTP entered: $otp');
    ref.read(registrationControllerProvider.notifier).verifyPhoneOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    final registrationState = ref.watch(registrationControllerProvider);

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      print('Registration state changed: $next');
      if (next.isPhoneVerifySuccess) {
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
        backgroundColor: DSColors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Image.asset(
                'assets/images/confirm_email_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            RoundBackButton(
              cardHeight: _cardHeight,
              goBackTo: '/registration-phone',
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _cardHeight,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: DSSpacing.m,
                    vertical: _cardVerticalPadding / 2,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _cardHeight - _cardVerticalPadding,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/authorization.svg',
                              ),
                              const SizedBox(width: DSSpacing.s8),
                              Text(
                                'Please check your phone',
                                style: context.h2,
                              ),
                            ],
                          ),
                          const SizedBox(height: DSSpacing.s14),
                          Text(
                            'We have sent a confirmation code to',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          Text(
                            registrationState.phoneNumber ?? 'your phone',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: DSSpacing.l),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (index) {
                              return AuthNumberBox(
                                controller: _controllers[index],
                                isLast: index == 5,
                              );
                            }),
                          ),

                          const Spacer(),

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
                              minimumSize: const Size.fromHeight(DSSpacing.xxl),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: DSSpacing.s8),

                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: TextButton(
                              onPressed: registrationState.isLoading
                                  ? null
                                  : () async {
                                      await ref
                                          .read(
                                            registrationControllerProvider
                                                .notifier,
                                          )
                                          .resendPhoneOtp();
                                      for (var controller in _controllers) {
                                        controller.clear();
                                      }
                                      FocusScope.of(context).unfocus();
                                    },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_rounded,
                                    color: DSColors.blue,
                                  ),
                                  const SizedBox(width: DSSpacing.s8),
                                  Text(
                                    'Resend Code',
                                    style: context.subtitleMBold?.copyWith(
                                      color: DSColors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
