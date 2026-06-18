// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Stornieren';

  @override
  String get commonSave => 'Speichern';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonShare => 'Aktie';

  @override
  String get commonCopy => 'Kopie';

  @override
  String get commonRetry => 'Wiederholen';

  @override
  String get commonClose => 'Schließen';

  @override
  String get commonDone => 'Fertig';

  @override
  String get commonLoading => 'Laden…';

  @override
  String get commonError => 'Etwas ist schief gelaufen';

  @override
  String get commonTryAgain => 'Bitte versuchen Sie es erneut';

  @override
  String get navHome => 'Heim';

  @override
  String get navScan => 'Scan';

  @override
  String get navDocuments => 'Unterlagen';

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
  String get homeTitlePrefix => 'AI-Dokument';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Menü öffnen';

  @override
  String get homeTagAiPowered => 'KI-betrieben';

  @override
  String get homeTagFastOcr => 'Schnelle OCR';

  @override
  String get homeTagSecure => 'Sicher';

  @override
  String get homeTagSmartCrop => 'Intelligente Ernte';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => 'Intelligente KI-OCR\nScanner';

  @override
  String get homeHeroSubtitle =>
      'KI-gestützte OCR mit schneller, präziser Texterkennung in Sekundenschnelle.';

  @override
  String get homeHeroButton => 'OCR-Scanner';

  @override
  String get homeSearchHint => 'Suchen Sie hier';

  @override
  String get homeFeatureOcrTitle => 'OCR-Scanner';

  @override
  String get homeFeatureOcrSubtitle =>
      'Scannen Sie Text aus Bildern oder Dokumenten';

  @override
  String get homeFeaturePdfTitle => 'PDF-Assistent';

  @override
  String get homeFeaturePdfSubtitle => 'PDF übersetzen und transkribieren';

  @override
  String get homeFeatureChatbotTitle => 'PDF fragen';

  @override
  String get homeFeatureChatbotSubtitle =>
      'Laden Sie ein PDF hoch, um Fragen zu stellen';

  @override
  String get homeFeatureCropTitle => 'Intelligente Ernte';

  @override
  String get homeFeatureCropSubtitle =>
      'Automatisches Zuschneiden, Reinigen und Verbessern';

  @override
  String get homeRecentDocuments => 'Aktuelle';

  @override
  String get homeSeeAll => 'Alle anzeigen';

  @override
  String get homeEmptyDocuments =>
      'Noch keine Dokumente. Tippen Sie zum Starten auf „Scannen“.';

  @override
  String get homeSampleDocName => 'Invoice_2026.pdf';

  @override
  String get homeSampleDocMeta => 'May 10, 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDFs';

  @override
  String get homeRecentImagesFolder => 'Bilder';

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
  String get homeRecentImagesTitle => 'Bilder';

  @override
  String get homeRecentAdded => 'Zuletzt';

  @override
  String get homeRecentSelect => 'Auswählen';

  @override
  String get homeRecentSelectAll => 'Alle auswählen';

  @override
  String get homeRecentDeselectAll => 'Auswahl aufheben';

  @override
  String get homeRecentSearchPdfs => 'PDFs suchen…';

  @override
  String get homeRecentSearchImages => 'Bilder suchen…';

  @override
  String get homeRecentNoSearchResults => 'Keine Treffer';

  @override
  String get homeRecentToggleFavorite => 'Favorit';

  @override
  String get homeRecentUnfavorite => 'Entfernen';

  @override
  String get homeRecentFavoriteAdded => 'Zu Favoriten hinzugefügt';

  @override
  String get homeRecentFavoriteRemoved => 'Aus Favoriten entfernt';

  @override
  String get homeRecentPdfEmptyTitle => 'Keine aktuellen PDFs';

  @override
  String get homeRecentPdfEmptySubtitle => 'PDF hochladen oder scannen';

  @override
  String get homeRecentImageEmptyTitle => 'Keine aktuellen Bilder';

  @override
  String get homeRecentImageEmptySubtitle => 'Bilder hochladen oder scannen';

  @override
  String get homeRecentUploadPdf => 'PDF hochladen';

  @override
  String get homeRecentUploadImages => 'Bilder hochladen';

  @override
  String get homeRecentScanDocument => 'Scannen';

  @override
  String get homeRecentDeleteImageTitle => 'Bild löschen?';

  @override
  String get homeRecentDeleteImageMessage =>
      'Möchten Sie dieses Bild wirklich löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get homeRecentDeleteImagesTitle => 'Bilder löschen?';

  @override
  String get homeRecentDeleteImagesMessage =>
      'Möchten Sie die ausgewählten Bilder wirklich löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get scanTitle => 'Scan';

  @override
  String get scanCapture => 'Erfassen';

  @override
  String get scanImportGallery => 'Aus Galerie importieren';

  @override
  String get scanImportFiles => 'Datei importieren';

  @override
  String get scanAddPage => 'Seite hinzufügen';

  @override
  String get scanRetake => 'Wiederholung';

  @override
  String get scanCrop => 'Ernte';

  @override
  String get scanEnhance => 'Erweitern';

  @override
  String get scanDone => 'Erledigt';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
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
  String get ocrRunning => 'Text lesen…';

  @override
  String get ocrEmpty => 'In diesem Bild wurde kein Text gefunden';

  @override
  String get ocrCopySuccess => 'Text kopiert';

  @override
  String get ocrEditHint => 'Bearbeiten Sie erkannten Text';

  @override
  String get ocrInputMethodTitle => 'Wählen Sie Eingabemethode';

  @override
  String get ocrInputMethodSubtitle =>
      'Wählen Sie aus, wie Sie Text extrahieren möchten';

  @override
  String get ocrInputLiveCameraTitle => 'Live-Kamera';

  @override
  String get ocrInputLiveCameraDescription =>
      'Erfassen Sie Livebilder mit der Kamera';

  @override
  String get ocrInputUploadImageTitle => 'Bild hochladen';

  @override
  String get ocrInputUploadImageDescription => 'Bild aus der Galerie hochladen';

  @override
  String get ocrLiveCameraTitle => 'Live-OCR-Kamera';

  @override
  String get ocrLiveCameraTip =>
      'Tipp: Um bessere Ergebnisse zu erzielen, platzieren Sie den Text in einem gut beleuchteten Bereich';

  @override
  String get ocrLiveCameraClose => 'Kamera schließen';

  @override
  String get ocrLiveCameraFlash => 'Blitz umschalten';

  @override
  String get ocrLiveCameraCapture => 'Erfassen Sie ein Bild zur Texterkennung';

  @override
  String get ocrLiveCameraInitializing => 'Kamera wird gestartet…';

  @override
  String get ocrAnalyzeTitle => 'OCR-Scanner';

  @override
  String get ocrAnalyzeCopy => 'Kopie';

  @override
  String get ocrAnalyzeTranslate => 'Übersetzen';

  @override
  String get ocrAnalyzeProcessing => 'Text analysieren…';

  @override
  String get ocrAnalyzeTranslateNext =>
      'Als nächstes wird „Übersetzen“ geöffnet';

  @override
  String get ocrNoTextTitle => 'Kein lesbarer Text erkannt';

  @override
  String get ocrNoTextHint => 'Versuchen Sie es mit einem klareren Bild';

  @override
  String get ocrNoTextRetakePhoto => 'Foto erneut aufnehmen';

  @override
  String get ocrNoTextChooseGallery => 'Wählen Sie aus der Galerie';

  @override
  String get translateTitle => 'Übersetzen';

  @override
  String get translateSourceLanguage => 'Aus';

  @override
  String get translateTargetLanguage => 'Zu';

  @override
  String get translateSwapLanguages => 'Sprachen tauschen';

  @override
  String get translateButton => 'Übersetzen';

  @override
  String get translateRunning => 'Übersetzen…';

  @override
  String get translatePasteHint => 'Fügen Sie Text ein oder geben Sie ihn ein';

  @override
  String get translateCopyResult => 'Übersetzung kopieren';

  @override
  String get translateResultTitle => 'Text übersetzen';

  @override
  String get translateResultSubtitle =>
      'Übersetzen Sie Ihren ausgewählten Text in eine beliebige Sprache';

  @override
  String get translateSelectedText => 'Ausgewählter Text';

  @override
  String get translateSelectedLanguage => 'Ausgewählte Sprache';

  @override
  String get translateSelectLanguage => 'Wählen Sie Sprache aus';

  @override
  String get translateSearchLanguage => 'Sprachen suchen';

  @override
  String get translateRecentLanguages => 'Jüngste';

  @override
  String get translateNoLanguagesFound => 'Keine Sprachen gefunden';

  @override
  String get translateTranslatedText => 'Übersetzter Text';

  @override
  String get translatePlaceholder => 'Die Übersetzung erscheint hier.';

  @override
  String get translateSeeMore => 'Mehr anzeigen';

  @override
  String get translateReadAloud => 'Vorlesen';

  @override
  String get translateSavePdf => 'Als PDF speichern';

  @override
  String get translateSavePng => 'Als PNG speichern';

  @override
  String get translateSaveComingSoon => 'Speichern wird bald verfügbar sein';

  @override
  String get translateDownloadOptionTitle => 'Wählen Sie die Download-Option';

  @override
  String get translateDownloadOptionSubtitle =>
      'Wählen Sie aus, was Sie herunterladen möchten';

  @override
  String get translateDownloadSelectedTextTitle =>
      'Ausgewählten Text herunterladen';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Laden Sie nur den ausgewählten Text herunter';

  @override
  String get translateDownloadCompleteFileTitle =>
      'Komplette Datei herunterladen';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Laden Sie die gesamte Datei herunter';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Laden Sie den übersetzten Text herunter';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Laden Sie nur den übersetzten Text herunter';

  @override
  String get translateSavePdfSuccess => 'PDF erfolgreich gespeichert';

  @override
  String get translateSavePngSuccess => 'Bild erfolgreich gespeichert';

  @override
  String get translateExportNeedsTranslation =>
      'Übersetzen Sie den Text vor dem Herunterladen';

  @override
  String get liveTitle => 'Live-Übersetzung';

  @override
  String get liveStart => 'Kamera starten';

  @override
  String get liveStop => 'Stoppen';

  @override
  String get liveListening => 'Hören…';

  @override
  String get livePointAtText => 'Richten Sie die Kamera auf den Text';

  @override
  String get livePermissionNeeded =>
      'Für die Live-Übersetzung ist Kamerazugriff erforderlich';

  @override
  String get documentsTitle => 'Meine Dokumente';

  @override
  String get documentRename => 'Umbenennen';

  @override
  String get documentDeleteConfirmTitle => 'Dokument löschen?';

  @override
  String get documentDeleteConfirmMessage =>
      'Dies kann nicht rückgängig gemacht werden.';

  @override
  String get documentDeleted => 'Dokument gelöscht';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsLanguage => 'App-Sprache';

  @override
  String get settingsTheme => 'Thema';

  @override
  String get settingsAbout => 'Um';

  @override
  String get settingsPrivacy => 'Datenschutzrichtlinie';

  @override
  String get settingsTerms => 'Allgemeine Geschäftsbedingungen';

  @override
  String get settingsContactSupport => 'Support kontaktieren';

  @override
  String get settingsMoreApps => 'Weitere Apps';

  @override
  String get settingsRateApp => 'App bewerten';

  @override
  String get settingsShareApp => 'App teilen';

  @override
  String get settingsGreetingPrefix => 'Guten Morgen,';

  @override
  String get settingsDefaultUserName => 'Abdullah';

  @override
  String get permissionCameraTitle => 'Kameraerlaubnis';

  @override
  String get permissionCameraMessage =>
      'Erlauben Sie den Zugriff auf die Kamera, um Dokumente zu scannen und die Live-Übersetzung zu verwenden.';

  @override
  String get permissionStorageTitle => 'Speichererlaubnis';

  @override
  String get permissionStorageMessage =>
      'Erlauben Sie den Zugriff zum Speichern und Öffnen Ihrer Scans.';

  @override
  String get permissionOpenSettings => 'Einstellungen öffnen';

  @override
  String get permissionDenied => 'Zugriff verweigert';

  @override
  String get errorCameraUnavailable =>
      'Die Kamera ist auf diesem Gerät nicht verfügbar';

  @override
  String get errorFileRead => 'Datei konnte nicht gelesen werden';

  @override
  String get errorNetwork => 'Überprüfen Sie Ihre Internetverbindung';

  @override
  String get errorNoInternetFeatures =>
      'Keine Internetverbindung. Einige Funktionen funktionieren möglicherweise nicht ordnungsgemäß.';

  @override
  String get exitAppTitle => 'App beenden';

  @override
  String get exitAppMessage =>
      'Sind Sie sicher, dass Sie den Vorgang beenden möchten?';

  @override
  String get exitAppConfirm => 'Ausfahrt';

  @override
  String get errorOcrFailed => 'Die Texterkennung ist fehlgeschlagen';

  @override
  String get errorTranslateFailed => 'Die Übersetzung ist fehlgeschlagen';

  @override
  String get errorTranslateModelDownload =>
      'Das Sprachpaket konnte nicht heruntergeladen werden. Überprüfen Sie Ihre Verbindung und versuchen Sie es erneut.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Diese Sprache ist nicht für die Offline-Übersetzung verfügbar.';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle =>
      'Unbegrenzte Scans, OCR, Sprachen und Live-Übersetzung';

  @override
  String get proUpgradeButton => 'Upgrade auf Pro';

  @override
  String get proRestorePurchases => 'Einkäufe wiederherstellen';

  @override
  String get proFeatureLocked => 'Pro-Funktion';

  @override
  String proLimitPages(int max) {
    return 'Der kostenlose Plan ermöglicht bis zu $max Seiten pro Dokument';
  }

  @override
  String get proLimitOcr => 'Upgrade auf Pro für unbegrenzte OCR';

  @override
  String get proLimitTranslate => 'Upgrade auf Pro für alle Sprachen';

  @override
  String get proLimitLive => 'Live-Übersetzung ist in Pro verfügbar';

  @override
  String get proPurchaseSuccess => 'Willkommen bei Pro!';

  @override
  String get proPurchaseFailed => 'Der Kauf konnte nicht abgeschlossen werden';

  @override
  String get proPaywallTitle => 'Get Pro Access';

  @override
  String get proPaywallTitleGet => 'Get';

  @override
  String get proPaywallTitlePro => 'Pro';

  @override
  String get proPaywallTitleAccess => 'Access';

  @override
  String get proEnableTrial => 'Enable Trial';

  @override
  String get proTrialPlanTitle => '3-Day Full Access';

  @override
  String get proYearlyPlanTitle => 'Yearly';

  @override
  String get proContinue => 'Continue';

  @override
  String proTrialDisclaimer(String price) {
    return 'After 3 days free - then weekly subscription for $price will start. Cancel anytime 24 hours before renewal.';
  }

  @override
  String proYearlyDisclaimer(String price) {
    return 'Yearly subscription for $price/year. Cancel anytime at least 24 hours before renewal.';
  }

  @override
  String proTrialThenPrice(String price) {
    return 'then $price/week';
  }

  @override
  String get proPerWeek => 'per week';

  @override
  String proYearlySubtitle(String price) {
    return 'just $price per year';
  }

  @override
  String get proSaveBadge => 'Save 86%';

  @override
  String get proFeatureUnlimitedScans => 'Unlimited Document Scans';

  @override
  String get proFeatureOcr => 'Accurate OCR Recognition';

  @override
  String get proFeaturePdf => 'Advanced PDF Tools';

  @override
  String get proFeatureAi => 'Smart AI Assistance';

  @override
  String get proStoreUnavailable =>
      'Store is not available right now. Please try again later.';

  @override
  String get proSplashEnable => 'Enable';

  @override
  String get proSplashTrialDays => '3-day trial';

  @override
  String get proSplashTrialEnabled => 'is enabled!';

  @override
  String get exportPdf => 'PDF exportieren';

  @override
  String get exportImage => 'Bild exportieren';

  @override
  String get exportSuccess => 'Export abgeschlossen';

  @override
  String get exportFailed => 'Der Export ist fehlgeschlagen';

  @override
  String get languageSearchHint => 'Suchsprache';

  @override
  String get languageAuto => 'Sprache erkennen';

  @override
  String get chatbotTitle => 'KI-Chatbot';

  @override
  String get chatbotHistoryButton => 'Chatverlauf';

  @override
  String get chatbotBadge => 'Ihr intelligenter KI-Assistent';

  @override
  String get chatbotHeadlineChat => 'Chatten';

  @override
  String get chatbotHeadlineMiddle => 'mit deinem';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Laden Sie ein PDF hoch und stellen Sie beliebige Fragen — erhalten Sie sofort Antworten, Zusammenfassungen, Erklärungen und mehr.';

  @override
  String get chatbotTryAsking => 'Versuchen Sie zu fragen';

  @override
  String get chatbotSuggestSummarize => 'Fassen Sie dieses PDF zusammen';

  @override
  String get chatbotSuggestKeyPoints => 'Kernpunkte dieses PDFs';

  @override
  String get chatbotSuggestExplain => 'Erklären Sie es ausführlich';

  @override
  String get chatbotSuggestTranslate => 'Übersetzen Sie dieses PDF';

  @override
  String get chatbotAskQuestions => 'Stellen Sie Fragen zu diesem PDF';

  @override
  String get chatbotUploadHint => 'Laden Sie ein PDF hoch...';

  @override
  String get chatbotSheetTitle => 'Chatten Sie mit Ihrem PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Laden Sie ein PDF hoch und fragen Sie etwas dazu';

  @override
  String get chatbotChoosePdfTitle => 'Wählen Sie eine PDF-Datei';

  @override
  String get chatbotChoosePdfDescription =>
      'Durchsuchen Sie die PDF-Datei auf Ihrem Gerät und wählen Sie sie aus';

  @override
  String get chatbotRecentFilesTitle => 'Aktuelle Dateien';

  @override
  String get chatbotRecentFilesDescription =>
      'Wählen Sie aus Ihren letzten Dateien';

  @override
  String get errorChatbotPdfPickFailed =>
      'Das ausgewählte PDF konnte nicht geöffnet werden';

  @override
  String get chatbotAnalyzingTitle => 'Analysieren Sie Ihr Dokument...';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Bitte warten Sie, während wir lesen und\nVerstehen Sie Ihr PDF';

  @override
  String get chatbotStepReadingPdf => 'PDF lesen';

  @override
  String get chatbotStepExtractingText => 'Text extrahieren';

  @override
  String get chatbotStepUnderstandingContent => 'Inhalte verstehen';

  @override
  String get chatbotStepPreparingChat => 'KI-Chat wird vorbereitet';

  @override
  String get chatbotHistoryTitle => 'Geschichte';

  @override
  String get chatbotNoConversationsTitle => 'Noch keine Gespräche';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Laden Sie ein PDF hoch, um mit Ihrem KI-Assistenten zu chatten.';

  @override
  String get chatbotUploadPdfButton => 'Laden Sie ein PDF hoch';

  @override
  String get chatbotDocumentReadyTitle => 'Dokumentbereit';

  @override
  String get chatbotDocumentReadySubtitle =>
      'Sie können jetzt mit Ihrem PDF chatten';

  @override
  String get chatbotCurrentSummary => 'Aktuelle Zusammenfassung';

  @override
  String get chatbotStartChatting => 'Beginnen Sie mit dem Chatten';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Hallo! Ich bin Ihr KI-Assistent. Fragen Sie mich etwas zu diesem PDF und ich werde Ihnen helfen.';

  @override
  String get chatbotChatYouCanAsk => 'Sie können mich fragen:';

  @override
  String get chatbotChatPromptSummarize =>
      'Fassen Sie dieses Dokument zusammen';

  @override
  String get chatbotChatPromptHighlights =>
      'Was sind die wichtigsten Highlights?';

  @override
  String get chatbotChatPromptFinancial => 'Zeigen Sie mir Finanzdaten';

  @override
  String get chatbotChatPromptDates => 'Extrahieren Sie wichtige Daten';

  @override
  String get chatbotChatInputHint => 'Fragen Sie nach diesem PDF...';

  @override
  String get chatbotDeleteTitle => 'Chat löschen?';

  @override
  String get chatbotDeleteMessage =>
      'Dadurch werden der Chat und das PDF aus Ihrem Verlauf entfernt. Dies kann nicht rückgängig gemacht werden.';

  @override
  String get chatbotRenameTitle => 'PDF umbenennen';

  @override
  String get chatbotRenameHint => 'Geben Sie einen Namen ein';

  @override
  String get chatbotHistorySearchHint => 'Durchsuchen Sie Ihre Gespräche ...';

  @override
  String get chatbotRenameSuccess => 'Erfolgreich umbenannt';

  @override
  String get chatbotDeleteSuccess => 'Erfolgreich gelöscht';

  @override
  String get chatbotEmptyConversationPreview => 'Leeres Gespräch…';

  @override
  String get chatbotAiThinking => 'KI denkt';

  @override
  String get chatbotTipsLabel => 'Tipps';

  @override
  String get chatbotSuggestSummarizeChip => 'Zusammenfassen\ndieses PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Wichtige Punkte\ndieses PDFs';

  @override
  String get chatbotSuggestExplainChip => 'Erklären Sie\nim Detail';

  @override
  String get chatbotSuggestTranslateChip => 'Übersetzen\ndieses PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Dieses PDF konnte nicht analysiert werden. Bitte versuchen Sie es erneut.';

  @override
  String get chatbotChatFailed =>
      'Konnte keine Antwort erhalten. Versuchen Sie es erneut.';

  @override
  String get errorChatbotPdfEmpty => 'In diesem PDF wurde kein Text gefunden';

  @override
  String get pdfAssistantTitle => 'PDF-Assistent';

  @override
  String get pdfAssistantSheetTitle => 'PDF hochladen';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Wählen Sie aus, wie Sie Ihre PDF-Datei hinzufügen möchten';

  @override
  String get pdfAssistantChoosePdfTitle => 'Wählen Sie eine PDF-Datei';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Durchsuchen Sie die PDF-Datei auf Ihrem Gerät und wählen Sie sie aus';

  @override
  String get pdfAssistantLinkTitle => 'PDF über Link hinzufügen';

  @override
  String get pdfAssistantLinkDescription =>
      'Fügen Sie einen PDF-Link ein, um ihn direkt hochzuladen';

  @override
  String get pdfAssistantLinkHint => 'PDF-URL einfügen';

  @override
  String get pdfAssistantLinkButton => 'PDF herunterladen';

  @override
  String get pdfAssistantTranslateTo => 'Übersetzen nach';

  @override
  String get pdfAssistantTranslateToOptional => 'Übersetzen nach (optional)';

  @override
  String get pdfAssistantNoTranslation => 'Keine Übersetzung';

  @override
  String get pdfAssistantExtractedPdfTitle => 'Extrahiertes PDF';

  @override
  String get pdfAssistantExtractedPdfDescription =>
      'Aus Ihren PDF-Seiten extrahierter Text';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => 'Extrahierter Text';

  @override
  String get pdfAssistantStepPreparingContent => 'Inhalt wird vorbereitet…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'PDF wird erstellt…';

  @override
  String get pdfAssistantStartProcessing => 'Beginnen Sie mit der Verarbeitung';

  @override
  String get pdfAssistantNoFileSelected => 'Keine Datei ausgewählt';

  @override
  String get pdfAssistantSelectLanguage =>
      'Bitte wählen Sie eine Zielsprache aus';

  @override
  String get pdfAssistantProcessingTitle => 'Verarbeiten Sie Ihr PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Bitte warten.';

  @override
  String get pdfAssistantStepExtracting => 'Text extrahieren…';

  @override
  String get pdfAssistantStepTranslating => 'Inhalte übersetzen…';

  @override
  String get pdfAssistantStepGeneratingPdf =>
      'Generieren einer übersetzten PDF-Datei…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalisierung…';

  @override
  String get pdfAssistantResultTitle => 'Ergebnisse';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'Übersetztes PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Originallayout mit übersetztem Text-Overlay';

  @override
  String get pdfAssistantExtractedTextTitle => 'Extrahierter übersetzter Text';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Einfaches A4-Textdokument';

  @override
  String get pdfAssistantActionOpen => 'Offen';

  @override
  String get pdfAssistantActionDownload => 'Herunterladen';

  @override
  String get pdfAssistantDeleteTitle => 'Ergebnisse löschen?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Dadurch werden die übersetzten Dateien von Ihrem Gerät entfernt.';

  @override
  String get pdfAssistantDownloadSuccess => 'Unter „Downloads“ gespeichert';

  @override
  String get pdfAssistantOpenFailed => 'Datei konnte nicht geöffnet werden';

  @override
  String get pdfAssistantProcessFailed =>
      'Dieses PDF konnte nicht verarbeitet werden';

  @override
  String get errorPdfAssistantPickFailed =>
      'Das ausgewählte PDF konnte nicht geöffnet werden';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Das PDF konnte über diesen Link nicht heruntergeladen werden';

  @override
  String get errorPdfAssistantPdfEmpty =>
      'In diesem PDF wurde kein Text gefunden';

  @override
  String get pdfAssistantRemoveTitle => 'PDF entfernen';

  @override
  String get pdfAssistantRemoveWarning =>
      'Dadurch wird die PDF-Datei von Ihrem Gerät entfernt.';

  @override
  String get pdfAssistantUploadPdf => 'PDF hochladen';

  @override
  String get cancel => 'Stornieren';

  @override
  String get remove => 'Entfernen';

  @override
  String get commonNext => 'Nächste';

  @override
  String get commonSkip => 'Überspringen';

  @override
  String get commonContinue => 'Weitermachen';

  @override
  String get onboardingStart => 'Jetzt starten →';

  @override
  String get splashTagline => 'KI-gestütztes Scannen von Dokumenten';

  @override
  String get splashAdDisclaimer => 'Diese Aktion kann zu einer Anzeige führen';

  @override
  String get adLoading => 'Anzeige wird geladen...';

  @override
  String get onboardingPage1Title => 'Text scannen\nin Sekunden';

  @override
  String get onboardingPage1Description =>
      'Text aus Bildern mit schnellem KI-OCR erfassen.';

  @override
  String get onboardingPage2Title => 'Smart PDF-\nAssistent';

  @override
  String get onboardingPage2Description =>
      'PDFs übersetzen, extrahieren\nund verstehen.';

  @override
  String get onboardingPage3Title => 'Chat mit\nIhren PDFs';

  @override
  String get onboardingPage3Description =>
      'Fragen stellen, zusammenfassen\nund Antworten erhalten.';

  @override
  String get onboardingPage4Title => 'Smart Crop\nin Sekunden';

  @override
  String get onboardingPage4Description =>
      'Mehrere Bilder zuschneiden\nund PDF erstellen.';

  @override
  String get settingsChooseLanguage => 'Wählen Sie eine Sprache';

  @override
  String get settingsLanguageApply => 'Anwenden';

  @override
  String get commonSaving => 'Sparen…';

  @override
  String get smartCropTitle => 'Intelligente Ernte';

  @override
  String get smartCropInputMethodTitle => 'Smart-Crop-Scanner';

  @override
  String get smartCropInputMethodSubtitle => 'Wählen Sie die Eingabeart';

  @override
  String get smartCropInputLiveCameraTitle => 'Live-Kamera';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Google-Scanner – automatische Kanten, Zuschneiden und Verbessern';

  @override
  String get smartCropInputUploadImageTitle => 'Bild hochladen';

  @override
  String get smartCropInputUploadImageDescription =>
      'Dokumentbild aus der Galerie hochladen';

  @override
  String get smartCropUploadIntroHeadline =>
      'Mehrere Bilder zuschneiden\nAutomatisch';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Erkennen Sie Kanten automatisch, schneiden Sie Bilder perfekt zu und erstellen Sie mit einem Fingertipp ein PDF.';

  @override
  String get smartCropUploadIntroStepSelect => 'Wählen Sie mehrere Bilder aus';

  @override
  String get smartCropUploadIntroStepCrop =>
      'Automatische Erkennung und Zuschnitt';

  @override
  String get smartCropUploadIntroStepPdf => 'Erstellen Sie sofort PDF';

  @override
  String get smartCropUploadIntroSelectImages => 'Wählen Sie Bilder aus';

  @override
  String get smartCropLiveCameraTitle => 'Intelligente Crop-Kamera';

  @override
  String get smartCropLiveCameraTip =>
      'Dokument erkannt – zum Erfassen antippen';

  @override
  String get smartCropLiveCameraAlignTip =>
      'Richten Sie das Dokument innerhalb der Ecken aus';

  @override
  String get smartCropLiveCameraClose => 'Kamera schließen';

  @override
  String get smartCropLiveCameraFlash => 'Blitz umschalten';

  @override
  String get smartCropLiveCameraCapture =>
      'Erfassen Sie Dokumente für intelligentes Zuschneiden';

  @override
  String get smartCropLiveCameraInitializing => 'Kamera wird gestartet…';

  @override
  String get smartCropCapturedTitle => 'Erfasstes Dokument';

  @override
  String get smartCropCapturedRetake => 'Letztes Foto noch einmal aufnehmen';

  @override
  String get smartCropCapturedAnotherPhoto =>
      'Fügen Sie ein weiteres Foto hinzu';

  @override
  String get smartCropCapturedRetakeAnotherPhoto =>
      'Machen Sie noch einmal ein Foto';

  @override
  String get smartCropCapturedPreview => 'Vorschau';

  @override
  String get smartCropPreviewTitle => 'Vorschau';

  @override
  String get smartCropCapturedCrop => 'Ernte';

  @override
  String get smartCropAdjustCornersTitle => 'Ecken anpassen';

  @override
  String get smartCropAdjustCornersHint =>
      'Ziehen Sie die violetten Ecken, um sie an die Dokumentkanten anzupassen';

  @override
  String get smartCropAdjustCornersConfirm => 'Zuschneiden anwenden';

  @override
  String get smartCropPresetAuto => 'Automatisch erkennen';

  @override
  String get smartCropPresetCenter => 'Seite zentrieren';

  @override
  String get smartCropPresetFull => 'Gesamtes Bild';

  @override
  String get smartCropUploadIntroGoogleScanner =>
      'Google Scanner (Bestes Zuschneiden)';

  @override
  String get smartCropDetectingEdges => 'Dokumentkanten erkennen…';

  @override
  String get smartCropAndroidOnly =>
      'Smart Scan ist nur für Android verfügbar.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Maximal $max Fotos erreicht';
  }

  @override
  String get smartCropProcessingCrop => 'Anwendung der magischen Ernte...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return '$count-Dokumente zuschneiden…';
  }

  @override
  String get smartCropCroppedTitle => 'Zugeschnittenes Dokument';

  @override
  String get smartCropFilterOriginal => 'Original';

  @override
  String get smartCropFilterLighten => 'Erleichtern';

  @override
  String get smartCropFilterMagic => 'Magie';

  @override
  String get smartCropFilterGrayscale => 'Graustufen';

  @override
  String get smartCropFilterMono => 'Schwarzweiß';

  @override
  String get smartCropFilterWarm => 'Warm';

  @override
  String get smartCropActionCreatePdf => 'PDF erstellen';

  @override
  String get smartCropProcessingPdf => 'PDF-Dokument wird erstellt...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'PDF mit $count Seiten erstellen…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF-Dokument erfolgreich generiert';

  @override
  String get smartCropPdfPagesLabel => 'Seiten';

  @override
  String get smartCropPdfSinglePageLabel => '1 Seite';

  @override
  String get smartCropImageCopied => 'Kopiert';

  @override
  String get smartCropDeleteImageConfirm =>
      'Diese Seite aus dem Dokument entfernen?';

  @override
  String get smartCropDeleteCapturedPageTitle => 'Seite löschen';

  @override
  String get smartCropDeleteCapturedPageMessage =>
      'Möchten Sie diese Seite wirklich löschen ?';

  @override
  String get smartCropDeleteDocumentTitle => 'Dokument löschen?';

  @override
  String get smartCropDeleteDocumentMessage =>
      'Möchten Sie dieses Dokument wirklich löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get smartCropDeletePdfTitle => 'PDF löschen?';

  @override
  String get smartCropDeletePdfMessage =>
      'Möchten Sie dieses PDF wirklich löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get smartCropDeletePdfConfirm => 'Dieses PDF von Ihrem Gerät löschen?';

  @override
  String get smartCropPdfRenamed => 'PDF umbenannt';

  @override
  String get smartCropPdfFileName => 'Dateiname';

  @override
  String get smartCropPdfFileSize => 'Dateigröße';

  @override
  String get smartCropViewPdf => 'PDF ansehen';

  @override
  String get smartCropSavePdf => 'PDF speichern';

  @override
  String get smartCropSavePdfSuccess => 'PDF erfolgreich gespeichert';

  @override
  String get smartCropRenamePdf => 'Umbenennen';

  @override
  String get smartCropRenamePdfHint => 'Dokumentname';

  @override
  String get smartCropStepReadingImages => 'Bilder lesen';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return 'Lesen $done von $total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return '$failed von $total Bildern konnten nicht importiert werden';
  }

  @override
  String get smartCropStepDetectingEdges => 'Kanten erkennen';

  @override
  String get smartCropStepCroppingImages => 'Bilder zuschneiden';

  @override
  String get smartCropStepGeneratingPdf => 'PDF erstellen';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Zugeschnittene Bilder werden\nin ein PDF organisiert';

  @override
  String get smartCropProcessingPdfTitle => 'PDF wird erstellt';

  @override
  String get commonUntitledDocument => 'dokumentieren';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Tippen Sie hier, um das Geräteverzeichnis zu durchsuchen';

  @override
  String get errorPdfTextLoad => 'Fehler beim Laden des Textes.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Übersetzung: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Dokumentübersetzung';

  @override
  String get translateExportTranslatedBadge => 'Übersetzt';

  @override
  String get translateExportVerifiedFooter =>
      'Verifizierter Offline-Übersetzungsexport';

  @override
  String get translateExportPdfHeader => 'Übersetzungsexport';

  @override
  String get translateExportPdfFooterLabel => 'Vertrauliches Dokument';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Seite $page von $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Seite $page';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size B';
  }

  @override
  String fileSizeKb(String size) {
    return '$size KB';
  }

  @override
  String fileSizeMb(String size) {
    return '$size MB';
  }

  @override
  String get translateLangName_en => 'Englisch';

  @override
  String get translateLangName_ur => 'Urdu';

  @override
  String get translateLangName_hi => 'Hindi';

  @override
  String get translateLangName_ar => 'Arabisch';

  @override
  String get translateLangName_es => 'Spanisch';

  @override
  String get translateLangName_fr => 'Französisch';

  @override
  String get translateLangName_de => 'Deutsch';

  @override
  String get translateLangName_pt => 'Portugiesisch';

  @override
  String get translateLangName_ru => 'Russisch';

  @override
  String get translateLangName_zh => 'Chinesisch (vereinfacht)';

  @override
  String get translateLangName_zhTw => 'Chinesisch (traditionell)';

  @override
  String get translateLangName_ja => 'japanisch';

  @override
  String get translateLangName_ko => 'Koreanisch';

  @override
  String get translateLangName_it => 'Italienisch';

  @override
  String get translateLangName_tr => 'Türkisch';

  @override
  String get translateLangName_nl => 'Niederländisch';

  @override
  String get translateLangName_sv => 'Schwedisch';

  @override
  String get translateLangName_no => 'norwegisch';

  @override
  String get translateLangName_da => 'dänisch';

  @override
  String get translateLangName_fi => 'finnisch';

  @override
  String get translateLangName_el => 'griechisch';

  @override
  String get translateLangName_pl => 'Polieren';

  @override
  String get translateLangName_cs => 'tschechisch';

  @override
  String get translateLangName_hu => 'ungarisch';

  @override
  String get translateLangName_ro => 'rumänisch';

  @override
  String get translateLangName_bg => 'bulgarisch';

  @override
  String get translateLangName_uk => 'ukrainisch';

  @override
  String get translateLangName_fa => 'persisch';

  @override
  String get translateLangName_he => 'hebräisch';

  @override
  String get translateLangName_th => 'Thailändisch';

  @override
  String get translateLangName_vi => 'Vietnamesisch';

  @override
  String get translateLangName_id => 'Indonesisch';

  @override
  String get translateLangName_ms => 'malaiisch';

  @override
  String get translateLangName_bn => 'Bengali';

  @override
  String get translateLangName_ta => 'Tamilisch';

  @override
  String get translateLangName_te => 'Telugu';

  @override
  String get translateLangName_mr => 'Marathi';

  @override
  String get translateLangName_gu => 'Gujarati';

  @override
  String get translateLangName_kn => 'Kannada';

  @override
  String get translateLangName_ml => 'Malayalam';

  @override
  String get translateLangName_pa => 'Punjabi';

  @override
  String get translateLangName_sw => 'Suaheli';

  @override
  String get translateLangName_af => 'Afrikaans';

  @override
  String get translateLangName_ca => 'katalanisch';

  @override
  String get translateLangName_hr => 'kroatisch';

  @override
  String get translateLangName_sk => 'slowakisch';

  @override
  String get translateLangName_sl => 'Slowenisch';

  @override
  String get translateLangName_sr => 'serbisch';

  @override
  String get translateLangName_lt => 'litauisch';

  @override
  String get translateLangName_lv => 'lettisch';

  @override
  String get translateLangName_et => 'estnisch';

  @override
  String get translateLangName_is => 'isländisch';

  @override
  String get translateLangName_ga => 'irisch';

  @override
  String get translateLangName_mt => 'maltesisch';

  @override
  String get translateLangName_sq => 'albanisch';

  @override
  String get translateLangName_mk => 'mazedonisch';

  @override
  String get translateLangName_be => 'Weißrussisch';

  @override
  String get translateLangName_kk => 'Kasachisch';

  @override
  String get translateLangName_uz => 'Usbekisch';

  @override
  String get translateLangName_az => 'Aserbaidschanisch';

  @override
  String get translateLangName_hy => 'Armenisch';

  @override
  String get translateLangName_ka => 'georgisch';

  @override
  String get translateLangName_lo => 'Laotisch';

  @override
  String get translateLangName_km => 'Khmer';

  @override
  String get translateLangName_my => 'birmanisch';

  @override
  String get translateLangName_ne => 'Nepali';

  @override
  String get translateLangName_si => 'Singhalesisch';

  @override
  String get translateLangName_am => 'Amharisch';

  @override
  String get translateLangName_ha => 'Hausa';

  @override
  String get translateLangName_yo => 'Yoruba';

  @override
  String get translateLangName_ig => 'Igbo';

  @override
  String get translateLangName_zu => 'Zulu';

  @override
  String get translateLangName_xh => 'Xhosa';

  @override
  String get translateLangName_st => 'Sesotho';

  @override
  String get translateLangName_sn => 'Shona';

  @override
  String get translateLangName_rw => 'Kinyarwanda';

  @override
  String get translateLangName_so => 'somali';

  @override
  String get translateLangName_mg => 'Madagassisch';

  @override
  String get translateLangName_cy => 'Walisisch';

  @override
  String get translateLangName_mn => 'mongolisch';

  @override
  String get translateLangName_tl => 'Philippinisch';

  @override
  String get translateLangName_ht => 'Haitianisches Kreol';

  @override
  String get translateLangName_eo => 'Esperanto';

  @override
  String get translateLangName_la => 'lateinisch';

  @override
  String get translateLangName_ku => 'kurdisch';

  @override
  String get translateLangName_ps => 'Paschtu';

  @override
  String get translateLangName_faAf => 'Dari';

  @override
  String get translateLangName_bs => 'bosnisch';

  @override
  String get translateLangName_mi => 'Maori';

  @override
  String get translateLangName_sm => 'Samoaner';

  @override
  String get translateLangName_haw => 'hawaiisch';

  @override
  String get translateLangName_lb => 'Luxemburgisch';
}
