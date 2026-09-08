import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/business_services_state.dart';
import 'package:go_sport/features/favorites/presentation/my_albums/my_albums_controller.dart';
import 'package:go_sport/features/shared_widgets/social_media_section.dart';
import 'package:go_sport/features/user_profile/for_business/presentation/widgets/single_service_header.dart';
import 'package:go_sport/features/user_profile/profile/presentation/profile/profile_controller.dart';
import 'package:go_sport/features/user_profile/profile/presentation/widgets/contact_info.dart';

class SingleServiceScreen extends ConsumerWidget {
  final String serviceId;
  const SingleServiceScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albums = ref.watch(myAlbumsStateProvider).albums;
    final service = ref
        .read(businessServicesStateProvider.notifier)
        .getServiceById(serviceId);

    if (service == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final socialLinksState = ref.watch(socialLinksControllerProvider);
    final socialLinks = socialLinksState.socialLinks;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.blue10,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top section with background image and header
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/mine_cover.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: SingleServiceHeader(
                      iconPath: service.iconUrl ?? '',
                      title: service.name,
                      itemCount: albums.length,
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable white card body
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                decoration: const BoxDecoration(
                  color: DSColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: DSSpacing.l),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subtitle / Teaser Quote
                    if (service.teaser != null &&
                        service.teaser!.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DSSpacing.l,
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: DSColors.blue, width: 3),
                            ),
                          ),
                          padding: const EdgeInsets.only(left: DSSpacing.m),
                          child: Text(
                            service.teaser!,
                            style: context.subtitleM,
                          ),
                        ),
                      ),
                      const SizedBox(height: DSSpacing.l),
                    ],

                    // Paragraph Content List
                    ...service.paragraphs.map(
                      (paragraph) => Padding(
                        padding: const EdgeInsets.only(
                          left: DSSpacing.l,
                          right: DSSpacing.l,
                          bottom: DSSpacing.m,
                        ),
                        child: Text(
                          paragraph['Body'] as String? ?? '',
                          style: context.bodyL?.copyWith(
                            height: 1.6,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    if (service.social != null && socialLinks != null)
                      SizedBox(height: DSSpacing.s8),
                    if (service.social != null && socialLinks != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DSSpacing.l,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: DSColors.blue5,
                            borderRadius: BorderRadius.circular(DSRadius.m),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ինտեգրացիաների հնարավորություն կա նաև մեր սոցիալական հարթակներում',
                                style: context.textL?.copyWith(
                                  color: DSColors.blue,
                                ),
                              ),
                              SizedBox(height: DSSpacing.s8),
                              SocialMediaSection(socialLinks: socialLinks),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(height: DSSpacing.l),

                    if ((service.phone != null &&
                            service.phone!.trim().isNotEmpty) ||
                        (service.email != null &&
                            service.email!.trim().isNotEmpty)) ...[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: DSSpacing.l,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 22,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: DSColors.blue5,
                            borderRadius: BorderRadius.circular(DSRadius.m),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Լրացուցիչ տեղեկության համար',
                                style: context.textL?.copyWith(
                                  color: DSColors.blue,
                                ),
                              ),
                              if (service.phone != null &&
                                  service.phone!.trim().isNotEmpty) ...[
                                const SizedBox(height: DSSpacing.s12),
                                ContactInfoItem(
                                  icon: SvgPicture.asset(
                                    'assets/icons/phone.svg',
                                    width: 20,
                                  ),
                                  text: service.phone!,
                                ),
                              ],
                              if (service.email != null &&
                                  service.email!.trim().isNotEmpty) ...[
                                const SizedBox(height: DSSpacing.s12),
                                ContactInfoItem(
                                  icon: SvgPicture.asset(
                                    'assets/icons/email.svg',
                                    width: 16,
                                  ),
                                  text: service.email!,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ],
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
