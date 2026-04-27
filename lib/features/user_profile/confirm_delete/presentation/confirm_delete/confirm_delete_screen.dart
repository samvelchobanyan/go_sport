import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/confirm_delete/presentation/confirm_delete/confirm_delete_controller.dart';

class ConfirmDeleteScreen extends ConsumerStatefulWidget {
  const ConfirmDeleteScreen({super.key});

  @override
  ConsumerState<ConfirmDeleteScreen> createState() =>
      _ConfirmDeleteScreenState();
}

class _ConfirmDeleteScreenState extends ConsumerState<ConfirmDeleteScreen> {
  // New Controllers for password flow
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _passwordController.dispose();

    super.dispose();
  }

  Future<void> deleteUser() async {
    await ref
        .read(deleteUserControllerProvider.notifier)
        .deleteUser(password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deleteUserControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    ref.listen<ConfirmDeleteState>(deleteUserControllerProvider, (
      previous,
      next,
    ) {
      if (next.error != null && next.error != previous?.error) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }

      if (next.isSuccess && !(previous?.isSuccess ?? false)) {
        context.push('/profile/delete-success');
      }
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Delete Account', style: context.h2),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => context.pop(),
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/confirm_delete.png',
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please enter your password \nto delete your account',
                      style: context.subtitleLBold?.copyWith(fontSize: 18),
                      textAlign: TextAlign.center,

                    ),
                    const SizedBox(height: 13),

                    CustomInput(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: true,
                    ),

                    const Spacer(),

                    // Action Button
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
                        onPressed: state.isLoading ? null : () => deleteUser(),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: DSColors.lime,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "Confirm",
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
