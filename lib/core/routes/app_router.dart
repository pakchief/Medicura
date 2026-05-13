import 'package:go_router/go_router.dart';
import 'package:medicuraapp/features/auth/presentation/landing_page.dart';
import 'package:medicuraapp/features/auth/presentation/login_page.dart';
import 'package:medicuraapp/features/auth/presentation/signup_page.dart';
import 'package:medicuraapp/features/home/presentation/home_screen.dart';
import 'package:medicuraapp/features/auth/presentation/preference_screen.dart';
import 'package:medicuraapp/features/home/presentation/home_page.dart';
import 'package:medicuraapp/features/home/presentation/emergency.dart';
import 'package:medicuraapp/features/home/presentation/insights_page.dart';
import 'package:medicuraapp/features/home/presentation/doctors_page.dart';
import 'package:medicuraapp/features/home/presentation/main_layout.dart';
import 'package:go_router/go_router.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LandingPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/preference', builder: (context, state) => const PreferenceScreen()),
      GoRoute(path: '/ai_chat',  builder: (context, state) => const AiChatPage()),
      GoRoute(path: '/home',builder: (context, state) => const MainLayout()),
      GoRoute(path: '/emergency',builder: (context, state) => const EmergencyPage()),
      GoRoute(path: '/insights',builder: (context, state) => const HealthInsightsPage()),
      GoRoute(path: '/doctors',builder: (context, state) => const DoctorsListPage()),
    ],
  );
}