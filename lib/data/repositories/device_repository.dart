import 'package:go_sport/core/device/device_service.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceRepository {
  final DeviceService _deviceService;
  final ApiClient _apiClient;

  DeviceRepository(this._deviceService, this._apiClient);

  Future<void> registerDevice() async {
    print('Checking device registration with backend...');
    try {
      final token = await _deviceService.getDeviceToken();
      if (token == null || token.isEmpty) {
        print('ℹ️ Registration cancelled: No device token available.');
        return;
      }

      final platform = _deviceService.getPlatform();

      // 🔍 1. Check if a device with this token already exists in Strapi
      // This hits: GET /api/devices?filters[Token]=your_token_string
      final checkResponse = await _apiClient.get(
        '/api/devices',
        queryParameters: {'filters[Token]': token},
      );

      // Strapi always returns a list inside the 'data' key for find/GET calls
      final List? existingEntries = checkResponse.data['data'];

      print('existingEntries from backend: $existingEntries');

      if (existingEntries != null && existingEntries.isNotEmpty) {
        // 🎉 Found it! The token already exists on the backend.
        // Strapi 5 uses 'documentId' directly on the object.
        final existingDocumentId = existingEntries.first['documentId'];

        if (existingDocumentId != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(
            'gosport_device_document_id',
            existingDocumentId.toString(),
          );
          print(
            'ℹ️ Token already exists in Strapi database. Saved documentId: $existingDocumentId',
          );
          return; // Exit safely, avoiding the 400 validation crash!
        }
      }

      // 🚀 2. If the token was NOT found, proceed with creating it fresh
      print('Token not found on server. Creating new device entry...');
      final response = await _apiClient.post(
        '/api/devices',
        data: {
          'data': {'Token': token, 'Platform': platform},
        },
      );

      final newDocumentId = response.data['data']['documentId'];
      if (newDocumentId != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(
          'gosport_device_document_id',
          newDocumentId.toString(),
        );
        print(
          '✅ New device registered successfully. Saved documentId: $newDocumentId',
        );
      }
    } catch (e) {
      print('❌ Device registration process failed: $e');
    }
  }

  Future<void> deleteDevice() async {
    // todo check if Arman fixed 403 error
    print('Attempting to delete device on backend...');
    try {
      // 1. Retrieve the documentId from local storage
      final prefs = await SharedPreferences.getInstance();
      final documentId = prefs.getString('gosport_device_document_id');
      if (documentId == null) {
        print('❌ Aborted: No documentId found in local storage.');
        return;
      }

      // 2. Make the call
      final response = await _apiClient.delete('/api/devices/$documentId');

      // 💡 Add explicit validation here based on your API client (Dio/Http/Retrofit)
      // If your API client doesn't throw automatically on non-200 codes, check it:
      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Backend returned status code ${response.statusCode}');
      }

      // 3. ONLY wipe local data if the backend successfully deleted it
      await prefs.remove('gosport_device_document_id');
      print('✅ Device successfully deleted locally and on backend.');
    } catch (e) {
      // This will catch your network failures, 403s, and 500s
      print('❌ Failed to delete device on backend: $e');
      // Consider rethrowing or passing this to your UI to block the flow
    }
  }
}
