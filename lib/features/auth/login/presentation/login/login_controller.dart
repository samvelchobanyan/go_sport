import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:go_sport/core/auth/auth_state.dart';
import 'package:go_sport/core/auth/token_storage.dart';
import 'package:go_sport/core/di/repository_providers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:go_sport/domain/repositories/auth_repository.dart';

part 'login_controller.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
  }) = _LoginState;
}
// login_controller.dart

class LoginController extends AutoDisposeNotifier<LoginState> {
  late final AuthRepository _authRepository;

  // do not initialize token storage here,
  //as it causes problem after logout and login again,
  //because late variables can be initialized only once per instance,
  //and after logout the same instance is used for login again,
  //so it tries to initialize token storage again and throws error

  @override
  LoginState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const LoginState();
  }

  Future<void> login(String email, String password) async {
    // Start loading
    state = state.copyWith(isLoading: true, error: null);

    try {
      final result = await _authRepository.login(
        identifier: email,
        password: password,
      );

      final tokenStorage = ref.watch(tokenStorageProvider);
      await tokenStorage.saveTokens(accessToken: result.jwt, refreshToken: '');
      ref.invalidate(authProvider);


      state = state.copyWith(isLoading: false, isAuthenticated: true);

      await _authRepository.registerDevice();
    } catch (e) {
      // Dio errors or parsing errors caught here
      state = state.copyWith(
        isLoading: false,
        error: "Invalid credentials or server error",
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize(
        serverClientId:
            '705440736708-guerbecm524h4mi211kj3kl9o1l6qinb.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      if (googleUser == null) {
        state = state.copyWith(isLoading: false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Use 'as dynamic' to satisfy VS Code's analyzer.
      // At runtime on Android/iOS, this property exists.
      final String? token = (googleAuth as dynamic).accessToken;
      print('Google access token: $token');
      if (token == null || token.isEmpty) {
        throw Exception("Could not retrieve access_token from Google.");
      }

      // Call your repository with the token
      final result = await _authRepository.loginWithGoogle(token: token);

      // Save the JWT from your Strapi backend
      final tokenStorage = ref.read(tokenStorageProvider);
      await tokenStorage.saveTokens(accessToken: result.jwt, refreshToken: '');

      ref.invalidate(authProvider);
      state = state.copyWith(isLoading: false, isAuthenticated: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  // Use .instance instead of a constructor
  return GoogleSignIn.instance;
});

final loginControllerProvider =
    NotifierProvider.autoDispose<LoginController, LoginState>(
      LoginController.new,
    );
