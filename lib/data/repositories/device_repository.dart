import 'package:go_sport/core/device/device_service.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepository {
  final DeviceService _deviceService;
  final ApiClient _apiClient;

  DeviceRepository(this._deviceService, this._apiClient);

  Future<void> registerDevice() async {
    //TODO CALL THIS FUNC AFTER REGISTRATION GOOGLE
    try {
      final token = await _deviceService.getDeviceToken();
      if (token == null || token.isEmpty) return;

      final platform = _deviceService.getPlatform();

      final response = await _apiClient.post(
        '/api/devices',
        data: {
          'data': {'Token': token, 'Platform': platform},
        },
      );

      final documentId = response.data['data']['documentId'];
      if (documentId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('documentId', documentId.toString());
      }
    } catch (e) {
      print('Silent failure: Device registration failed: $e');
    }
  }

  Future<void> deleteDevice() async {
    //TODO CHECK IF ARMAN FIXED THIS CALL - SENT 403

    try {
      final token = await _deviceService.getDeviceToken();
      if (token == null || token.isEmpty) return;

      final prefs = await SharedPreferences.getInstance();
      final documentId = prefs.getString('documentId');
      if (documentId == null) return;

      await _apiClient.delete('/api/devices/$documentId');
      await prefs.remove('documentId');
    } catch (e) {
      print('Failed to delete device on backend: $e');
    }
  }
}
