import 'package:go_router/go_router.dart';
import 'package:medicuraapp/features/auth/presentation/landing_page.dart';
import 'package:medicuraapp/features/auth/presentation/login_page.dart';
import 'package:medicuraapp/features/auth/presentation/signup_page.dart';
import 'package:medicuraapp/features/home/presentation/home_screen.dart';
import 'package:medicuraapp/features/auth/presentation/preference_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/preference', builder: (context, state) => const PreferenceScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    ],
  );
}