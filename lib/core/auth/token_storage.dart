import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final tokenStorageProvider = Provider<TokenStorage>((_) =>
  throw UnimplementedError('tokenStorageProvider must be overridden in ProviderScope'));

class TokenStorage {
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  final _secureStorage = const FlutterSecureStorage();

  String? _cachedAccessToken;
  String? _cachedRefreshToken;

  String? get accessToken => _cachedAccessToken;
  String? get refreshToken => _cachedRefreshToken;

  Future<void> init() async {
    _cachedAccessToken = await _secureStorage.read(key: _accessTokenKey);
    _cachedRefreshToken = await _secureStorage.read(key: _refreshTokenKey);
  }

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    _cachedAccessToken = accessToken;
    _cachedRefreshToken = refreshToken;
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: refreshToken),
    ]);
  }

  Future<void> clearTokens() async {
    _cachedAccessToken = null;
    _cachedRefreshToken = null;
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
    ]);
  }
  
}