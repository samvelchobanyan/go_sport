import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/features/user_profile/confirm_delete/presentation/confirm_delete/confirm_delete_controller.dart';

const double _cardHeight = 430;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

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
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

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
        context.push(AppRoutes.deleteSuccess);
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
              height: imageHeight,
              child: Image.asset(
                'assets/images/confirm_delete.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: _cardHeight,
                width: screenSize.width,
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
                    vertical: _cardVerticalPadding / 2,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: _cardHeight - _cardVerticalPadding,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Please enter your password \nto delete your account',
                            style: context.subtitleLBold?.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: DSSpacing.s12),

                          CustomInput(
                            label: 'Password',
                            controller: _passwordController,
                            obscureText: true,
                          ),

                          const Spacer(),

                          // Action Button
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              minimumSize: const Size.fromHeight(DSSpacing.xxl),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(DSRadius.xxl),
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
                        ],
                      ),
                    ),
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
