import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/user_profile/profile/presentation/profile/profile_controller.dart';
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
    final profileState = ref.watch(profileControllerProvider);
    final profileNotifier = ref.read(profileControllerProvider.notifier);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.blue.withOpacity(0.1),
        appBar: AppBar(
          title: Text('Profile', style: context.h2),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () => {},
              icon: SvgPicture.asset('assets/icons/bell_blue.svg'),
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            // Top Profile Section (Scrollable)
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: DSColors.white, width: 12),
                    ),
                    child: const UserAvatarButton(imageUrl: null, size: 100),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Alexandr Hovhannisyan',
                    style: context.bodyL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'alexandr.hovhannisyan@gmail.com',
                    style: context.textL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+98522365622',
                    style: context.textL,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
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
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Clickable Banner
                      GestureDetector(
                        onTap: () => context.push('/profile/for-business'),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/case_bg.svg',
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      'Services for\nbusiness',
                                      style: context.h1?.copyWith(
                                        color: Colors.white,
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
                      const SizedBox(height: 24),

                      // Menu of actions
                      ActionRow(
                        icon: SvgPicture.asset('assets/icons/edit.svg'),
                        text: 'Edit Profile',
                        onTap: () => context.push('/profile/edit-profile'),
                      ),

                      const SizedBox(height: 12),

                      ActionRow(
                        icon: SvgPicture.asset('assets/icons/lock_bg.svg'),
                        text: 'Change Password',
                        onTap: () => {},
                      ),

                      const SizedBox(height: 12),

                      ActionRow(
                        icon: SvgPicture.asset('assets/icons/logout_bg.svg'),
                        text: 'Logout',
                        onTap: () => {profileNotifier.logout()},
                      ),
                      const SizedBox(height: 24),

                      const DottedDivider(),
                      const SizedBox(height: 24),

                      // Contact Us Container
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          color: DSColors.blue.withOpacity(0.05),
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
                            const SizedBox(height: 12),
                            ContactInfoItem(
                              icon: Icons.location_on_sharp,
                              text: '123 Sport Ave, Yerevan',
                            ),
                            const SizedBox(height: 12),

                            ContactInfoItem(
                              icon: Icons.phone_in_talk_rounded,
                              text: '+374 00 000 000',
                            ),
                            const SizedBox(height: 12),

                            ContactInfoItem(
                              icon: Icons.email_rounded,
                              text: 'support@gosport.com',
                            ),
                            const SizedBox(height: 12),

                            ContactInfoItem(
                              icon: Icons.language,
                              text: 'www.gosport.am',
                            ),
                            const SizedBox(height: 24),

                            // Social Media Icons
                            Text(
                              'Social media',
                              style: context.textL?.copyWith(
                                color: DSColors.blue,
                              ),
                            ),
                            SizedBox(height: 6),
                            Row(
                              children: [
                                SocialMediaButton(
                                  icon: const Icon(
                                    Icons.facebook,
                                    color: DSColors.blue,
                                  ),
                                  onTap: () => {},
                                ),
                                const SizedBox(width: 10),
                                SocialMediaButton(
                                  icon: SvgPicture.asset(
                                    'assets/icons/youtube_blue.svg',
                                  ),
                                  onTap: () => {},
                                ),
                                const SizedBox(width: 10),
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
                      const SizedBox(height: 24),
                      DottedDivider(),
                      const SizedBox(height: 24),
                      ActionRow(
                        icon: SvgPicture.asset(
                          'assets/icons/delete_orange_bg.svg',
                        ),
                        text: 'Delete Account',
                        onTap: () => {},
                      ),

                      const SizedBox(height: 24),
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
