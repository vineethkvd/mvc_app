import 'package:go_router/go_router.dart';
import 'package:mvc_app/features/HomePage/view/HomePage.dart';

import '../../../features/SplashScreen/view/SplashScreen.dart';
import 'app_route_constants.dart';

class AppRoutes {
  final GoRouter router;

  AppRoutes()
      : router = GoRouter(
          initialLocation: Routes.splashScreen,
          routes: [
            GoRoute(
              path: Routes.splashScreen,
              builder: (context, state) => const Splashscreen(),
            ),
            GoRoute(
              path: Routes.loginPage,
              builder: (context, state) => const Splashscreen(),
            ),
            GoRoute(
              path: Routes.homePage,
              builder: (context, state) => const Homepage(),
            ),
          ],
        );
}
