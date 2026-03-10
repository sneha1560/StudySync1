import 'package:study_sync/models/study_plan.dart';
import 'package:uuid/uuid.dart';

/// AI-powered schedule generation (stub - replace with Firebase ML or API)
class AiScheduleService {
  Future<StudyPlan> generateSchedule({
    required String goal,
    required DateTime deadline,
    required int hoursPerDay,
    required FocusPattern focusPattern,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    final now = DateTime.now();
    final daysUntilDeadline = deadline.difference(now).inDays;
    final totalHours = (daysUntilDeadline * hoursPerDay).clamp(1, 100);
    final sessions = <StudySession>[];

    var currentDate = DateTime(now.year, now.month, now.day);
    var hourOffset = _getStartHour(focusPattern);
    var sessionId = 0;

    for (var i = 0; i < daysUntilDeadline && sessions.length < totalHours; i++) {
      for (var h = 0; h < hoursPerDay && sessions.length < totalHours; h++) {
        final start = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          hourOffset + h * 2,
          0,
        );
        final end = start.add(const Duration(hours: 1));
        sessions.add(StudySession(
          id: 's${sessionId++}',
          subject: goal,
          startTime: start,
          endTime: end,
          pomodoros: 2,
        ));
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return StudyPlan(
      id: const Uuid().v4(),
      title: goal,
      description: 'AI-generated schedule',
      deadline: deadline,
      totalHours: totalHours,
      sessions: sessions,
      focusPattern: focusPattern,
    );
  }

  int _getStartHour(FocusPattern pattern) {
    switch (pattern) {
      case FocusPattern.morning:
        return 8;
      case FocusPattern.afternoon:
        return 14;
      case FocusPattern.evening:
        return 18;
      case FocusPattern.flexible:
        return 9;
    }
  }
}
