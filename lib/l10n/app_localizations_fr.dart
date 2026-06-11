// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

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
  String get commonDone => 'Terminé';

  @override
  String get commonLoading => 'Chargement…';

  @override
  String get commonError => 'Une erreur est survenue';

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
  String get homeTagAiPowered => 'Propulsé par l\'IA';

  @override
  String get homeTagFastOcr => 'OCR rapide';

  @override
  String get homeTagSecure => 'Sécurisé';

  @override
  String get homeTagSmartCrop => 'Recadrage intelligent';

  @override
  String get homeHeroBadge => 'PROPULSÉ PAR L\'IA';

  @override
  String get homeHeroTitle => 'Scanner OCR IA\nIntelligent';

  @override
  String get homeHeroSubtitle =>
      'OCR propulsé par l\'IA avec reconnaissance de texte rapide et précise en quelques secondes.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Rechercher ici';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle =>
      'Scanner le texte d\'une image ou d\'un document';

  @override
  String get homeFeaturePdfTitle => 'Assistant PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduire & Transcrire un PDF';

  @override
  String get homeFeatureChatbotTitle => 'Demander au PDF';

  @override
  String get homeFeatureChatbotSubtitle =>
      'Importer un PDF pour poser des questions';

  @override
  String get homeFeatureCropTitle => 'Recadrage intelligent';

  @override
  String get homeFeatureCropSubtitle =>
      'Recadrer, nettoyer et améliorer automatiquement';

  @override
  String get homeRecentDocuments => 'Récents';

  @override
  String get homeSeeAll => 'Voir tout';

  @override
  String get homeEmptyDocuments =>
      'Aucun document pour le moment. Appuyez sur Scanner pour commencer.';

  @override
  String get homeSampleDocName => 'Facture_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 mai 2026 • 2,4 Mo';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => 'Images';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers',
      one: '1 fichier',
      zero: '0 fichier',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fichiers',
      one: '1 fichier',
      zero: '0 fichier',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => 'Images';

  @override
  String get homeRecentAdded => 'Récents';

  @override
  String get homeRecentSelect => 'Sélectionner';

  @override
  String get homeRecentSelectAll => 'Tout sélectionner';

  @override
  String get homeRecentDeselectAll => 'Tout désélectionner';

  @override
  String get homeRecentSearchPdfs => 'Chercher PDF…';

  @override
  String get homeRecentSearchImages => 'Chercher images…';

  @override
  String get homeRecentNoSearchResults =>
      'Aucun fichier ne correspond à votre recherche';

  @override
  String get homeRecentToggleFavorite => 'Favoris';

  @override
  String get homeRecentUnfavorite => 'Retirer des favoris';

  @override
  String get homeRecentFavoriteAdded => 'Ajouté aux favoris';

  @override
  String get homeRecentFavoriteRemoved => 'Retiré des favoris';

  @override
  String get homeRecentPdfEmptyTitle => 'Aucun PDF récent';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Importez ou scannez des documents pour créer votre premier PDF';

  @override
  String get homeRecentImageEmptyTitle => 'Aucune image récente';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Importez ou scannez des images pour les organiser ici';

  @override
  String get homeRecentUploadPdf => 'Importer un PDF';

  @override
  String get homeRecentUploadImages => 'Importer des images';

  @override
  String get homeRecentScanDocument => 'Scanner un document';

  @override
  String get homeRecentDeleteImageTitle => 'Supprimer l\'image ?';

  @override
  String get homeRecentDeleteImageMessage =>
      'Êtes-vous sûr de vouloir supprimer cette image ? Cette action est irréversible.';

  @override
  String get homeRecentDeleteImagesTitle => 'Supprimer les images ?';

  @override
  String get homeRecentDeleteImagesMessage =>
      'Êtes-vous sûr de vouloir supprimer les images sélectionnées ? Cette action est irréversible.';

  @override
  String get scanTitle => 'Scanner';

  @override
  String get scanCapture => 'Capturer';

  @override
  String get scanImportGallery => 'Importer de la galerie';

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
  String get ocrInputMethodTitle => 'Choisir la méthode de saisie';

  @override
  String get ocrInputMethodSubtitle =>
      'Sélectionnez comment vous souhaitez extraire le texte';

  @override
  String get ocrInputLiveCameraTitle => 'Appareil photo';

  @override
  String get ocrInputLiveCameraDescription =>
      'Capturer une image en direct avec l\'appareil photo';

  @override
  String get ocrInputUploadImageTitle => 'Importer une image';

  @override
  String get ocrInputUploadImageDescription =>
      'Importer une image depuis la galerie';

  @override
  String get ocrLiveCameraTitle => 'Appareil photo OCR en direct';

  @override
  String get ocrLiveCameraTip =>
      'Astuce : Pour de meilleurs résultats, placez le texte dans une zone bien éclairée';

  @override
  String get ocrLiveCameraClose => 'Fermer l\'appareil photo';

  @override
  String get ocrLiveCameraFlash => 'Activer/Désactiver le flash';

  @override
  String get ocrLiveCameraCapture =>
      'Capturer l\'image pour la reconnaissance de texte';

  @override
  String get ocrLiveCameraInitializing => 'Démarrage de l\'appareil photo…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copier';

  @override
  String get ocrAnalyzeTranslate => 'Traduire';

  @override
  String get ocrAnalyzeProcessing => 'Analyse du texte…';

  @override
  String get ocrAnalyzeTranslateNext => 'L\'outil de traduction va s\'ouvrir';

  @override
  String get ocrNoTextTitle => 'Aucun texte lisible détecté';

  @override
  String get ocrNoTextHint => 'Essayez avec une image plus claire';

  @override
  String get ocrNoTextRetakePhoto => 'Reprendre la photo';

  @override
  String get ocrNoTextChooseGallery => 'Choisir depuis la galerie';

  @override
  String get translateTitle => 'Traduire';

  @override
  String get translateSourceLanguage => 'De';

  @override
  String get translateTargetLanguage => 'À';

  @override
  String get translateSwapLanguages => 'Inverser les langues';

  @override
  String get translateButton => 'Traduire';

  @override
  String get translateRunning => 'Traduction en cours…';

  @override
  String get translatePasteHint => 'Coller ou saisir du texte';

  @override
  String get translateCopyResult => 'Copier la traduction';

  @override
  String get translateResultTitle => 'Traduire le texte';

  @override
  String get translateResultSubtitle =>
      'Traduisez votre texte sélectionné dans n\'importe quelle langue';

  @override
  String get translateSelectedText => 'Texte sélectionné';

  @override
  String get translateSelectedLanguage => 'Langue sélectionnée';

  @override
  String get translateSelectLanguage => 'Choisir la langue';

  @override
  String get translateSearchLanguage => 'Rechercher des langues';

  @override
  String get translateRecentLanguages => 'Récents';

  @override
  String get translateNoLanguagesFound => 'Aucune langue trouvée';

  @override
  String get translateTranslatedText => 'Texte traduit';

  @override
  String get translatePlaceholder => 'La traduction apparaîtra ici…';

  @override
  String get translateSeeMore => 'Voir plus';

  @override
  String get translateReadAloud => 'Lire à haute voix';

  @override
  String get translateSavePdf => 'Enregistrer en PDF';

  @override
  String get translateSavePng => 'Enregistrer en PNG';

  @override
  String get translateSaveComingSoon =>
      'L\'enregistrement sera bientôt disponible';

  @override
  String get translateDownloadOptionTitle =>
      'Choisir l\'option de téléchargement';

  @override
  String get translateDownloadOptionSubtitle =>
      'Sélectionnez ce que vous souhaitez télécharger';

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
      'Télécharger l\'intégralité du fichier';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Télécharger le texte traduit';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Télécharger uniquement le texte traduit';

  @override
  String get translateSavePdfSuccess => 'PDF enregistré avec succès';

  @override
  String get translateSavePngSuccess => 'Image enregistrée avec succès';

  @override
  String get translateExportNeedsTranslation =>
      'Traduisez le texte avant de le télécharger';

  @override
  String get liveTitle => 'Traduction en direct';

  @override
  String get liveStart => 'Démarrer l\'appareil photo';

  @override
  String get liveStop => 'Arrêter';

  @override
  String get liveListening => 'Écoute en cours…';

  @override
  String get livePointAtText => 'Dirigez l\'appareil photo vers le texte';

  @override
  String get livePermissionNeeded =>
      'L\'accès à l\'appareil photo est requis pour la traduction en direct';

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
  String get settingsTerms => 'Conditions générales';

  @override
  String get settingsContactSupport => 'Contacter le support';

  @override
  String get settingsMoreApps => 'Plus d\'applications';

  @override
  String get settingsRateApp => 'Noter l\'app';

  @override
  String get settingsShareApp => 'Partager l\'app';

  @override
  String get settingsGreetingPrefix => 'Bonjour,';

  @override
  String get settingsDefaultUserName => 'Abdallah';

  @override
  String get permissionCameraTitle => 'Autorisation de l\'appareil photo';

  @override
  String get permissionCameraMessage =>
      'Autorisez l\'accès à l\'appareil photo pour scanner des documents et utiliser la traduction en direct.';

  @override
  String get permissionStorageTitle => 'Autorisation de stockage';

  @override
  String get permissionStorageMessage =>
      'Autorisez l\'accès pour enregistrer et ouvrir vos scans.';

  @override
  String get permissionOpenSettings => 'Ouvrir les paramètres';

  @override
  String get permissionDenied => 'Autorisation refusée';

  @override
  String get errorCameraUnavailable =>
      'L\'appareil photo n\'est pas disponible sur cet appareil';

  @override
  String get errorFileRead => 'Impossible de lire le fichier';

  @override
  String get errorNetwork => 'Vérifiez votre connexion internet';

  @override
  String get errorNoInternetFeatures =>
      'Pas de connexion internet. Certaines fonctionnalités pourraient ne pas fonctionner correctement.';

  @override
  String get exitAppTitle => 'Quitter l\'application';

  @override
  String get exitAppMessage => 'Êtes-vous sûr de vouloir quitter ?';

  @override
  String get exitAppConfirm => 'Quitter';

  @override
  String get errorOcrFailed => 'Échec de la reconnaissance de texte';

  @override
  String get errorTranslateFailed => 'Échec de la traduction';

  @override
  String get errorTranslateModelDownload =>
      'Impossible de télécharger le pack de langue. Vérifiez votre connexion et réessayez.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Cette langue n\'est pas disponible pour la traduction hors ligne.';

  @override
  String get proTitle => 'Scanner de documents Pro';

  @override
  String get proSubtitle =>
      'Scans, OCR, langues et traduction en direct illimités';

  @override
  String get proUpgradeButton => 'Passer à la version Pro';

  @override
  String get proRestorePurchases => 'Restaurer les achats';

  @override
  String get proFeatureLocked => 'Fonctionnalité Pro';

  @override
  String proLimitPages(int max) {
    return 'Le forfait gratuit permet jusqu\'à $max pages par document';
  }

  @override
  String get proLimitOcr => 'Passez à la version Pro pour un OCR illimité';

  @override
  String get proLimitTranslate =>
      'Passez à la version Pro pour toutes les langues';

  @override
  String get proLimitLive =>
      'La traduction en direct est disponible dans la version Pro';

  @override
  String get proPurchaseSuccess => 'Bienvenue dans la version Pro !';

  @override
  String get proPurchaseFailed => 'L\'achat n\'a pas pu être finalisé';

  @override
  String get exportPdf => 'Exporter en PDF';

  @override
  String get exportImage => 'Exporter en image';

  @override
  String get exportSuccess => 'Exportation réussie';

  @override
  String get exportFailed => 'Échec de l\'exportation';

  @override
  String get languageSearchHint => 'Rechercher une langue';

  @override
  String get languageAuto => 'Détecter la langue';

  @override
  String get chatbotTitle => 'Chatbot IA';

  @override
  String get chatbotHistoryButton => 'Historique des discussions';

  @override
  String get chatbotBadge => 'Votre assistant IA intelligent';

  @override
  String get chatbotHeadlineChat => 'Discutez';

  @override
  String get chatbotHeadlineMiddle => ' avec votre ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Importez un PDF et posez n\'importe quelle question — obtenez des réponses instantanées, des résumés, des explications et plus encore.';

  @override
  String get chatbotTryAsking => 'Essayez de demander';

  @override
  String get chatbotSuggestSummarize => 'Résumer ce PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Points clés de ce PDF';

  @override
  String get chatbotSuggestExplain => 'Expliquer en détail';

  @override
  String get chatbotSuggestTranslate => 'Traduire ce PDF';

  @override
  String get chatbotAskQuestions => 'Poser des questions sur ce PDF';

  @override
  String get chatbotUploadHint => 'Importer un PDF…';

  @override
  String get chatbotSheetTitle => 'Discutez avec votre PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Importez un PDF et posez toutes vos questions à son sujet';

  @override
  String get chatbotChoosePdfTitle => 'Choisir un fichier PDF';

  @override
  String get chatbotChoosePdfDescription =>
      'Parcourir et sélectionner un PDF depuis votre appareil';

  @override
  String get chatbotRecentFilesTitle => 'Fichiers récents';

  @override
  String get chatbotRecentFilesDescription =>
      'Choisissez parmi vos fichiers récents';

  @override
  String get errorChatbotPdfPickFailed =>
      'Impossible d\'ouvrir le PDF sélectionné';

  @override
  String get chatbotAnalyzingTitle => 'Analyse de votre document…';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Veuillez patienter pendant que nous lisons et\ncomprenons votre PDF';

  @override
  String get chatbotStepReadingPdf => 'Lecture du PDF';

  @override
  String get chatbotStepExtractingText => 'Extraction du texte';

  @override
  String get chatbotStepUnderstandingContent => 'Compréhension du contenu';

  @override
  String get chatbotStepPreparingChat => 'Préparation du chat IA';

  @override
  String get chatbotHistoryTitle => 'Historique';

  @override
  String get chatbotNoConversationsTitle => 'Aucune discussion pour le moment';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Importez un PDF pour commencer à discuter avec votre assistant IA.';

  @override
  String get chatbotUploadPdfButton => 'Importer un PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Document prêt';

  @override
  String get chatbotDocumentReadySubtitle =>
      'Vous pouvez maintenant discuter avec votre PDF';

  @override
  String get chatbotCurrentSummary => 'Résumé actuel';

  @override
  String get chatbotStartChatting => 'Commencer à discuter';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Salut ! Je suis votre assistant IA. Posez-moi n\'importe quelle question sur ce PDF et je vous aiderai.';

  @override
  String get chatbotChatYouCanAsk => 'Vous pouvez me demander :';

  @override
  String get chatbotChatPromptSummarize => 'Résumer ce document';

  @override
  String get chatbotChatPromptHighlights => 'Quels sont les points saillants ?';

  @override
  String get chatbotChatPromptFinancial => 'Montre-moi les données financières';

  @override
  String get chatbotChatPromptDates => 'Extraire les dates importantes';

  @override
  String get chatbotChatInputHint => 'Poser une question sur ce PDF…';

  @override
  String get chatbotDeleteTitle => 'Supprimer la discussion ?';

  @override
  String get chatbotDeleteMessage =>
      'Cela supprimera la discussion et le PDF de votre historique. Cette action est irréversible.';

  @override
  String get chatbotRenameTitle => 'Renommer le PDF';

  @override
  String get chatbotRenameHint => 'Entrez un nom';

  @override
  String get chatbotHistorySearchHint => 'Rechercher dans vos discussions…';

  @override
  String get chatbotRenameSuccess => 'Renommé avec succès';

  @override
  String get chatbotDeleteSuccess => 'Supprimé avec succès';

  @override
  String get chatbotEmptyConversationPreview => 'Discussion vide…';

  @override
  String get chatbotAiThinking => 'L\'IA réfléchit';

  @override
  String get chatbotTipsLabel => 'Conseils';

  @override
  String get chatbotSuggestSummarizeChip => 'Résumer\nce PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Points clés\nde ce PDF';

  @override
  String get chatbotSuggestExplainChip => 'Expliquer\nen détail';

  @override
  String get chatbotSuggestTranslateChip => 'Traduire\nce PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Impossible d\'analyser ce PDF. Veuillez réessayer.';

  @override
  String get chatbotChatFailed =>
      'Impossible d\'obtenir une réponse. Réessayez.';

  @override
  String get errorChatbotPdfEmpty => 'Aucun texte trouvé dans ce PDF';

  @override
  String get pdfAssistantTitle => 'Assistant PDF';

  @override
  String get pdfAssistantSheetTitle => 'Importer un PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Choisissez comment vous souhaitez ajouter votre fichier PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Choisir un fichier PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Parcourir et sélectionner un PDF depuis votre appareil';

  @override
  String get pdfAssistantLinkTitle => 'Ajouter un PDF depuis un lien';

  @override
  String get pdfAssistantLinkDescription =>
      'Collez un lien PDF pour l\'importer directement';

  @override
  String get pdfAssistantLinkHint => 'Coller l\'URL du PDF';

  @override
  String get pdfAssistantLinkButton => 'Télécharger le PDF';

  @override
  String get pdfAssistantTranslateTo => 'Traduire en';

  @override
  String get pdfAssistantTranslateToOptional => 'Translate To (optional)';

  @override
  String get pdfAssistantNoTranslation => 'No translation';

  @override
  String get pdfAssistantExtractedPdfTitle => 'Extracted PDF';

  @override
  String get pdfAssistantExtractedPdfDescription =>
      'Text extracted from your PDF pages';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => 'Extracted text';

  @override
  String get pdfAssistantStepPreparingContent => 'Preparing content…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'Generating PDF…';

  @override
  String get pdfAssistantStartProcessing => 'Lancer le traitement';

  @override
  String get pdfAssistantNoFileSelected => 'Aucun fichier sélectionné';

  @override
  String get pdfAssistantSelectLanguage =>
      'Veuillez sélectionner une langue cible';

  @override
  String get pdfAssistantProcessingTitle => 'Traitement de votre PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Veuillez patienter.';

  @override
  String get pdfAssistantStepExtracting => 'Extraction du texte…';

  @override
  String get pdfAssistantStepTranslating => 'Traduction du contenu…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Génération du PDF traduit…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalisation…';

  @override
  String get pdfAssistantResultTitle => 'Résultats';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF traduit';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Mise en page originale avec superposition du texte traduit';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texte traduit extrait';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Document texte simple au format A4';

  @override
  String get pdfAssistantActionOpen => 'Ouvrir';

  @override
  String get pdfAssistantActionDownload => 'Télécharger';

  @override
  String get pdfAssistantDeleteTitle => 'Supprimer les résultats ?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Cela supprimera les fichiers traduits de votre appareil.';

  @override
  String get pdfAssistantDownloadSuccess =>
      'Enregistré dans les Téléchargements';

  @override
  String get pdfAssistantOpenFailed => 'Impossible d\'ouvrir le fichier';

  @override
  String get pdfAssistantProcessFailed => 'Impossible de traiter ce PDF';

  @override
  String get errorPdfAssistantPickFailed =>
      'Impossible d\'ouvrir le PDF sélectionné';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Impossible de télécharger le PDF depuis ce lien';

  @override
  String get errorPdfAssistantPdfEmpty => 'Aucun texte trouvé dans ce PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Retirer le PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Cela supprimera le PDF de votre appareil.';

  @override
  String get pdfAssistantUploadPdf => 'Importer un PDF';

  @override
  String get cancel => 'Annuler';

  @override
  String get remove => 'Retirer';

  @override
  String get commonNext => 'Suivant';

  @override
  String get commonSkip => 'Passer';

  @override
  String get commonContinue => 'Continuer';

  @override
  String get onboardingStart => 'Commencer avec →';

  @override
  String get splashTagline => 'Numérisation de documents optimisée par l\'IA';

  @override
  String get onboardingPage1Title => 'Scannez le texte\nen secondes';

  @override
  String get onboardingPage1Description =>
      'Capturez le texte des images avec l\'OCR rapide.';

  @override
  String get onboardingPage2Title => 'Assistant PDF\nintelligent';

  @override
  String get onboardingPage2Description =>
      'Traduisez et comprenez\nvos PDF avec l\'IA.';

  @override
  String get onboardingPage3Title => 'Discutez avec\nvos PDF';

  @override
  String get onboardingPage3Description =>
      'Posez des questions, résumez\net obtenez des réponses.';

  @override
  String get onboardingPage4Title => 'Recadrage intelligent\nen secondes';

  @override
  String get onboardingPage4Description =>
      'Recadrez des images\net créez des PDF instantanément.';

  @override
  String get settingsChooseLanguage => 'Choisir une langue';

  @override
  String get settingsLanguageApply => 'Appliquer';

  @override
  String get commonSaving => 'Enregistrement…';

  @override
  String get smartCropTitle => 'Recadrage intelligent';

  @override
  String get smartCropInputMethodTitle => 'Scanner de recadrage intelligent';

  @override
  String get smartCropInputMethodSubtitle =>
      'Choisissez comment vous souhaitez recadrer votre document';

  @override
  String get smartCropInputLiveCameraTitle => 'Appareil photo';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Scanner Google — détection auto des bords, recadrage et amélioration';

  @override
  String get smartCropInputUploadImageTitle => 'Importer une image';

  @override
  String get smartCropInputUploadImageDescription =>
      'Importer l\'image du document depuis la galerie';

  @override
  String get smartCropUploadIntroHeadline =>
      'Recadrer plusieurs images\nautomatiquement';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Détectez automatiquement les bords, recadrez les images parfaitement et créez un PDF en un seul geste.';

  @override
  String get smartCropUploadIntroStepSelect => 'Sélectionner plusieurs images';

  @override
  String get smartCropUploadIntroStepCrop =>
      'Détection et recadrage automatiques';

  @override
  String get smartCropUploadIntroStepPdf => 'Créer un PDF instantanément';

  @override
  String get smartCropUploadIntroSelectImages => 'Sélectionner les images';

  @override
  String get smartCropLiveCameraTitle =>
      'Appareil photo à recadrage intelligent';

  @override
  String get smartCropLiveCameraTip =>
      'Document détecté — appuyez pour capturer';

  @override
  String get smartCropLiveCameraAlignTip =>
      'Alignez le document à l\'intérieur des coins';

  @override
  String get smartCropLiveCameraClose => 'Fermer l\'appareil photo';

  @override
  String get smartCropLiveCameraFlash => 'Activer/Désactiver le flash';

  @override
  String get smartCropLiveCameraCapture =>
      'Capturer le document pour le recadrage intelligent';

  @override
  String get smartCropLiveCameraInitializing =>
      'Démarrage de l\'appareil photo…';

  @override
  String get smartCropCapturedTitle => 'Document capturé';

  @override
  String get smartCropCapturedRetake => 'Reprendre la dernière photo';

  @override
  String get smartCropCapturedAnotherPhoto => 'Ajouter une autre photo';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Reprendre une autre photo';

  @override
  String get smartCropCapturedPreview => 'Aperçu';

  @override
  String get smartCropPreviewTitle => 'Aperçu';

  @override
  String get smartCropCapturedCrop => 'Recadrer';

  @override
  String get smartCropAdjustCornersTitle => 'Ajuster les coins';

  @override
  String get smartCropAdjustCornersHint =>
      'Faites glisser les coins violets pour les faire correspondre aux bords du document';

  @override
  String get smartCropAdjustCornersConfirm => 'Appliquer le recadrage';

  @override
  String get smartCropDetectingEdges => 'Détection des bords du document…';

  @override
  String get smartCropAndroidOnly =>
      'Le scan intelligent est disponible uniquement sur Android.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Maximum de $max photos atteint';
  }

  @override
  String get smartCropProcessingCrop => 'Application du recadrage magique…';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Recadrage de $count documents…';
  }

  @override
  String get smartCropCroppedTitle => 'Document recadré';

  @override
  String get smartCropFilterOriginal => 'Original';

  @override
  String get smartCropFilterLighten => 'Éclaircir';

  @override
  String get smartCropFilterMagic => 'Magique';

  @override
  String get smartCropFilterGrayscale => 'Nuances de gris';

  @override
  String get smartCropFilterMono => 'N&B';

  @override
  String get smartCropFilterWarm => 'Chaud';

  @override
  String get smartCropActionCreatePdf => 'Créer le PDF';

  @override
  String get smartCropProcessingPdf => 'Génération du document PDF…';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Génération du PDF avec $count pages…';
  }

  @override
  String get smartCropPdfSuccess => 'Document PDF généré avec succès';

  @override
  String get smartCropPdfPagesLabel => 'pages';

  @override
  String get smartCropPdfSinglePageLabel => '1 page';

  @override
  String get smartCropImageCopied => 'Copié';

  @override
  String get smartCropDeleteImageConfirm => 'Retirer cette page du document ?';

  @override
  String get smartCropDeleteDocumentTitle => 'Supprimer le document ?';

  @override
  String get smartCropDeleteDocumentMessage =>
      'Êtes-vous sûr de vouloir supprimer ce document ? Cette action est irréversible.';

  @override
  String get smartCropDeletePdfTitle => 'Supprimer le PDF ?';

  @override
  String get smartCropDeletePdfMessage =>
      'Êtes-vous sûr de vouloir supprimer ce PDF ? Cette action est irréversible.';

  @override
  String get smartCropDeletePdfConfirm =>
      'Supprimer ce PDF de votre appareil ?';

  @override
  String get smartCropPdfRenamed => 'PDF renommé';

  @override
  String get smartCropPdfFileName => 'Nom du fichier';

  @override
  String get smartCropPdfFileSize => 'Taille du fichier';

  @override
  String get smartCropViewPdf => 'Voir le PDF';

  @override
  String get smartCropSavePdf => 'Enregistrer le PDF';

  @override
  String get smartCropSavePdfSuccess => 'PDF enregistré avec succès';

  @override
  String get smartCropRenamePdf => 'Renommer';

  @override
  String get smartCropRenamePdfHint => 'Nom du document';

  @override
  String get smartCropStepReadingImages => 'Lecture des images';

  @override
  String get smartCropStepDetectingEdges => 'Détection des bords';

  @override
  String get smartCropStepCroppingImages => 'Recadrage';

  @override
  String get smartCropStepGeneratingPdf => 'Génération PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Nous organisons vos images recadrées\ndans un PDF de haute qualité';

  @override
  String get smartCropProcessingPdfTitle => 'Création de votre PDF';

  @override
  String get commonUntitledDocument => 'document';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Appuyez pour parcourir les dossiers de l\'appareil';

  @override
  String get errorPdfTextLoad => 'Erreur lors du chargement du texte.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Traduction : $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Traduction de document';

  @override
  String get translateExportTranslatedBadge => 'Traduit';

  @override
  String get translateExportVerifiedFooter =>
      'Exportation certifiée de la traduction hors ligne';

  @override
  String get translateExportPdfHeader => 'Exportation de la traduction';

  @override
  String get translateExportPdfFooterLabel => 'Document confidentiel';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Page $page sur $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Page $page';
  }

  @override
  String fileSizeBytes(String size) {
    return '${size}B';
  }

  @override
  String fileSizeKb(String size) {
    return '$size Ko';
  }

  @override
  String fileSizeMb(String size) {
    return '$size Mo';
  }

  @override
  String get translateLangName_en => 'Anglais';

  @override
  String get translateLangName_ur => 'Ourdou';

  @override
  String get translateLangName_hi => 'hindi';

  @override
  String get translateLangName_ar => 'Arabe';

  @override
  String get translateLangName_es => 'Espagnol';

  @override
  String get translateLangName_fr => 'Français';

  @override
  String get translateLangName_de => 'Allemand';

  @override
  String get translateLangName_pt => 'Portugais';

  @override
  String get translateLangName_ru => 'Russe';

  @override
  String get translateLangName_zh => 'Chinois (simplifié)';

  @override
  String get translateLangName_zhTw => 'Chinoix (traditionnel)';

  @override
  String get translateLangName_ja => 'Japonais';

  @override
  String get translateLangName_ko => 'Coréen';

  @override
  String get translateLangName_it => 'Italien';

  @override
  String get translateLangName_tr => 'Turc';

  @override
  String get translateLangName_nl => 'Néerlandais';

  @override
  String get translateLangName_sv => 'Suédois';

  @override
  String get translateLangName_no => 'Norvégien';

  @override
  String get translateLangName_da => 'Danois';

  @override
  String get translateLangName_fi => 'Finnois';

  @override
  String get translateLangName_el => 'Grec';

  @override
  String get translateLangName_pl => 'Polonais';

  @override
  String get translateLangName_cs => 'Tchèque';

  @override
  String get translateLangName_hu => 'Hongrois';

  @override
  String get translateLangName_ro => 'Roumain';

  @override
  String get translateLangName_bg => 'Bulgare';

  @override
  String get translateLangName_uk => 'Ukrainien';

  @override
  String get translateLangName_fa => 'Persan';

  @override
  String get translateLangName_he => 'Hébreu';

  @override
  String get translateLangName_th => 'Thaïlandais';

  @override
  String get translateLangName_vi => 'Vietnamien';

  @override
  String get translateLangName_id => 'Indonésien';

  @override
  String get translateLangName_ms => 'Malais';

  @override
  String get translateLangName_bn => 'bengali';

  @override
  String get translateLangName_ta => 'Tamoul';

  @override
  String get translateLangName_te => 'Télougou';

  @override
  String get translateLangName_mr => 'Marathi';

  @override
  String get translateLangName_gu => 'Goudjarati';

  @override
  String get translateLangName_kn => 'Kannada';

  @override
  String get translateLangName_ml => 'Malayalam';

  @override
  String get translateLangName_pa => 'Pendjabi';

  @override
  String get translateLangName_sw => 'Swahili';

  @override
  String get translateLangName_af => 'afrikaans';

  @override
  String get translateLangName_ca => 'catalan';

  @override
  String get translateLangName_hr => 'Croate';

  @override
  String get translateLangName_sk => 'Slovaque';

  @override
  String get translateLangName_sl => 'Slovène';

  @override
  String get translateLangName_sr => 'Serbe';

  @override
  String get translateLangName_lt => 'Lituanien';

  @override
  String get translateLangName_lv => 'Letton';

  @override
  String get translateLangName_et => 'Estonien';

  @override
  String get translateLangName_is => 'Islandais';

  @override
  String get translateLangName_ga => 'Irlandais';

  @override
  String get translateLangName_mt => 'Maltais';

  @override
  String get translateLangName_sq => 'Albanais';

  @override
  String get translateLangName_mk => 'Macédonien';

  @override
  String get translateLangName_be => 'Biélorusse';

  @override
  String get translateLangName_kk => 'Kazakh';

  @override
  String get translateLangName_uz => 'Ouzbek';

  @override
  String get translateLangName_az => 'Azéri';

  @override
  String get translateLangName_hy => 'Arménien';

  @override
  String get translateLangName_ka => 'Géorgien';

  @override
  String get translateLangName_lo => 'Laotien';

  @override
  String get translateLangName_km => 'Khmer';

  @override
  String get translateLangName_my => 'Birman';

  @override
  String get translateLangName_ne => 'Népalais';

  @override
  String get translateLangName_si => 'Cingalais';

  @override
  String get translateLangName_am => 'Amharique';

  @override
  String get translateLangName_ha => 'Haoussa';

  @override
  String get translateLangName_yo => 'Yorouba';

  @override
  String get translateLangName_ig => 'Igbo';

  @override
  String get translateLangName_zu => 'Zoulou';

  @override
  String get translateLangName_xh => 'Xhosa';

  @override
  String get translateLangName_st => 'Sotho du Sud';

  @override
  String get translateLangName_sn => 'Shona';

  @override
  String get translateLangName_rw => 'kinyarwanda';

  @override
  String get translateLangName_so => 'somali';

  @override
  String get translateLangName_mg => 'Malgache';

  @override
  String get translateLangName_cy => 'Gallois';

  @override
  String get translateLangName_mn => 'Mongol';

  @override
  String get translateLangName_tl => 'Tagalog / Filipino';

  @override
  String get translateLangName_ht => 'Créole haïtien';

  @override
  String get translateLangName_eo => 'Espéranto';

  @override
  String get translateLangName_la => 'latin';

  @override
  String get translateLangName_ku => 'Kurde';

  @override
  String get translateLangName_ps => 'pachtou';

  @override
  String get translateLangName_faAf => 'Dari';

  @override
  String get translateLangName_bs => 'Bosnien';

  @override
  String get translateLangName_mi => 'Maori';

  @override
  String get translateLangName_sm => 'Samoan';

  @override
  String get translateLangName_haw => 'Hawaïen';

  @override
  String get translateLangName_lb => 'Luxembourgeois';
}
