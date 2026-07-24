import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/state/player_state.dart';
import 'package:go_router/go_router.dart';

class ExpiredGuestScreen extends ConsumerStatefulWidget {
  const ExpiredGuestScreen({super.key});

  @override
  ConsumerState<ExpiredGuestScreen> createState() => _ExpiredGuestScreenState();
}

class _ExpiredGuestScreenState extends ConsumerState<ExpiredGuestScreen> {
  @override
  void initState() {
    super.initState();
    // Guest session is over — stop any ongoing playback when this screen appears.
    // Post-frame so we don't mutate the provider during the first build.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(playerStateProvider.notifier).stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            // Background Image (Top half)
            Image.asset(
              'assets/images/login_bg.png',
              width: screenWidth,
              height: screenHeight * 0.7,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),

            // Main Content Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.only(top: DSSpacing.s20, bottom: 0),
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
                              Icon(Icons.alarm, color: DSColors.blue),
                              SizedBox(width: DSSpacing.s8),
                              Text('Time is up !', style: context.h2),
                            ],
                          ),

                          SizedBox(height: DSSpacing.s14),

                          Text(
                            'Time for using the app in guest mode is up. Please register or login to continue using the app.',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          SizedBox(height: 100),

                          // Registration Button
                          ElevatedButton.icon(
                            onPressed: () {
                              context.go('/registration-email');
                            },
                            icon: Icon(
                              Icons.person_rounded,
                              color: DSColors.lime,
                            ),
                            label: Text(
                              'Registration',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              padding: const EdgeInsets.symmetric(
                                vertical: DSSpacing.s14,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: DSSpacing.s14),

                          // Login Button
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: TextButton(
                              onPressed: () {
                                context.go('/login');
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: DSSpacing.s14,
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
                                    'assets/icons/login_blue.svg',
                                  ),
                                  const SizedBox(width: DSSpacing.s8),
                                  Text(
                                    'Login',
                                    style: context.subtitleLBold?.copyWith(
                                      color: DSColors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: DSSpacing.l),
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
