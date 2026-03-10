import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/pomodoro_provider.dart';
import 'package:study_sync/widgets/neumorphic_container.dart';

class PomodoroScreen extends StatelessWidget {
  const PomodoroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pomodoro Timer'),
      ),
      body: Consumer<PomodoroProvider>(
        builder: (context, pomodoro, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  pomodoro.phaseLabel,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                ).animate().fadeIn(),
                const SizedBox(height: 24),
                NeumorphicContainer(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    children: [
                      Text(
                        pomodoro.formattedTime,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFeatures: [const FontFeature.tabularFigures()],
                            ),
                      ).animate().fadeIn(),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ControlButton(
                            icon: pomodoro.isRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            onPressed: pomodoro.isRunning ? pomodoro.pause : pomodoro.start,
                          ),
                          const SizedBox(width: 16),
                          _ControlButton(
                            icon: Icons.skip_next_rounded,
                            onPressed: pomodoro.skipToNext,
                          ),
                          const SizedBox(width: 16),
                          _ControlButton(
                            icon: Icons.refresh_rounded,
                            onPressed: pomodoro.reset,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
                    .animate()
                    .scale(duration: 400.ms, curve: Curves.elasticOut)
                    .fadeIn(delay: 100.ms),
                const SizedBox(height: 32),
                NeumorphicContainer(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(
                        value: '${pomodoro.completedPomodoros}',
                        label: 'Completed',
                      ),
                      _StatItem(
                        value: '${(pomodoro.completedPomodoros * 25) ~/ 60}h',
                        label: 'Total Focus',
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _ControlButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: NeumorphicContainer(
        isPressed: true,
        padding: const EdgeInsets.all(16),
        child: Icon(icon, size: 32, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
        ),
      ],
    );
  }
}
