/// Google Calendar integration (stub - add googleapis_auth + OAuth)
class CalendarService {
  Future<bool> isConnected() async => false;

  Future<void> connect() async {
    // TODO: Implement Google Sign-In + Calendar API
  }

  Future<void> addEvent({
    required String title,
    required DateTime start,
    required DateTime end,
    String? description,
  }) async {
    // TODO: Call Google Calendar API
  }

  Future<void> syncStudySessions(List<dynamic> sessions) async {
    for (final s in sessions) {
      await addEvent(
        title: s.subject ?? 'Study Session',
        start: s.startTime,
        end: s.endTime,
      );
    }
  }
}
