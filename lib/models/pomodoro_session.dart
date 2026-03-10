class PomodoroSession {
  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final int durationMinutes;
  final String? subject;
  final bool completed;

  PomodoroSession({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    this.subject,
    this.completed = true,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'durationMinutes': durationMinutes,
        'subject': subject,
        'completed': completed,
      };

  factory PomodoroSession.fromJson(Map<String, dynamic> json) =>
      PomodoroSession(
        id: json['id'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        durationMinutes: json['durationMinutes'] as int,
        subject: json['subject'] as String?,
        completed: json['completed'] as bool? ?? true,
      );
}
