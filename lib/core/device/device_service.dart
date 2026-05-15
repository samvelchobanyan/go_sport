import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class DeviceService {
  final FirebaseMessaging _firebaseMessaging;

  DeviceService(this._firebaseMessaging);

  String getPlatform() {
    if (Platform.isIOS) return 'iOS';
    if (Platform.isAndroid) return 'Android';
    return 'unknown';
  }

  Future<String?> getDeviceToken() async {
    try {
      // Once Firebase is setup, use this:
      return await _firebaseMessaging.getToken(); 
      // return 'test_device_token_12345';
    } catch (e) {
      print('Error getting device token: $e');
      return null;
    }
  }

  /// Helper to get both platform and token for the API
  Future<Map<String, String>> getDeviceInfo() async {
    final token = await getDeviceToken();
    return {'platform': getPlatform(), 'deviceToken': token ?? ''};
  }

  Future<NotificationSettings> requestNotificationPermissions() async {
    return await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}
