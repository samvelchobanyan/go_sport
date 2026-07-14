import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  const factory Notification({
    required int id,
    required String title,
    required String body,
    required String documentId,
    @Default(false) bool isRead,
    required DateTime createdAt,
    String? type,
    String? targetId, // documentId of the entity this notification points to
    String? programId, // parent program — sent only for episode notifications
    String? coverUrl,
  }) = _Notification;
}
