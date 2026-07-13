// import 'package:go_sport/domain/entities/notification.dart';

// class NotificationDto {
//   final int id; // Added to capture the raw integer ID if needed
//   final String documentId;
//   final String title;
//   final String body;
//   final bool isRead;
//   final DateTime createdAt;
//   final NotificationPayloadDto? payload;
//   final String? coverUrl;

//   const NotificationDto({
//     required this.id,
//     required this.documentId,
//     required this.title,
//     required this.body,
//     required this.isRead,
//     required this.createdAt,
//     this.coverUrl,
//     this.payload,
//   });

//   factory NotificationDto.fromJson(Map<String, dynamic> json) {
//     final coverJson =
//         json['Cover'] as Map<String, dynamic>? ??
//         json['cover'] as Map<String, dynamic>?;
//     String? extractedUrl = json['coverUrl'] as String?;
//     if (extractedUrl == null && coverJson != null) {
//       extractedUrl = _extractCoverUrl(coverJson);
//     }
//     return NotificationDto(
//       id: json['id'] as int? ?? 0,
//       documentId: json['documentId'] as String? ?? json['_id'] as String? ?? '',
//       title: json['title'] as String? ?? json['Title'] as String? ?? '',
//       body: json['body'] as String? ?? json['Body'] as String? ?? '',
//       isRead: json['isRead'] as bool? ?? json['IsSeen'] as bool? ?? false,
//       createdAt: json['createdAt'] != null
//           ? DateTime.parse(json['createdAt'].toString())
//           : DateTime.now(),
//       // Safely checks and parses the nested Payload object
//       payload:
//           json['Payload'] != null && json['Payload'] is Map<String, dynamic>
//           ? NotificationPayloadDto.fromJson(
//               json['Payload'] as Map<String, dynamic>,
//             )
//           : json['payload'] != null && json['payload'] is Map<String, dynamic>
//           ? NotificationPayloadDto.fromJson(
//               json['payload'] as Map<String, dynamic>,
//             )
//           : null,
//       coverUrl: extractedUrl,
//     );
//   }
//   static String? _extractCoverUrl(Map<String, dynamic>? coverJson) {
//     if (coverJson == null) return null;

//     final rawUrl = coverJson['url'] as String?;
//     if (rawUrl != null && rawUrl.isNotEmpty) return rawUrl;

//     final formats = coverJson['formats'] as Map<String, dynamic>?;
//     final small = formats?['small'] as Map<String, dynamic>?;
//     final thumbnail = formats?['thumbnail'] as Map<String, dynamic>?;
//     return small?['url'] as String? ?? thumbnail?['url'] as String?;
//   }

//   Notification toDomain() {
//     return Notification(
//       id: id, // Maps to the entity's integer id
//       documentId: documentId, // Maps to the new entity string field
//       title: title,
//       body: body,
//       isRead: isRead,
//       createdAt: createdAt,
//       type: payload?.type,
//       targetId: payload?.documentId, // Inner payload id
//       coverUrl: coverUrl,
//     );
//   }
// }

// /// Helper DTO to parse the nested map inside the notification JSON
// class NotificationPayloadDto {
//   final String? type;
//   final String? documentId;

//   const NotificationPayloadDto({this.type, this.documentId});

//   factory NotificationPayloadDto.fromJson(Map<String, dynamic> json) {
//     return NotificationPayloadDto(
//       type: json['type'] as String?,
//       documentId: json['documentId'] as String? ?? json['targetId'] as String?,
//     );
//   }
// }

import 'package:go_sport/domain/entities/notification.dart';

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
    String? extractedUrl = json['coverUrl'] as String?;
    if (extractedUrl == null && coverJson != null) {
      extractedUrl = _extractCoverUrl(coverJson);
    }
    return NotificationDto(
      id: json['id'] as int? ?? 0,
      documentId: json['documentId'] as String? ?? json['_id'] as String? ?? '',
      title: json['title'] as String? ?? json['Title'] as String? ?? '',
      body: json['body'] as String? ?? json['Body'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? json['IsSeen'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'].toString())
          : DateTime.now(),
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
      coverUrl: extractedUrl,
    );
  }

  static String? _extractCoverUrl(Map<String, dynamic>? coverJson) {
    if (coverJson == null) return null;

    final rawUrl = coverJson['url'] as String?;
    if (rawUrl != null && rawUrl.isNotEmpty) return rawUrl;

    final formats = coverJson['formats'] as Map<String, dynamic>?;
    final small = formats?['small'] as Map<String, dynamic>?;
    final thumbnail = formats?['thumbnail'] as Map<String, dynamic>?;
    return small?['url'] as String? ?? thumbnail?['url'] as String?;
  }

  Notification toDomain() {
    // Determine the dynamic target identifier based on payload type requirements
    String? resolvedTargetId;

    if (payload != null) {
      switch (payload!.type?.toLowerCase()) {
        case 'episode':
          // If episode, route using the programId instead of the item's documentId
          resolvedTargetId = payload!.programId ?? payload!.documentId;
          break;
        case 'article':
        case 'album':
        case 'playlist':
        default:
          // Standard entities route directly using their resource documentId
          resolvedTargetId = payload!.documentId;
          break;
      }
    }

    return Notification(
      id: id,
      documentId: documentId,
      title: title,
      body: body,
      isRead: isRead,
      createdAt: createdAt,
      type: payload?.type,
      targetId: resolvedTargetId, // Injects your customized target ID
      coverUrl: coverUrl,
    );
  }
}

/// Helper DTO updated to extract additional conditional fields
class NotificationPayloadDto {
  final String? type;
  final String? documentId;
  final String? programId;
  final String? artistId;

  const NotificationPayloadDto({
    this.type,
    this.documentId,
    this.programId,
    this.artistId,
  });

  factory NotificationPayloadDto.fromJson(Map<String, dynamic> json) {
    return NotificationPayloadDto(
      type: json['type'] as String?,
      documentId: json['documentId'] as String? ?? json['targetId'] as String?,
      programId: json['programId'] as String?,
      artistId: json['artistId'] as String?,
    );
  }
}
