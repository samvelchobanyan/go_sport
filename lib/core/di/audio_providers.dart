import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../audio/app_audio_handler.dart';

/// Provides a singleton instance of AppAudioHandler.
/// Must be overridden in main.dart with the initialized instance from AudioService.init()
final audioHandlerProvider = Provider<AppAudioHandler>((ref) {
  throw UnimplementedError('audioHandlerProvider must be overridden in ProviderScope');
});
