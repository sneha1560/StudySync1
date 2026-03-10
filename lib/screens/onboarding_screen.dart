import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/auth_provider.dart';
import 'package:study_sync/widgets/neumorphic_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Icon(
                Icons.auto_awesome,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              )
                  .animate()
                  .scale(duration: 500.ms, curve: Curves.elasticOut)
                  .fadeIn(),
              const SizedBox(height: 24),
              Text(
                'Welcome to StudySync',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
              const SizedBox(height: 12),
              Text(
                'AI-powered study schedules, Pomodoro timer, and calendar sync. Get started in seconds.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
              ).animate().fadeIn(delay: 400.ms),
              const Spacer(),
              NeumorphicButton(
                label: 'Get Started',
                icon: Icons.arrow_forward,
                isPrimary: true,
                onPressed: () async {
                  await context.read<AuthProvider>().signInWithGoogle();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
              ),
              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
