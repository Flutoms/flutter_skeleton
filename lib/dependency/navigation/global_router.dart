
import 'package:midlr/ui/auth/splash_screen.dart';

import 'global_router_exports.dart';

class GlobalRouter {
  GlobalRouter._();

  static generateRoutes(settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

    }
  }
}
