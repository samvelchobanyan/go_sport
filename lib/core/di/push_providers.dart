import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:go_sport/core/push/firebase_service.dart';
import 'package:go_sport/core/push/push_local_storage.dart';
import 'package:go_sport/core/push/push_service.dart';

final firebaseMessagingProvider = Provider<FirebaseMessaging>((ref) {
  return FirebaseMessaging.instance;
});

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService(ref.read(firebaseMessagingProvider));
});

final pushLocalStorageProvider = Provider<PushLocalStorage>((ref) {
  return PushLocalStorage();
});

final pushServiceProvider = Provider<PushService>((ref) {
  return PushService(
    ref.read(firebaseServiceProvider),
    ref.read(deviceRepositoryProvider),
    ref.read(pushLocalStorageProvider),
  );
});
