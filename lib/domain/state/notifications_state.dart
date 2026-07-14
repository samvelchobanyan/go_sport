import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/domain/entities/notification.dart';
import 'package:go_sport/domain/repositories/notifications_repository.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(false) bool isLoading,
    String? error,
    @Default([]) List<Notification> items,
    @Default(0) int unseenCount,
    Notification? selectedNotification,
  }) = _NotificationsState;
}

class NotificationsController extends AutoDisposeNotifier<NotificationsState> {
  late final NotificationsRepository _notificationsRepository;

  @override
  NotificationsState build() {
    _notificationsRepository = ref.watch(notificationsRepositoryProvider);
    return const NotificationsState();
  }

  Future<void> getAllNotifications() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final notifications = await _notificationsRepository
          .getAllNotifications();
      state = state.copyWith(isLoading: false, items: notifications);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _messageFromError(e));
    }
  }

  /// Fetches only the unseen count for the profile badge. Failures stay silent —
  /// a badge is not worth blocking the user with an error.
  Future<void> getUnseenCount() async {
    try {
      final count = await _notificationsRepository.getUnseenCount();
      state = state.copyWith(unseenCount: count);
    } catch (_) {
      // Intentionally swallowed: badge accuracy is best-effort.
    }
  }

  Future<void> getSingleNotification(String documentId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final notification = await _notificationsRepository.getNotification(
        documentId,
      );
      state = state.copyWith(
        isLoading: false,
        selectedNotification: notification,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _messageFromError(e));
    }
  }

  Future<void> readNotification(String documentId) async {
    try {
      var notification = await _notificationsRepository.readNotification(
        documentId,
      );

      // The read endpoint responds without the cover, so keep the one the
      // list already holds.
      if (notification.coverUrl == null || notification.coverUrl!.isEmpty) {
        for (final item in state.items) {
          if (item.documentId == documentId) {
            notification = notification.copyWith(coverUrl: item.coverUrl);
            break;
          }
        }
      }

      state = state.copyWith(
        items: [
          for (final item in state.items)
            item.documentId == documentId ? notification : item,
        ],
        selectedNotification: notification,
      );

      // Re-read the authoritative count so the badge stays in sync.
      await getUnseenCount();
    } catch (e) {
      state = state.copyWith(error: _messageFromError(e));
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
