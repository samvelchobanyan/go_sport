import 'package:go_sport/domain/entities/notification.dart';

/// Strapi media object: prefers a resized format suitable for the 52px tile,
/// falls back to the original url.
class _CoverDto {
  final String? url;

  const _CoverDto({this.url});

  factory _CoverDto.fromJson(Map<String, dynamic> json) {
    final rawUrl = json['url'] as String?;
    if (rawUrl != null && rawUrl.isNotEmpty) return _CoverDto(url: rawUrl);

    final formats = json['formats'] as Map<String, dynamic>?;
    final small = formats?['small'] as Map<String, dynamic>?;
    final thumbnail = formats?['thumbnail'] as Map<String, dynamic>?;
    return _CoverDto(
      url: small?['url'] as String? ?? thumbnail?['url'] as String?,
    );
  }
}

class NotificationDto {
  final int id;
  final String documentId;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;
  final NotificationPayloadDto? payload;
  final String? coverUrl;

  const NotificationDto({
    required this.id,
    required this.documentId,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.coverUrl,
    this.payload,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    final coverJson =
        json['Cover'] as Map<String, dynamic>? ??
        json['cover'] as Map<String, dynamic>?;
    final payloadJson = json['Payload'] ?? json['payload'];

    return NotificationDto(
      id: json['id'] as int? ?? 0,
      documentId: json['documentId'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? json['Title'] as String? ?? '',
      body: json['body'] as String? ?? json['Body'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? json['IsSeen'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
      payload: payloadJson is Map<String, dynamic>
          ? NotificationPayloadDto.fromJson(payloadJson)
          : null,
      coverUrl:
          json['coverUrl'] as String? ??
          (coverJson != null ? _CoverDto.fromJson(coverJson).url : null),
    );
  }

  Notification toDomain() {
    return Notification(
      id: id,
      documentId: documentId,
      title: title,
      body: body,
      isRead: isRead,
      createdAt: createdAt,
      type: payload?.type,
      targetId: payload?.documentId,
      programId: payload?.programId,
      coverUrl: coverUrl,
    );
  }
}

/// Nested Payload object: what the notification points at. Route resolution
/// happens in AppRoutes.contentRoute — this layer only carries raw ids.
class NotificationPayloadDto {
  final String? type;
  final String? documentId;
  final String? programId;

  const NotificationPayloadDto({this.type, this.documentId, this.programId});

  factory NotificationPayloadDto.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadDto(
      type: json['type'] as String?,
      documentId: json['documentId'] as String? ?? json['targetId'] as String?,
      programId: json['programId'] as String?,
    );
  }
}
