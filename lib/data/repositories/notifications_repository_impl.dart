import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/data/dto/notification_dto.dart';
import 'package:go_sport/domain/entities/notification.dart';
import 'package:go_sport/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final ApiClient _apiClient;

  NotificationsRepositoryImpl(this._apiClient);

  @override
  Future<List<Notification>> getAllNotifications() async {
    // Update the path to match Postman and pass the query parameters explicitly
    final response = await _apiClient.get(
      '/api/notifications',
      queryParameters: {'populate': '*', 'sort[0]': 'createdAt:desc'},
    );

    final data = response.data['data'] as List<dynamic>? ?? [];
    return data
        .map(
          (e) => NotificationDto.fromJson(e as Map<String, dynamic>).toDomain(),
        )
        .toList();
  }

  @override
  Future<Notification> getNotification(String id) async {
    final response = await _apiClient.get('/api/notifications/$id');

    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    return NotificationDto.fromJson(data).toDomain();
  }

  @override
  Future<int> getUnseenCount() async {
    // Only the total is needed for the badge, so ask for a single-item page
    // and read the count from Strapi's pagination meta (accurate beyond the
    // default page size, and sidesteps per-item DTO parsing entirely).
    final response = await _apiClient.get(
      '/api/notifications',
      queryParameters: {
        'filters[IsSeen][\$eq]': 'false',
        'pagination[pageSize]': '1',
      },
    );

    final meta = response.data['meta'] as Map<String, dynamic>?;
    final pagination = meta?['pagination'] as Map<String, dynamic>?;
    return pagination?['total'] as int? ?? 0;
  }

  @override
  Future<Notification> readNotification(String documentId) async {
    final response = await _apiClient.put(
      '/api/notifications/$documentId',
      data: {
        'data': {'IsSeen': true},
      },
    );

    final data = response.data['data'] as Map<String, dynamic>? ?? {};
    return NotificationDto.fromJson(data).toDomain();
  }
}
