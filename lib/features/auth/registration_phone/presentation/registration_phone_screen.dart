import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/design_system/foundations/ds_radius.dart';
import 'package:go_sport/design_system/foundations/ds_spacing.dart';
import 'package:go_sport/domain/state/registration_state.dart';
import 'package:go_sport/features/shared_widgets/input.dart';
import 'package:go_router/go_router.dart';

const double _cardHeight = 371;
const double _cardOverlap = 25;
const double _cardVerticalPadding = 40;

class RegistrationPhoneScreen extends ConsumerStatefulWidget {
  const RegistrationPhoneScreen({super.key});

  @override
  ConsumerState<RegistrationPhoneScreen> createState() =>
      _RegistrationPhoneScreenState();
}

class _RegistrationPhoneScreenState
    extends ConsumerState<RegistrationPhoneScreen> {
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    // Оставляем только цифры (клавиатура телефонная, но допускает + * # и т.п.).
    var phone = _phoneController.text.trim().replaceAll(RegExp(r'\D'), '');

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number cannot be empty')),
      );
      return;
    }

    // Нормализуем к национальному номеру: срезаем ведущий 0, затем код 374.
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    if (phone.startsWith('374')) {
      phone = phone.substring(3);
    }

    // Армянский мобильный — ровно 8 цифр. Иначе формат неверный.
    if (phone.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid phone number format')),
      );
      return;
    }

    ref
        .read(registrationControllerProvider.notifier)
        .registerPhone('374$phone');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final imageHeight = screenSize.height - _cardHeight + _cardOverlap;

    final state = ref.watch(registrationControllerProvider);

    ref.listen<RegistrationState>(registrationControllerProvider, (prev, next) {
      if (next.isPhoneSuccess) {
        context.go(AppRoutes.confirmPhone);
      }
      if (next.isSkipSuccess) {
        context.go(AppRoutes.createPassword);
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
                'assets/images/phone_registration_bg.png',
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.phone_in_talk_rounded,
                                color: DSColors.blue,
                              ),
                              SizedBox(width: DSSpacing.s8),
                              Text('Phone Number', style: context.h2),
                            ],
                          ),

                          SizedBox(height: DSSpacing.s10),
                          Text(
                            'We will send a one time password to your phone number via SMS',
                            style: context.bodyL?.copyWith(
                              color: DSColors.gray70,
                            ),
                          ),
                          SizedBox(height: DSSpacing.s20),

                          CustomInput(
                            controller: _phoneController,
                            label: 'Phone number',
                            hintText: 'Enter your phone number',
                            keyboardType: TextInputType.phone,
                            prefix: true,
                          ),

                          const Spacer(),

                          ElevatedButton.icon(
                            onPressed: state.isLoading ? null : _onContinue,
                            icon: state.isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: DSColors.white,
                                    ),
                                  )
                                : Icon(
                                    Icons.arrow_forward,
                                    color: DSColors.lime,
                                  ),
                            label: Text(
                              state.isLoading ? 'Processing...' : 'Continue',
                              style: context.subtitleLBold?.copyWith(
                                color: DSColors.lime,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: DSColors.blue,
                              minimumSize: const Size.fromHeight(DSSpacing.xxl),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  DSRadius.xxl,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: DSSpacing.s14),
                          SafeArea(
                            top: false,
                            right: false,
                            left: false,
                            child: TextButton(
                              onPressed: () {
                                ref
                                    .read(
                                      registrationControllerProvider.notifier,
                                    )
                                    .skipPhone();
                              },
                              style: TextButton.styleFrom(
                                side: BorderSide.none,
                              ),
                              child: Text(
                                'Skip',
                                style: context.subtitleLBold?.copyWith(
                                  color: DSColors.blue,
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
