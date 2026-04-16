import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/forgot_password_state.dart';
import 'package:go_sport/features/auth/login/presentation/login/login_controller.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class ConfirmChangePasswordScreen extends ConsumerStatefulWidget {
  const ConfirmChangePasswordScreen({super.key});

  @override
  ConsumerState<ConfirmChangePasswordScreen> createState() =>
      _ConfirmChangePasswordScreenState();
}

class _ConfirmChangePasswordScreenState
    extends ConsumerState<ConfirmChangePasswordScreen> {
  late final TextEditingController _passwordController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();

    // Grab inputed values from RegistrationState
    final forgotPasswordState = ref.read(forgotPasswordControllerProvider);

    _emailController = TextEditingController(
      text: forgotPasswordState.email ?? '',
    );

    _passwordController = TextEditingController(
      text: forgotPasswordState.newPassword ?? '',
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final loginState = ref.watch(loginControllerProvider);
    final loginNotifier = ref.read(loginControllerProvider.notifier);

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
        backgroundColor: DSColors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            // Background Image (Top half)
            Image.asset(
              'assets/images/create_password_bg.png',
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
                              SvgPicture.asset('assets/icons/login_blue.svg'),
                              const SizedBox(width: 8),
                              Text('Password changed!', style: context.h2),
                            ],
                          ),

                          const SizedBox(height: 14),
                          Text(
                            'You can now login to app using your new password',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Email Input
                          CustomInput(
                            label: 'Email',
                            hintText: 'Enter your email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 16),

                          // Password Input
                          CustomInput(
                            controller: _passwordController,
                            label: 'Password',
                            hintText: 'Enter your password',
                            obscureText: true,
                          ),
                          const SizedBox(height: 25),

                          ElevatedButton.icon(
                            onPressed: loginState.isLoading
                                ? null
                                : () {
                                    loginNotifier.login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  },
                            icon: SvgPicture.asset('assets/icons/login.svg'),
                            label: Text(
                              loginState.isLoading ? 'Processing...' : 'Log in',
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
