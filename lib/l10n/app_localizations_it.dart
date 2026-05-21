// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Scanner Documenti';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Annulla';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get commonShare => 'Condividi';

  @override
  String get commonCopy => 'Copia';

  @override
  String get commonRetry => 'Riprova';

  @override
  String get commonClose => 'Chiudi';

  @override
  String get commonLoading => 'Caricamento…';

  @override
  String get commonError => 'Qualcosa è andato storto';

  @override
  String get commonTryAgain => 'Riprova';

  @override
  String get navHome => 'Home';

  @override
  String get navScan => 'Scansiona';

  @override
  String get navDocuments => 'Documenti';

  @override
  String get navTranslate => 'Traduci';

  @override
  String get navLive => 'Live';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String homeGreeting(String name) {
    return 'Buongiorno, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'Documento AI';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Apri menu';

  @override
  String get homeTagAiPowered => 'Basato su AI';

  @override
  String get homeTagFastOcr => 'OCR veloce';

  @override
  String get homeTagSecure => 'Sicuro';

  @override
  String get homeTagSmartCrop => 'Ritaglio intelligente';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => 'Scanner OCR\nIntelligente';

  @override
  String get homeHeroSubtitle =>
      'OCR basato su AI con riconoscimento del testo rapido e preciso in pochi secondi.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Cerca qui';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle => 'Estrai testo da immagini o documenti';

  @override
  String get homeFeaturePdfTitle => 'Assistente PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduci e trascrivi PDF';

  @override
  String get homeFeatureChatbotTitle => 'Chatbot AI';

  @override
  String get homeFeatureChatbotSubtitle => 'Carica PDF e fai domande';

  @override
  String get homeFeatureCropTitle => 'Ritaglio intelligente';

  @override
  String get homeFeatureCropSubtitle => 'Auto ritaglio e miglioramento';

  @override
  String get homeRecentDocuments => 'Documenti recenti';

  @override
  String get homeSeeAll => 'Vedi tutto';

  @override
  String get homeEmptyDocuments =>
      'Nessun documento. Tocca Scansiona per iniziare.';

  @override
  String get homeSampleDocName => 'Fattura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 maggio 2026 • 2,4 MB';

  @override
  String get scanTitle => 'Scansione';

  @override
  String get scanCapture => 'Scatta';

  @override
  String get scanImportGallery => 'Importa dalla galleria';

  @override
  String get scanImportFiles => 'Importa file';

  @override
  String get scanAddPage => 'Aggiungi pagina';

  @override
  String get scanRetake => 'Rifai';

  @override
  String get scanCrop => 'Ritaglia';

  @override
  String get scanEnhance => 'Migliora';

  @override
  String get scanDone => 'Fatto';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagine',
      one: '1 pagina',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'Salvataggio scansione…';

  @override
  String get scanSaved => 'Documento salvato';

  @override
  String get ocrTitle => 'Riconoscimento testo';

  @override
  String get ocrRun => 'Riconosci testo';

  @override
  String get ocrRunning => 'Lettura del testo…';

  @override
  String get ocrEmpty => 'Nessun testo trovato';

  @override
  String get ocrCopySuccess => 'Testo copiato';

  @override
  String get ocrEditHint => 'Modifica testo riconosciuto';

  @override
  String get ocrInputMethodTitle => 'Scegli metodo di input';

  @override
  String get ocrInputMethodSubtitle => 'Seleziona come estrarre il testo';

  @override
  String get ocrInputLiveCameraTitle => 'Fotocamera live';

  @override
  String get ocrInputLiveCameraDescription => 'Scatta con la fotocamera';

  @override
  String get ocrInputUploadImageTitle => 'Carica immagine';

  @override
  String get ocrInputUploadImageDescription => 'Scegli dalla galleria';

  @override
  String get ocrLiveCameraTitle => 'Fotocamera OCR live';

  @override
  String get ocrLiveCameraTip => 'Suggerimento: usa una buona illuminazione';

  @override
  String get ocrLiveCameraClose => 'Chiudi fotocamera';

  @override
  String get ocrLiveCameraFlash => 'Attiva/disattiva flash';

  @override
  String get ocrLiveCameraCapture => 'Scatta per OCR';

  @override
  String get ocrLiveCameraInitializing => 'Avvio fotocamera…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copia';

  @override
  String get ocrAnalyzeTranslate => 'Traduci';

  @override
  String get ocrAnalyzeProcessing => 'Analisi in corso…';

  @override
  String get ocrAnalyzeTranslateNext => 'Apertura traduzione';

  @override
  String get ocrNoTextTitle => 'Nessun testo leggibile';

  @override
  String get ocrNoTextHint => 'Prova un\'immagine più chiara';

  @override
  String get ocrNoTextRetakePhoto => 'Rifai foto';

  @override
  String get ocrNoTextChooseGallery => 'Scegli dalla galleria';

  @override
  String get translateTitle => 'Traduci';

  @override
  String get translateSourceLanguage => 'Da';

  @override
  String get translateTargetLanguage => 'A';

  @override
  String get translateSwapLanguages => 'Inverti lingue';

  @override
  String get translateButton => 'Traduci';

  @override
  String get translateRunning => 'Traduzione…';

  @override
  String get translatePasteHint => 'Incolla o scrivi testo';

  @override
  String get translateCopyResult => 'Copia traduzione';

  @override
  String get translateResultTitle => 'Traduzione';

  @override
  String get translateResultSubtitle =>
      'Traduci il tuo testo in qualsiasi lingua';

  @override
  String get translateSelectedText => 'Testo selezionato';

  @override
  String get translateSelectedLanguage => 'Lingua selezionata';

  @override
  String get translateSelectLanguage => 'Seleziona lingua';

  @override
  String get translateSearchLanguage => 'Cerca lingua';

  @override
  String get translateRecentLanguages => 'Recenti';

  @override
  String get translateNoLanguagesFound => 'Nessuna lingua trovata';

  @override
  String get translateTranslatedText => 'Testo tradotto';

  @override
  String get translatePlaceholder => 'La traduzione apparirà qui…';

  @override
  String get translateSeeMore => 'Mostra altro';

  @override
  String get translateReadAloud => 'Leggi ad alta voce';

  @override
  String get translateSavePdf => 'Salva PDF';

  @override
  String get translateSavePng => 'Salva immagine';

  @override
  String get translateSaveComingSoon => 'Disponibile presto';

  @override
  String get translateDownloadOptionTitle => 'Scegli opzione download';

  @override
  String get translateDownloadOptionSubtitle => 'Seleziona cosa scaricare';

  @override
  String get translateDownloadSelectedTextTitle => 'Scarica testo selezionato';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Solo testo selezionato';

  @override
  String get translateDownloadCompleteFileTitle => 'Scarica file completo';

  @override
  String get translateDownloadCompleteFileDescription => 'File intero';

  @override
  String get translateDownloadTranslatedTextTitle => 'Scarica testo tradotto';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Scarica solo il testo tradotto';

  @override
  String get translateSavePdfSuccess => 'PDF salvato';

  @override
  String get translateSavePngSuccess => 'Immagine salvata';

  @override
  String get translateExportNeedsTranslation => 'Traduci prima di scaricare';

  @override
  String get liveTitle => 'Traduzione live';

  @override
  String get liveStart => 'Avvia fotocamera';

  @override
  String get liveStop => 'Stop';

  @override
  String get liveListening => 'Ascolto…';

  @override
  String get livePointAtText => 'Inquadra il testo';

  @override
  String get livePermissionNeeded => 'Accesso fotocamera richiesto';

  @override
  String get documentsTitle => 'I miei documenti';

  @override
  String get documentRename => 'Rinomina';

  @override
  String get documentDeleteConfirmTitle => 'Eliminare documento?';

  @override
  String get documentDeleteConfirmMessage => 'Operazione irreversibile.';

  @override
  String get documentDeleted => 'Documento eliminato';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguage => 'Lingua app';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsAbout => 'Informazioni';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get settingsTerms => 'Termini di utilizzo';

  @override
  String get permissionCameraTitle => 'Permesso fotocamera';

  @override
  String get permissionCameraMessage => 'Consenti accesso alla fotocamera.';

  @override
  String get permissionStorageTitle => 'Permesso memoria';

  @override
  String get permissionStorageMessage => 'Consenti accesso per salvare file.';

  @override
  String get permissionOpenSettings => 'Apri impostazioni';

  @override
  String get permissionDenied => 'Permesso negato';

  @override
  String get errorCameraUnavailable => 'Fotocamera non disponibile';

  @override
  String get errorFileRead => 'Impossibile leggere il file';

  @override
  String get errorNetwork => 'Controlla la connessione internet';

  @override
  String get errorNoInternetFeatures => 'Nessuna connessione internet';

  @override
  String get exitAppTitle => 'Esci dall\'app';

  @override
  String get exitAppMessage => 'Vuoi uscire?';

  @override
  String get exitAppConfirm => 'Esci';

  @override
  String get errorOcrFailed => 'OCR fallito';

  @override
  String get errorTranslateFailed => 'Traduzione fallita';

  @override
  String get errorTranslateModelDownload => 'Download pacchetto lingua fallito';

  @override
  String get errorTranslateUnsupportedLanguage => 'Lingua non supportata';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'Scansioni e OCR illimitati';

  @override
  String get proUpgradeButton => 'Passa a Pro';

  @override
  String get proRestorePurchases => 'Ripristina acquisti';

  @override
  String get proFeatureLocked => 'Funzione Pro';

  @override
  String proLimitPages(int max) {
    return 'Gratis fino a $max pagine';
  }

  @override
  String get proLimitOcr => 'OCR illimitato con Pro';

  @override
  String get proLimitTranslate => 'Tutte le lingue con Pro';

  @override
  String get proLimitLive => 'Live translate solo Pro';

  @override
  String get proPurchaseSuccess => 'Benvenuto Pro!';

  @override
  String get proPurchaseFailed => 'Acquisto fallito';

  @override
  String get exportPdf => 'Esporta PDF';

  @override
  String get exportImage => 'Esporta immagine';

  @override
  String get exportSuccess => 'Esportazione completata';

  @override
  String get exportFailed => 'Esportazione fallita';

  @override
  String get languageSearchHint => 'Cerca lingua';

  @override
  String get languageAuto => 'Rilevamento automatico';

  @override
  String get chatbotTitle => 'Chatbot AI';

  @override
  String get chatbotHistoryButton => 'Cronologia';

  @override
  String get chatbotBadge => 'Il tuo assistente AI';

  @override
  String get chatbotHeadlineChat => 'Chat';

  @override
  String get chatbotHeadlineMiddle => ' con il tuo ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Prova a chiedere';

  @override
  String get chatbotSuggestSummarize => 'Riassumi PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Punti chiave';

  @override
  String get chatbotSuggestExplain => 'Spiega in dettaglio';

  @override
  String get chatbotSuggestTranslate => 'Traduci PDF';

  @override
  String get chatbotAskQuestions => 'Fai domande su questo PDF';

  @override
  String get chatbotUploadHint => 'Carica un PDF...';

  @override
  String get chatbotSheetTitle => 'Chat con PDF';

  @override
  String get chatbotSheetSubtitle => 'Carica un PDF e fai domande';

  @override
  String get chatbotChoosePdfTitle => 'Scegli PDF';

  @override
  String get chatbotChoosePdfDescription => 'Seleziona dal dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'File recenti';

  @override
  String get chatbotRecentFilesDescription => 'Scegli recenti';

  @override
  String get errorChatbotPdfPickFailed => 'Impossibile aprire PDF';

  @override
  String get chatbotAnalyzingTitle => 'Analisi documento...';

  @override
  String get chatbotAnalyzingSubtitle => 'Attendere';

  @override
  String get chatbotStepReadingPdf => 'Lettura PDF';

  @override
  String get chatbotStepExtractingText => 'Estrazione testo';

  @override
  String get chatbotStepUnderstandingContent => 'Comprensione contenuto';

  @override
  String get chatbotStepPreparingChat => 'Preparazione chat';

  @override
  String get chatbotHistoryTitle => 'Cronologia';

  @override
  String get chatbotNoConversationsTitle => 'Nessuna conversazione';

  @override
  String get chatbotNoConversationsSubtitle => 'Carica un PDF per iniziare';

  @override
  String get chatbotUploadPdfButton => 'Carica PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento pronto';

  @override
  String get chatbotDocumentReadySubtitle => 'Riepilogo rapido';

  @override
  String get chatbotCurrentSummary => 'Riepilogo';

  @override
  String get chatbotStartChatting => 'Inizia chat';

  @override
  String get chatbotChatGreeting => '👋🏻 Ciao! Fammi domande sul PDF.';

  @override
  String get chatbotChatYouCanAsk => 'Puoi chiedere:';

  @override
  String get chatbotChatPromptSummarize => 'Riassumi documento';

  @override
  String get chatbotChatPromptHighlights => 'Punti importanti';

  @override
  String get chatbotChatPromptFinancial => 'Dati finanziari';

  @override
  String get chatbotChatPromptDates => 'Date importanti';

  @override
  String get chatbotChatInputHint => 'Chiedi qualcosa...';

  @override
  String get chatbotDeleteTitle => 'Eliminare chat?';

  @override
  String get chatbotDeleteMessage => 'Non reversibile.';

  @override
  String get chatbotRenameTitle => 'Rinomina PDF';

  @override
  String get chatbotRenameHint => 'Inserisci nome';

  @override
  String get chatbotAnalyzeFailed => 'Analisi fallita';

  @override
  String get chatbotChatFailed => 'Risposta fallita';

  @override
  String get errorChatbotPdfEmpty => 'Nessun testo trovato';

  @override
  String get pdfAssistantTitle => 'Assistente PDF';

  @override
  String get pdfAssistantSheetTitle => 'Carica PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Scegli come vuoi aggiungere il tuo file PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Scegli PDF';

  @override
  String get pdfAssistantChoosePdfDescription => 'Seleziona dal dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Aggiungi link PDF';

  @override
  String get pdfAssistantLinkDescription =>
      'Incolla un link PDF per caricarlo direttamente';

  @override
  String get pdfAssistantLinkHint => 'Incolla URL';

  @override
  String get pdfAssistantLinkButton => 'Scarica';

  @override
  String get pdfAssistantTranslateTo => 'Traduci in';

  @override
  String get pdfAssistantStartProcessing => 'Avvia';

  @override
  String get pdfAssistantNoFileSelected => 'Nessun file';

  @override
  String get pdfAssistantSelectLanguage => 'Seleziona lingua';

  @override
  String get pdfAssistantProcessingTitle => 'Elaborazione…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Attendere';

  @override
  String get pdfAssistantStepExtracting => 'Estrazione…';

  @override
  String get pdfAssistantStepTranslating => 'Traduzione…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Creazione PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizzazione…';

  @override
  String get pdfAssistantResultTitle => 'Risultato';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF tradotto';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'Layout originale';

  @override
  String get pdfAssistantExtractedTextTitle => 'Testo estratto';

  @override
  String get pdfAssistantExtractedTextDescription => 'Documento semplice';

  @override
  String get pdfAssistantActionOpen => 'Apri';

  @override
  String get pdfAssistantActionDownload => 'Scarica';

  @override
  String get pdfAssistantDeleteTitle => 'Eliminare?';

  @override
  String get pdfAssistantDeleteMessage => 'Non reversibile';

  @override
  String get pdfAssistantDownloadSuccess => 'Salvato';

  @override
  String get pdfAssistantOpenFailed => 'Impossibile aprire';

  @override
  String get pdfAssistantProcessFailed => 'Errore elaborazione';

  @override
  String get errorPdfAssistantPickFailed => 'Selezione fallita';

  @override
  String get errorPdfAssistantLinkFailed => 'Link non valido';

  @override
  String get errorPdfAssistantPdfEmpty => 'PDF vuoto';

  @override
  String get pdfAssistantRemoveTitle => 'Rimuovi PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Questo rimuoverà il PDF dal tuo dispositivo.';

  @override
  String get pdfAssistantUploadPdf => 'Carica PDF';

  @override
  String get cancel => 'Annulla';

  @override
  String get remove => 'Rimuovi';

  @override
  String get commonNext => 'Avanti';

  @override
  String get commonSkip => 'Salta';

  @override
  String get commonContinue => 'Continua';

  @override
  String get splashTagline => 'Scanner documenti con AI';

  @override
  String get onboardingPage1Title => 'Scansiona documenti';

  @override
  String get onboardingPage1Description =>
      'Acquisisci ricevute e note rapidamente.';

  @override
  String get onboardingPage2Title => 'OCR e traduzione';

  @override
  String get onboardingPage2Description => 'Estrai e traduci testo.';

  @override
  String get onboardingPage3Title => 'Salva ed esporta';

  @override
  String get onboardingPage3Description => 'Tutto in un unico posto.';

  @override
  String get settingsChooseLanguage => 'Scegli lingua';

  @override
  String get settingsLanguageApply => 'Applica';

  @override
  String get commonSaving => 'Salvataggio…';
}
