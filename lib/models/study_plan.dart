class StudyPlan {
  final String id;
  final String title;
  final String? description;
  final DateTime deadline;
  final int totalHours;
  final List<StudySession> sessions;
  final FocusPattern focusPattern;

  StudyPlan({
    required this.id,
    required this.title,
    this.description,
    required this.deadline,
    required this.totalHours,
    this.sessions = const [],
    this.focusPattern = FocusPattern.morning,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'deadline': deadline.toIso8601String(),
        'totalHours': totalHours,
        'sessions': sessions.map((s) => s.toJson()).toList(),
        'focusPattern': focusPattern.name,
      };

  factory StudyPlan.fromJson(Map<String, dynamic> json) => StudyPlan(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String?,
        deadline: DateTime.parse(json['deadline'] as String),
        totalHours: json['totalHours'] as int,
        sessions: (json['sessions'] as List?)
                ?.map((s) => StudySession.fromJson(s as Map<String, dynamic>))
                .toList() ??
            [],
        focusPattern: FocusPattern.values.firstWhere(
          (e) => e.name == json['focusPattern'],
          orElse: () => FocusPattern.morning,
        ),
      );
}

class StudySession {
  final String id;
  final String subject;
  final DateTime startTime;
  final DateTime endTime;
  final int pomodoros;
  final bool completed;

  StudySession({
    required this.id,
    required this.subject,
    required this.startTime,
    required this.endTime,
    this.pomodoros = 1,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'subject': subject,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'pomodoros': pomodoros,
        'completed': completed,
      };

  factory StudySession.fromJson(Map<String, dynamic> json) => StudySession(
        id: json['id'] as String,
        subject: json['subject'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        pomodoros: json['pomodoros'] as int? ?? 1,
        completed: json['completed'] as bool? ?? false,
      );
}

enum FocusPattern { morning, afternoon, evening, flexible }
