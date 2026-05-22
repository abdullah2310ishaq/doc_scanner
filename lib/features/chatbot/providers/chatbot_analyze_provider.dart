import 'package:flutter/foundation.dart';

import '../models/chatbot_session_model.dart';
import '../services/chatbot_openai_service.dart';
import '../services/chatbot_pdf_extract_service.dart';
import '../../home/services/recent_documents_service.dart';
import '../services/chatbot_storage_service.dart';

enum ChatbotAnalyzeStep {
  readingPdf,
  extractingText,
  understandingContent,
  preparingChat,
}

enum ChatbotAnalyzeStatus { idle, running, success, failed }

class ChatbotAnalyzeProvider extends ChangeNotifier {
  ChatbotAnalyzeProvider({
    required this.sourcePdfPath,
    ChatbotPdfExtractService? extractService,
    ChatbotOpenAiService? openAiService,
    ChatbotStorageService? storageService,
  })  : _extractService = extractService ?? ChatbotPdfExtractService(),
        _openAiService = openAiService ?? ChatbotOpenAiService(),
        _storageService = storageService ?? ChatbotStorageService();

  final String sourcePdfPath;
  final ChatbotPdfExtractService _extractService;
  final ChatbotOpenAiService _openAiService;
  final ChatbotStorageService _storageService;

  ChatbotAnalyzeStatus status = ChatbotAnalyzeStatus.idle;
  ChatbotAnalyzeStep currentStep = ChatbotAnalyzeStep.readingPdf;
  int completedSteps = 0;
  String? errorMessage;
  String? errorCode;
  ChatbotSessionModel? session;

  static const int totalSteps = 4;

  double get progressFraction {
    if (status == ChatbotAnalyzeStatus.success) return 1;
    return completedSteps / totalSteps;
  }

  Future<void> start() async {
    if (status == ChatbotAnalyzeStatus.running) return;

    status = ChatbotAnalyzeStatus.running;
    completedSteps = 0;
    currentStep = ChatbotAnalyzeStep.readingPdf;
    errorMessage = null;
    errorCode = null;
    session = null;
    notifyListeners();

    try {
      final sessionId = DateTime.now().millisecondsSinceEpoch.toString();
      final storedPath = await _storageService.copyPdfToAppStorage(
        sourcePath: sourcePdfPath,
        sessionId: sessionId,
      );
      await RecentDocumentsService().registerPdf(
        storedPath,
        displayName: _storageService.displayNameFromPath(sourcePdfPath),
      );
      _completeStep(ChatbotAnalyzeStep.extractingText);

      final extractedText = await _extractService.extractText(storedPath);
      if (extractedText.isEmpty) {
        errorCode = 'empty_pdf';
        throw StateError('empty_pdf');
      }
      _completeStep(ChatbotAnalyzeStep.understandingContent);

      final summary = await _openAiService.summarizeDocument(extractedText);
      _completeStep(ChatbotAnalyzeStep.preparingChat);

      final now = DateTime.now();
      final saved = await _storageService.saveSession(
        ChatbotSessionModel(
          id: sessionId,
          pdfPath: storedPath,
          displayName: _storageService.displayNameFromPath(sourcePdfPath),
          extractedText: extractedText,
          summary: summary,
          messages: const [],
          createdAt: now,
          updatedAt: now,
        ),
      );

      session = saved;
      status = ChatbotAnalyzeStatus.success;
      completedSteps = totalSteps;
      notifyListeners();
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[ChatbotAnalyze] $error\n$stack');
      }
      status = ChatbotAnalyzeStatus.failed;
      errorMessage = error.toString();
      notifyListeners();
    }
  }

  void _completeStep(ChatbotAnalyzeStep nextStep) {
    completedSteps++;
    currentStep = nextStep;
    notifyListeners();
  }
}
