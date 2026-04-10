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
  // static const _choseGuestKey = 'chose_guest';
  String? _registrationToken;

  final _secureStorage = const FlutterSecureStorage();

  String? _cachedAccessToken;
  String? _cachedRefreshToken;
  bool _choseGuest = false;

  String? get registrationToken => _registrationToken;

  String? get accessToken => _cachedAccessToken;
  String? get refreshToken => _cachedRefreshToken;
  bool get choseGuest => _choseGuest;

  Future<void> init() async {
    _cachedAccessToken = await _secureStorage.read(key: _accessTokenKey);
    _cachedRefreshToken = await _secureStorage.read(key: _refreshTokenKey);
    // _choseGuest = await _secureStorage.read(key: _choseGuestKey) == 'true';
  }

  void setChoseGuest() {
    _choseGuest = true;
    // await _secureStorage.write(key: _choseGuestKey, value: 'true');
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    _choseGuest = false;

    _registrationToken = null;

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
    
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
    ]);
  }

  void saveRegistrationToken(String token) {
    _registrationToken = token;
  }

  void clearRegistrationToken() {
    _registrationToken = null;
  }
}
