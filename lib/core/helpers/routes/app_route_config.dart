import 'package:go_router/go_router.dart';
import 'package:mvc_app/features/HomePage/view/HomePage.dart';
import 'package:mvc_app/features/login/view/LoginPage.dart';

import '../../../features/SplashScreen/view/SplashScreen.dart';
import 'app_route_name.dart';
import 'app_route_path.dart';

class AppRoutes {
  final GoRouter router;

  AppRoutes()
      : router = GoRouter(
          initialLocation: RoutesPath.splashScreen,
          routes: [
            GoRoute(
              name: RoutesName.splash,
              path: RoutesPath.splashScreen,
              builder: (context, state) => const Splashscreen(),
            ),
            GoRoute(
              name: RoutesName.login,
              path: RoutesPath.loginPage,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              name: RoutesName.home,
              path: '${RoutesPath.homePage}/:userName',
              builder: (context, state) {
                final userName = state.pathParameters['userName'] ?? 'Guest';
                return Homepage(userName: userName);
              },
            ),
          ],
        );
}
