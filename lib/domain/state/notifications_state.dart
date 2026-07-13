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

  // Future<void> readNotification(String documentId) async {
  //   try {
  //     final notification = await _notificationsRepository.readNotification(
  //       documentId,
  //     );
  //     final updatedItems = state.items
  //         .map((item) => item.documentId == documentId ? notification : item)
  //         .toList();
  //     state = state.copyWith(
  //       items: updatedItems,
  //       selectedNotification: notification,
  //     );

  //     // Re-read the authoritative count so the badge stays in sync.
  //     await getUnseenCount();
  //   } catch (e) {
  //     state = state.copyWith(error: _messageFromError(e));
  //   }
  // }

  Future<void> readNotification(String documentId) async {
    try {
      // 1. Send the read request to the backend
      final notification = await _notificationsRepository.readNotification(
        documentId,
      );

      // 2. Safely merge the state data
      final updatedItems = state.items.map((item) {
        if (item.documentId == documentId) {
          // Use the new update payload, but preserve the old coverUrl if the incoming one is null or empty
          return notification.copyWith(
            coverUrl:
                (notification.coverUrl != null &&
                    notification.coverUrl!.isNotEmpty)
                ? notification.coverUrl
                : item.coverUrl, // <--- THIS SAVES YOUR IMAGE DATA ENVELOPE
          );
        }
        return item;
      }).toList();

      state = state.copyWith(
        items: updatedItems,
        selectedNotification: notification.copyWith(
          coverUrl:
              (notification.coverUrl != null &&
                  notification.coverUrl!.isNotEmpty)
              ? notification.coverUrl
              : state.items
                    .firstWhere((i) => i.documentId == documentId)
                    .coverUrl,
        ),
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
