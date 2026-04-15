import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';

class RegistrationNameScreen extends ConsumerStatefulWidget {
  const RegistrationNameScreen({super.key});

  @override
  ConsumerState<RegistrationNameScreen> createState() =>
      _RegistrationNameScreenState();
}

class _RegistrationNameScreenState
    extends ConsumerState<RegistrationNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  Future<void> _onFinish() async {
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();

    if (name.isEmpty || surname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both fields')),
      );
      return;
    }

    await ref
        .read(registrationControllerProvider.notifier)
        .finalizeProfile(name: name, surname: surname);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isSuccess) {
        context.go('/');
      }
      if (next.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: DSColors.white,
        body: Stack(
          children: [
            // Background Image
            Image.asset(
              'assets/images/confirm_email_bg.png',
              width: screenWidth,
              height: screenHeight * 0.7,
              fit: BoxFit.cover,
              cacheHeight: (screenHeight * 0.7).toInt(),
              cacheWidth: screenWidth.toInt(),
            ),

            // Main Content Container
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenWidth,
                padding: const EdgeInsets.only(top: 20, bottom: 0),
                decoration: BoxDecoration(
                  color: DSColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(DSRadius.m),
                    topRight: Radius.circular(DSRadius.m),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header Row
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/user.svg'),
                              const SizedBox(width: 8),
                              Text('Your name and surname', style: context.h2),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            'Please use only letters, no numbers or special characters',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Name Input
                          CustomInput(
                            controller: _nameController,
                            label: 'Name',
                            hintText: 'Enter your name',
                            keyboardType: TextInputType.name,
                          ),

                          const SizedBox(height: 16),

                          // Surname Input
                          CustomInput(
                            controller: _surnameController,
                            label: 'Surname',
                            hintText: 'Enter your surname',
                            keyboardType: TextInputType.name,
                          ),

                          const SizedBox(height: 16),

                          // Continue Button
                          ElevatedButton.icon(
                            onPressed: _onFinish,
                            icon: const Icon(
                              Icons.check_circle,
                              color: DSColors.lime,
                            ),
                            label: Text(
                              'Finish',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xl,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
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
