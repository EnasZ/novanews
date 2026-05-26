import 'package:flutter/material.dart';
import 'package:novanews/core/theme/app_routes.dart';
import 'package:novanews/feature/home/presentation/screens/home.dart';
import 'package:novanews/splash.dart';

void main() {
  runApp(const NovaNews());
}

class NovaNews extends StatelessWidget {
  const NovaNews({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NovaNews',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: {
        AppRoutes.splash: (context) => const Splash(),
        AppRoutes.home: (context) => const Home(),
      },
    );
  }
}

