import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/notification.dart';
import 'package:go_sport/domain/repositories/notifications_repository.dart';
import 'package:go_sport/domain/repositories/profile_repository.dart';

part 'notifications_controller.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isSuccess,
    @Default([]) List<Notification> items,
    Notification? selectedNotification,
    @Default([]) List<Notification> unseenItems,
  }) = _NotificationsState;
}

class NotificationsController extends AutoDisposeNotifier<NotificationsState> {
  late final NotificationsRepository _notificationsRepository;
  late final ProfileRepository _profileRepository;

  @override
  NotificationsState build() {
    _notificationsRepository = ref.watch(notificationsRepositoryProvider);
    _profileRepository = ref.watch(profileRepositoryProvider);
    return const NotificationsState();
  }

  Future<void> getAllNotifications() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final notifications = await _notificationsRepository
          .getAllNotifications();
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        items: notifications,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _messageFromError(e),
        isSuccess: false,
      );
    }
  }

  Future<void> getSingleNotification(String id) async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final notification = await _notificationsRepository.getNotification(id);
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        selectedNotification: notification,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _messageFromError(e),
        isSuccess: false,
      );
    }
  }

  Future<void> getUnseenNotifications() async {
    state = state.copyWith(isLoading: true, error: null, isSuccess: false);
    try {
      final notifications = await _notificationsRepository
          .getUnseenNotifications();
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        unseenItems: notifications,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _messageFromError(e),
        isSuccess: false,
      );
    }
  }

  String _messageFromError(Object error) {
    if (error is DioException && error.response != null) {
      final errorData = error.response!.data;
      if (errorData != null &&
          errorData['error'] != null &&
          errorData['error']['message'] != null) {
        return errorData['error']['message'].toString();
      }
    }

    return 'Something went wrong';
  }
}

final notificationsControllerProvider =
    NotifierProvider.autoDispose<NotificationsController, NotificationsState>(
      NotificationsController.new,
    );
