import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'profile_controller.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
  }) = _ProfileState;
}

class ProfileController extends AutoDisposeNotifier<ProfileState> {
  late final AuthRepository _authRepository;

  @override
  ProfileState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const ProfileState();
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      await ref.read(authProvider.notifier).logout();

      state = state.copyWith(isLoading: false, isAuthenticated: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Logout failed. Please try again.",
      );
    }
  }
}

final profileControllerProvider =
    NotifierProvider.autoDispose<ProfileController, ProfileState>(
      ProfileController.new,
    );
