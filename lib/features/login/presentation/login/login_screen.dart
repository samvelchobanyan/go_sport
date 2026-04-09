import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            // Background Image (Top half)
            Image.asset(
              'assets/images/login_bg.png',
              width: screenWidth,
              height: screenHeight * 0.6,
              fit: BoxFit.cover,
            ),

            // Main Content Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.5, // Adjust height as needed
                width: screenWidth,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
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
                              SizedBox(width: 8),
                              Text('Login', style: context.h2),
                            ],
                          ),

                          SizedBox(height: 20),

                          // Email Input
                          const CustomInput(
                            label: 'Email',
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                          ),

                          const SizedBox(height: 14),

                          // Password Input
                          const CustomInput(
                            label: 'Password',
                            hintText: 'Enter your password',
                            obscureText: true,
                          ),

                          // Forgot Password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {}, // TODO: Forgot Password logic
                              child: Text(
                                'Forgot Password?',
                                style: context.subtitleMBold?.copyWith(
                                  color: DSColors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Login Button
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/icons/login.svg'),
                            label: Text(
                              'Log in',
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
                            onPressed: () {},
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

                          const SizedBox(height: 16),

                          // Sign Up Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: context.label?.copyWith(
                                  color: DSColors.gray50,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  context.push('/registration');
                                },
                                icon: SvgPicture.asset('assets/icons/user.svg'),
                                label: Text(
                                  'Sign Up',
                                  style: context.textL?.copyWith(
                                    color: DSColors.blue,
                                    fontWeight: FontWeight.bold,
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

                    Spacer(),
                    // Continue as Guest
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: DSColors.blue.withOpacity(0.05),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: Text(
                        'Continue as guest',
                        style: context.textL?.copyWith(color: DSColors.blue),
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
