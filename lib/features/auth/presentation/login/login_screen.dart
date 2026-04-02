import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/auth/presentation/login/login_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (prev, next) {
      next.whenOrNull(
        success: () => context.go(AppRoutes.home),
        error: (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        ),
      );
    });

    return Scaffold(
      backgroundColor: DSColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Go Sport',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: DSColors.black,
                ),
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: state.maybeWhen(
                    loading: () => null,
                    orElse: () => () {
                      ref.read(loginControllerProvider.notifier).login(
                            identifier: 'chelovek84@yahoo.com',
                            password: 'Asdf1234!',
                          );
                    },
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DSColors.black,
                    foregroundColor: DSColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.maybeWhen(
                    loading: () => const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: DSColors.white,
                        strokeWidth: 2,
                      ),
                    ),
                    orElse: () => const Text('Войти'),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => context.go(AppRoutes.home),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: DSColors.black,
                    side: const BorderSide(color: DSColors.black),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Пропустить'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
