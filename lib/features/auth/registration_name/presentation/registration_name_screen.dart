import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';

const double _cardHeight = 371;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

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
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isNameSuccess) {
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
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: imageHeight,
              child: Image.asset(
                'assets/images/registration_name.png',
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
                  padding: EdgeInsets.symmetric(
                    horizontal: DSSpacing.m,
                    vertical: _cardVerticalPadding / 2,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: _cardHeight - _cardVerticalPadding,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset('assets/icons/user.svg'),
                              const SizedBox(width: DSSpacing.s8),
                              Text('Your name and surname', style: context.h2),
                            ],
                          ),
                          const SizedBox(height: DSSpacing.s14),
                          Text(
                            'Please use only letters, no numbers or special characters',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),

                          const SizedBox(height: DSSpacing.s20),

                          CustomInput(
                            controller: _nameController,
                            label: 'Name',
                            hintText: 'Enter your name',
                            keyboardType: TextInputType.name,
                          ),

                          const SizedBox(height: DSSpacing.m),

                          CustomInput(
                            controller: _surnameController,
                            label: 'Surname',
                            hintText: 'Enter your surname',
                            keyboardType: TextInputType.name,
                          ),

                          const Spacer(),
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: ElevatedButton.icon(
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
                                minimumSize: const Size.fromHeight(
                                  DSSpacing.xxl,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    DSRadius.xxl,
                                  ),
                                ),
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
