import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/helpers/cache_helper/cache_helper.dart';
import '../../../core/helpers/routes/app_route_constants.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() async {
    final storedValue = await CacheHelper.getData('regId');
    if (storedValue != null && storedValue.isNotEmpty) {
      context.go(Routes.homePage);
    } else {
      context.go(Routes.loginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
