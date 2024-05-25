class GeminiModel {
  final bool isPrompt;
  final String message;
  final DateTime time;

  GeminiModel(
      {required this.isPrompt, required this.message, required this.time});
}
