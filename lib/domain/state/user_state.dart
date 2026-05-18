import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/user.dart';
import '../repositories/profile_repository.dart';
import '../../core/di/repository_providers.dart';

part 'user_state.freezed.dart';

@freezed
class UserState with _$UserState {
  const factory UserState({
    User? user,
    @Default(false) bool isLoading,
    String? error,
  }) = _UserState;
}

class UserNotifier extends Notifier<UserState> {
  late final ProfileRepository _repository;

  @override
  UserState build() {
    _repository = ref.watch(profileRepositoryProvider);
    Future.microtask(() => getUser());
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
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to delete user.',
      );
    }
  }
}

final userStateProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
