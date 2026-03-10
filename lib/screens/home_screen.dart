import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:study_sync/screens/pomodoro_screen.dart';
import 'package:study_sync/screens/plans_screen.dart';
import 'package:study_sync/screens/analytics_screen.dart';
import 'package:study_sync/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _screens = [
    const _DashboardTab(),
    const PomodoroScreen(),
    const PlansScreen(),
    const AnalyticsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              offset: const Offset(0, -4),
              blurRadius: 12,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(icon: Icons.dashboard_rounded, label: 'Home', index: 0, current: _currentIndex, onTap: () => setState(() => _currentIndex = 0)),
                _NavItem(icon: Icons.timer_rounded, label: 'Pomodoro', index: 1, current: _currentIndex, onTap: () => setState(() => _currentIndex = 1)),
                _NavItem(icon: Icons.calendar_month_rounded, label: 'Plans', index: 2, current: _currentIndex, onTap: () => setState(() => _currentIndex = 2)),
                _NavItem(icon: Icons.analytics_rounded, label: 'Analytics', index: 3, current: _currentIndex, onTap: () => setState(() => _currentIndex = 3)),
                _NavItem(icon: Icons.settings_rounded, label: 'Settings', index: 4, current: _currentIndex, onTap: () => setState(() => _currentIndex = 4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final int index;
  final int current;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = index == current;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'StudySync',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _QuickActionCard(
                icon: Icons.timer_rounded,
                title: 'Start Pomodoro',
                subtitle: '25 min focus session',
                color: const Color(0xFF6C63FF),
              ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 16),
              _QuickActionCard(
                icon: Icons.auto_awesome,
                title: 'Generate Plan',
                subtitle: 'AI-powered schedule',
                color: const Color(0xFF00D9A5),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1, end: 0),
              const SizedBox(height: 16),
              _QuickActionCard(
                icon: Icons.calendar_today_rounded,
                title: 'Sync Calendar',
                subtitle: 'Google Calendar',
                color: const Color(0xFF4285F4),
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
            ]),
          ),
        ),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6))),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}
