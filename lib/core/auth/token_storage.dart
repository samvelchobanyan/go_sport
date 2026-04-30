import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>(
  (_) => throw UnimplementedError(
    'tokenStorageProvider must be overridden in ProviderScope',
  ),
);

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _choseGuestKey = 'chose_guest';

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
    _cachedAccessToken = await _secureStorage.read(key: _accessTokenKey);
    _cachedRefreshToken = await _secureStorage.read(key: _refreshTokenKey);

    final guestFlag = await _secureStorage.read(key: _choseGuestKey);
    _choseGuest = guestFlag == 'true';
  }

  Future<void> setChoseGuest() async {
    _choseGuest = true;
    await _secureStorage.write(key: _choseGuestKey, value: 'true');
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
      _secureStorage.delete(key: _choseGuestKey),
    ]);
  }

  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    _choseGuest = false;
    _registrationToken = null;
    _resetToken = null;

    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
      _secureStorage.delete(key: _choseGuestKey),
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
