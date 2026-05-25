import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

part 'change_password_controller.freezed.dart';

@freezed
class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isSuccess, // Changed from isAuthenticated to isSuccess
  }) = _ChangePasswordState;
}

class ChangePasswordController
    extends AutoDisposeNotifier<ChangePasswordState> {
  late final ProfileRepository _profileRepository;

  @override
  ChangePasswordState build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
    return const ChangePasswordState();
  }

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await _profileRepository.changePassword(
        currentPassword: currentPassword,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      state = state.copyWith(isLoading: false, isSuccess: true);
    } catch (e) {
      String errorMessage = 'Something went wrong';
      if (e is DioException && e.response != null) {
        final errorData = e.response!.data;
        if (errorData != null &&
            errorData['error'] != null &&
            errorData['error']['message'] != null) {
          errorMessage = errorData['error']['message'];
        }
      }
      print(e);

      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
        isSuccess: false,
      );
    }
  }
}

final changePasswordControllerProvider =
    NotifierProvider.autoDispose<ChangePasswordController, ChangePasswordState>(
      ChangePasswordController.new,
    );
