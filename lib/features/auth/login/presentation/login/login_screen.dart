import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/features/auth/login/presentation/login/login_controller.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final loginState = ref.watch(loginControllerProvider);
    final loginNotifier = ref.read(loginControllerProvider.notifier);

    ref.listen<LoginState>(loginControllerProvider, (previous, next) {
      if (next.isAuthenticated) {
        context.go('/'); // Navigate to home
      }
      // if (next.error != null) {
      //   ScaffoldMessenger.of(
      //     context,
      //   ).showSnackBar(SnackBar(content: Text(next.error!)));
      // }

      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(
          context,
        ).hideCurrentSnackBar(); // Clear any previous snackbar
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
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Background image — fills the remaining space above the
                    // form, plus 20px that overflow behind the card's rounded
                    // top corners so they reveal the image (Clip.none).
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: -20,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/login_bg.png',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Main Content Container
                    Container(
                      width: screenWidth,
                      padding: const EdgeInsets.only(
                        top: DSSpacing.s20,
                        bottom: 0,
                      ),
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
                            padding: const EdgeInsets.symmetric(
                              horizontal: DSSpacing.m,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/login_blue.svg',
                                    ),
                                    SizedBox(width: DSSpacing.s8),
                                    Text('Login', style: context.h2),
                                  ],
                                ),

                                SizedBox(height: DSSpacing.m),

                                // Email Input
                                CustomInput(
                                  label: 'Email',
                                  hintText: 'Enter your email',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                const SizedBox(height: DSSpacing.m),

                                // Password Input
                                CustomInput(
                                  controller: _passwordController,
                                  label: 'Password',
                                  hintText: 'Enter your password',
                                  obscureText: true,
                                ),

                                // const SizedBox(height: DSSpacing.xs),

                                // Forgot Password
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      context.go('/forgot-password');
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: context.subtitleMBold?.copyWith(
                                        color: DSColors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: DSSpacing.s14),

                                // Login Button
                                ElevatedButton.icon(
                                  onPressed: loginState.isLoading
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();

                                          loginNotifier.login(
                                            _emailController.text,
                                            _passwordController.text,
                                          );
                                        },
                                  icon: SvgPicture.asset(
                                    'assets/icons/login.svg',
                                  ),
                                  label: Text(
                                    loginState.isLoading
                                        ? 'Processing...'
                                        : 'Log in',
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
                                const SizedBox(height: DSSpacing.s14),

                                // Google Login Button
                                TextButton(
                                  onPressed: loginState.isLoading
                                      ? null
                                      : () {
                                          FocusScope.of(context).unfocus();
                                          loginNotifier.loginWithGoogle();
                                        },
                                  style: TextButton.styleFrom(
                                    minimumSize: const Size.fromHeight(
                                      DSSpacing.xxl,
                                    ),
                                    backgroundColor: DSColors.blue5,
                                    // This ensures no border is drawn
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

                                const SizedBox(height: DSSpacing.s20),

                                // Sign Up Row
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account?",
                                      style: context.bodyL?.copyWith(
                                        color: DSColors.gray50,
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () {
                                        context.go('/registration-email');
                                      },
                                      icon: Icon(
                                        Icons.person_rounded,
                                        color: DSColors.blue,
                                      ),
                                      label: Text(
                                        'Sign Up',
                                        style: context.subtitleMBold?.copyWith(
                                          color: DSColors.blue,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        minimumSize: Size
                                            .zero, // Removes extra default padding
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: DSSpacing.xl),

                          // Continue as Guest
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: SizedBox(
                              height: DSSpacing.xxl,
                              width: screenWidth,
                              child: TextButton(
                                onPressed: () {
                                  // Sets both the persisted choseGuest flag (for the
                                  // router) and the AuthGuest state (for the guest bar).
                                  ref
                                      .read(authProvider.notifier)
                                      .continueAsGuest();

                                  context.go('/');
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: DSColors.blue5,
                                  padding: EdgeInsets.symmetric(
                                    vertical: DSSpacing.s8,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                child: Text(
                                  'Continue as guest',
                                  style: context.subtitleMBold?.copyWith(
                                    color: DSColors.blue,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
