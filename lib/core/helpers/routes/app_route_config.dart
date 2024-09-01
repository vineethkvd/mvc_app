import 'package:go_router/go_router.dart';
import 'package:mvc_app/features/HomePage/view/HomePage.dart';
import 'package:mvc_app/features/login/view/LoginPage.dart';

import '../../../features/SplashScreen/view/SplashScreen.dart';
import 'app_route_path.dart';

class AppRoutes {
  final GoRouter router;

  AppRoutes()
      : router = GoRouter(
          initialLocation: RoutesPath.splashScreen,
          routes: [
            GoRoute(
              name: "SplashScreen",
              path: RoutesPath.splashScreen,
              builder: (context, state) => const Splashscreen(),
            ),
            GoRoute(
              name: "LoginPage",
              path: RoutesPath.loginPage,
              builder: (context, state) => const LoginPage(),
            ),
            GoRoute(
              name: "HomePage",
              path: RoutesPath.homePage,
              builder: (context, state) => const Homepage(userName: '',),
            ),
          ],
        );
}
