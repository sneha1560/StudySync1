import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:study_sync/providers/study_provider.dart';
import 'package:study_sync/models/study_plan.dart';
import 'package:intl/intl.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  final _goalController = TextEditingController();
  DateTime _deadline = DateTime.now().add(const Duration(days: 7));
  int _hoursPerDay = 2;
  FocusPattern _focusPattern = FocusPattern.morning;

  @override
  void dispose() {
    _goalController.dispose();
    super.dispose();
  }

  void _showCreatePlan() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Generate Study Plan',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _goalController,
                decoration: const InputDecoration(
                  labelText: 'Goal / Subject',
                  hintText: 'e.g. Pass Calculus exam',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: Text('Deadline: ${DateFormat.yMd().format(_deadline)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _deadline,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _deadline = picked);
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<int>(
                value: _hoursPerDay,
                decoration: const InputDecoration(labelText: 'Hours per day'),
                items: [1, 2, 3, 4, 5, 6].map((h) => DropdownMenuItem(value: h, child: Text('$h hours'))).toList(),
                onChanged: (v) => setState(() => _hoursPerDay = v ?? 2),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<FocusPattern>(
                value: _focusPattern,
                decoration: const InputDecoration(labelText: 'Focus pattern'),
                items: FocusPattern.values
                    .map((p) => DropdownMenuItem(
                          value: p,
                          child: Text(p.name[0].toUpperCase() + p.name.substring(1)),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _focusPattern = v ?? FocusPattern.morning),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () async {
                  if (_goalController.text.isEmpty) return;
                  await context.read<StudyProvider>().generatePlan(
                        goal: _goalController.text,
                        deadline: _deadline,
                        hoursPerDay: _hoursPerDay,
                        focusPattern: _focusPattern,
                      );
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Generate Plan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Plans'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: _showCreatePlan,
          ),
        ],
      ),
      body: Consumer<StudyProvider>(
        builder: (context, study, _) {
          if (study.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (study.plans.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No plans yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to generate an AI study plan',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: _showCreatePlan,
                    icon: const Icon(Icons.add),
                    label: const Text('Create Plan'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: study.plans.length,
            itemBuilder: (context, i) {
              final plan = study.plans[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(plan.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    '${plan.totalHours} hours • ${DateFormat.yMd().format(plan.deadline)}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => study.removePlan(plan.id),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: (i * 50).ms)
                  .slideX(begin: 0.1, end: 0);
            },
          );
        },
      ),
    );
  }
}
