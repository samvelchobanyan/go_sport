import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final String _webClientId;
  bool _initialized = false;

  GoogleAuthService({required String webClientId})
    : _webClientId = webClientId;

  Future<String?> signInAndGetAccessToken() async {
    await _ensureInitialized();

    try {
      final account = await GoogleSignIn.instance.authenticate();
      final scopes = ['email', 'profile'];

      final authorization =
          await account.authorizationClient.authorizationForScopes(scopes) ??
          await account.authorizationClient.authorizeScopes(scopes);

      return authorization.accessToken;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) return null;
      rethrow;
    }
  }

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await GoogleSignIn.instance.initialize(serverClientId: _webClientId);
    _initialized = true;
  }
}
