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
Future<List<Notification>> getUnseenNotifications() async {
  // Update path and map the Strapi filters to the queryParameters map
  final response = await _apiClient.get(
    '/api/notifications',
    queryParameters: {
      'filters[IsSeen][\$eq]': 'false',
    },
  );

  print('response.data for unseen notifications: ${response.data}');

  final data = response.data['data'] as List<dynamic>? ?? [];
  return data
      .map(
        (e) => NotificationDto.fromJson(e as Map<String, dynamic>).toDomain(),
      )
      .toList();
}
}
