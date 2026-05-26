import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/domain/state/user_state.dart';

class DeleteScreen extends ConsumerStatefulWidget {
  const DeleteScreen({super.key});

  @override
  ConsumerState<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends ConsumerState<DeleteScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final userState = ref.watch(userStateProvider);

    ref.listen<UserState>(userStateProvider, (previous, next) {
      if (next.isDeleted && !(previous?.isDeleted ?? false)) {
        context.push(AppRoutes.deleteSuccess);
      }
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    confirmDelete() {
      if (userState.user?.provider == 'local') {
        context.push(AppRoutes.confirmDeleteAccount);
      } else {
        ref.read(userStateProvider.notifier).deleteGoogleUser();
      }
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Delete Account', style: context.h2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/delete_profile.png',
              width: screenWidth,
              height: screenHeight * 0.5,
              fit: BoxFit.cover,
              cacheHeight: (screenHeight * 0.5).toInt(),
              cacheWidth: screenWidth.toInt(),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: screenHeight * 0.6,
                width: screenWidth,
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 33,
                ),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Are you sure you want \nto delete your account?',
                      style: context.subtitleLBold?.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 13),

                    Text(
                      'All your data, favorite artists, albums, \nplaylists, songs and programs will be \ndeleted.  It won’t be possible \nto recover your data.',
                      style: context.bodyL?.copyWith(color: DSColors.gray80),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(),

                    // If user.provider=google then redirect to google login, if its local then redirect to confirm delete screen
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: SvgPicture.asset('assets/icons/delete_white.svg'),
                        label: Text(
                          "Yes, delete my account",
                          style: context.subtitleLBold?.copyWith(
                            color: DSColors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DSColors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DSRadius.xl),
                          ),
                        ),
                        onPressed: userState.isLoading
                            ? null
                            : () => confirmDelete(),
                      ),
                    ),
                    SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DSColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DSRadius.xl),
                          ),
                        ),
                        onPressed: () => context.pop(),
                        child: Text(
                          "No, keep my account",
                          style: context.subtitleLBold?.copyWith(
                            color: DSColors.lime,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
