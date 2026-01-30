import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../audio/app_audio_handler.dart';

/// Provides a singleton instance of AppAudioHandler.
/// Lives for the entire app lifecycle.
final audioHandlerProvider = Provider<AppAudioHandler>((ref) {
  final handler = AppAudioHandler();

  ref.onDispose(() {
    handler.dispose();
  });

  return handler;
});
