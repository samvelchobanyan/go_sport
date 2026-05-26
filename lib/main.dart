import 'package:audio_service/audio_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_sport/core/di/network_providers.dart';
import 'package:go_sport/core/navigation/routes.dart';
import 'package:go_sport/core/network/api_client.dart';
import 'package:go_sport/core/notifications/notification_service.dart';
import 'package:go_sport/core/notifications/reminder_storage.dart';
import 'package:go_sport/design_system/foundations/ds_colors.dart';
import 'core/audio/app_audio_handler.dart';
import 'core/auth/google_auth_service.dart';
import 'core/auth/token_storage.dart';
import 'core/config/app_config.dart';
import 'core/di/audio_providers.dart';
import 'core/di/auth_providers.dart';
import 'core/navigation/app_router.dart';
import 'core/network/interceptors/auth_interceptor.dart';
import 'design_system/theme/ds_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // todo pass options: DefaultFirebaseOptions.currentPlatform after running `flutterfire configure`
  try {
    await Firebase.initializeApp();
    FirebaseMessaging.instance.subscribeToTopic('all_users');
  } catch (e, stackTrace) {
    debugPrint('Firebase Init Error: $e');
    debugPrintStack(stackTrace: stackTrace);
  }

  const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  final config = env == 'prod' ? AppConfig.prod : AppConfig.dev;

  final tokenStorage = TokenStorage();

  await tokenStorage.init();

  final apiClient = ApiClient(config, [AuthInterceptor(tokenStorage)]);

  final googleAuthService = GoogleAuthService(
    webClientId: config.googleWebClientId,
  );

  final notificationService = NotificationService();
  await notificationService.init();
  await notificationService.requestPermissions();

  final reminderStorage = ReminderStorage();
  await reminderStorage.init();

  try {
    // Initialize AudioService
    final audioHandler = await AudioService.init(
      builder: () => AppAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.go_sport.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );

    // ProviderScope обязателен для работы Riverpod провайдеров
    runApp(
      ProviderScope(
        overrides: [
          audioHandlerProvider.overrideWithValue(audioHandler),
          apiClientProvider.overrideWithValue(apiClient),
          tokenStorageProvider.overrideWithValue(tokenStorage),
          googleAuthServiceProvider.overrideWithValue(googleAuthService),
          notificationServiceProvider.overrideWithValue(notificationService),
          reminderStorageProvider.overrideWithValue(reminderStorage),
        ],
        child: MainApp(tokenStorage: tokenStorage),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('AudioService Init Error: $e');
    debugPrintStack(stackTrace: stackTrace);
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Initialization Error:\n$e',
                textAlign: TextAlign.center,
                style: const TextStyle(color: DSColors.errorColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainApp extends ConsumerStatefulWidget {
  final TokenStorage tokenStorage;

  const MainApp({super.key, required this.tokenStorage});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createAppRouter(widget.tokenStorage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final payload = ref.read(notificationServiceProvider).initialPayload;
      if (payload != null) {
        _handleNotificationPayload(payload);
      }
    });
  }

  void _handleNotificationPayload(String payload) {
    if (payload == kRadioSchedulePayload) {
      _router.push(AppRoutes.radioSchedule);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<String>>(notificationTapProvider, (prev, next) {
      next.whenData(_handleNotificationPayload);
    });

    return MaterialApp.router(
      title: 'Audio App',
      debugShowCheckedModeBanner: false,
      theme: DSThemeData.mainTheme,
      routerConfig: _router,
    );
  }
}
