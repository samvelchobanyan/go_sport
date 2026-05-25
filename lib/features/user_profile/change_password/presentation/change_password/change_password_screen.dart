import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/change_password/presentation/change_password/change_password_controller.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
            Image.asset(
              'assets/images/change_password.png',
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
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your password must contain at least one special character',
                      style: context.subtitleMBold?.copyWith(
                        color: DSColors.gray70,
                      ),
                    ),
                    const SizedBox(height: 16),

                    CustomInput(
                      label: 'Old password',
                      controller: _oldPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: 'New password',
                      controller: _newPasswordController,
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    CustomInput(
                      label: 'Repeat new password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                    ),

                    const Spacer(),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
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
                            : SvgPicture.asset('assets/icons/check_lime.svg'),
                        label: Text(
                          "Change Password",
                          style: context.subtitleLBold?.copyWith(
                            color: DSColors.lime,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DSColors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(DSRadius.xl),
                          ),
                        ),
                        onPressed: state.isLoading ? null : _onSave,
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
