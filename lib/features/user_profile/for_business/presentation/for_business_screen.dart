// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:go_sport/design_system/ds_extensions.dart';
// import 'package:go_sport/design_system/foundations/ds_colors.dart';
// import 'package:go_sport/design_system/foundations/ds_radius.dart';
// import 'package:go_sport/design_system/foundations/ds_spacing.dart';
// import 'package:go_sport/domain/state/business_services_state.dart';
// import 'package:go_sport/features/user_profile/for_business/presentation/widgets/service_card.dart';

// class ForBusinessScreen extends ConsumerStatefulWidget {
//   const ForBusinessScreen({super.key});

//   @override
//   ConsumerState<ForBusinessScreen> createState() => _ForBusinessScreenState();
// }

// class _ForBusinessScreenState extends ConsumerState<ForBusinessScreen> {
//   double appBarOpacity = 0;

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final servicesState = ref.watch(businessServicesStateProvider);
//     final topService = servicesState.services.firstWhereOrNull(
//       (s) => s.top == true,
//     );

//     // 2. Filter remaining services (exclude the single service rendered in the top blue container)
//     final remainingServices = servicesState.services
//         .where((s) => topService == null || s.id != topService.id)
//         .toList();
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.dark,
//       child: Scaffold(
//         backgroundColor: DSColors.white,
//         body: Stack(
//           children: [
//             /// 🔹 Background Image (Placed at top)
//             Image.asset(
//               'assets/images/bussiness.png',
//               width: screenWidth,
//               fit: BoxFit.cover,
//             ),
//             NotificationListener<ScrollNotification>(
//               onNotification: (scrollInfo) {
//                 if (scrollInfo.metrics.axis == Axis.vertical) {
//                   double offset = scrollInfo.metrics.pixels;
//                   double newOpacity = (offset / 250).clamp(0, 1);

//                   if (newOpacity != appBarOpacity) {
//                     setState(() {
//                       appBarOpacity = newOpacity;
//                     });
//                   }
//                 }
//                 return false;
//               },
//               child: RefreshIndicator(
//                 onRefresh: () => Future.wait([]),
//                 child: CustomScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   slivers: [
//                     /// 🔹 Floating / Sticky AppBar
//                     SliverAppBar(
//                       backgroundColor: DSColors.white.withValues(
//                         alpha: appBarOpacity,
//                       ),
//                       elevation: 0,
//                       pinned: true,
//                       floating: true,
//                       leading: IconButton(
//                         icon: const Icon(
//                           Icons.arrow_back,
//                           color: DSColors.black,
//                         ),
//                         onPressed: () => context.pop(),
//                       ),
//                       title: Text('For Business', style: context.h2),
//                       centerTitle: true,
//                     ),

//                     /// 🔹 Space on top of the image (Matches quick actions space in MusicScreen)
//                     SliverToBoxAdapter(
//                       child: SizedBox(
//                         height:
//                             180, // Adjust this height based on how much image you want visible
//                       ),
//                     ),

//                     /// 🔹 Rounded corners transition box (Same exact structure as MusicScreen)
//                     SliverToBoxAdapter(
//                       child: Container(
//                         decoration: const BoxDecoration(
//                           color: DSColors.white,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(DSRadius.m),
//                             topRight: Radius.circular(DSRadius.m),
//                           ),
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: const SizedBox(height: DSSpacing.m),
//                       ),
//                     ),

//                     /// 🔹 Blue Card Section (Inside DSColors.white background)
//                     SliverToBoxAdapter(
//                       child: Container(
//                         color: DSColors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: DSSpacing.m,
//                           vertical: DSSpacing.s20,
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(DSSpacing.m),
//                           decoration: BoxDecoration(
//                             color: DSColors.blue,
//                             borderRadius: BorderRadius.circular(DSRadius.m),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 children: [
//                                   SvgPicture.asset(
//                                     'assets/icons/bussiness_add.svg',
//                                   ),
//                                   const SizedBox(width: DSSpacing.s14),
//                                   Expanded(
//                                     child: Text(
//                                       'Գովազդ GO. spot հավելվածում',
//                                       style: context.h3?.copyWith(
//                                         color: DSColors.white,
//                                         fontWeight: FontWeight.w400,
//                                       ),
//                                     ),
//                                   ),
//                                   const Icon(
//                                     Icons.arrow_forward_ios,
//                                     color: DSColors.lime,
//                                     size: 16,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: DSSpacing.s10),
//                               Text(
//                                 'Ներկայացրեք Ձեր բրենդը օգտատերերին՝ անմիջապես այն միջավայրում, որտեղ նրանք լսում և օգտագործում են իրենց սիրելի բովանդակությունը։',
//                                 style: context.subtitleMBold?.copyWith(
//                                   fontWeight: FontWeight.w400,
//                                   color: DSColors.white,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// 🔹 Title Header
//                     SliverToBoxAdapter(
//                       child: Container(
//                         color: DSColors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: DSSpacing.m,
//                           // vertical: DSSpacing.s12,
//                         ),
//                         child: Text(
//                           'Ծառայություններ',
//                           style: context.h2?.copyWith(
//                             fontWeight: FontWeight.w400,
//                           ),
//                         ),
//                       ),
//                     ),

//                     /// 🔹 Services List Loading / Error / Content Rendering
//                     if (servicesState.isLoading &&
//                         servicesState.services.isEmpty)
//                       SliverToBoxAdapter(
//                         child: ColoredBox(
//                           color: DSColors.white,
//                           child: const Padding(
//                             padding: EdgeInsets.all(DSSpacing.xl),
//                             child: Center(child: CircularProgressIndicator()),
//                           ),
//                         ),
//                       )
//                     else if (servicesState.error != null &&
//                         servicesState.services.isEmpty)
//                       SliverToBoxAdapter(
//                         child: ColoredBox(
//                           color: DSColors.white,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: DSSpacing.m,
//                             ),
//                             child: Center(
//                               child: Text(
//                                 servicesState.error!,
//                                 style: context.bodyL?.copyWith(
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     else
//                       SliverToBoxAdapter(
//                         child: Container(
//                           color: DSColors.white,
//                           padding: const EdgeInsets.only(
//                             left: DSSpacing.m,
//                             right: DSSpacing.m,
//                             bottom: DSSpacing.xl,
//                           ),
//                           child: ListView.separated(
//                             padding: EdgeInsets.only(top: DSSpacing.s12),
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: servicesState.services.length,

//                             itemBuilder: (context, index) {
//                               final service = servicesState.services[index];
//                               return ServiceCard(service: service);
//                             },
//                             separatorBuilder: (context, index) =>
//                                 const SizedBox(height: DSSpacing.s8),
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/business_services_state.dart';
import 'package:go_sport/features/user_profile/for_business/presentation/widgets/service_card.dart';

class ForBusinessScreen extends ConsumerStatefulWidget {
  const ForBusinessScreen({super.key});

  @override
  ConsumerState<ForBusinessScreen> createState() => _ForBusinessScreenState();
}

class _ForBusinessScreenState extends ConsumerState<ForBusinessScreen> {
  double appBarOpacity = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final servicesState = ref.watch(businessServicesStateProvider);

    // 1. Find the FIRST service where top is true
    final topService = servicesState.services.firstWhereOrNull(
      (s) => s.top == true,
    );

    // 2. Filter remaining services (exclude the single service rendered in the top blue container)
    final remainingServices = servicesState.services
        .where((s) => topService == null || s.id != topService.id)
        .toList();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            /// 🔹 Background Image (Placed at top)
            Image.asset(
              'assets/images/bussiness.png',
              width: screenWidth,
              fit: BoxFit.cover,
            ),
            NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                if (scrollInfo.metrics.axis == Axis.vertical) {
                  double offset = scrollInfo.metrics.pixels;
                  double newOpacity = (offset / 250).clamp(0, 1);

                  if (newOpacity != appBarOpacity) {
                    setState(() {
                      appBarOpacity = newOpacity;
                    });
                  }
                }
                return false;
              },
              child: RefreshIndicator(
                onRefresh: () => Future.wait([]),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    /// 🔹 Floating / Sticky AppBar
                    SliverAppBar(
                      backgroundColor: DSColors.white.withValues(
                        alpha: appBarOpacity,
                      ),
                      elevation: 0,
                      pinned: true,
                      floating: true,
                      leading: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: DSColors.black,
                        ),
                        onPressed: () => context.pop(),
                      ),
                      title: Text('For Business', style: context.h2),
                      centerTitle: true,
                    ),

                    /// 🔹 Space on top of the image
                    const SliverToBoxAdapter(child: SizedBox(height: 180)),

                    /// 🔹 Rounded corners transition box
                    SliverToBoxAdapter(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: DSColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(DSRadius.m),
                            topRight: Radius.circular(DSRadius.m),
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: const SizedBox(height: DSSpacing.s20),
                      ),
                    ),

                    /// 🔹 Dynamic Blue Card Section (Shows ONLY if topService exists)
                    if (topService != null)
                      SliverToBoxAdapter(
                        child: Container(
                          color: DSColors.white,
                          padding: const EdgeInsets.only(
                            right: DSSpacing.m,
                            left: DSSpacing.m,
                            bottom: DSSpacing.s20,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context.push(
                                '/profile/for-business/${topService.documentId}',
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(DSSpacing.m),
                              decoration: BoxDecoration(
                                color: DSColors.blue,
                                borderRadius: BorderRadius.circular(DSRadius.m),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.network(
                                        topService.iconUrl ?? '',
                                        width: 22,
                                        height: 22,
                                        fit: BoxFit.cover,
                                        placeholderBuilder: (context) =>
                                            Image.asset(
                                              'assets/images/noimage.png',
                                              width: 22,
                                              height: 22,
                                            ),
                                      ),
                                      const SizedBox(width: DSSpacing.s14),
                                      Expanded(
                                        child: Text(
                                          topService.name,
                                          style: context.h3?.copyWith(
                                            color: DSColors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const Icon(
                                        Icons.arrow_forward_ios,
                                        color: DSColors.lime,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  if (topService.teaser != null &&
                                      topService.teaser!.isNotEmpty) ...[
                                    const SizedBox(height: DSSpacing.s10),
                                    Text(
                                      topService.teaser!,
                                      style: context.subtitleMBold?.copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: DSColors.white,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    /// 🔹 Title Header
                    SliverToBoxAdapter(
                      child: Container(
                        color: DSColors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: DSSpacing.m,
                        ),
                        child: Text(
                          'Ծառայություններ',
                          style: context.h2?.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),

                    /// 🔹 Services List Loading / Error / Content Rendering
                    if (servicesState.isLoading &&
                        servicesState.services.isEmpty)
                      SliverToBoxAdapter(
                        child: ColoredBox(
                          color: DSColors.white,
                          child: const Padding(
                            padding: EdgeInsets.all(DSSpacing.xl),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                        ),
                      )
                    else if (servicesState.error != null &&
                        servicesState.services.isEmpty)
                      SliverToBoxAdapter(
                        child: ColoredBox(
                          color: DSColors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: DSSpacing.m,
                            ),
                            child: Center(
                              child: Text(
                                servicesState.error!,
                                style: context.bodyL?.copyWith(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      SliverToBoxAdapter(
                        child: Container(
                          color: DSColors.white,
                          padding: const EdgeInsets.only(
                            left: DSSpacing.m,
                            right: DSSpacing.m,
                            bottom: DSSpacing.xl,
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: DSSpacing.s12),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: remainingServices.length,
                            itemBuilder: (context, index) {
                              final service = remainingServices[index];
                              return ServiceCard(service: service);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: DSSpacing.s8),
                          ),
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
