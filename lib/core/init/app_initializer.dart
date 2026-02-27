import 'package:flutter/widgets.dart';

import '../config/env_config.dart';
import '../../di/injection.dart';
import '../../presentation/routes/app_routes.dart';

/// Handles async app bootstrap: env, DI, and initial route resolution.
abstract class AppInitializer {
  /// Ensures Flutter binding, loads env, sets up DI, and returns the initial route.
  static Future<String> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EnvConfig.load();
    setupDependencyInjection();

    // Always show splash screen on every app start
    return AppRoutes.splash;
  }
}
