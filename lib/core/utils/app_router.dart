import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/change_password_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/news/presentation/pages/news_feed_page.dart';
import '../../features/news/presentation/pages/news_details_page.dart';
import '../../features/news/data/models/news_model.dart';

/// AppRouter defines all navigation paths in the NovaNews application.
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/splash', // Starting point of the app
    routes: [
      // Splash and Onboarding
      GoRoute(path: '/splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: '/onboarding', builder: (context, state) => const OnboardingPage()),
      
      // Authentication
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
      GoRoute(path: '/change-password', builder: (context, state) => const ChangePasswordPage()),
      
      // Main App Content
      GoRoute(path: '/news-feed', builder: (context, state) => const NewsFeedPage()),
      GoRoute(
        path: '/news-details', 
        builder: (context, state) {
          final news = state.extra as NewsModel; // Pass news model as extra parameter
          return NewsDetailsPage(news: news);
        }
      ),
      
      // User Profile and Settings
      GoRoute(path: '/profile', builder: (context, state) => const ProfilePage()),
      GoRoute(path: '/settings', builder: (context, state) => const SettingsPage()),
    ],
  );
}
