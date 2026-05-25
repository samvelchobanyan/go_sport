import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
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
  late final ProfileRepository _profileRepository;

  @override
  EditProfileState build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
    return const EditProfileState();
  }

  Future<void> updateUser({String? name, String? surname, File? avatar}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _profileRepository.updateUser(
        name: name,
        surname: surname,
        avatar: avatar,
      );
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final editProfileControllerProvider =
    NotifierProvider.autoDispose<EditProfileController, EditProfileState>(
      EditProfileController.new,
    );
