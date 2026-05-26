import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_sport/core/auth/google_auth_service.dart';

final googleAuthServiceProvider = Provider<GoogleAuthService>(
  (_) => throw UnimplementedError(
    'googleAuthServiceProvider must be overridden in ProviderScope',
  ),
);
