import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

part 'edit_profile_controller.freezed.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
  }) = _EditProfileState;
}

class EditProfileController extends AutoDisposeNotifier<EditProfileState> {
  // We need both repositories now
  late final AuthRepository _authRepository;
  late final ProfileRepository _profileRepository;

  @override
  EditProfileState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _profileRepository = ref.watch(profileRepositoryProvider); // Added this
    return const EditProfileState();
  }

  Future<void> updateProfile({
    String? imagePath,
    String? name,
    String? surname,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Use the profile repository to update the user
      await _profileRepository.updateUser(
        name: name,
        surname: surname,
        avatar: imagePath,
      );

      // Usually, you'd want to update your global user state here
      // so the rest of the app sees the new name/image immediately
      // ref.read(userProvider.notifier).state = updatedUser;

      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: "Failed to update profile. Please try again.",
      );
    }
  }
}

final editProfileControllerProvider =
    NotifierProvider.autoDispose<EditProfileController, EditProfileState>(
      EditProfileController.new,
    );
