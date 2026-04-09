import 'package:go_sport/domain/entities/user.dart';

abstract interface class AuthRepository {
  /// Authenticates a user using email and password.
  // Future<User> loginWithEmail({
  //   required String email,
  //   required String password,
  // });

  // /// Registers a new user account. 
  // /// phoneNumber is optional.
  // Future<User> registerWithEmail({
  //   required String firstName,
  //   required String lastName,
  //   required String email,
  //   required String password,
  //   String? phoneNumber,
  // });

  // /// Handles both Login and Registration via Google OAuth.
  // Future<User> loginWithGoogle();

  // /// Ends the current user session.
  // Future<void> logout();

  // /// Optional: Sends a password reset email.
  // Future<void> forgotPassword(String email);

}