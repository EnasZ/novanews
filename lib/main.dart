import 'package:flutter/material.dart';
import 'package:novanews/core/routes/app_routes.dart';
import 'package:novanews/feature/home/presentation/screens/home.dart';
import 'package:novanews/feature/splash/presentation/screens/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://supabase.com/dashboard/project/jkkwdfmdqmyjfqyxzcdh/database/schemas',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Impra3dkZm1kcW15amZxeXh6Y2RoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk3OTk0ODYsImV4cCI6MjA5NTM3NTQ4Nn0.lMJ5dmf0RppSeJDsFyl2YJs-24ylV6RL85AhImPKoO8',
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

