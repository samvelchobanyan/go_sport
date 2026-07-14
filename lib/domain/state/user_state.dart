import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/user.dart';
import '../repositories/profile_repository.dart';
import '../../core/auth/auth_state.dart';
import '../../core/auth/google_auth_service.dart';
import '../../core/di/auth_providers.dart';
import '../../core/di/repository_providers.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    User? user,
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isDeleted,
  }) = _UserState;
}

class UserNotifier extends Notifier<UserState> {
  late ProfileRepository _repository;
  late GoogleAuthService _googleAuthService;

  @override
 
  UserState build() {
    _repository = ref.watch(profileRepositoryProvider);
    _googleAuthService = ref.watch(googleAuthServiceProvider);

    // 1. Read the auth state to see if we should fetch data on startup/rebuild
    final authState = ref.watch(authProvider);

    if (authState is AuthAuthenticated) {
      Future.microtask(() => getUser());
      return const UserState(isLoading: true);
    }

    // Default state for Guests or Unauthorized users (no automatic fetch!)
    return const UserState();
  }

  Future<void> getUser() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await _repository.getUser();
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to load profile data.',
      );
    }
  }

  Future<void> deleteUser({required String password}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _repository.deleteUser(password: password);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete user.');
    }
  }

  Future<void> deleteGoogleUser() async {
    state = state.copyWith(isLoading: true, error: null, isDeleted: false);

    try {
      final accessToken = await _googleAuthService.signInAndGetAccessToken();
      if (accessToken == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      await _repository.deleteUserWithGoogle(accessToken: accessToken);
      await ref.read(authProvider.notifier).logout();
      state = state.copyWith(isLoading: false, isDeleted: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Failed to delete user.');
    }
  }

  resetUser() {
    state = state.copyWith(
      isLoading: false,
      isDeleted: false,
      user: null,
      error: null,
    );
  }
}

final userStateProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
