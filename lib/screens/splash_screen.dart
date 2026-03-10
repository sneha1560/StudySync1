import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/auth_provider.dart';
import 'package:study_sync/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _navigate);
  }

  void _navigate() {
    if (!mounted) return;
    final auth = context.read<AuthProvider>();
    Navigator.of(context).pushReplacementNamed(
      auth.isLoggedIn ? '/home' : '/onboarding',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF00D9A5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school_rounded,
                size: 80,
                color: Colors.white.withValues(alpha: 0.95),
              )
                  .animate()
                  .scale(duration: 600.ms, curve: Curves.elasticOut)
                  .fadeIn(),
              const SizedBox(height: 24),
              Text(
                'StudySync',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms)
                  .slideY(begin: 0.3, end: 0, duration: 500.ms),
              Text(
                'AI-Powered Study Planner',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
              )
                  .animate()
                  .fadeIn(delay: 500.ms)
                  .slideY(begin: 0.3, end: 0, duration: 500.ms),
            ],
          ),
        ),
      ),
    );
  }
}
