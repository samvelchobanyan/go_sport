import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/domain/state/user_state.dart';
import 'package:go_sport/features/user_profile/profile/presentation/widgets/action_row.dart';
import 'package:go_sport/features/user_profile/profile/presentation/widgets/contact_info.dart';
import 'package:go_sport/features/user_profile/profile/presentation/widgets/social_media_button.dart';
import 'package:go_sport/features/shared_widgets/dotted_divider.dart';
import 'package:go_sport/features/shared_widgets/user_avatar_button.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userStateProvider);

    ref.listen<UserState>(userStateProvider, (previous, next) {
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    final user = userState.user;

    // Error and no data — show error with retry
    if (userState.error != null && user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Failed to load profile', style: context.subtitleLSemi),
              const SizedBox(height: DSSpacing.s8),
              Text(
                userState.error!,
                style: context.textL?.copyWith(color: DSColors.gray60),
              ),
              const SizedBox(height: DSSpacing.m),
              ElevatedButton(
                onPressed: () => ref.read(userStateProvider.notifier).getUser(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // No data yet — initial frame or first load in progress
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: DSColors.blue)),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.blue10,
        appBar: AppBar(
          title: Text('Profile', style: context.h2),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => context.push(AppRoutes.notifications),
              icon: SvgPicture.asset('assets/icons/bell_blue.svg'),
            ),
            const SizedBox(width: DSSpacing.s8),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // Top Profile Section (Scrollable)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: DSSpacing.s20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: DSColors.white50, width: 12),
                    ),

                    child: UserAvatarButton(imageUrl: user.avatar, size: 100),
                  ),
                  const SizedBox(height: DSSpacing.s12),
                  Text(
                    '${user.name} ${user.surname}',
                    style: context.subtitleLBold?.copyWith(fontSize: 18),

                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DSSpacing.s8),
                  Text(
                    user.email,
                    style: context.textL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DSSpacing.xs),
                  Text(
                    user.phone != null
                        ? '+${user.phone}'
                        : 'Phone not available',
                    style: context.textL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: DSSpacing.l),
                ],
              ),
            ),

            // Bottom White Section
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(DSSpacing.m),
                  child: Column(
                    children: [
                      // Clickable Banner
                      GestureDetector(
                        onTap: () => context.push(AppRoutes.profileForBusiness),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(DSRadius.s),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/profile_banner.png',
                                width: double.infinity,
                                height: 64,
                                fit: BoxFit.cover,
                              ),

                              Padding(
                                padding: const EdgeInsets.all(DSSpacing.s10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/case_bg.svg',
                                    ),
                                    const SizedBox(width: DSSpacing.s14),
                                    Text(
                                      'Services for\nbusiness',
                                      style: context.h1?.copyWith(
                                        color: DSColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: DSColors.lime,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: DSSpacing.s14),

                      // Menu of actions
                      ActionRow(
                        icon: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          width: 32,
                        ),
                        text: 'Edit Profile',
                        onTap: () => context.push(AppRoutes.editProfile),
                      ),

                      if (user.provider != 'google')
                        Column(
                          children: [
                            ActionRow(
                              icon: SvgPicture.asset(
                                'assets/icons/lock_bg.svg',
                                width: 32,
                              ),
                              text: 'Change Password',
                              onTap: () =>
                                  context.push(AppRoutes.profileChangePassword),
                            ),
                          ],
                        ),

                      ActionRow(
                        icon: SvgPicture.asset(
                          'assets/icons/logout_bg.svg',
                          width: 32,
                        ),
                        text: 'Logout',
                        onTap: () async {
                          await ref.read(authProvider.notifier).logout();
                          if (context.mounted) context.go('/login');
                        },
                      ),

                      const SizedBox(height: DSSpacing.s14),
                      const DottedDivider(),
                      const SizedBox(height: DSSpacing.l),

                      // Contact Us Container
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          color: DSColors.blue5,
                          borderRadius: BorderRadius.circular(DSRadius.m),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Contact Us',
                              style: context.textL?.copyWith(
                                color: DSColors.blue,
                              ),
                            ),
                            const SizedBox(height: DSSpacing.s12),
                            ContactInfoItem(
                              icon: SvgPicture.asset(
                                'assets/icons/pin.svg',
                                width: 16,
                              ),
                              text: '0002 Yrevan, Hanrapetutyan street 4',
                            ),
                            const SizedBox(height: DSSpacing.s12),

                            ContactInfoItem(
                              icon: SvgPicture.asset(
                                'assets/icons/phone.svg',
                                width: 20,
                              ),
                              text: '+010 96 456 456',
                            ),
                            const SizedBox(height: DSSpacing.s12),

                            ContactInfoItem(
                              icon: SvgPicture.asset(
                                'assets/icons/email.svg',
                                width: 16,
                              ),
                              text: 'Info@gosport.fm',
                            ),
                            const SizedBox(height: DSSpacing.s12),

                            ContactInfoItem(
                              icon: SvgPicture.asset(
                                'assets/icons/world.svg',
                                width: 20,
                              ),
                              text: 'gosport.fm',
                            ),
                            const SizedBox(height: DSSpacing.l),

                            // Social Media Icons
                            Text(
                              'Social media',
                              style: context.textL?.copyWith(
                                color: DSColors.blue,
                              ),
                            ),
                            SizedBox(height: DSSpacing.s6),
                            Row(
                              children: [
                                SocialMediaButton(
                                  icon: const Icon(
                                    Icons.facebook,
                                    color: DSColors.blue,
                                  ),
                                  onTap: () => {},
                                ),
                                const SizedBox(width: DSSpacing.s10),
                                SocialMediaButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/youtube_blue.svg',
                                  ),
                                  onTap: () => {},
                                ),
                                const SizedBox(width: DSSpacing.s10),
                                SocialMediaButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/inst.svg',
                                  ),
                                  onTap: () => {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: DSSpacing.l),
                      DottedDivider(),
                      const SizedBox(height: DSSpacing.s14),
                      ActionRow(
                        icon: SvgPicture.asset(
                          'assets/icons/delete_orange_bg.svg',
                        ),
                        text: 'Delete Account',
                        onTap: () => context.push(AppRoutes.deleteAccount),
                      ),

                      const SizedBox(height: DSSpacing.l),
                    ],
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
