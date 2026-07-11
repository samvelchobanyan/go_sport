import 'package:go_sport/domain/entities/notification.dart';

abstract interface class NotificationsRepository {
  Future<List<Notification>> getAllNotifications();

  Future<Notification> getNotification(String id);

  Future<int> getUnseenCount();

  Future<Notification> readNotification(String documentId);
}
