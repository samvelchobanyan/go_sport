import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/data/repositories/device_repository.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

part 'confirm_delete_controller.freezed.dart';

@freezed
class ConfirmDeleteState with _$ConfirmDeleteState {
  const factory ConfirmDeleteState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isSuccess,
  }) = _ConfirmDeleteState;
}

class ConfirmDeleteController extends AutoDisposeNotifier<ConfirmDeleteState> {
  late final ProfileRepository _profileRepository;
  late final DeviceRepository _deviceRepository;

  @override
  ConfirmDeleteState build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
    _deviceRepository = ref.watch(deviceRepositoryProvider);
    return const ConfirmDeleteState();
  }

  Future<void> deleteUser({required String password}) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final tokenStorage = ref.read(tokenStorageProvider);

      await _profileRepository.deleteUser(password: password);

      await _deviceRepository.deleteDevice();

      state = state.copyWith(isLoading: false, isSuccess: true);
      // todo check if after cleartokens it doesnt automaticly throw user to login screen
      await tokenStorage.clearTokens();
    } catch (e) {
      String errorMessage = 'Something went wrong';
      if (e is DioError && e.response != null) {
        final errorData = e.response!.data;
        if (errorData != null &&
            errorData['error'] != null &&
            errorData['error']['message'] != null) {
          errorMessage = errorData['error']['message'];
        }
      }

      state = state.copyWith(
        isLoading: false,
        error: errorMessage,
        isSuccess: false,
      );
    }
  }
}

final deleteUserControllerProvider =
    NotifierProvider.autoDispose<ConfirmDeleteController, ConfirmDeleteState>(
      ConfirmDeleteController.new,
    );
