import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/study_provider.dart';
import 'package:study_sync/providers/pomodoro_provider.dart';
import 'package:study_sync/providers/auth_provider.dart';
import 'package:study_sync/screens/splash_screen.dart';
import 'package:study_sync/screens/home_screen.dart';
import 'package:study_sync/screens/onboarding_screen.dart';
import 'package:study_sync/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const StudySyncApp());
}

class StudySyncApp extends StatelessWidget {
  const StudySyncApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => StudyProvider()),
        ChangeNotifierProvider(create: (_) => PomodoroProvider()),
      ],
      child: MaterialApp(
        title: 'StudySync',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/onboarding': (context) => const OnboardingScreen(),
        },
      ),
    );
  }
}
