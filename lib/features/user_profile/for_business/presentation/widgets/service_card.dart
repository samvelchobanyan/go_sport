import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/domain/entities/business_service.dart';
import 'package:go_router/go_router.dart';

class ServiceCard extends StatelessWidget {
  final BusinessService service;

  const ServiceCard({super.key, required this.service});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/profile/for-business/${service.documentId}');
      },
      child: Container(
        padding: const EdgeInsets.all(DSSpacing.m),
        decoration: BoxDecoration(
          // Using a subtle background with your DS Blue
          color: DSColors.blue10,
          borderRadius: BorderRadius.circular(DSRadius.s),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.network(
                  service.iconUrl ?? '',
                  width: 22,
                  height: 22,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Image.asset(
                    'assets/images/noimage.png',
                    width: 22,
                    height: 22,
                  ),
                ),
                SizedBox(width: DSSpacing.s8),
                Expanded(
                  child: Text(service.name, style: context.subtitleLBold),
                ),
                SvgPicture.asset(
                  'assets/icons/arrow_right.svg',
                  width: 20,
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
