import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/device/device_service.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final deviceServiceProvider = Provider<DeviceService>((ref) {
  final firebaseMessaging = ref.read(firebaseMessagingProvider);
  return DeviceService(firebaseMessaging);
});
