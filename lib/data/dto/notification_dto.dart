import 'package:go_sport/domain/entities/notification.dart';

class NotificationDto {
  final int id; // Added to capture the raw integer ID if needed
  final String documentId;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final NotificationPayloadDto? payload;

  const NotificationDto({
    required this.id,
    required this.documentId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.payload,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: json['id'] as int? ?? 0,
      documentId: json['documentId'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? json['Title'] as String? ?? '',
      body: json['body'] as String? ?? json['Body'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? json['IsSeen'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      // Safely checks and parses the nested Payload object
      payload:
          json['Payload'] != null && json['Payload'] is Map<String, dynamic>
          ? NotificationPayloadDto.fromJson(
              json['Payload'] as Map<String, dynamic>,
            )
          : json['payload'] != null && json['payload'] is Map<String, dynamic>
          ? NotificationPayloadDto.fromJson(
              json['payload'] as Map<String, dynamic>,
            )
          : null,
    );
  }

  Notification toDomain() {
    return Notification(
      id: id, // Maps to the entity's integer id
      documentId: documentId, // Maps to the new entity string field
      title: title,
      body: body,
      isRead: isRead,
      createdAt: createdAt,
      type: payload?.type,
      targetId: payload?.documentId, // Inner payload id
    );
  }
}

/// Helper DTO to parse the nested map inside the notification JSON
class NotificationPayloadDto {
  final String? type;
  final String? documentId;

  const NotificationPayloadDto({this.type, this.documentId});

  factory NotificationPayloadDto.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadDto(
      type: json['type'] as String?,
      documentId: json['documentId'] as String? ?? json['targetId'] as String?,
    );
  }
}
