import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification.freezed.dart';

@freezed
class Notification with _$Notification {
  const factory Notification({
    required String id,
    required String title,
    required String body,
    @Default(false) bool isRead,
    required DateTime createdAt,
    String? type,
    String? targetId, // Renamed from payload to clearly reflect what it holds
  }) = _Notification;
}