import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/round_back_button.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

/// Fixed height of the white card, taken directly from the design (not derived
/// from the inner content). Shared across the registration flow so the card is
/// the same height on every screen.
const double _cardHeight = 371;

/// How many px the card overlaps the image at the top (rounded corners zone).
const double _cardOverlap = 25;

/// Vertical padding inside the card (top + bottom) â€” used to set the
/// SingleChildScrollView's minimum content height so Spacer() still works when
/// the card is not scrolling.
const double _cardVerticalPadding = 40;

class RegistrationEmailScreen extends ConsumerStatefulWidget {
  const RegistrationEmailScreen({super.key});

  @override
  ConsumerState<RegistrationEmailScreen> createState() =>
      _RegistrationEmailScreenState();
}

class _RegistrationEmailScreenState
    extends ConsumerState<RegistrationEmailScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _onContinue() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email cannot be empty')));
      return;
    }

    if (!_isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address')),
      );
      return;
    }
    ref.read(registrationControllerProvider.notifier).registerEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.size is keyboard-independent â€” the image height is calculated
    // once and never changes when the keyboard opens.
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    final state = ref.watch(registrationControllerProvider);

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isEmailSuccess) {
        context.go('/confirm-email');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    // Google sign-in authenticates via the domain auth notifier; navigate when
    // the app becomes authenticated (email flow instead goes to /confirm-email).
    ref.listen(authProvider, (prev, next) {
      if (next is AuthAuthenticated) {
        context.go('/');
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
                          // Top content
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.person_rounded, color: DSColors.blue),
                              SizedBox(width: DSSpacing.s8),
                              Text('Registration', style: context.h2),
                            ],
                          ),

                          SizedBox(height: DSSpacing.s14),
                          Text(
                            'Create your account to get started and unlock all features',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          SizedBox(height: DSSpacing.s20),

                          CustomInput(
                            controller: _emailController,
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const Spacer(),

                          // Continue Button
                          ElevatedButton.icon(
                            onPressed: state.isLoading ? null : _onContinue,
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
                              minimumSize: const Size.fromHeight(DSSpacing.xxl),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: DSSpacing.s14),

                          // Google Login Button
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: TextButton(
                              onPressed: () => ref
                                  .read(registrationControllerProvider.notifier)
                                  .loginWithGoogle(),
                              style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(
                                  DSSpacing.xxl,
                                ),
                                backgroundColor: DSColors.blue5,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    DSRadius.xxl,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/google_logo.svg',
                                  ),
                                  const SizedBox(width: DSSpacing.s8),
                                  Text(
                                    'Login with Google',
                                    style: context.subtitleLBold?.copyWith(
                                      color: DSColors.gray60,
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
