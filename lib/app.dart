import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:mvc_app/features/login/view/LoginPage.dart';
import 'features/login/controller/PLoginController.dart';  // Import your LoginProvider

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),  // Add your LoginProvider
        // Add other providers here if needed
      ],
      child: MaterialApp(
        home: LoginPage(),
      ),
    );
  }
}
