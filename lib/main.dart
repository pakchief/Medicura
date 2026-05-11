import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
      url: 'https://smtptjsivkotxxmmndya.supabase.co',
      anonKey: 'sb_publishable_B9t7QV-R8ppo1tVyUpNOoQ_HfCxeDlN',
  );

  runApp(const MediCuraApp());
}

class MediCuraApp extends StatelessWidget {
  const MediCuraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MediCura',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primaryTeal, // Updated to your new Teal color
        scaffoldBackgroundColor: Colors.white, // Standard white background
        fontFamily: 'Inter', // Matching your Figma font
      ),
      routerConfig: AppRouter.router,
    );
  }
}