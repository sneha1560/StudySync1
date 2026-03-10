import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/pomodoro_provider.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: Consumer<PomodoroProvider>(
        builder: (context, pomodoro, _) {
          final sessions = pomodoro.sessions;
          final totalMinutes = sessions.fold<int>(0, (s, e) => s + e.durationMinutes);
          final todayCount = sessions.where((s) {
            final d = DateTime.now();
            return s.startTime.year == d.year && s.startTime.month == d.month && s.startTime.day == d.day;
          }).length;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _StatCard(
                  icon: Icons.timer_rounded,
                  title: 'Total Focus Time',
                  value: '${totalMinutes ~/ 60}h ${totalMinutes % 60}m',
                  color: const Color(0xFF6C63FF),
                ).animate().fadeIn().slideY(begin: 0.1, end: 0),
                const SizedBox(height: 16),
                _StatCard(
                  icon: Icons.today_rounded,
                  title: 'Today',
                  value: '$todayCount pomodoros',
                  color: const Color(0xFF00D9A5),
                ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),
                const SizedBox(height: 24),
                Text(
                  'Recent Sessions',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 12),
                if (sessions.isEmpty)
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        'No sessions yet. Start a Pomodoro!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                      ),
                    ),
                  )
                else
                  ...sessions.take(10).map((s) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                            child: Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                          ),
                          title: Text(s.subject ?? 'Study Session'),
                          subtitle: Text(
                            '${DateFormat.MMMd().format(s.startTime)} • ${s.durationMinutes} min',
                          ),
                        ),
                      )).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7))),
                  Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
