import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/user.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

part 'profile_controller.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
    User? user,
  }) = _ProfileState;
}

class ProfileController extends AutoDisposeNotifier<ProfileState> {
  late final ProfileRepository _profileRepository;

  @override
  ProfileState build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
    Future.microtask(() => getUser());
    return const ProfileState();
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(authProvider.notifier).logout();

      state = state.copyWith(
        isLoading: false,
        error: null,
        isAuthenticated: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Logout failed. Please try again.",
      );
    }
  }

  Future<void> getUser() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final userData = await _profileRepository.getUser();

      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: userData,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load profile data.",
      );
    }
  }

  Future<void> deleteUser() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await _profileRepository.deleteUser();

      state = state.copyWith(isLoading: false, isAuthenticated: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to load profile data.",
      );
    }
  }
}

final profileControllerProvider =
    NotifierProvider.autoDispose<ProfileController, ProfileState>(
      ProfileController.new,
    );
