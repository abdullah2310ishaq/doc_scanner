// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Dokumentenscanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonShare => 'Teilen';

  @override
  String get commonCopy => 'Kopieren';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonLoading => 'Wird geladen…';

  @override
  String get commonError => 'Etwas ist schiefgelaufen';

  @override
  String get commonTryAgain => 'Bitte erneut versuchen';

  @override
  String get navHome => 'Startseite';

  @override
  String get navScan => 'Scannen';

  @override
  String get navDocuments => 'Dokumente';

  @override
  String get navTranslate => 'Übersetzen';

  @override
  String get navLive => 'Live';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String homeGreeting(String name) {
    return 'Guten Morgen, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'KI-Dokumenten';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Menü öffnen';

  @override
  String get homeTagAiPowered => 'KI-gestützt';

  @override
  String get homeTagFastOcr => 'Schnelles OCR';

  @override
  String get homeTagSecure => 'Sicher';

  @override
  String get homeTagSmartCrop => 'Intelligenter Zuschnitt';

  @override
  String get homeHeroBadge => 'KI POWERED';

  @override
  String get homeHeroTitle => 'Intelligenter KI-OCR\nScanner';

  @override
  String get homeHeroSubtitle =>
      'KI-gestützte OCR mit schneller und präziser Texterkennung in Sekunden.';

  @override
  String get homeHeroButton => 'OCR Scanner';

  @override
  String get homeSearchHint => 'Hier suchen';

  @override
  String get homeFeatureOcrTitle => 'OCR Scanner';

  @override
  String get homeFeatureOcrSubtitle =>
      'Text aus Bildern oder Dokumenten extrahieren';

  @override
  String get homeFeaturePdfTitle => 'PDF Assistent';

  @override
  String get homeFeaturePdfSubtitle => 'PDFs übersetzen & transkribieren';

  @override
  String get homeFeatureChatbotTitle => 'KI Chatbot';

  @override
  String get homeFeatureChatbotSubtitle => 'PDF hochladen und Fragen stellen';

  @override
  String get homeFeatureCropTitle => 'Intelligenter Zuschnitt';

  @override
  String get homeFeatureCropSubtitle =>
      'Automatisch zuschneiden und verbessern';

  @override
  String get homeRecentDocuments => 'Letzte Dokumente';

  @override
  String get homeSeeAll => 'Alle anzeigen';

  @override
  String get homeEmptyDocuments =>
      'Keine Dokumente vorhanden. Tippe auf Scannen.';

  @override
  String get homeSampleDocName => 'Rechnung_2026.pdf';

  @override
  String get homeSampleDocMeta => '10. Mai 2026 • 2,4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDFs';

  @override
  String get homeRecentImagesFolder => 'Images';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files',
      one: '1 file',
      zero: '0 files',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count files',
      one: '1 file',
      zero: '0 files',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDFs';

  @override
  String get homeRecentImagesTitle => 'Images';

  @override
  String get homeRecentAdded => 'Recent Added';

  @override
  String get homeRecentSelect => 'Select';

  @override
  String get homeRecentSearchPdfs => 'Search your PDFs…';

  @override
  String get homeRecentSearchImages => 'Search your images…';

  @override
  String get homeRecentNoSearchResults => 'No files match your search';

  @override
  String get homeRecentToggleFavorite => 'Favorite';

  @override
  String get homeRecentPdfEmptyTitle => 'No PDF yet';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Upload or scan documents to create your first PDF';

  @override
  String get homeRecentImageEmptyTitle => 'No Image yet';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Upload or scan images to organize them here';

  @override
  String get homeRecentUploadPdf => 'Upload a PDF';

  @override
  String get homeRecentUploadImages => 'Upload Images';

  @override
  String get homeRecentScanDocument => 'Scan Document';

  @override
  String get scanTitle => 'Scannen';

  @override
  String get scanCapture => 'Aufnehmen';

  @override
  String get scanImportGallery => 'Aus Galerie importieren';

  @override
  String get scanImportFiles => 'Datei importieren';

  @override
  String get scanAddPage => 'Seite hinzufügen';

  @override
  String get scanRetake => 'Erneut aufnehmen';

  @override
  String get scanCrop => 'Zuschneiden';

  @override
  String get scanEnhance => 'Verbessern';

  @override
  String get scanDone => 'Fertig';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Seiten',
      one: '1 Seite',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'Scan wird gespeichert…';

  @override
  String get scanSaved => 'Dokument gespeichert';

  @override
  String get ocrTitle => 'Texterkennung';

  @override
  String get ocrRun => 'Text erkennen';

  @override
  String get ocrRunning => 'Text wird gelesen…';

  @override
  String get ocrEmpty => 'Kein Text gefunden';

  @override
  String get ocrCopySuccess => 'Text kopiert';

  @override
  String get ocrEditHint => 'Erkannten Text bearbeiten';

  @override
  String get ocrInputMethodTitle => 'Eingabemethode wählen';

  @override
  String get ocrInputMethodSubtitle =>
      'Wähle, wie du Text extrahieren möchtest';

  @override
  String get ocrInputLiveCameraTitle => 'Live Kamera';

  @override
  String get ocrInputLiveCameraDescription => 'Foto mit Kamera aufnehmen';

  @override
  String get ocrInputUploadImageTitle => 'Bild hochladen';

  @override
  String get ocrInputUploadImageDescription => 'Aus Galerie wählen';

  @override
  String get ocrLiveCameraTitle => 'Live OCR Kamera';

  @override
  String get ocrLiveCameraTip => 'Tipp: Gute Beleuchtung verbessert Ergebnisse';

  @override
  String get ocrLiveCameraClose => 'Kamera schließen';

  @override
  String get ocrLiveCameraFlash => 'Blitz umschalten';

  @override
  String get ocrLiveCameraCapture => 'Bild für OCR aufnehmen';

  @override
  String get ocrLiveCameraInitializing => 'Kamera startet…';

  @override
  String get ocrAnalyzeTitle => 'OCR Scanner';

  @override
  String get ocrAnalyzeCopy => 'Kopieren';

  @override
  String get ocrAnalyzeTranslate => 'Übersetzen';

  @override
  String get ocrAnalyzeProcessing => 'Analyse läuft…';

  @override
  String get ocrAnalyzeTranslateNext => 'Übersetzung wird geöffnet';

  @override
  String get ocrNoTextTitle => 'Kein lesbarer Text';

  @override
  String get ocrNoTextHint => 'Versuche ein klareres Bild';

  @override
  String get ocrNoTextRetakePhoto => 'Foto neu aufnehmen';

  @override
  String get ocrNoTextChooseGallery => 'Aus Galerie wählen';

  @override
  String get translateTitle => 'Übersetzen';

  @override
  String get translateSourceLanguage => 'Von';

  @override
  String get translateTargetLanguage => 'Nach';

  @override
  String get translateSwapLanguages => 'Sprachen tauschen';

  @override
  String get translateButton => 'Übersetzen';

  @override
  String get translateRunning => 'Übersetzung läuft…';

  @override
  String get translatePasteHint => 'Text einfügen oder eingeben';

  @override
  String get translateCopyResult => 'Übersetzung kopieren';

  @override
  String get translateResultTitle => 'Übersetzung';

  @override
  String get translateResultSubtitle => 'Übersetze deinen Text in jede Sprache';

  @override
  String get translateSelectedText => 'Ausgewählter Text';

  @override
  String get translateSelectedLanguage => 'Ausgewählte Sprache';

  @override
  String get translateSelectLanguage => 'Sprache wählen';

  @override
  String get translateSearchLanguage => 'Sprache suchen';

  @override
  String get translateRecentLanguages => 'Zuletzt';

  @override
  String get translateNoLanguagesFound => 'Keine Sprachen gefunden';

  @override
  String get translateTranslatedText => 'Übersetzter Text';

  @override
  String get translatePlaceholder => 'Übersetzung erscheint hier…';

  @override
  String get translateSeeMore => 'Mehr anzeigen';

  @override
  String get translateReadAloud => 'Vorlesen';

  @override
  String get translateSavePdf => 'Als PDF speichern';

  @override
  String get translateSavePng => 'Als Bild speichern';

  @override
  String get translateSaveComingSoon => 'Bald verfügbar';

  @override
  String get translateDownloadOptionTitle => 'Download-Option wählen';

  @override
  String get translateDownloadOptionSubtitle =>
      'Wähle, was du herunterladen möchtest';

  @override
  String get translateDownloadSelectedTextTitle =>
      'Ausgewählten Text herunterladen';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Nur ausgewählten Text herunterladen';

  @override
  String get translateDownloadCompleteFileTitle =>
      'Komplette Datei herunterladen';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Gesamte Datei herunterladen';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Übersetzten Text herunterladen';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Nur übersetzten Text herunterladen';

  @override
  String get translateSavePdfSuccess => 'PDF erfolgreich gespeichert';

  @override
  String get translateSavePngSuccess => 'Bild erfolgreich gespeichert';

  @override
  String get translateExportNeedsTranslation => 'Bitte zuerst übersetzen';

  @override
  String get liveTitle => 'Live Übersetzung';

  @override
  String get liveStart => 'Kamera starten';

  @override
  String get liveStop => 'Stopp';

  @override
  String get liveListening => 'Erkennung läuft…';

  @override
  String get livePointAtText => 'Kamera auf Text richten';

  @override
  String get livePermissionNeeded => 'Kamerazugriff erforderlich';

  @override
  String get documentsTitle => 'Meine Dokumente';

  @override
  String get documentRename => 'Umbenennen';

  @override
  String get documentDeleteConfirmTitle => 'Dokument löschen?';

  @override
  String get documentDeleteConfirmMessage =>
      'Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get documentDeleted => 'Dokument gelöscht';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'App-Sprache';

  @override
  String get settingsTheme => 'Design';

  @override
  String get settingsAbout => 'Über';

  @override
  String get settingsPrivacy => 'Datenschutz';

  @override
  String get settingsTerms => 'Nutzungsbedingungen';

  @override
  String get permissionCameraTitle => 'Kameraberechtigung';

  @override
  String get permissionCameraMessage =>
      'Zugriff auf Kamera erlauben zum Scannen.';

  @override
  String get permissionStorageTitle => 'Speicherberechtigung';

  @override
  String get permissionStorageMessage => 'Zugriff zum Speichern erlauben.';

  @override
  String get permissionOpenSettings => 'Einstellungen öffnen';

  @override
  String get permissionDenied => 'Berechtigung verweigert';

  @override
  String get errorCameraUnavailable => 'Kamera nicht verfügbar';

  @override
  String get errorFileRead => 'Datei konnte nicht gelesen werden';

  @override
  String get errorNetwork => 'Internetverbindung prüfen';

  @override
  String get errorNoInternetFeatures => 'Keine Internetverbindung';

  @override
  String get exitAppTitle => 'App beenden';

  @override
  String get exitAppMessage => 'Wirklich beenden?';

  @override
  String get exitAppConfirm => 'Beenden';

  @override
  String get errorOcrFailed => 'Texterkennung fehlgeschlagen';

  @override
  String get errorTranslateFailed => 'Übersetzung fehlgeschlagen';

  @override
  String get errorTranslateModelDownload =>
      'Sprachpaket konnte nicht geladen werden';

  @override
  String get errorTranslateUnsupportedLanguage => 'Sprache nicht unterstützt';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'Unbegrenzte Scans und OCR';

  @override
  String get proUpgradeButton => 'Auf Pro upgraden';

  @override
  String get proRestorePurchases => 'Käufe wiederherstellen';

  @override
  String get proFeatureLocked => 'Pro Funktion';

  @override
  String proLimitPages(int max) {
    return 'Kostenlos: bis $max Seiten';
  }

  @override
  String get proLimitOcr => 'Unbegrenztes OCR nur mit Pro';

  @override
  String get proLimitTranslate => 'Alle Sprachen nur mit Pro';

  @override
  String get proLimitLive => 'Live Übersetzung nur Pro';

  @override
  String get proPurchaseSuccess => 'Willkommen bei Pro!';

  @override
  String get proPurchaseFailed => 'Kauf fehlgeschlagen';

  @override
  String get exportPdf => 'PDF exportieren';

  @override
  String get exportImage => 'Bild exportieren';

  @override
  String get exportSuccess => 'Export abgeschlossen';

  @override
  String get exportFailed => 'Export fehlgeschlagen';

  @override
  String get languageSearchHint => 'Sprache suchen';

  @override
  String get languageAuto => 'Automatische Erkennung';

  @override
  String get chatbotTitle => 'KI Chatbot';

  @override
  String get chatbotHistoryButton => 'Verlauf';

  @override
  String get chatbotBadge => 'Dein KI-Assistent';

  @override
  String get chatbotHeadlineChat => 'Chat';

  @override
  String get chatbotHeadlineMiddle => ' mit deinem ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Versuche zu fragen';

  @override
  String get chatbotSuggestSummarize => 'PDF zusammenfassen';

  @override
  String get chatbotSuggestKeyPoints => 'Wichtige Punkte';

  @override
  String get chatbotSuggestExplain => 'Detailliert erklären';

  @override
  String get chatbotSuggestTranslate => 'PDF übersetzen';

  @override
  String get chatbotAskQuestions => 'Fragen zu dieser PDF-Datei stellen';

  @override
  String get chatbotUploadHint => 'PDF hochladen...';

  @override
  String get chatbotSheetTitle => 'Chat mit PDF';

  @override
  String get chatbotSheetSubtitle => 'PDF hochladen und Fragen stellen';

  @override
  String get chatbotChoosePdfTitle => 'PDF auswählen';

  @override
  String get chatbotChoosePdfDescription => 'Vom Gerät auswählen';

  @override
  String get chatbotRecentFilesTitle => 'Letzte Dateien';

  @override
  String get chatbotRecentFilesDescription => 'Aus Verlauf wählen';

  @override
  String get errorChatbotPdfPickFailed => 'PDF konnte nicht geöffnet werden';

  @override
  String get chatbotAnalyzingTitle => 'Dokument wird analysiert...';

  @override
  String get chatbotAnalyzingSubtitle => 'Bitte warten';

  @override
  String get chatbotStepReadingPdf => 'PDF lesen';

  @override
  String get chatbotStepExtractingText => 'Text extrahieren';

  @override
  String get chatbotStepUnderstandingContent => 'Inhalt verstehen';

  @override
  String get chatbotStepPreparingChat => 'Chat vorbereiten';

  @override
  String get chatbotHistoryTitle => 'Verlauf';

  @override
  String get chatbotNoConversationsTitle => 'Keine Chats';

  @override
  String get chatbotNoConversationsSubtitle => 'PDF hochladen zum Starten';

  @override
  String get chatbotUploadPdfButton => 'PDF hochladen';

  @override
  String get chatbotDocumentReadyTitle => 'Dokument bereit';

  @override
  String get chatbotDocumentReadySubtitle => 'Kurze Zusammenfassung';

  @override
  String get chatbotCurrentSummary => 'Zusammenfassung';

  @override
  String get chatbotStartChatting => 'Chat starten';

  @override
  String get chatbotChatGreeting => '👋🏻 Hallo! Frag mich etwas zum PDF.';

  @override
  String get chatbotChatYouCanAsk => 'Du kannst fragen:';

  @override
  String get chatbotChatPromptSummarize => 'Zusammenfassen';

  @override
  String get chatbotChatPromptHighlights => 'Wichtige Punkte';

  @override
  String get chatbotChatPromptFinancial => 'Finanzdaten anzeigen';

  @override
  String get chatbotChatPromptDates => 'Wichtige Daten extrahieren';

  @override
  String get chatbotChatInputHint => 'Frage etwas zum PDF...';

  @override
  String get chatbotDeleteTitle => 'Chat löschen?';

  @override
  String get chatbotDeleteMessage => 'Unwiderruflich.';

  @override
  String get chatbotRenameTitle => 'PDF umbenennen';

  @override
  String get chatbotRenameHint => 'Name eingeben';

  @override
  String get chatbotAnalyzeFailed => 'Analyse fehlgeschlagen';

  @override
  String get chatbotChatFailed => 'Antwort fehlgeschlagen';

  @override
  String get errorChatbotPdfEmpty => 'Kein Text gefunden';

  @override
  String get pdfAssistantTitle => 'PDF Assistent';

  @override
  String get pdfAssistantSheetTitle => 'PDF hochladen';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Wählen Sie aus, wie Sie Ihre PDF-Datei hinzufügen möchten';

  @override
  String get pdfAssistantChoosePdfTitle => 'PDF auswählen';

  @override
  String get pdfAssistantChoosePdfDescription => 'Vom Gerät auswählen';

  @override
  String get pdfAssistantLinkTitle => 'PDF-Link hinzufügen';

  @override
  String get pdfAssistantLinkDescription =>
      'PDF-Link einfügen zum direkten Hochladen';

  @override
  String get pdfAssistantLinkHint => 'URL einfügen';

  @override
  String get pdfAssistantLinkButton => 'Herunterladen';

  @override
  String get pdfAssistantTranslateTo => 'Übersetzen nach';

  @override
  String get pdfAssistantStartProcessing => 'Starten';

  @override
  String get pdfAssistantNoFileSelected => 'Keine Datei';

  @override
  String get pdfAssistantSelectLanguage => 'Sprache wählen';

  @override
  String get pdfAssistantProcessingTitle => 'Verarbeitung läuft…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Bitte warten';

  @override
  String get pdfAssistantStepExtracting => 'Extrahieren…';

  @override
  String get pdfAssistantStepTranslating => 'Übersetzen…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'PDF erstellen…';

  @override
  String get pdfAssistantStepFinalizing => 'Fertigstellen…';

  @override
  String get pdfAssistantResultTitle => 'Ergebnis';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'Übersetztes PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'Original Layout';

  @override
  String get pdfAssistantExtractedTextTitle => 'Extrahierter Text';

  @override
  String get pdfAssistantExtractedTextDescription => 'Einfaches Dokument';

  @override
  String get pdfAssistantActionOpen => 'Öffnen';

  @override
  String get pdfAssistantActionDownload => 'Download';

  @override
  String get pdfAssistantDeleteTitle => 'Löschen?';

  @override
  String get pdfAssistantDeleteMessage => 'Unwiderruflich';

  @override
  String get pdfAssistantDownloadSuccess => 'Gespeichert';

  @override
  String get pdfAssistantOpenFailed => 'Kann nicht geöffnet werden';

  @override
  String get pdfAssistantProcessFailed => 'Fehler bei Verarbeitung';

  @override
  String get errorPdfAssistantPickFailed => 'Auswahl fehlgeschlagen';

  @override
  String get errorPdfAssistantLinkFailed => 'Link ungültig';

  @override
  String get errorPdfAssistantPdfEmpty => 'Leeres PDF';

  @override
  String get pdfAssistantRemoveTitle => 'PDF entfernen';

  @override
  String get pdfAssistantRemoveWarning =>
      'Dadurch wird das PDF von Ihrem Gerät entfernt.';

  @override
  String get pdfAssistantUploadPdf => 'PDF hochladen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get remove => 'Entfernen';

  @override
  String get commonNext => 'Weiter';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonContinue => 'Fortfahren';

  @override
  String get onboardingStart => 'Start';

  @override
  String get splashTagline => 'KI-gestütztes Dokumentenscannen';

  @override
  String get onboardingPage1Title => 'Dokumente scannen';

  @override
  String get onboardingPage1Description =>
      'Belege und Notizen schnell erfassen.';

  @override
  String get onboardingPage2Title => 'OCR & Übersetzung';

  @override
  String get onboardingPage2Description => 'Text extrahieren und übersetzen.';

  @override
  String get onboardingPage3Title => 'Speichern & Exportieren';

  @override
  String get onboardingPage3Description => 'Alles an einem Ort speichern.';

  @override
  String get settingsChooseLanguage => 'Sprache wählen';

  @override
  String get settingsLanguageApply => 'Anwenden';

  @override
  String get commonSaving => 'Wird gespeichert…';

  @override
  String get smartCropTitle => 'Smart Crop';

  @override
  String get smartCropInputMethodTitle => 'Smart Crop Scanner';

  @override
  String get smartCropInputMethodSubtitle =>
      'Choose how you want to crop your document';

  @override
  String get smartCropInputLiveCameraTitle => 'Live Camera';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Google scanner — auto edges, crop and enhance';

  @override
  String get smartCropInputUploadImageTitle => 'Upload Image';

  @override
  String get smartCropInputUploadImageDescription =>
      'Upload document image from gallery';

  @override
  String get smartCropUploadIntroHeadline =>
      'Crop Multiple Images\nAutomatically';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Automatically detect edges, crop images perfectly and create a PDF in one tap.';

  @override
  String get smartCropUploadIntroStepSelect => 'Select multiple images';

  @override
  String get smartCropUploadIntroStepCrop => 'Auto detect and crop';

  @override
  String get smartCropUploadIntroStepPdf => 'Create PDF instantly';

  @override
  String get smartCropUploadIntroSelectImages => 'Select Images';

  @override
  String get smartCropLiveCameraTitle => 'Smart Crop Camera';

  @override
  String get smartCropLiveCameraTip => 'Document detected — tap to capture';

  @override
  String get smartCropLiveCameraAlignTip => 'Align document inside the corners';

  @override
  String get smartCropLiveCameraClose => 'Close camera';

  @override
  String get smartCropLiveCameraFlash => 'Toggle flash';

  @override
  String get smartCropLiveCameraCapture =>
      'Capture document for smart cropping';

  @override
  String get smartCropLiveCameraInitializing => 'Starting camera…';

  @override
  String get smartCropCapturedTitle => 'Captured Document';

  @override
  String get smartCropCapturedRetake => 'Retake last photo';

  @override
  String get smartCropCapturedAnotherPhoto => 'Add another photo';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Retake another photo';

  @override
  String get smartCropCapturedPreview => 'Preview';

  @override
  String get smartCropPreviewTitle => 'Preview';

  @override
  String get smartCropCapturedCrop => 'Crop';

  @override
  String get smartCropAdjustCornersTitle => 'Adjust corners';

  @override
  String get smartCropAdjustCornersHint =>
      'Drag the purple corners to match the document edges';

  @override
  String get smartCropAdjustCornersConfirm => 'Apply crop';

  @override
  String get smartCropDetectingEdges => 'Detecting document edges…';

  @override
  String get smartCropAndroidOnly => 'Smart scan is available on Android only.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Maximum $max photos reached';
  }

  @override
  String get smartCropProcessingCrop => 'Applying magical crop...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Cropping $count documents…';
  }

  @override
  String get smartCropCroppedTitle => 'Cropped Document';

  @override
  String get smartCropFilterOriginal => 'Original';

  @override
  String get smartCropFilterLighten => 'Lighten';

  @override
  String get smartCropFilterMagic => 'Magic';

  @override
  String get smartCropFilterGrayscale => 'Grayscale';

  @override
  String get smartCropFilterMono => 'B&W';

  @override
  String get smartCropFilterWarm => 'Warm';

  @override
  String get smartCropActionCreatePdf => 'Create PDF';

  @override
  String get smartCropProcessingPdf => 'Generating PDF document...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Generating PDF with $count pages…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF document generated successfully';

  @override
  String get smartCropPdfPagesLabel => 'pages';

  @override
  String get smartCropPdfSinglePageLabel => '1 page';

  @override
  String get smartCropImageCopied => 'Copied';

  @override
  String get smartCropDeleteImageConfirm =>
      'Remove this page from the document?';

  @override
  String get smartCropDeletePdfConfirm => 'Delete this PDF from your device?';

  @override
  String get smartCropPdfRenamed => 'PDF renamed';

  @override
  String get smartCropPdfFileName => 'File name';

  @override
  String get smartCropPdfFileSize => 'File size';

  @override
  String get smartCropViewPdf => 'View PDF';

  @override
  String get smartCropSavePdf => 'Save PDF';

  @override
  String get smartCropRenamePdf => 'Rename';

  @override
  String get smartCropRenamePdfHint => 'Document name';
}
