import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:study_sync/models/study_plan.dart';
import 'package:study_sync/services/ai_schedule_service.dart';

class StudyProvider extends ChangeNotifier {
  List<StudyPlan> _plans = [];
  bool _isLoading = false;
  String? _error;

  List<StudyPlan> get plans => _plans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final AiScheduleService _aiService = AiScheduleService();

  StudyProvider() {
    _loadPlans();
  }

  Future<void> _loadPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('studyPlans');
    if (jsonList != null) {
      _plans = jsonList
          .map((j) => StudyPlan.fromJson(jsonDecode(j) as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _savePlans() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        _plans.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList('studyPlans', jsonList);
  }

  Future<void> generatePlan({
    required String goal,
    required DateTime deadline,
    required int hoursPerDay,
    required FocusPattern focusPattern,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final plan = await _aiService.generateSchedule(
        goal: goal,
        deadline: deadline,
        hoursPerDay: hoursPerDay,
        focusPattern: focusPattern,
      );
      _plans.insert(0, plan);
      await _savePlans();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addPlan(StudyPlan plan) {
    _plans.insert(0, plan);
    _savePlans();
    notifyListeners();
  }

  void removePlan(String id) {
    _plans.removeWhere((p) => p.id == id);
    _savePlans();
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
