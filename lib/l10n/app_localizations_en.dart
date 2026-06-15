// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonSave => 'Save';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonShare => 'Share';

  @override
  String get commonCopy => 'Copy';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonClose => 'Close';

  @override
  String get commonDone => 'Done';

  @override
  String get commonLoading => 'Loading…';

  @override
  String get commonError => 'Something went wrong';

  @override
  String get commonTryAgain => 'Please try again';

  @override
  String get navHome => 'Home';

  @override
  String get navScan => 'Scan';

  @override
  String get navDocuments => 'Documents';

  @override
  String get navTranslate => 'Translate';

  @override
  String get navLive => 'Live';

  @override
  String get navSettings => 'Settings';

  @override
  String homeGreeting(String name) {
    return 'Good Morning, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI Document';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Open menu';

  @override
  String get homeTagAiPowered => 'AI Powered';

  @override
  String get homeTagFastOcr => 'Fast OCR';

  @override
  String get homeTagSecure => 'Secure';

  @override
  String get homeTagSmartCrop => 'Smart Crop';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => 'Smart AI OCR\nScanner';

  @override
  String get homeHeroSubtitle =>
      'AI-powered OCR with fast, accurate text recognition in seconds.';

  @override
  String get homeHeroButton => 'OCR Scanner';

  @override
  String get homeSearchHint => 'Search here';

  @override
  String get homeFeatureOcrTitle => 'OCR Scanner';

  @override
  String get homeFeatureOcrSubtitle => 'Scan text from image or documents';

  @override
  String get homeFeaturePdfTitle => 'PDF Assistant';

  @override
  String get homeFeaturePdfSubtitle => 'Translate & Transcribe PDF';

  @override
  String get homeFeatureChatbotTitle => 'Ask PDF';

  @override
  String get homeFeatureChatbotSubtitle => 'Upload PDF to ask questions';

  @override
  String get homeFeatureCropTitle => 'Smart Crop';

  @override
  String get homeFeatureCropSubtitle => 'Auto crop, clean and enhance';

  @override
  String get homeRecentDocuments => 'Recent';

  @override
  String get homeSeeAll => 'See All';

  @override
  String get homeEmptyDocuments => 'No documents yet. Tap Scan to start.';

  @override
  String get homeSampleDocName => 'Invoice_2026.pdf';

  @override
  String get homeSampleDocMeta => 'May 10, 2026 • 2.4 MB';

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
  String get homeRecentSelectAll => 'Select all';

  @override
  String get homeRecentDeselectAll => 'Deselect all';

  @override
  String get homeRecentSearchPdfs => 'Search your PDFs…';

  @override
  String get homeRecentSearchImages => 'Search your images…';

  @override
  String get homeRecentNoSearchResults => 'No files match your search';

  @override
  String get homeRecentToggleFavorite => 'Favorite';

  @override
  String get homeRecentUnfavorite => 'Unfavorite';

  @override
  String get homeRecentFavoriteAdded => 'Added to favorites';

  @override
  String get homeRecentFavoriteRemoved => 'Removed from favorites';

  @override
  String get homeRecentPdfEmptyTitle => 'No recent PDFs';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Upload or scan documents to create your first PDF';

  @override
  String get homeRecentImageEmptyTitle => 'No recent images';

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
  String get homeRecentDeleteImageTitle => 'Delete image';

  @override
  String get homeRecentDeleteImageMessage =>
      'Are you sure you want to delete this image ?';

  @override
  String get homeRecentDeleteImagesTitle => 'Delete images';

  @override
  String get homeRecentDeleteImagesMessage =>
      'Are you sure you want to delete the selected images ?';

  @override
  String get scanTitle => 'Scan';

  @override
  String get scanCapture => 'Capture';

  @override
  String get scanImportGallery => 'Import from gallery';

  @override
  String get scanImportFiles => 'Import file';

  @override
  String get scanAddPage => 'Add page';

  @override
  String get scanRetake => 'Retake';

  @override
  String get scanCrop => 'Crop';

  @override
  String get scanEnhance => 'Enhance';

  @override
  String get scanDone => 'Done';

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
  String get scanSaving => 'Saving scan…';

  @override
  String get scanSaved => 'Document saved';

  @override
  String get ocrTitle => 'Text recognition';

  @override
  String get ocrRun => 'Recognize text';

  @override
  String get ocrRunning => 'Reading text…';

  @override
  String get ocrEmpty => 'No text found in this image';

  @override
  String get ocrCopySuccess => 'Text copied';

  @override
  String get ocrEditHint => 'Edit recognized text';

  @override
  String get ocrInputMethodTitle => 'Choose Input Method';

  @override
  String get ocrInputMethodSubtitle => 'Select how you want to extract text';

  @override
  String get ocrInputLiveCameraTitle => 'Live Camera';

  @override
  String get ocrInputLiveCameraDescription => 'Capture live image using camera';

  @override
  String get ocrInputUploadImageTitle => 'Upload Image';

  @override
  String get ocrInputUploadImageDescription => 'Upload image from gallery';

  @override
  String get ocrLiveCameraTitle => 'Live OCR Camera';

  @override
  String get ocrLiveCameraTip =>
      'Tip: For better results, place the text in well-lit area';

  @override
  String get ocrLiveCameraClose => 'Close camera';

  @override
  String get ocrLiveCameraFlash => 'Toggle flash';

  @override
  String get ocrLiveCameraCapture => 'Capture image for text recognition';

  @override
  String get ocrLiveCameraInitializing => 'Starting camera…';

  @override
  String get ocrAnalyzeTitle => 'OCR Scanner';

  @override
  String get ocrAnalyzeCopy => 'Copy';

  @override
  String get ocrAnalyzeTranslate => 'Translate';

  @override
  String get ocrAnalyzeProcessing => 'Analyzing text…';

  @override
  String get ocrAnalyzeTranslateNext => 'Translate will open next';

  @override
  String get ocrNoTextTitle => 'No readable text detected';

  @override
  String get ocrNoTextHint => 'Try a clearer image';

  @override
  String get ocrNoTextRetakePhoto => 'Retake Photo';

  @override
  String get ocrNoTextChooseGallery => 'Choose from Gallery';

  @override
  String get translateTitle => 'Translate';

  @override
  String get translateSourceLanguage => 'From';

  @override
  String get translateTargetLanguage => 'To';

  @override
  String get translateSwapLanguages => 'Swap languages';

  @override
  String get translateButton => 'Translate';

  @override
  String get translateRunning => 'Translating…';

  @override
  String get translatePasteHint => 'Paste or type text';

  @override
  String get translateCopyResult => 'Copy translation';

  @override
  String get translateResultTitle => 'Translate Text';

  @override
  String get translateResultSubtitle =>
      'Translate your selected text into any language';

  @override
  String get translateSelectedText => 'Selected Text';

  @override
  String get translateSelectedLanguage => 'Selected Language';

  @override
  String get translateSelectLanguage => 'Select Language';

  @override
  String get translateSearchLanguage => 'Search languages';

  @override
  String get translateRecentLanguages => 'Recent';

  @override
  String get translateNoLanguagesFound => 'No languages found';

  @override
  String get translateTranslatedText => 'Translated Text';

  @override
  String get translatePlaceholder => 'Translation will appear here..';

  @override
  String get translateSeeMore => 'See More';

  @override
  String get translateReadAloud => 'Read aloud';

  @override
  String get translateSavePdf => 'Save as PDF';

  @override
  String get translateSavePng => 'Save as PNG';

  @override
  String get translateSaveComingSoon => 'Save will be available soon';

  @override
  String get translateDownloadOptionTitle => 'Choose Download Option';

  @override
  String get translateDownloadOptionSubtitle =>
      'Select what you want to download';

  @override
  String get translateDownloadSelectedTextTitle => 'Download selected text';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Download only the selected text';

  @override
  String get translateDownloadCompleteFileTitle => 'Download complete file';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Download the entire file';

  @override
  String get translateDownloadTranslatedTextTitle => 'Download translated text';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Download only the translated text';

  @override
  String get translateSavePdfSuccess => 'PDF saved successfully';

  @override
  String get translateSavePngSuccess => 'Image saved successfully';

  @override
  String get translateExportNeedsTranslation =>
      'Translate the text before downloading';

  @override
  String get liveTitle => 'Live translate';

  @override
  String get liveStart => 'Start camera';

  @override
  String get liveStop => 'Stop';

  @override
  String get liveListening => 'Listening…';

  @override
  String get livePointAtText => 'Point camera at text';

  @override
  String get livePermissionNeeded =>
      'Camera access is required for live translate';

  @override
  String get documentsTitle => 'My documents';

  @override
  String get documentRename => 'Rename';

  @override
  String get documentDeleteConfirmTitle => 'Delete document?';

  @override
  String get documentDeleteConfirmMessage => 'This cannot be undone.';

  @override
  String get documentDeleted => 'Document deleted';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'App language';

  @override
  String get settingsTheme => 'Theme';

  @override
  String get settingsAbout => 'About';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsTerms => 'Terms & Conditions';

  @override
  String get settingsContactSupport => 'Contact Support';

  @override
  String get settingsMoreApps => 'More Apps';

  @override
  String get settingsRateApp => 'Rate App';

  @override
  String get settingsShareApp => 'Share App';

  @override
  String get settingsGreetingPrefix => 'Good Morning,';

  @override
  String get settingsDefaultUserName => 'Abdullah';

  @override
  String get permissionCameraTitle => 'Camera permission';

  @override
  String get permissionCameraMessage =>
      'Allow camera access to scan documents and use live translate.';

  @override
  String get permissionStorageTitle => 'Storage permission';

  @override
  String get permissionStorageMessage =>
      'Allow access to save and open your scans.';

  @override
  String get permissionOpenSettings => 'Open settings';

  @override
  String get permissionDenied => 'Permission denied';

  @override
  String get errorCameraUnavailable => 'Camera is not available on this device';

  @override
  String get errorFileRead => 'Could not read file';

  @override
  String get errorNetwork => 'Check your internet connection';

  @override
  String get errorNoInternetFeatures =>
      'No internet connection. Some features may not work properly.';

  @override
  String get exitAppTitle => 'Exit App';

  @override
  String get exitAppMessage => 'Are you sure you want to exit?';

  @override
  String get exitAppConfirm => 'Exit';

  @override
  String get errorOcrFailed => 'Text recognition failed';

  @override
  String get errorTranslateFailed => 'Translation failed';

  @override
  String get errorTranslateModelDownload =>
      'Could not download the language pack. Check your connection and try again.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'This language is not available for offline translation.';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle =>
      'Unlimited scans, OCR, languages, and live translate';

  @override
  String get proUpgradeButton => 'Upgrade to Pro';

  @override
  String get proRestorePurchases => 'Restore purchases';

  @override
  String get proFeatureLocked => 'Pro feature';

  @override
  String proLimitPages(int max) {
    return 'Free plan allows up to $max pages per document';
  }

  @override
  String get proLimitOcr => 'Upgrade to Pro for unlimited OCR';

  @override
  String get proLimitTranslate => 'Upgrade to Pro for all languages';

  @override
  String get proLimitLive => 'Live translate is available in Pro';

  @override
  String get proPurchaseSuccess => 'Welcome to Pro!';

  @override
  String get proPurchaseFailed => 'Purchase could not be completed';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get exportImage => 'Export image';

  @override
  String get exportSuccess => 'Export complete';

  @override
  String get exportFailed => 'Export failed';

  @override
  String get languageSearchHint => 'Search language';

  @override
  String get languageAuto => 'Detect language';

  @override
  String get chatbotTitle => 'AI Chatbot';

  @override
  String get chatbotHistoryButton => 'Chat history';

  @override
  String get chatbotBadge => 'Your Smart AI Assistant';

  @override
  String get chatbotHeadlineChat => 'Chat';

  @override
  String get chatbotHeadlineMiddle => ' with your ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Upload a PDF and ask anything — get instant answers, summaries, explanations, and more.';

  @override
  String get chatbotTryAsking => 'Try asking';

  @override
  String get chatbotSuggestSummarize => 'Summarize this PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Key Points of this PDF';

  @override
  String get chatbotSuggestExplain => 'Explain in detail';

  @override
  String get chatbotSuggestTranslate => 'Translate this PDF';

  @override
  String get chatbotAskQuestions => 'Ask Questions About this PDF';

  @override
  String get chatbotUploadHint => 'Upload a PDF';

  @override
  String get chatbotSheetTitle => 'Chat with your PDF';

  @override
  String get chatbotSheetSubtitle => 'Upload a PDF and ask anything about it';

  @override
  String get chatbotChoosePdfTitle => 'Choose PDF file';

  @override
  String get chatbotChoosePdfDescription =>
      'Browse and select PDF from your device';

  @override
  String get chatbotRecentFilesTitle => 'Recent Files';

  @override
  String get chatbotRecentFilesDescription => 'Choose from your recent files';

  @override
  String get errorChatbotPdfPickFailed => 'Could not open the selected PDF';

  @override
  String get chatbotAnalyzingTitle => 'Analyzing Your Document...';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Please wait while we read and\nunderstand your PDF';

  @override
  String get chatbotStepReadingPdf => 'Reading PDF';

  @override
  String get chatbotStepExtractingText => 'Extracting Text';

  @override
  String get chatbotStepUnderstandingContent => 'Understanding Content';

  @override
  String get chatbotStepPreparingChat => 'Preparing AI Chat';

  @override
  String get chatbotHistoryTitle => 'History';

  @override
  String get chatbotNoConversationsTitle => 'No conversations yet';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Upload a PDF to start chatting with your AI assistant.';

  @override
  String get chatbotUploadPdfButton => 'Upload a PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Document Ready';

  @override
  String get chatbotDocumentReadySubtitle => 'You can now chat with your PDF';

  @override
  String get chatbotCurrentSummary => 'Current Summary';

  @override
  String get chatbotStartChatting => 'Start Chatting';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Hi! I\'m your AI assistant. Ask me anything about this PDF and I\'ll help you.';

  @override
  String get chatbotChatYouCanAsk => 'You can ask me:';

  @override
  String get chatbotChatPromptSummarize => 'Summarize this document';

  @override
  String get chatbotChatPromptHighlights => 'What are the key highlights?';

  @override
  String get chatbotChatPromptFinancial => 'Show me financial data';

  @override
  String get chatbotChatPromptDates => 'Extract important dates';

  @override
  String get chatbotChatInputHint => 'Ask about this PDF...';

  @override
  String get chatbotDeleteTitle => 'Delete chat?';

  @override
  String get chatbotDeleteMessage =>
      'This will remove the chat and PDF from your history. This cannot be undone.';

  @override
  String get chatbotRenameTitle => 'Rename PDF';

  @override
  String get chatbotRenameHint => 'Enter a name';

  @override
  String get chatbotHistorySearchHint => 'Search your conversations…';

  @override
  String get chatbotRenameSuccess => 'Renamed successfully';

  @override
  String get chatbotDeleteSuccess => 'Deleted successfully';

  @override
  String get chatbotEmptyConversationPreview => 'Empty conversation…';

  @override
  String get chatbotAiThinking => 'AI is thinking';

  @override
  String get chatbotTipsLabel => 'Tips';

  @override
  String get chatbotSuggestSummarizeChip => 'Summarize\nthis PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Key Points\nof this PDF';

  @override
  String get chatbotSuggestExplainChip => 'Explain\nin detail';

  @override
  String get chatbotSuggestTranslateChip => 'Translate\nthis PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Could not analyze this PDF. Please try again.';

  @override
  String get chatbotChatFailed => 'Could not get a response. Try again.';

  @override
  String get errorChatbotPdfEmpty => 'No text found in this PDF';

  @override
  String get pdfAssistantTitle => 'PDF Assistant';

  @override
  String get pdfAssistantSheetTitle => 'Upload PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Choose how you want to add your PDF file';

  @override
  String get pdfAssistantChoosePdfTitle => 'Choose PDF file';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Browse and select PDF from your device';

  @override
  String get pdfAssistantLinkTitle => 'Add PDF from link';

  @override
  String get pdfAssistantLinkDescription =>
      'Paste a PDF link to upload directly';

  @override
  String get pdfAssistantLinkHint => 'Paste PDF URL';

  @override
  String get pdfAssistantLinkButton => 'Download PDF';

  @override
  String get pdfAssistantTranslateTo => 'Translate To';

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
  String get pdfAssistantStartProcessing => 'Start Processing';

  @override
  String get pdfAssistantNoFileSelected => 'No file selected';

  @override
  String get pdfAssistantSelectLanguage => 'Please select a target language';

  @override
  String get pdfAssistantProcessingTitle => 'Processing your PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Please wait.';

  @override
  String get pdfAssistantStepExtracting => 'Extracting text…';

  @override
  String get pdfAssistantStepTranslating => 'Translating content…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Generating translated PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizing…';

  @override
  String get pdfAssistantResultTitle => 'Results';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'Translated PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Original layout with translated text overlay';

  @override
  String get pdfAssistantExtractedTextTitle => 'Extracted translated text';

  @override
  String get pdfAssistantExtractedTextDescription => 'Simple A4 text document';

  @override
  String get pdfAssistantActionOpen => 'Open';

  @override
  String get pdfAssistantActionDownload => 'Download';

  @override
  String get pdfAssistantDeleteTitle => 'Delete results?';

  @override
  String get pdfAssistantDeleteMessage =>
      'This will remove the translated files from your device.';

  @override
  String get pdfAssistantDownloadSuccess => 'Saved to Downloads';

  @override
  String get pdfAssistantOpenFailed => 'Could not open file';

  @override
  String get pdfAssistantProcessFailed => 'Could not process this PDF';

  @override
  String get errorPdfAssistantPickFailed => 'Could not open the selected PDF';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Could not download PDF from this link';

  @override
  String get errorPdfAssistantPdfEmpty => 'No text found in this PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Remove PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'This will remove the PDF from your device.';

  @override
  String get pdfAssistantUploadPdf => 'Upload PDF';

  @override
  String get cancel => 'Cancel';

  @override
  String get remove => 'Remove';

  @override
  String get commonNext => 'Next';

  @override
  String get commonSkip => 'Skip';

  @override
  String get commonContinue => 'Continue';

  @override
  String get onboardingStart => 'Get Started →';

  @override
  String get splashTagline => 'AI-powered document scanning';

  @override
  String get splashAdDisclaimer => 'This action may lead to an ad';

  @override
  String get adLoading => 'Ad loading...';

  @override
  String get onboardingPage1Title => 'Scan Text \nin Seconds';

  @override
  String get onboardingPage1Description =>
      'Capture text from images with fast AI-powered OCR scanning.';

  @override
  String get onboardingPage2Title => 'Smart PDF \nAssistant';

  @override
  String get onboardingPage2Description =>
      'Translate, extract and understand\nyour PDF documents with AI.';

  @override
  String get onboardingPage3Title => 'Chat with \nYour PDFs';

  @override
  String get onboardingPage3Description =>
      'Ask questions, summarize documents\nand get instant AI answers.';

  @override
  String get onboardingPage4Title => 'Smart Crop \nin Seconds';

  @override
  String get onboardingPage4Description =>
      'Auto-crop multiple images and\ncreate clean PDFs instantly.';

  @override
  String get settingsChooseLanguage => 'Choose a language';

  @override
  String get settingsLanguageApply => 'Apply';

  @override
  String get commonSaving => 'Saving…';

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
  String get smartCropPresetAuto => 'Auto detect';

  @override
  String get smartCropPresetCenter => 'Center page';

  @override
  String get smartCropPresetFull => 'Full image';

  @override
  String get smartCropUploadIntroGoogleScanner => 'Google Scanner (Best crop)';

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
  String get smartCropDeleteCapturedPageTitle => 'Delete page';

  @override
  String get smartCropDeleteCapturedPageMessage =>
      'Are you sure you want this page to be deleted ?';

  @override
  String get smartCropDeleteDocumentTitle => 'Delete document';

  @override
  String get smartCropDeleteDocumentMessage =>
      'Are you sure you want to delete this document ?';

  @override
  String get smartCropDeletePdfTitle => 'Delete PDF?';

  @override
  String get smartCropDeletePdfMessage =>
      'Are you sure you want to delete this PDF? This cannot be undone.';

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
  String get smartCropSavePdfSuccess => 'PDF saved successfully';

  @override
  String get smartCropRenamePdf => 'Rename';

  @override
  String get smartCropRenamePdfHint => 'Document name';

  @override
  String get smartCropStepReadingImages => 'Reading Images';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return 'Reading $done of $total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return '$failed of $total images could not be imported';
  }

  @override
  String get smartCropStepDetectingEdges => 'Detecting document edges';

  @override
  String get smartCropStepCroppingImages => 'Cropping Images';

  @override
  String get smartCropStepGeneratingPdf => 'Generating PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'We are organizing your cropped images\ninto a high quality PDF';

  @override
  String get smartCropProcessingPdfTitle => 'Creating Your PDF';

  @override
  String get commonUntitledDocument => 'document';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse => 'Tap to browse device directory';

  @override
  String get errorPdfTextLoad => 'Error loading text.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Translation: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Document Translation';

  @override
  String get translateExportTranslatedBadge => 'Translated';

  @override
  String get translateExportVerifiedFooter =>
      'Verified offline translation export';

  @override
  String get translateExportPdfHeader => 'Translation Export';

  @override
  String get translateExportPdfFooterLabel => 'Confidential Document';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Page $page of $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Page $page';
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
  String get translateLangName_en => 'English';

  @override
  String get translateLangName_ur => 'Urdu';

  @override
  String get translateLangName_hi => 'Hindi';

  @override
  String get translateLangName_ar => 'Arabic';

  @override
  String get translateLangName_es => 'Spanish';

  @override
  String get translateLangName_fr => 'French';

  @override
  String get translateLangName_de => 'German';

  @override
  String get translateLangName_pt => 'Portuguese';

  @override
  String get translateLangName_ru => 'Russian';

  @override
  String get translateLangName_zh => 'Chinese (Simplified)';

  @override
  String get translateLangName_zhTw => 'Chinese (Traditional)';

  @override
  String get translateLangName_ja => 'Japanese';

  @override
  String get translateLangName_ko => 'Korean';

  @override
  String get translateLangName_it => 'Italian';

  @override
  String get translateLangName_tr => 'Turkish';

  @override
  String get translateLangName_nl => 'Dutch';

  @override
  String get translateLangName_sv => 'Swedish';

  @override
  String get translateLangName_no => 'Norwegian';

  @override
  String get translateLangName_da => 'Danish';

  @override
  String get translateLangName_fi => 'Finnish';

  @override
  String get translateLangName_el => 'Greek';

  @override
  String get translateLangName_pl => 'Polish';

  @override
  String get translateLangName_cs => 'Czech';

  @override
  String get translateLangName_hu => 'Hungarian';

  @override
  String get translateLangName_ro => 'Romanian';

  @override
  String get translateLangName_bg => 'Bulgarian';

  @override
  String get translateLangName_uk => 'Ukrainian';

  @override
  String get translateLangName_fa => 'Persian';

  @override
  String get translateLangName_he => 'Hebrew';

  @override
  String get translateLangName_th => 'Thai';

  @override
  String get translateLangName_vi => 'Vietnamese';

  @override
  String get translateLangName_id => 'Indonesian';

  @override
  String get translateLangName_ms => 'Malay';

  @override
  String get translateLangName_bn => 'Bengali';

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
  String get translateLangName_af => 'Afrikaans';

  @override
  String get translateLangName_ca => 'Catalan';

  @override
  String get translateLangName_hr => 'Croatian';

  @override
  String get translateLangName_sk => 'Slovak';

  @override
  String get translateLangName_sl => 'Slovenian';

  @override
  String get translateLangName_sr => 'Serbian';

  @override
  String get translateLangName_lt => 'Lithuanian';

  @override
  String get translateLangName_lv => 'Latvian';

  @override
  String get translateLangName_et => 'Estonian';

  @override
  String get translateLangName_is => 'Icelandic';

  @override
  String get translateLangName_ga => 'Irish';

  @override
  String get translateLangName_mt => 'Maltese';

  @override
  String get translateLangName_sq => 'Albanian';

  @override
  String get translateLangName_mk => 'Macedonian';

  @override
  String get translateLangName_be => 'Belarusian';

  @override
  String get translateLangName_kk => 'Kazakh';

  @override
  String get translateLangName_uz => 'Uzbek';

  @override
  String get translateLangName_az => 'Azerbaijani';

  @override
  String get translateLangName_hy => 'Armenian';

  @override
  String get translateLangName_ka => 'Georgian';

  @override
  String get translateLangName_lo => 'Lao';

  @override
  String get translateLangName_km => 'Khmer';

  @override
  String get translateLangName_my => 'Burmese';

  @override
  String get translateLangName_ne => 'Nepali';

  @override
  String get translateLangName_si => 'Sinhala';

  @override
  String get translateLangName_am => 'Amharic';

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
  String get translateLangName_so => 'Somali';

  @override
  String get translateLangName_mg => 'Malagasy';

  @override
  String get translateLangName_cy => 'Welsh';

  @override
  String get translateLangName_mn => 'Mongolian';

  @override
  String get translateLangName_tl => 'Filipino';

  @override
  String get translateLangName_ht => 'Haitian Creole';

  @override
  String get translateLangName_eo => 'Esperanto';

  @override
  String get translateLangName_la => 'Latin';

  @override
  String get translateLangName_ku => 'Kurdish';

  @override
  String get translateLangName_ps => 'Pashto';

  @override
  String get translateLangName_faAf => 'Dari';

  @override
  String get translateLangName_bs => 'Bosnian';

  @override
  String get translateLangName_mi => 'Maori';

  @override
  String get translateLangName_sm => 'Samoan';

  @override
  String get translateLangName_haw => 'Hawaiian';

  @override
  String get translateLangName_lb => 'Luxembourgish';
}
