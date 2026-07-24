import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/domain/state/forgot_password_state.dart';
import 'package:go_sport/features/shared_widgets/auth_number_box.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/shared_widgets/round_back_button.dart';

const double _cardHeight = 371;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

class CheckEmailScreen extends ConsumerStatefulWidget {
  const CheckEmailScreen({super.key});

  @override
  ConsumerState<CheckEmailScreen> createState() => _CheckEmailScreenState();
}

class _CheckEmailScreenState extends ConsumerState<CheckEmailScreen> {
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

    ref.read(forgotPasswordControllerProvider.notifier).verifyResetOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    final forgotPasswordState = ref.watch(forgotPasswordControllerProvider);

    ref.listen<ForgotPasswordState>(forgotPasswordControllerProvider, (
      prev,
      next,
    ) {
      if (next.isConfirmSuccess) {
        context.go(AppRoutes.changePassword);
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Image.asset(
                'assets/images/email_registration_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            RoundBackButton(cardHeight: _cardHeight, goBackTo: '/login'),

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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.email_rounded, color: DSColors.blue),
                              SizedBox(width: DSSpacing.s8),
                              Text('Check your email', style: context.h2),
                            ],
                          ),

                          SizedBox(height: DSSpacing.s14),
                          Text(
                            'The password reset link has been sent to \n${forgotPasswordState.email}',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          SizedBox(height: DSSpacing.s20),

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
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: ElevatedButton.icon(
                              onPressed: forgotPasswordState.isLoading
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
                                minimumSize: const Size.fromHeight(
                                  DSSpacing.xxl,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    DSRadius.xxl,
                                  ),
                                ),
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
