import 'package:go_sport/core/push/firebase_service.dart';
import 'package:go_sport/core/push/push_local_storage.dart';
import 'package:go_sport/domain/repositories/device_repository.dart';

class PushService {
  final FirebaseService _firebaseService;
  final DeviceRepository _deviceRepository;
  final PushLocalStorage _localStorage;

  PushService(
    this._firebaseService,
    this._deviceRepository,
    this._localStorage,
  );

  // todo handle token refresh:
  //   1. subscribe to FirebaseMessaging.onTokenRefresh while app is running
  //   2. call register() on every app start (idempotent via findByToken) to catch refreshes that happened while app was killed
  Future<void> register() async {
    // iOS-specific: triggers registerForRemoteNotifications; idempotent on Android.
    await _firebaseService.requestNotificationPermissions();

    final token = await _firebaseService.getDeviceToken();
    if (token == null || token.isEmpty) return;

    final platform = _firebaseService.getPlatform();

    final existingId = await _deviceRepository.findByToken(token);
    final documentId =
        existingId ??
        await _deviceRepository.register(token: token, platform: platform);
    await _localStorage.saveDocumentId(documentId);
  }

  Future<void> unregister() async {
    final documentId = await _localStorage.getDocumentId();
    if (documentId == null) return;

    await _deviceRepository.delete(documentId);
    await _localStorage.clearDocumentId();
  }
}
