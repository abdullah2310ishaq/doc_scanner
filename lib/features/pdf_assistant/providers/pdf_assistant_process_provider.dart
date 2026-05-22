import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

import '../../home/providers/recent_documents_provider.dart';
import '../../home/services/recent_documents_service.dart';
import '../../translate/models/translate_language.dart';
import '../models/pdf_assistant_session_model.dart';
import '../services/pdf_assistant_extract_service.dart';
import '../services/pdf_assistant_pdf_builder_service.dart';
import '../services/pdf_assistant_storage_service.dart';
import '../services/pdf_assistant_translate_service.dart';

enum PdfAssistantProcessStep {
  extracting,
  translating,
  generatingPdf,
  finalizing,
}

enum PdfAssistantProcessStatus { idle, running, success, failed }

class PdfAssistantProcessProvider extends ChangeNotifier {
    PdfAssistantProcessProvider({
    required this.originalPath,
    required this.displayName,
    required this.targetLanguage,
    required this.pageLabelFor,
    PdfAssistantExtractService? extractService,
    PdfAssistantTranslateService? translateService,
    PdfAssistantPdfBuilderService? pdfBuilderService,
    PdfAssistantStorageService? storageService,
  })  : _extractService = extractService ?? PdfAssistantExtractService(),
        _translateService = translateService ?? PdfAssistantTranslateService(),
        _pdfBuilderService = pdfBuilderService ?? PdfAssistantPdfBuilderService(),
        _storageService = storageService ?? PdfAssistantStorageService();

  final String originalPath;
  final String displayName;
  final TranslateLanguage targetLanguage;
  final String Function(int pageNumber) pageLabelFor;

  final PdfAssistantExtractService _extractService;
  final PdfAssistantTranslateService _translateService;
  final PdfAssistantPdfBuilderService _pdfBuilderService;
  final PdfAssistantStorageService _storageService;

  PdfAssistantProcessStatus status = PdfAssistantProcessStatus.idle;
  PdfAssistantProcessStep currentStep = PdfAssistantProcessStep.extracting;
  double completedSteps = 0;
  String? errorCode;
  PdfAssistantSessionModel? session;

  static const double totalSteps = 4;

  double get progressFraction {
    if (status == PdfAssistantProcessStatus.success) return 1;
    return completedSteps / totalSteps;
  }

  Future<void> start() async {
    if (status == PdfAssistantProcessStatus.running) return;

    status = PdfAssistantProcessStatus.running;
    completedSteps = 0;
    currentStep = PdfAssistantProcessStep.extracting;
    errorCode = null;
    session = null;
    notifyListeners();

    final sessionId = DateTime.now().millisecondsSinceEpoch.toString();

    try {
      final sessionDir = await _storageService.sessionDirectory(sessionId);
      final storedOriginal = await _storageService.saveOriginal(
        sessionId: sessionId,
        sourcePath: originalPath,
      );

      final extract = await _extractService.extract(storedOriginal);
      _advance(PdfAssistantProcessStep.translating);

      final translatedPages = await _translateService.translatePages(
        pageTexts: extract.pageTexts,
        targetLanguageName: targetLanguage.name,
        targetLanguageCode: targetLanguage.code,
      );

      final translatedFull = translatedPages
          .where((page) => page.trim().isNotEmpty)
          .join('\n\n');

      _advance(PdfAssistantProcessStep.generatingPdf);

      final translatedPath = p.join(sessionDir.path, 'translated.pdf');
      final extractedPath = p.join(sessionDir.path, 'extracted_text.pdf');

      await _pdfBuilderService.buildTranslatedPagesPdf(
        outputPath: translatedPath,
        translatedPageTexts: translatedPages,
        pageLabelFor: pageLabelFor,
        onProgress: (pageProgress) {
          completedSteps = 2 + pageProgress.clamp(0.0, 1.0);
          notifyListeners();
        },
      );

      await RecentDocumentsService().registerPdf(
        translatedPath,
        displayName: '${displayName}_translated',
      );
      await RecentDocumentsProvider.refreshGlobal();

      await _pdfBuilderService.buildExtractedTextPdf(
        outputPath: extractedPath,
        title: '$displayName (${targetLanguage.name})',
        translatedText: translatedFull,
      );

      final extractedTxtPath = extractedPath.replaceAll('.pdf', '.txt');
      await File(extractedTxtPath).writeAsString(translatedFull);

      _advance(PdfAssistantProcessStep.finalizing);

      session = await _storageService.saveMetadata(
        PdfAssistantSessionModel(
          id: sessionId,
          displayName: displayName,
          originalPath: storedOriginal,
          translatedPdfPath: translatedPath,
          extractedTextPdfPath: extractedPath,
          targetLanguageCode: targetLanguage.code,
          targetLanguageName: targetLanguage.name,
          createdAt: DateTime.now(),
        ),
      );

      status = PdfAssistantProcessStatus.success;
      completedSteps = totalSteps;
      notifyListeners();
    } catch (error, stack) {
      if (kDebugMode) {
        debugPrint('[PdfAssistantProcess] $error\n$stack');
      }
      await _storageService.deleteSession(sessionId);
      status = PdfAssistantProcessStatus.failed;
      errorCode = error is StateError ? error.message : 'unknown';
      notifyListeners();
    }
  }

  void _advance(PdfAssistantProcessStep nextStep) {
    completedSteps++;
    currentStep = nextStep;
    notifyListeners();
  }
}
