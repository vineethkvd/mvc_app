import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../../core/helpers/routes/app_route_name.dart';
import '../../../core/helpers/routes/app_route_path.dart'; // Import your route constants

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final storedValue = await CacheHelper.getData('regId');
    if (!mounted) return;

    if (storedValue != null && storedValue.isNotEmpty) {
      // context.go(RoutesPath.homePage);
      context.goNamed(
        RoutesName.home,
      );
    } else {
      // context.go(RoutesPath.loginPage);
      context.goNamed(
        RoutesName.login,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height:size.height ,
        width: size.width,
        color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.hail,
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}
