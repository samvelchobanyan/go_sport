// not used for now

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_typography.dart';
import 'package:go_sport/features/user_profile/for_business/presentation/widgets/service_card.dart';

class ForBusinessScreen extends StatelessWidget {
  const ForBusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        appBar: AppBar(
          backgroundColor: DSColors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
          title: Text('For Business', style: context.h2),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(DSSpacing.m),
            child: Column(
              children: [
                // Banner
                GestureDetector(
                  onTap: () => {
                    //todo open bottom modal
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(DSRadius.s),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/for_business_banner.png',
                          width: double.infinity,
                          height: 64,
                          fit: BoxFit.cover,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(DSSpacing.s10),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/icons/phone_lime.svg'),
                              const SizedBox(width: DSSpacing.s14),
                              Text(
                                'How can we \nreach you ?',
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
                const SizedBox(height: DSSpacing.l),

                // Services Cards
                Text('Services', style: DSTypography.h2),
                SizedBox(height: DSSpacing.s10),
                const ServiceCard(
                  title: 'Premium Subscription',
                  description:
                      'Unlock exclusive content and premium features for your business',
                  price: '\$99/month',
                ),
                const SizedBox(height: DSSpacing.m),
                const ServiceCard(
                  title: 'Analytics Dashboard',
                  description:
                      'Get detailed insights and analytics for your content',
                  price: '\$49/month',
                ),
                const SizedBox(height: DSSpacing.m),
                const ServiceCard(
                  title: 'Custom Branding',
                  description:
                      'Customize your brand with white-label solutions',
                  price: '\$199/month',
                ),
                const SizedBox(height: DSSpacing.m),
                const ServiceCard(
                  title: 'Priority Support',
                  description: '24/7 dedicated support team for your business',
                  price: '\$29/month',
                ),
                const SizedBox(height: DSSpacing.l),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
