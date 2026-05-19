// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Scanner de Documents';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonShare => 'Partager';

  @override
  String get commonCopy => 'Copier';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonError => 'Une erreur s\'est produite';

  @override
  String get commonTryAgain => 'Veuillez réessayer';

  @override
  String get navHome => 'Accueil';

  @override
  String get navScan => 'Scanner';

  @override
  String get navDocuments => 'Documents';

  @override
  String get navTranslate => 'Traduire';

  @override
  String get navLive => 'En direct';

  @override
  String get navSettings => 'Paramètres';

  @override
  String homeGreeting(String name) {
    return 'Bonjour, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'Document IA';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Ouvrir le menu';

  @override
  String get homeTagAiPowered => 'Propulsé par IA';

  @override
  String get homeTagFastOcr => 'OCR rapide';

  @override
  String get homeTagSecure => 'Sécurisé';

  @override
  String get homeTagSmartCrop => 'Recadrage intelligent';

  @override
  String get homeHeroBadge => 'IA INTELLIGENTE';

  @override
  String get homeHeroTitle => 'Scanner OCR IA\nIntelligent';

  @override
  String get homeHeroSubtitle =>
      'OCR alimenté par IA avec reconnaissance rapide et précise du texte en quelques secondes.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Rechercher ici';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle =>
      'Extraire du texte depuis images ou documents';

  @override
  String get homeFeaturePdfTitle => 'Assistant PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduire et transcrire les PDF';

  @override
  String get homeFeatureChatbotTitle => 'Chatbot IA';

  @override
  String get homeFeatureChatbotSubtitle =>
      'Importer un PDF pour poser des questions';

  @override
  String get homeFeatureCropTitle => 'Recadrage intelligent';

  @override
  String get homeFeatureCropSubtitle => 'Auto-cadrage et amélioration';

  @override
  String get homeRecentDocuments => 'Documents récents';

  @override
  String get homeSeeAll => 'Voir tout';

  @override
  String get homeEmptyDocuments =>
      'Aucun document. Appuyez sur Scanner pour commencer.';

  @override
  String get homeSampleDocName => 'Facture_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 mai 2026 • 2,4 Mo';

  @override
  String get scanTitle => 'Scanner';

  @override
  String get scanCapture => 'Capturer';

  @override
  String get scanImportGallery => 'Importer depuis la galerie';

  @override
  String get scanImportFiles => 'Importer un fichier';

  @override
  String get scanAddPage => 'Ajouter une page';

  @override
  String get scanRetake => 'Reprendre';

  @override
  String get scanCrop => 'Recadrer';

  @override
  String get scanEnhance => 'Améliorer';

  @override
  String get scanDone => 'Terminé';

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
  String get scanSaving => 'Enregistrement du scan…';

  @override
  String get scanSaved => 'Document enregistré';

  @override
  String get ocrTitle => 'Reconnaissance de texte';

  @override
  String get ocrRun => 'Reconnaître le texte';

  @override
  String get ocrRunning => 'Lecture du texte…';

  @override
  String get ocrEmpty => 'Aucun texte trouvé dans cette image';

  @override
  String get ocrCopySuccess => 'Texte copié';

  @override
  String get ocrEditHint => 'Modifier le texte reconnu';

  @override
  String get ocrInputMethodTitle => 'Choisir la méthode d\'entrée';

  @override
  String get ocrInputMethodSubtitle => 'Sélectionnez comment extraire le texte';

  @override
  String get ocrInputLiveCameraTitle => 'Caméra en direct';

  @override
  String get ocrInputLiveCameraDescription =>
      'Capturer une image avec la caméra';

  @override
  String get ocrInputUploadImageTitle => 'Importer une image';

  @override
  String get ocrInputUploadImageDescription => 'Choisir depuis la galerie';

  @override
  String get ocrLiveCameraTitle => 'Caméra OCR en direct';

  @override
  String get ocrLiveCameraTip =>
      'Astuce : pour de meilleurs résultats, placez le texte dans un endroit bien éclairé';

  @override
  String get ocrLiveCameraClose => 'Fermer la caméra';

  @override
  String get ocrLiveCameraFlash => 'Activer/désactiver le flash';

  @override
  String get ocrLiveCameraCapture => 'Capturer l\'image pour OCR';

  @override
  String get ocrLiveCameraInitializing => 'Démarrage de la caméra…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copier';

  @override
  String get ocrAnalyzeTranslate => 'Traduire';

  @override
  String get ocrAnalyzeProcessing => 'Analyse du texte…';

  @override
  String get ocrAnalyzeTranslateNext => 'La traduction va s\'ouvrir';

  @override
  String get ocrNoTextTitle => 'Aucun texte détecté';

  @override
  String get ocrNoTextHint => 'Essayez une image plus claire';

  @override
  String get ocrNoTextRetakePhoto => 'Reprendre la photo';

  @override
  String get ocrNoTextChooseGallery => 'Choisir depuis la galerie';

  @override
  String get translateTitle => 'Traduire';

  @override
  String get translateSourceLanguage => 'De';

  @override
  String get translateTargetLanguage => 'Vers';

  @override
  String get translateSwapLanguages => 'Inverser les langues';

  @override
  String get translateButton => 'Traduire';

  @override
  String get translateRunning => 'Traduction…';

  @override
  String get translatePasteHint => 'Coller ou écrire du texte';

  @override
  String get translateCopyResult => 'Copier la traduction';

  @override
  String get translateResultTitle => 'Traduction';

  @override
  String get translateResultSubtitle =>
      'Traduisez votre texte dans n\'importe quelle langue';

  @override
  String get translateSelectedText => 'Texte sélectionné';

  @override
  String get translateSelectedLanguage => 'Langue sélectionnée';

  @override
  String get translateSelectLanguage => 'Choisir une langue';

  @override
  String get translateSearchLanguage => 'Rechercher une langue';

  @override
  String get translateRecentLanguages => 'Récentes';

  @override
  String get translateNoLanguagesFound => 'Aucune langue trouvée';

  @override
  String get translateTranslatedText => 'Texte traduit';

  @override
  String get translatePlaceholder => 'La traduction apparaîtra ici…';

  @override
  String get translateSeeMore => 'Voir plus';

  @override
  String get translateReadAloud => 'Lire à voix haute';

  @override
  String get translateSavePdf => 'Enregistrer en PDF';

  @override
  String get translateSavePng => 'Enregistrer en image';

  @override
  String get translateSaveComingSoon => 'Bientôt disponible';

  @override
  String get translateDownloadOptionTitle =>
      'Choisir l\'option de téléchargement';

  @override
  String get translateDownloadOptionSubtitle =>
      'Sélectionnez ce que vous voulez télécharger';

  @override
  String get translateDownloadSelectedTextTitle =>
      'Télécharger le texte sélectionné';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Télécharger uniquement le texte sélectionné';

  @override
  String get translateDownloadCompleteFileTitle =>
      'Télécharger le fichier complet';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Télécharger tout le fichier';

  @override
  String get translateSavePdfSuccess => 'PDF enregistré avec succès';

  @override
  String get translateSavePngSuccess => 'Image enregistrée avec succès';

  @override
  String get translateExportNeedsTranslation =>
      'Veuillez traduire le texte avant de télécharger';

  @override
  String get liveTitle => 'Traduction en direct';

  @override
  String get liveStart => 'Démarrer la caméra';

  @override
  String get liveStop => 'Arrêter';

  @override
  String get liveListening => 'Écoute…';

  @override
  String get livePointAtText => 'Pointez la caméra vers le texte';

  @override
  String get livePermissionNeeded => 'L\'accès à la caméra est requis';

  @override
  String get documentsTitle => 'Mes documents';

  @override
  String get documentRename => 'Renommer';

  @override
  String get documentDeleteConfirmTitle => 'Supprimer le document ?';

  @override
  String get documentDeleteConfirmMessage => 'Cette action est irréversible.';

  @override
  String get documentDeleted => 'Document supprimé';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get settingsLanguage => 'Langue de l\'application';

  @override
  String get settingsTheme => 'Thème';

  @override
  String get settingsAbout => 'À propos';

  @override
  String get settingsPrivacy => 'Politique de confidentialité';

  @override
  String get settingsTerms => 'Conditions d\'utilisation';

  @override
  String get permissionCameraTitle => 'Autorisation caméra';

  @override
  String get permissionCameraMessage =>
      'Autorisez l\'accès à la caméra pour scanner et traduire.';

  @override
  String get permissionStorageTitle => 'Autorisation stockage';

  @override
  String get permissionStorageMessage =>
      'Autorisez l\'accès pour enregistrer vos scans.';

  @override
  String get permissionOpenSettings => 'Ouvrir les paramètres';

  @override
  String get permissionDenied => 'Permission refusée';

  @override
  String get errorCameraUnavailable => 'Caméra non disponible';

  @override
  String get errorFileRead => 'Impossible de lire le fichier';

  @override
  String get errorNetwork => 'Vérifiez votre connexion internet';

  @override
  String get errorNoInternetFeatures => 'Pas de connexion internet';

  @override
  String get exitAppTitle => 'Quitter l\'application';

  @override
  String get exitAppMessage => 'Voulez-vous vraiment quitter ?';

  @override
  String get exitAppConfirm => 'Quitter';

  @override
  String get errorOcrFailed => 'Échec de la reconnaissance';

  @override
  String get errorTranslateFailed => 'Échec de la traduction';

  @override
  String get errorTranslateModelDownload =>
      'Impossible de télécharger le pack de langue';

  @override
  String get errorTranslateUnsupportedLanguage => 'Langue non supportée';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'Scans illimités, OCR et traduction';

  @override
  String get proUpgradeButton => 'Passer à Pro';

  @override
  String get proRestorePurchases => 'Restaurer les achats';

  @override
  String get proFeatureLocked => 'Fonction Pro';

  @override
  String proLimitPages(int max) {
    return 'La version gratuite permet $max pages';
  }

  @override
  String get proLimitOcr => 'Passez à Pro pour OCR illimité';

  @override
  String get proLimitTranslate => 'Passez à Pro pour toutes les langues';

  @override
  String get proLimitLive => 'Traduction en direct Pro uniquement';

  @override
  String get proPurchaseSuccess => 'Bienvenue Pro !';

  @override
  String get proPurchaseFailed => 'Achat échoué';

  @override
  String get exportPdf => 'Exporter en PDF';

  @override
  String get exportImage => 'Exporter en image';

  @override
  String get exportSuccess => 'Export terminé';

  @override
  String get exportFailed => 'Échec de l\'export';

  @override
  String get languageSearchHint => 'Rechercher une langue';

  @override
  String get languageAuto => 'Détection automatique';

  @override
  String get chatbotTitle => 'Chatbot IA';

  @override
  String get chatbotHistoryButton => 'Historique';

  @override
  String get chatbotBadge => 'Votre assistant IA';

  @override
  String get chatbotHeadlineChat => 'Chat';

  @override
  String get chatbotHeadlineMiddle => ' avec votre ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Essayez de demander';

  @override
  String get chatbotSuggestSummarize => 'Résumer ce PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Points clés';

  @override
  String get chatbotSuggestExplain => 'Expliquer en détail';

  @override
  String get chatbotSuggestTranslate => 'Traduire ce PDF';

  @override
  String get chatbotUploadHint => 'Importer un PDF...';

  @override
  String get chatbotSheetTitle => 'Chat avec votre PDF';

  @override
  String get chatbotSheetSubtitle => 'Importez un PDF et posez vos questions';

  @override
  String get chatbotChoosePdfTitle => 'Choisir un PDF';

  @override
  String get chatbotChoosePdfDescription => 'Sélectionner depuis l\'appareil';

  @override
  String get chatbotRecentFilesTitle => 'Fichiers récents';

  @override
  String get chatbotRecentFilesDescription => 'Choisir un fichier récent';

  @override
  String get errorChatbotPdfPickFailed => 'Impossible d\'ouvrir le PDF';

  @override
  String get chatbotAnalyzingTitle => 'Analyse du document...';

  @override
  String get chatbotAnalyzingSubtitle => 'Veuillez patienter';

  @override
  String get chatbotStepReadingPdf => 'Lecture du PDF';

  @override
  String get chatbotStepExtractingText => 'Extraction du texte';

  @override
  String get chatbotStepUnderstandingContent => 'Compréhension';

  @override
  String get chatbotStepPreparingChat => 'Préparation du chat';

  @override
  String get chatbotHistoryTitle => 'Historique';

  @override
  String get chatbotNoConversationsTitle => 'Aucune conversation';

  @override
  String get chatbotNoConversationsSubtitle => 'Importez un PDF pour commencer';

  @override
  String get chatbotUploadPdfButton => 'Importer un PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Document prêt';

  @override
  String get chatbotDocumentReadySubtitle => 'Voici un résumé rapide';

  @override
  String get chatbotCurrentSummary => 'Résumé';

  @override
  String get chatbotStartChatting => 'Commencer';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Bonjour ! Posez-moi vos questions sur ce PDF.';

  @override
  String get chatbotChatYouCanAsk => 'Vous pouvez demander :';

  @override
  String get chatbotChatPromptSummarize => 'Résumer ce document';

  @override
  String get chatbotChatPromptHighlights => 'Points importants';

  @override
  String get chatbotChatPromptFinancial => 'Données financières';

  @override
  String get chatbotChatPromptDates => 'Dates importantes';

  @override
  String get chatbotChatInputHint => 'Demandez quelque chose...';

  @override
  String get chatbotDeleteTitle => 'Supprimer le chat ?';

  @override
  String get chatbotDeleteMessage => 'Action irréversible.';

  @override
  String get chatbotRenameTitle => 'Renommer PDF';

  @override
  String get chatbotRenameHint => 'Entrez un nom';

  @override
  String get chatbotAnalyzeFailed => 'Analyse impossible';

  @override
  String get chatbotChatFailed => 'Réponse impossible';

  @override
  String get errorChatbotPdfEmpty => 'Aucun texte trouvé';

  @override
  String get pdfAssistantTitle => 'Assistant PDF';

  @override
  String get pdfAssistantSheetTitle => 'Assistant PDF';

  @override
  String get pdfAssistantSheetSubtitle => 'Traduire votre PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Choisir un PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Sélectionner depuis l\'appareil';

  @override
  String get pdfAssistantLinkTitle => 'Ajouter un lien PDF';

  @override
  String get pdfAssistantLinkDescription =>
      'Collez un lien PDF pour télécharger';

  @override
  String get pdfAssistantLinkHint => 'Coller l\'URL';

  @override
  String get pdfAssistantLinkButton => 'Télécharger';

  @override
  String get pdfAssistantTranslateTo => 'Traduire vers';

  @override
  String get pdfAssistantStartProcessing => 'Commencer';

  @override
  String get pdfAssistantNoFileSelected => 'Aucun fichier';

  @override
  String get pdfAssistantSelectLanguage => 'Choisissez une langue';

  @override
  String get pdfAssistantProcessingTitle => 'Traitement du PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Veuillez patienter';

  @override
  String get pdfAssistantStepExtracting => 'Extraction…';

  @override
  String get pdfAssistantStepTranslating => 'Traduction…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Génération du PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalisation…';

  @override
  String get pdfAssistantResultTitle => 'Résultat';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF traduit';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'Disposition originale';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texte extrait';

  @override
  String get pdfAssistantExtractedTextDescription => 'Document simple';

  @override
  String get pdfAssistantActionOpen => 'Ouvrir';

  @override
  String get pdfAssistantActionDownload => 'Télécharger';

  @override
  String get pdfAssistantDeleteTitle => 'Supprimer ?';

  @override
  String get pdfAssistantDeleteMessage => 'Suppression irréversible';

  @override
  String get pdfAssistantDownloadSuccess => 'Téléchargé';

  @override
  String get pdfAssistantOpenFailed => 'Impossible d\'ouvrir';

  @override
  String get pdfAssistantProcessFailed => 'Échec du traitement';

  @override
  String get errorPdfAssistantPickFailed => 'Impossible de sélectionner';

  @override
  String get errorPdfAssistantLinkFailed => 'Lien invalide';

  @override
  String get errorPdfAssistantPdfEmpty => 'PDF vide';

  @override
  String get pdfAssistantRemoveTitle => 'Supprimer le PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Cela supprimera le PDF de votre appareil.';

  @override
  String get pdfAssistantUploadPdf => 'Importer PDF';

  @override
  String get cancel => 'Annuler';

  @override
  String get remove => 'Supprimer';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get splashTagline => 'Scanner intelligent alimenté par IA';

  @override
  String get onboardingPage1Title => 'Scanner n\'importe quel document';

  @override
  String get onboardingPage1Description =>
      'Capturez reçus et papiers en quelques secondes.';

  @override
  String get onboardingPage2Title => 'OCR et traduction';

  @override
  String get onboardingPage2Description =>
      'Extraction et traduction instantanées.';

  @override
  String get onboardingPage3Title => 'Organisation et export';

  @override
  String get onboardingPage3Description =>
      'Enregistrez et exportez facilement.';

  @override
  String get settingsChooseLanguage => 'Choisir une langue';

  @override
  String get settingsLanguageApply => 'Appliquer';
}
