import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
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

  @override
  ConfirmDeleteState build() {
    _profileRepository = ref.watch(profileRepositoryProvider);
    return const ConfirmDeleteState();
  }

  Future<void> deleteUser({required String password}) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      await _profileRepository.deleteUser(password: password);

      state = state.copyWith(isLoading: false, isSuccess: true);
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
