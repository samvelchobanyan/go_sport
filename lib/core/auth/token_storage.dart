import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>(
  (_) => throw UnimplementedError(
    'tokenStorageProvider must be overridden in ProviderScope',
  ),
);

class TokenStorage extends ChangeNotifier {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  String? _registrationToken;
  String? _resetToken;

  final _secureStorage = const FlutterSecureStorage();

  String? _cachedAccessToken;
  String? _cachedRefreshToken;
  bool _choseGuest = false;

  String? get registrationToken => _registrationToken;
  String? get resetToken => _resetToken;

  String? get accessToken => _cachedAccessToken;
  String? get refreshToken => _cachedRefreshToken;
  bool get choseGuest => _choseGuest;

  Future<void> init() async {
    try {
      _cachedAccessToken = await _secureStorage.read(key: _accessTokenKey);
      _cachedRefreshToken = await _secureStorage.read(key: _refreshTokenKey);
    } on PlatformException {
      // Secure storage unreadable (e.g. Android Keystore reset → BadPaddingException).
      // Wipe the corrupt entries and fall back to unauthenticated (ADR-005).
      await _secureStorage.deleteAll();
      _cachedAccessToken = null;
      _cachedRefreshToken = null;
      _choseGuest = false;
    }
  }

  /// Guest choice is per-session only (in-memory): it is intentionally NOT
  /// persisted, so each app launch starts at login until the user opts into
  /// guest mode again — mirroring the in-memory guest session timer.
  void setChoseGuest() {
    _choseGuest = true;
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    _choseGuest = false;

    _registrationToken = null;
    _resetToken = null;

    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    _choseGuest = false;
    _registrationToken = null;
    _resetToken = null;
    // Notify synchronously (cache is already cleared) so the router's
    // refreshListenable re-runs its redirect and lands on login immediately.
    notifyListeners();

    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
    ]);
  }

  void saveRegistrationToken(String token) {
    _registrationToken = token;
  }

  void saveResetToken(String token) {
    _resetToken = token;
  }

  void clearRegistrationToken() {
    _registrationToken = null;
  }

  void clearResetToken() {
    _resetToken = null;
  }
}
