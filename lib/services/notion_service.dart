/// Notion API integration (stub - add http + Notion API)
class NotionService {
  Future<bool> isConnected() async => false;

  Future<void> connect(String apiKey) async {
    // TODO: Store API key, validate connection
  }

  Future<void> createStudyPage({
    required String title,
    required String content,
  }) async {
    // TODO: Call Notion API to create page
  }

  Future<void> syncStudyPlan(Map<String, dynamic> plan) async {
    await createStudyPage(
      title: plan['title'] ?? 'Study Plan',
      content: plan.toString(),
    );
  }
}
