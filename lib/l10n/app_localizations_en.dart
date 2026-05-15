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
  String get homeFeatureChatbotTitle => 'AI Chabot';

  @override
  String get homeFeatureChatbotSubtitle => 'Upload PDF to ask questions';

  @override
  String get homeFeatureCropTitle => 'Smart Crop';

  @override
  String get homeFeatureCropSubtitle => 'Auto crop, clean and enhance';

  @override
  String get homeRecentDocuments => 'Recent Documents';

  @override
  String get homeSeeAll => 'See All';

  @override
  String get homeEmptyDocuments => 'No documents yet. Tap Scan to start.';

  @override
  String get homeSampleDocName => 'Invoice_2026.pdf';

  @override
  String get homeSampleDocMeta => 'May 10, 2026 • 2.4 MB';

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
  String get settingsTerms => 'Terms of use';

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
  String get errorOcrFailed => 'Text recognition failed';

  @override
  String get errorTranslateFailed => 'Translation failed';

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
}
