import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/design_system/ds_extensions.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'package:go_sport/features/shared_widgets/user_avatar_button.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userName = authState.maybeWhen(
      authenticated: (name, avatarUrl) => name.isEmpty ? 'Profile' : name,
      orElse: () => 'Profile',
    );
    final avatarUrl = authState.maybeWhen(
      authenticated: (name, avatarUrl) => avatarUrl.isEmpty ? null : avatarUrl,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: DSColors.white,
      appBar: AppBar(
        title: Text('Profile', style: context.h2),
        centerTitle: true,
      ),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Center(
                child: UserAvatarButton(
                  imageUrl: avatarUrl,
                  size: 88,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                userName,
                style: context.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your session here',
                style: context.bodyL?.copyWith(color: DSColors.gray60),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    await ref.read(authProvider.notifier).logout();
                    if (context.mounted) {
                      context.go(AppRoutes.login);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DSColors.black,
                    foregroundColor: DSColors.white,
                  ),
                  child: Text('Logout', style: context.fieldLabel),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}