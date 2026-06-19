// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

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
  String get commonDone => 'Fine';

  @override
  String get commonLoading => 'Caricamento…';

  @override
  String get commonError => 'Qualcosa è andato storto';

  @override
  String get commonTryAgain => 'Per favore riprova';

  @override
  String get navHome => 'Casa';

  @override
  String get navScan => 'Scansiona';

  @override
  String get navDocuments => 'Documenti';

  @override
  String get navTranslate => 'Traduci';

  @override
  String get navLive => 'Dal vivo';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String homeGreeting(String name) {
    return 'Buongiorno, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'Documento IA';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Apri menu';

  @override
  String get homeTagAiPowered => 'Basato su IA';

  @override
  String get homeTagFastOcr => 'OCR rapido';

  @override
  String get homeTagSecure => 'Sicuro';

  @override
  String get homeTagSmartCrop => 'Ritaglio smart';

  @override
  String get homeHeroBadge => 'BASATO SU IA';

  @override
  String get homeHeroTitle => 'Scanner OCR IA\nSmart';

  @override
  String get homeHeroSubtitle =>
      'OCR basato su IA con riconoscimento del testo rapido e accurato in pochi secondi.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Cerca qui';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle =>
      'Scansiona testo da immagini o documenti';

  @override
  String get homeFeaturePdfTitle => 'Assistente PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduci e trascrivi PDF';

  @override
  String get homeFeatureChatbotTitle => 'Chiedi al PDF';

  @override
  String get homeFeatureChatbotSubtitle => 'Carica PDF per fare domande';

  @override
  String get homeFeatureCropTitle => 'Ritaglio smart';

  @override
  String get homeFeatureCropSubtitle =>
      'Ritaglia, pulisci e migliora automaticamente';

  @override
  String get homeRecentDocuments => 'Recenti';

  @override
  String get homeSeeAll => 'Vedi tutti';

  @override
  String get homeEmptyDocuments =>
      'Nessun documento presente. Tocca Scansiona per iniziare.';

  @override
  String get homeSampleDocName => 'Fattura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 maggio 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => 'Immagini';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file',
      one: '1 file',
      zero: '0 file',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count file',
      one: '1 file',
      zero: '0 file',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => 'Immagini';

  @override
  String get homeRecentAdded => 'Aggiunti di recente';

  @override
  String get homeRecentSelect => 'Seleziona';

  @override
  String get homeRecentSelectAll => 'Seleziona tutto';

  @override
  String get homeRecentDeselectAll => 'Deseleziona tutto';

  @override
  String get homeRecentSearchPdfs => 'Cerca tra i tuoi PDF…';

  @override
  String get homeRecentSearchImages => 'Cerca tra le tue immagini…';

  @override
  String get homeRecentNoSearchResults =>
      'Nessun file corrisponde alla ricerca';

  @override
  String get homeRecentToggleFavorite => 'Preferito';

  @override
  String get homeRecentUnfavorite => 'Rimuovi dai preferiti';

  @override
  String get homeRecentFavoriteAdded => 'Aggiunto ai preferiti';

  @override
  String get homeRecentFavoriteRemoved => 'Rimosso dai preferiti';

  @override
  String get homeRecentPdfEmptyTitle => 'Nessun PDF recente';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Carica o scansiona documenti per creare il tuo primo PDF';

  @override
  String get homeRecentImageEmptyTitle => 'Nessuna immagine recente';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Carica o scansiona immagini per organizzarle qui';

  @override
  String get homeRecentUploadPdf => 'Carica un PDF';

  @override
  String get homeRecentUploadImages => 'Carica immagini';

  @override
  String get homeRecentScanDocument => 'Scansiona documento';

  @override
  String get homeRecentDeleteImageTitle => 'Eliminare l\'immagine?';

  @override
  String get homeRecentDeleteImageMessage =>
      'Sei sicuro di voler eliminare questa immagine? Questa azione non può essere annullata.';

  @override
  String get homeRecentDeleteImagesTitle => 'Eliminare le immagini?';

  @override
  String get homeRecentDeleteImagesMessage =>
      'Sei sicuro di voler eliminare le immagini selezionate? Questa azione non può essere annullata.';

  @override
  String get scanTitle => 'Scansiona';

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
  String get scanDone => 'Fine';

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
  String get ocrRunning => 'Lettura testo…';

  @override
  String get ocrEmpty => 'Nessun testo trovato in questa immagine';

  @override
  String get ocrCopySuccess => 'Testo copiato';

  @override
  String get ocrEditHint => 'Modifica il testo riconosciuto';

  @override
  String get ocrInputMethodTitle => 'Scegli il metodo di input';

  @override
  String get ocrInputMethodSubtitle =>
      'Seleziona come desideri estrarre il testo';

  @override
  String get ocrInputLiveCameraTitle => 'Fotocamera live';

  @override
  String get ocrInputLiveCameraDescription =>
      'Acquisisci un\'immagine in tempo reale con la fotocamera';

  @override
  String get ocrInputUploadImageTitle => 'Carica immagine';

  @override
  String get ocrInputUploadImageDescription =>
      'Carica un\'immagine dalla galleria';

  @override
  String get ocrLiveCameraTitle => 'Fotocamera OCR live';

  @override
  String get ocrLiveCameraTip =>
      'Suggerimento: Per risultati migliori, posiziona il testo in un\'area ben illuminata';

  @override
  String get ocrLiveCameraClose => 'Chiudi fotocamera';

  @override
  String get ocrLiveCameraFlash => 'Attiva/Disattiva flash';

  @override
  String get ocrLiveCameraCapture =>
      'Acquisisci immagine per il riconoscimento del testo';

  @override
  String get ocrLiveCameraInitializing => 'Avvio fotocamera…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copia';

  @override
  String get ocrAnalyzeTranslate => 'Traduci';

  @override
  String get ocrAnalyzeProcessing => 'Analisi del testo…';

  @override
  String get ocrAnalyzeTranslateNext =>
      'La schermata di traduzione si aprirà tra poco';

  @override
  String get ocrNoTextTitle => 'Nessun testo leggibile rilevato';

  @override
  String get ocrNoTextHint => 'Prova con un\'immagine più chiara';

  @override
  String get ocrNoTextRetakePhoto => 'Scatta di nuovo';

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
  String get translateRunning => 'Traduzione in corso…';

  @override
  String get translatePasteHint => 'Incolla o digita il testo';

  @override
  String get translateCopyResult => 'Copia traduzione';

  @override
  String get translateResultTitle => 'Traduci testo';

  @override
  String get translateResultSubtitle =>
      'Traduci il testo selezionato in qualsiasi lingua';

  @override
  String get translateSelectedText => 'Testo selezionato';

  @override
  String get translateSelectedLanguage => 'Lingua selezionata';

  @override
  String get translateSelectLanguage => 'Seleziona lingua';

  @override
  String get translateSearchLanguage => 'Cerca lingue';

  @override
  String get translateRecentLanguages => 'Recenti';

  @override
  String get translateNoLanguagesFound => 'Nessuna lingua trovata';

  @override
  String get translateTranslatedText => 'Testo tradotto';

  @override
  String get translatePlaceholder => 'La traduzione apparirà qui…';

  @override
  String get translateSeeMore => 'Vedi altro';

  @override
  String get translateReadAloud => 'Leggi ad alta voce';

  @override
  String get translateSavePdf => 'Salva come PDF';

  @override
  String get translateSavePng => 'Salva como PNG';

  @override
  String get translateSaveComingSoon =>
      'Il salvataggio sarà disponibile a breve';

  @override
  String get translateDownloadOptionTitle => 'Scegli l\'opzione di download';

  @override
  String get translateDownloadOptionSubtitle =>
      'Seleziona cosa desideri scaricare';

  @override
  String get translateDownloadSelectedTextTitle =>
      'Scarica il testo selezionato';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Scarica solo il testo selezionato';

  @override
  String get translateDownloadCompleteFileTitle => 'Scarica il file completo';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Scarica l\'intero file';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Scarica il testo tradotto';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Scarica solo il testo tradotto';

  @override
  String get translateSavePdfSuccess => 'PDF salvato con successo';

  @override
  String get translateSavePngSuccess => 'Immagine salvata con successo';

  @override
  String get translateExportNeedsTranslation =>
      'Traduci il testo prima di scaricare';

  @override
  String get liveTitle => 'Traduzione live';

  @override
  String get liveStart => 'Avvia fotocamera';

  @override
  String get liveStop => 'Ferma';

  @override
  String get liveListening => 'Ascolto in corso…';

  @override
  String get livePointAtText => 'Inquadra il testo con la fotocamera';

  @override
  String get livePermissionNeeded =>
      'L\'accesso alla fotocamera è richiesto per la traduzione live';

  @override
  String get documentsTitle => 'I miei documenti';

  @override
  String get documentRename => 'Rinomina';

  @override
  String get documentDeleteConfirmTitle => 'Eliminare il documento?';

  @override
  String get documentDeleteConfirmMessage =>
      'Questa azione non può essere annullata.';

  @override
  String get documentDeleted => 'Documento eliminato';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get settingsLanguage => 'Lingua dell\'app';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsAbout => 'Informazioni';

  @override
  String get settingsPrivacy => 'Informativa sulla privacy';

  @override
  String get settingsTerms => 'Termini e condizioni';

  @override
  String get settingsContactSupport => 'Contatta il supporto';

  @override
  String get settingsMoreApps => 'Altre app';

  @override
  String get settingsRateApp => 'Valuta app';

  @override
  String get settingsShareApp => 'Condividi app';

  @override
  String get settingsGreetingPrefix => 'Buongiorno,';

  @override
  String get settingsDefaultUserName => 'Abdullah';

  @override
  String get permissionCameraTitle => 'Permesso fotocamera';

  @override
  String get permissionCameraMessage =>
      'Consenti l\'accesso alla fotocamera per scansionare documenti e utilizzare la traduzione live.';

  @override
  String get permissionStorageTitle => 'Permesso di archiviazione';

  @override
  String get permissionStorageMessage =>
      'Consenti l\'accesso per salvare e aprire le tue scansioni.';

  @override
  String get permissionOpenSettings => 'Apri impostazioni';

  @override
  String get permissionDenied => 'Permesso negato';

  @override
  String get errorCameraUnavailable =>
      'La fotocamera non è disponibile su questo dispositivo';

  @override
  String get errorFileRead => 'Impossibile leggere il file';

  @override
  String get errorNetwork => 'Controlla la tua connessione internet';

  @override
  String get errorNoInternetFeatures =>
      'Nessuna connessione internet. Alcune funzionalità potrebbero non funzionare correttamente.';

  @override
  String get exitAppTitle => 'Esci dall\'app';

  @override
  String get exitAppMessage => 'Sei sicuro di voler uscire?';

  @override
  String get exitAppConfirm => 'Esci';

  @override
  String get errorOcrFailed => 'Riconoscimento del testo fallito';

  @override
  String get errorTranslateFailed => 'Traduzione fallita';

  @override
  String get errorTranslateModelDownload =>
      'Impossibile scaricare il pacchetto della lingua. Controlla la connessione e riprova.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Questa lingua non è disponibile per la traduzione offline.';

  @override
  String get proTitle => 'Scanner per documenti Pro';

  @override
  String get proSubtitle =>
      'Scansioni, OCR, lingue e traduzione live illimitati';

  @override
  String get proUpgradeButton => 'Passa a Pro';

  @override
  String get proRestorePurchases => 'Ripristina acquisti';

  @override
  String get proFeatureLocked => 'Funzionalità Pro';

  @override
  String proLimitPages(int max) {
    return 'Il piano gratuito consente fino a $max pagine per documento';
  }

  @override
  String get proLimitOcr => 'Passa a Pro per OCR illimitato';

  @override
  String get proLimitTranslate => 'Passa a Pro per tutte le lingue';

  @override
  String get proLimitLive =>
      'La traduzione live è disponibile nella versione Pro';

  @override
  String get proPurchaseSuccess => 'Benvenuto in Pro!';

  @override
  String get proPurchaseFailed => 'Impossibile completare l\'acquisto';

  @override
  String get proPaywallTitle => 'Ottieni accesso Pro';

  @override
  String get proPaywallTitleGet => 'Ottieni';

  @override
  String get proPaywallTitlePro => 'Pro';

  @override
  String get proPaywallTitleAccess => 'accesso';

  @override
  String get proEnableTrial => 'Attiva prova';

  @override
  String get proTrialPlanTitle => 'Accesso completo 3 giorni';

  @override
  String get proYearlyPlanTitle => 'Annuale';

  @override
  String get proContinue => 'Continua';

  @override
  String proTrialDisclaimer(String price) {
    return 'Dopo 3 giorni gratis, inizierà l\'abbonamento settimanale a $price. Annulla in qualsiasi momento 24 ore prima del rinnovo.';
  }

  @override
  String proYearlyDisclaimer(String price) {
    return 'Abbonamento annuale a $price/anno. Annulla almeno 24 ore prima del rinnovo.';
  }

  @override
  String proTrialThenPrice(String price) {
    return 'poi $price/settimana';
  }

  @override
  String get proPerWeek => 'a settimana';

  @override
  String proYearlySubtitle(String price) {
    return 'solo $price all\'anno';
  }

  @override
  String get proSaveBadge => 'Risparmia 86%';

  @override
  String get proFeatureUnlimitedScans => 'Scansioni documenti illimitate';

  @override
  String get proFeatureOcr => 'Riconoscimento OCR accurato';

  @override
  String get proFeaturePdf => 'Strumenti PDF avanzati';

  @override
  String get proFeatureAi => 'Assistenza IA intelligente';

  @override
  String get proStoreUnavailable =>
      'Lo store non è disponibile al momento. Riprova più tardi.';

  @override
  String get proSplashEnable => 'Attiva';

  @override
  String get proSplashTrialDays => 'Prova di 3 giorni';

  @override
  String get proSplashTrialEnabled => 'è attiva!';

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
  String get languageAuto => 'Rileva lingua';

  @override
  String get chatbotTitle => 'Chatbot IA';

  @override
  String get chatbotHistoryButton => 'Cronologia chat';

  @override
  String get chatbotBadge => 'Il tuo assistente smart con IA';

  @override
  String get chatbotHeadlineChat => 'Chatta';

  @override
  String get chatbotHeadlineMiddle => ' con il tuo ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Carica un PDF e chiedi qualsiasi cosa — ottieni risposte immediate, riassunti, spiegazioni e altro ancora.';

  @override
  String get chatbotTryAsking => 'Prova a chiedere';

  @override
  String get chatbotSuggestSummarize => 'Riassumi questo PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Punti chiave di questo PDF';

  @override
  String get chatbotSuggestExplain => 'Spiega in dettaglio';

  @override
  String get chatbotSuggestTranslate => 'Traduci questo PDF';

  @override
  String get chatbotAskQuestions => 'Fai domande su questo PDF';

  @override
  String get chatbotUploadHint => 'Carica un PDF...';

  @override
  String get chatbotSheetTitle => 'Chatta con il tuo PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Carica un PDF e chiedi qualsiasi cosa al riguardo';

  @override
  String get chatbotChoosePdfTitle => 'Scegli file PDF';

  @override
  String get chatbotChoosePdfDescription =>
      'Sfoglia e seleziona un PDF dal tuo dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'File recenti';

  @override
  String get chatbotRecentFilesDescription => 'Scegli tra i tuoi file recenti';

  @override
  String get errorChatbotPdfPickFailed =>
      'Impossibile aprire il PDF selezionato';

  @override
  String get chatbotAnalyzingTitle => 'Analisi del documento in corso…';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Si prega di attendere mentre leggiamo e\ncomprendiamo il tuo PDF';

  @override
  String get chatbotStepReadingPdf => 'Lettura PDF';

  @override
  String get chatbotStepExtractingText => 'Estrazione testo';

  @override
  String get chatbotStepUnderstandingContent => 'Comprensione del contenuto';

  @override
  String get chatbotStepPreparingChat => 'Preparazione chat IA';

  @override
  String get chatbotHistoryTitle => 'Cronologia';

  @override
  String get chatbotNoConversationsTitle => 'Nessuna conversazione presente';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Carica un PDF per iniziare a chattare con il tuo assistente IA.';

  @override
  String get chatbotUploadPdfButton => 'Carica un PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento pronto';

  @override
  String get chatbotDocumentReadySubtitle => 'Ora puoi chattare con il tuo PDF';

  @override
  String get chatbotCurrentSummary => 'Riepilogo attuale';

  @override
  String get chatbotStartChatting => 'Inizia a chattare';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Ciao! Sono il tuo assistente IA. Chiedimi qualsiasi cosa su questo PDF e ti aiuterò.';

  @override
  String get chatbotChatYouCanAsk => 'Puoi chiedermi:';

  @override
  String get chatbotChatPromptSummarize => 'Riassumi questo documento';

  @override
  String get chatbotChatPromptHighlights => 'Quali sono i punti principali?';

  @override
  String get chatbotChatPromptFinancial => 'Mostrami i dati finanziari';

  @override
  String get chatbotChatPromptDates => 'Estrai le date importanti';

  @override
  String get chatbotChatInputHint => 'Chiedi qualcosa su questo PDF…';

  @override
  String get chatbotDeleteTitle => 'Eliminare la chat?';

  @override
  String get chatbotDeleteMessage =>
      'Questo rimuoverà la chat e il PDF dalla tua cronologia. L\'azione non può essere annullata.';

  @override
  String get chatbotRenameTitle => 'Rinomina PDF';

  @override
  String get chatbotRenameHint => 'Inserisci un nome';

  @override
  String get chatbotHistorySearchHint => 'Cerca tra le tue conversazioni…';

  @override
  String get chatbotRenameSuccess => 'Rinominato con successo';

  @override
  String get chatbotDeleteSuccess => 'Eliminato con successo';

  @override
  String get chatbotEmptyConversationPreview => 'Conversazione vuota…';

  @override
  String get chatbotAiThinking => 'L\'IA sta pensando';

  @override
  String get chatbotTipsLabel => 'Suggerimenti';

  @override
  String get chatbotSuggestSummarizeChip => 'Riassumi\nquesto PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Punti chiave\ndi questo PDF';

  @override
  String get chatbotSuggestExplainChip => 'Spiega\nin dettaglio';

  @override
  String get chatbotSuggestTranslateChip => 'Traduci\nquesto PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Impossibile analizzare questo PDF. Per favore riprova.';

  @override
  String get chatbotChatFailed => 'Impossibile ottenere una risposta. Riprova.';

  @override
  String get errorChatbotPdfEmpty => 'Nessun testo trovato in questo PDF';

  @override
  String get pdfAssistantTitle => 'Assistente PDF';

  @override
  String get pdfAssistantSheetTitle => 'Carica PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Scegli come desideri aggiungere il tuo file PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Scegli file PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Sfoglia e seleziona un PDF dal tuo dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Aggiungi PDF da link';

  @override
  String get pdfAssistantLinkDescription =>
      'Incolla il link di un PDF per caricarlo direttamente';

  @override
  String get pdfAssistantLinkHint => 'Incolla l\'URL del PDF';

  @override
  String get pdfAssistantLinkButton => 'Scarica PDF';

  @override
  String get pdfAssistantTranslateTo => 'Traduci in';

  @override
  String get pdfAssistantTranslateToOptional => 'Traduci in (facoltativo)';

  @override
  String get pdfAssistantNoTranslation => 'Nessuna traduzione';

  @override
  String get pdfAssistantExtractedPdfTitle => 'PDF estratto';

  @override
  String get pdfAssistantExtractedPdfDescription =>
      'Testo estratto dalle pagine del PDF';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => 'Testo estratto';

  @override
  String get pdfAssistantStepPreparingContent => 'Preparazione del contenuto…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'Generazione del PDF…';

  @override
  String get pdfAssistantStartProcessing => 'Avvia elaborazione';

  @override
  String get pdfAssistantNoFileSelected => 'Nessun file selezionato';

  @override
  String get pdfAssistantSelectLanguage =>
      'Seleziona una lingua di destinazione';

  @override
  String get pdfAssistantProcessingTitle =>
      'Elaborazione del tuo PDF in corso…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Si prega di attendere.';

  @override
  String get pdfAssistantStepExtracting => 'Estrazione del testo…';

  @override
  String get pdfAssistantStepTranslating => 'Traduzione del contenuto…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Generazione del PDF tradotto…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizzazione in corso…';

  @override
  String get pdfAssistantResultTitle => 'Risultati';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF tradotto';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Layout originale con testo tradotto in sovrimpressione';

  @override
  String get pdfAssistantExtractedTextTitle => 'Testo tradotto estratto';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Semplice documento di testo in formato A4';

  @override
  String get pdfAssistantActionOpen => 'Apri';

  @override
  String get pdfAssistantActionDownload => 'Scarica';

  @override
  String get pdfAssistantDeleteTitle => 'Eliminare i risultati?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Questo rimuoverà i file tradotti dal tuo dispositivo.';

  @override
  String get pdfAssistantDownloadSuccess => 'Salvato in Download';

  @override
  String get pdfAssistantOpenFailed => 'Impossibile aprire il file';

  @override
  String get pdfAssistantProcessFailed => 'Impossibile elaborare questo PDF';

  @override
  String get errorPdfAssistantPickFailed =>
      'Impossibile aprire il PDF selezionato';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Impossibile scaricare il PDF da questo link';

  @override
  String get errorPdfAssistantPdfEmpty => 'Nessun testo trovato in questo PDF';

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
  String get onboardingStart => 'Inizia con →';

  @override
  String get splashTagline => 'Scansione documenti basata su IA';

  @override
  String get splashAdDisclaimer =>
      'Questa azione potrebbe mostrare un annuncio';

  @override
  String get adLoading => 'Caricamento annuncio...';

  @override
  String get onboardingPage1Title => 'Scansiona testo\nin pochi secondi';

  @override
  String get onboardingPage1Description =>
      'Acquisisci testo dalle immagini con la rapida scansione OCR basata su IA.';

  @override
  String get onboardingPage2Title => 'Assistente PDF\nsmart';

  @override
  String get onboardingPage2Description =>
      'Traduci, estrai e comprendi i tuoi documenti PDF grazie all\'IA.';

  @override
  String get onboardingPage3Title => 'Chatta con\ni tuoi PDF';

  @override
  String get onboardingPage3Description =>
      'Fai domande, riassumi documenti e ottieni risposte istantanee dall\'IA.';

  @override
  String get onboardingPage4Title => 'Ritaglio smart\nin pochi secondi';

  @override
  String get onboardingPage4Description =>
      'Ritaglia automaticamente più immagini e crea PDF nitidi all\'istante.';

  @override
  String get settingsChooseLanguage => 'Scegli una lingua';

  @override
  String get settingsLanguageApply => 'Applica';

  @override
  String get commonSaving => 'Salvataggio…';

  @override
  String get smartCropTitle => 'Ritaglio smart';

  @override
  String get smartCropInputMethodTitle => 'Scanner con ritaglio smart';

  @override
  String get smartCropInputMethodSubtitle =>
      'Scegli come desideri ritagliare il tuo documento';

  @override
  String get smartCropInputLiveCameraTitle => 'Fotocamera live';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Scanner di Google — rileva bordi, ritaglia e migliora automaticamente';

  @override
  String get smartCropInputUploadImageTitle => 'Carica immagine';

  @override
  String get smartCropInputUploadImageDescription =>
      'Carica l\'immagine del documento dalla galleria';

  @override
  String get smartCropUploadIntroHeadline =>
      'Ritaglia più immagini\nautomaticamente';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Rileva automaticamente i bordi, ritaglia le immagini alla perfezione e crea un PDF con un solo tocco.';

  @override
  String get smartCropUploadIntroStepSelect => 'Seleziona più immagini';

  @override
  String get smartCropUploadIntroStepCrop =>
      'Rilevamento e ritaglio automatici';

  @override
  String get smartCropUploadIntroStepPdf => 'Crea un PDF all\'istante';

  @override
  String get smartCropUploadIntroSelectImages => 'Seleziona immagini';

  @override
  String get smartCropLiveCameraTitle => 'Fotocamera con ritaglio smart';

  @override
  String get smartCropLiveCameraTip =>
      'Documento rilevato — tocca per acquisire';

  @override
  String get smartCropLiveCameraAlignTip =>
      'Allinea il documento all\'interno degli angoli';

  @override
  String get smartCropLiveCameraClose => 'Chiudi fotocamera';

  @override
  String get smartCropLiveCameraFlash => 'Attiva/Disattiva flash';

  @override
  String get smartCropLiveCameraCapture =>
      'Acquisisci documento per il ritaglio smart';

  @override
  String get smartCropLiveCameraInitializing => 'Avvio fotocamera…';

  @override
  String get smartCropCapturedTitle => 'Documento acquisito';

  @override
  String get smartCropCapturedRetake => 'Rifai l\'ultima foto';

  @override
  String get smartCropCapturedAnotherPhoto => 'Aggiungi un\'altra foto';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Rifai un\'altra foto';

  @override
  String get smartCropCapturedPreview => 'Anteprima';

  @override
  String get smartCropPreviewTitle => 'Anteprima';

  @override
  String get smartCropCapturedCrop => 'Ritaglia';

  @override
  String get smartCropAdjustCornersTitle => 'Regola gli angoli';

  @override
  String get smartCropAdjustCornersHint =>
      'Trascina gli angoli viola per farli coincidere con i bordi del documento';

  @override
  String get smartCropAdjustCornersConfirm => 'Applica ritaglio';

  @override
  String get smartCropPresetAuto => 'Rilevamento automatico';

  @override
  String get smartCropPresetCenter => 'Pagina centrata';

  @override
  String get smartCropPresetFull => 'Immagine intera';

  @override
  String get smartCropUploadIntroGoogleScanner =>
      'Google Scanner (Miglior ritaglio)';

  @override
  String get smartCropDetectingEdges => 'Rilevamento dei bordi del documento…';

  @override
  String get smartCropAndroidOnly =>
      'La scansione intelligente è disponibile solo su Android.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Raggiunto il limite massimo di $max foto';
  }

  @override
  String get smartCropProcessingCrop => 'Applicazione del ritaglio magico…';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Ritaglio di $count documenti in corso…';
  }

  @override
  String get smartCropCroppedTitle => 'Documento ritagliato';

  @override
  String get smartCropFilterOriginal => 'Originale';

  @override
  String get smartCropFilterLighten => 'Schiarisci';

  @override
  String get smartCropFilterMagic => 'Magico';

  @override
  String get smartCropFilterGrayscale => 'Scala di grigi';

  @override
  String get smartCropFilterMono => 'B&N';

  @override
  String get smartCropFilterWarm => 'Caldo';

  @override
  String get smartCropActionCreatePdf => 'Crea PDF';

  @override
  String get smartCropProcessingPdf => 'Generazione del documento PDF…';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Generazione del PDF con $count pagine…';
  }

  @override
  String get smartCropPdfSuccess => 'Documento PDF generato con successo';

  @override
  String get smartCropPdfPagesLabel => 'pagine';

  @override
  String get smartCropPdfSinglePageLabel => '1 pagina';

  @override
  String get smartCropImageCopied => 'Copiato';

  @override
  String get smartCropDeleteImageConfirm =>
      'Rimuovere questa pagina dal documento?';

  @override
  String get smartCropDeleteCapturedPageTitle => 'Elimina pagina';

  @override
  String get smartCropDeleteCapturedPageMessage =>
      'Sei sicuro di voler eliminare questa pagina ?';

  @override
  String get smartCropDeleteDocumentTitle => 'Eliminare il documento?';

  @override
  String get smartCropDeleteDocumentMessage =>
      'Sei sicuro di voler eliminare questo documento? Questa azione non può essere annullata.';

  @override
  String get smartCropDeletePdfTitle => 'Eliminare il PDF?';

  @override
  String get smartCropDeletePdfMessage =>
      'Sei sicuro di voler eliminare questo PDF? Questa azione non può essere annullata.';

  @override
  String get smartCropDeletePdfConfirm =>
      'Eliminare questo PDF dal tuo dispositivo?';

  @override
  String get smartCropPdfRenamed => 'PDF rinominato';

  @override
  String get smartCropPdfFileName => 'Nome file';

  @override
  String get smartCropPdfFileSize => 'Dimensione file';

  @override
  String get smartCropViewPdf => 'Visualizza PDF';

  @override
  String get smartCropSavePdf => 'Salva PDF';

  @override
  String get smartCropSavePdfSuccess => 'PDF salvato con successo';

  @override
  String get smartCropRenamePdf => 'Rinomina';

  @override
  String get smartCropRenamePdfHint => 'Nome del documento';

  @override
  String get smartCropStepReadingImages => 'Lettura immagini';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return 'Lettura di $done su $total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return '$failed di $total immagini non sono state importate';
  }

  @override
  String get smartCropStepDetectingEdges => 'Rilevamento bordi';

  @override
  String get smartCropStepCroppingImages => 'Ritaglio immagini';

  @override
  String get smartCropStepGeneratingPdf => 'Generazione PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Stiamo organizzando le tue immagini ritagliate\nin un PDF di alta qualità';

  @override
  String get smartCropProcessingPdfTitle => 'Creazione del tuo PDF';

  @override
  String get commonUntitledDocument => 'documento';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Tocca per sfogliare le cartelle del dispositivo';

  @override
  String get errorPdfTextLoad => 'Errore durante il caricamento del testo.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Traduzione: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Traduzione del documento';

  @override
  String get translateExportTranslatedBadge => 'Tradotto';

  @override
  String get translateExportVerifiedFooter =>
      'Esportazione della traduzione offline verificata';

  @override
  String get translateExportPdfHeader => 'Esportazione della traduzione';

  @override
  String get translateExportPdfFooterLabel => 'Documento riservato';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Pagina $page di $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Pagina $page';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size B';
  }

  @override
  String fileSizeKb(String size) {
    return '${size}KB';
  }

  @override
  String fileSizeMb(String size) {
    return '$size MB';
  }

  @override
  String get translateLangName_en => 'Inglese';

  @override
  String get translateLangName_ur => 'Urdu';

  @override
  String get translateLangName_hi => 'hindi';

  @override
  String get translateLangName_ar => 'Arabo';

  @override
  String get translateLangName_es => 'Spagnolo';

  @override
  String get translateLangName_fr => 'Francese';

  @override
  String get translateLangName_de => 'Tedesco';

  @override
  String get translateLangName_pt => 'Portoghese';

  @override
  String get translateLangName_ru => 'Russo';

  @override
  String get translateLangName_zh => 'Cinese (Semplificato)';

  @override
  String get translateLangName_zhTw => 'Cinese (Tradizionale)';

  @override
  String get translateLangName_ja => 'Giapponese';

  @override
  String get translateLangName_ko => 'Coreano';

  @override
  String get translateLangName_it => 'Italiano';

  @override
  String get translateLangName_tr => 'Turco';

  @override
  String get translateLangName_nl => 'Olandese';

  @override
  String get translateLangName_sv => 'Svedese';

  @override
  String get translateLangName_no => 'Norvegese';

  @override
  String get translateLangName_da => 'Danese';

  @override
  String get translateLangName_fi => 'Finlandese';

  @override
  String get translateLangName_el => 'Greco';

  @override
  String get translateLangName_pl => 'Polacco';

  @override
  String get translateLangName_cs => 'Ceco';

  @override
  String get translateLangName_hu => 'Ungherese';

  @override
  String get translateLangName_ro => 'Rumeno';

  @override
  String get translateLangName_bg => 'Bulgaro';

  @override
  String get translateLangName_uk => 'Ucraino';

  @override
  String get translateLangName_fa => 'Persiano';

  @override
  String get translateLangName_he => 'Ebraico';

  @override
  String get translateLangName_th => 'Thailandese';

  @override
  String get translateLangName_vi => 'Vietnamita';

  @override
  String get translateLangName_id => 'Indonesiano';

  @override
  String get translateLangName_ms => 'Malese';

  @override
  String get translateLangName_bn => 'Bengalese';

  @override
  String get translateLangName_ta => 'Tamil';

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
  String get translateLangName_sw => 'Swahili';

  @override
  String get translateLangName_af => 'afrikaans';

  @override
  String get translateLangName_ca => 'Catalano';

  @override
  String get translateLangName_hr => 'Croato';

  @override
  String get translateLangName_sk => 'Slovacco';

  @override
  String get translateLangName_sl => 'Sloveno';

  @override
  String get translateLangName_sr => 'Serbo';

  @override
  String get translateLangName_lt => 'Lituano';

  @override
  String get translateLangName_lv => 'Lettone';

  @override
  String get translateLangName_et => 'Estone';

  @override
  String get translateLangName_is => 'Islandese';

  @override
  String get translateLangName_ga => 'Irlandese';

  @override
  String get translateLangName_mt => 'maltese';

  @override
  String get translateLangName_sq => 'Albanese';

  @override
  String get translateLangName_mk => 'Macedone';

  @override
  String get translateLangName_be => 'Bielorusso';

  @override
  String get translateLangName_kk => 'Kazako';

  @override
  String get translateLangName_uz => 'Uzbeco';

  @override
  String get translateLangName_az => 'Azerbaigiano';

  @override
  String get translateLangName_hy => 'Armeno';

  @override
  String get translateLangName_ka => 'Georgiano';

  @override
  String get translateLangName_lo => 'Laotiano';

  @override
  String get translateLangName_km => 'Khmer';

  @override
  String get translateLangName_my => 'Birmano';

  @override
  String get translateLangName_ne => 'Nepalese';

  @override
  String get translateLangName_si => 'Singalese';

  @override
  String get translateLangName_am => 'Amarico';

  @override
  String get translateLangName_ha => 'Hausa';

  @override
  String get translateLangName_yo => 'Yoruba';

  @override
  String get translateLangName_ig => 'Igbo';

  @override
  String get translateLangName_zu => 'Zulù';

  @override
  String get translateLangName_xh => 'Xhosa';

  @override
  String get translateLangName_st => 'Sesotho';

  @override
  String get translateLangName_sn => 'Shona';

  @override
  String get translateLangName_rw => 'Kinyarwanda';

  @override
  String get translateLangName_so => 'Somalo';

  @override
  String get translateLangName_mg => 'Malgascio';

  @override
  String get translateLangName_cy => 'Gallese';

  @override
  String get translateLangName_mn => 'Mongolo';

  @override
  String get translateLangName_tl => 'Filippino';

  @override
  String get translateLangName_ht => 'Creolo Haitiano';

  @override
  String get translateLangName_eo => 'esperanto';

  @override
  String get translateLangName_la => 'Latino';

  @override
  String get translateLangName_ku => 'Curdo';

  @override
  String get translateLangName_ps => 'Pashtu';

  @override
  String get translateLangName_faAf => 'Dari';

  @override
  String get translateLangName_bs => 'Bosniaco';

  @override
  String get translateLangName_mi => 'Maori';

  @override
  String get translateLangName_sm => 'Samoano';

  @override
  String get translateLangName_haw => 'Hawaiano';

  @override
  String get translateLangName_lb => 'Lussemburghese';
}
