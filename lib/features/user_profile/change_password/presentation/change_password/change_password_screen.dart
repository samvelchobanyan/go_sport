import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/change_password/presentation/change_password/change_password_controller.dart';

// const double _cardHeight = 600;
// const double _cardOverlap = 25;
// const double _cardVerticalPadding = 40;

class ProfileChangePasswordScreen extends ConsumerStatefulWidget {
  const ProfileChangePasswordScreen({super.key});

  @override
  ConsumerState<ProfileChangePasswordScreen> createState() =>
      _ProfileChangePasswordScreenState();
}

class _ProfileChangePasswordScreenState
    extends ConsumerState<ProfileChangePasswordScreen> {
  // New Controllers for password flow
  late final TextEditingController _oldPasswordController;
  late final TextEditingController _newPasswordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New passwords do not match')),
      );
      return;
    }

    await ref
        .read(changePasswordControllerProvider.notifier)
        .changePassword(
          currentPassword: _oldPasswordController.text,
          password: _newPasswordController.text,
          passwordConfirmation: _confirmPasswordController.text,
        );

    // if (mounted && ref.read(changePasswordControllerProvider).error == null) {
    //   context.pop();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(changePasswordControllerProvider);
    // final screenSize = MediaQuery.of(context).size;
    // final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    ref.listen<ChangePasswordState>(changePasswordControllerProvider, (
      previous,
      next,
    ) {
      // Handle Errors from the controller/API
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }

      // Handle Success
      if (next.isSuccess && next.isSuccess != previous?.isSuccess) {
        context.pop();
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Change Password', style: context.h2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: DSColors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              // height: imageHeight,
              child: Image.asset(
                'assets/images/change_password.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: DSSpacing.s20),
                // height: _cardHeight,
                // width: screenSize.width,
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DSSpacing.m,
                    // vertical: _cardVerticalPadding / 2,
                  ),
                  // child: ConstrainedBox(
                  //   constraints: const BoxConstraints(
                  //     minHeight: _cardHeight - _cardVerticalPadding,
                  //   ),
                  child:
                      // IntrinsicHeight(
                      //   child:
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Your password must contain at least one special character',
                            style: context.subtitleMBold?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          const SizedBox(height: DSSpacing.m),

                          CustomInput(
                            label: 'Old password',
                            controller: _oldPasswordController,
                            obscureText: true,
                          ),
                          const SizedBox(height: DSSpacing.m),
                          CustomInput(
                            label: 'New password',
                            controller: _newPasswordController,
                            obscureText: true,
                          ),
                          const SizedBox(height: DSSpacing.m),
                          CustomInput(
                            label: 'Repeat new password',
                            controller: _confirmPasswordController,
                            obscureText: true,
                          ),

                          // const Spacer(),
                          const SizedBox(height: DSSpacing.l),

                          // Action Button
                          SafeArea(
                            top: false, 
                            left: false, 
                            right: false,
                            child: ElevatedButton.icon(
                              icon: state.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        color: DSColors.lime,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : SvgPicture.asset(
                                      'assets/icons/check_lime.svg',
                                    ),
                              label: Text(
                                "Change Password",
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
                              onPressed: state.isLoading ? null : _onSave,
                            ),
                          ),
                        ],
                      ),
                ),
                // ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
