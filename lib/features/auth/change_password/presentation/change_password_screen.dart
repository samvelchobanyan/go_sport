import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/forgot_password_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

const double _cardHeight = 371;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onContinue() {
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a password')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    ref
        .read(forgotPasswordControllerProvider.notifier)
        .resetPasswordOtp(password);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    ref.listen<ForgotPasswordState>(forgotPasswordControllerProvider, (
      prev,
      next,
    ) {
      if (next.isSuccess) {
        context.go('/confirm-password-change');
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
                'assets/images/create_password_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset('assets/icons/lock.svg'),
                              const SizedBox(width: DSSpacing.s8),
                              Text('Restore password', style: context.h2),
                            ],
                          ),

                          const SizedBox(height: DSSpacing.s14),
                          Text(
                            'Your password must contain at least one special character',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          const SizedBox(height: DSSpacing.m),

                          CustomInput(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),

                          const SizedBox(height: DSSpacing.m),

                          CustomInput(
                            controller: _confirmPasswordController,
                            label: 'Repeat Password',
                            hintText: 'Enter your password again',
                            keyboardType: TextInputType.text,
                            obscureText: true,
                          ),

                          const Spacer(),

                          ElevatedButton.icon(
                            onPressed: _onContinue,
                            icon: const Icon(
                              Icons.check_circle,
                              color: DSColors.lime,
                            ),
                            label: Text(
                              'Change password',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              minimumSize: const Size.fromHeight(DSSpacing.xxl),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(DSRadius.xxl),
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
