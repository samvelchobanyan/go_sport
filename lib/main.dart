import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/navigation/app_router.dart';
import 'design_system/theme/ds_theme_data.dart';

void main() {
  // ProviderScope обязателен для работы Riverpod провайдеров
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Audio App',
      debugShowCheckedModeBanner: false,
      theme: DSThemeData.mainTheme,
      routerConfig: appRouter,
    );
  }
}