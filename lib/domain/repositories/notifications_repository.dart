import 'package:go_sport/domain/entities/notification.dart';

abstract interface class NotificationsRepository {
  Future<List<Notification>> getAllNotifications();

  Future<Notification> getNotification(String id);

  Future<List<Notification>> getUnseenNotifications();
}
