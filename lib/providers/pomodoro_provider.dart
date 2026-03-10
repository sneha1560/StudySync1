import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:study_sync/models/pomodoro_session.dart';
import 'package:uuid/uuid.dart';

enum PomodoroPhase { work, shortBreak, longBreak }

class PomodoroProvider extends ChangeNotifier {
  static const int workDuration = 25;
  static const int shortBreakDuration = 5;
  static const int longBreakDuration = 15;

  int _remainingSeconds = workDuration * 60;
  PomodoroPhase _phase = PomodoroPhase.work;
  bool _isRunning = false;
  Timer? _timer;
  int _completedPomodoros = 0;
  List<PomodoroSession> _sessions = [];
  String? _currentSubject;

  int get remainingSeconds => _remainingSeconds;
  PomodoroPhase get phase => _phase;
  bool get isRunning => _isRunning;
  int get completedPomodoros => _completedPomodoros;
  List<PomodoroSession> get sessions => _sessions;
  String? get currentSubject => _currentSubject;

  PomodoroProvider() {
    _loadSessions();
  }

  void setSubject(String? subject) {
    _currentSubject = subject;
    notifyListeners();
  }

  Future<void> _loadSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('pomodoroSessions');
    if (jsonList != null) {
      _sessions = jsonList
          .map((j) =>
              PomodoroSession.fromJson(jsonDecode(j) as Map<String, dynamic>))
          .toList();
      _completedPomodoros = _sessions.length;
      notifyListeners();
    }
  }

  Future<void> _saveSessions() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        _sessions.map((s) => jsonEncode(s.toJson())).toList();
    await prefs.setStringList('pomodoroSessions', jsonList);
  }

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
    notifyListeners();
  }

  void pause() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
    notifyListeners();
  }

  void _tick(Timer timer) {
    if (_remainingSeconds > 0) {
      _remainingSeconds--;
      notifyListeners();
    } else {
      _onPhaseComplete();
    }
  }

  void _onPhaseComplete() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;

    if (_phase == PomodoroPhase.work) {
      _completedPomodoros++;
      _sessions.add(PomodoroSession(
        id: const Uuid().v4(),
        startTime: DateTime.now().subtract(Duration(minutes: workDuration)),
        endTime: DateTime.now(),
        durationMinutes: workDuration,
        subject: _currentSubject,
      ));
      _saveSessions();

      if (_completedPomodoros % 4 == 0) {
        _phase = PomodoroPhase.longBreak;
        _remainingSeconds = longBreakDuration * 60;
      } else {
        _phase = PomodoroPhase.shortBreak;
        _remainingSeconds = shortBreakDuration * 60;
      }
    } else {
      _phase = PomodoroPhase.work;
      _remainingSeconds = workDuration * 60;
    }
    notifyListeners();
  }

  void reset() {
    pause();
    _remainingSeconds = workDuration * 60;
    _phase = PomodoroPhase.work;
    notifyListeners();
  }

  void skipToNext() {
    _onPhaseComplete();
  }

  String get formattedTime {
    final mins = _remainingSeconds ~/ 60;
    final secs = _remainingSeconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String get phaseLabel {
    switch (_phase) {
      case PomodoroPhase.work:
        return 'Focus Time';
      case PomodoroPhase.shortBreak:
        return 'Short Break';
      case PomodoroPhase.longBreak:
        return 'Long Break';
    }
  }
}
