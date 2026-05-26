import 'package:flutter/material.dart';
import 'package:novanews/core/theme/app_routes.dart';
import 'package:novanews/feature/home/presentation/screens/home.dart';
import 'package:novanews/feature/splash/presentation/screens/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

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

