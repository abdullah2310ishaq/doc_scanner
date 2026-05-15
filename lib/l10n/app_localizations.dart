import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// Application name shown in launcher and about
  ///
  /// In en, this message translates to:
  /// **'Doc Scanner'**
  String get appTitle;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get commonShare;

  /// No description provided for @commonCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get commonCopy;

  /// No description provided for @commonRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @commonLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading…'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get commonError;

  /// No description provided for @commonTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get commonTryAgain;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navScan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get navScan;

  /// No description provided for @navDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get navDocuments;

  /// No description provided for @navTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get navTranslate;

  /// No description provided for @navLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get navLive;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good Morning, {name} 👋'**
  String homeGreeting(String name);

  /// No description provided for @homeTitlePrefix.
  ///
  /// In en, this message translates to:
  /// **'AI Document'**
  String get homeTitlePrefix;

  /// No description provided for @homeTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'Scanner'**
  String get homeTitleHighlight;

  /// No description provided for @homeProBadge.
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get homeProBadge;

  /// No description provided for @homeTagAiPowered.
  ///
  /// In en, this message translates to:
  /// **'AI Powered'**
  String get homeTagAiPowered;

  /// No description provided for @homeTagFastOcr.
  ///
  /// In en, this message translates to:
  /// **'Fast OCR'**
  String get homeTagFastOcr;

  /// No description provided for @homeTagSecure.
  ///
  /// In en, this message translates to:
  /// **'Secure'**
  String get homeTagSecure;

  /// No description provided for @homeTagSmartCrop.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop'**
  String get homeTagSmartCrop;

  /// No description provided for @homeHeroBadge.
  ///
  /// In en, this message translates to:
  /// **'AI POWERED'**
  String get homeHeroBadge;

  /// No description provided for @homeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart AI OCR Scanner'**
  String get homeHeroTitle;

  /// No description provided for @homeHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'AI-powered OCR with fast, accurate text recognition in seconds.'**
  String get homeHeroSubtitle;

  /// No description provided for @homeHeroButton.
  ///
  /// In en, this message translates to:
  /// **'OCR Scanner'**
  String get homeHeroButton;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search here'**
  String get homeSearchHint;

  /// No description provided for @homeFeatureOcrTitle.
  ///
  /// In en, this message translates to:
  /// **'OCR Scanner'**
  String get homeFeatureOcrTitle;

  /// No description provided for @homeFeatureOcrSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Scan text from image or documents'**
  String get homeFeatureOcrSubtitle;

  /// No description provided for @homeFeaturePdfTitle.
  ///
  /// In en, this message translates to:
  /// **'PDF Assistant'**
  String get homeFeaturePdfTitle;

  /// No description provided for @homeFeaturePdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Translate & Transcribe PDF'**
  String get homeFeaturePdfSubtitle;

  /// No description provided for @homeFeatureChatbotTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Chabot'**
  String get homeFeatureChatbotTitle;

  /// No description provided for @homeFeatureChatbotSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF to ask questions'**
  String get homeFeatureChatbotSubtitle;

  /// No description provided for @homeFeatureCropTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop'**
  String get homeFeatureCropTitle;

  /// No description provided for @homeFeatureCropSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Auto crop, clean and enhance'**
  String get homeFeatureCropSubtitle;

  /// No description provided for @homeRecentDocuments.
  ///
  /// In en, this message translates to:
  /// **'Recent Documents'**
  String get homeRecentDocuments;

  /// No description provided for @homeSeeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get homeSeeAll;

  /// No description provided for @homeEmptyDocuments.
  ///
  /// In en, this message translates to:
  /// **'No documents yet. Tap Scan to start.'**
  String get homeEmptyDocuments;

  /// No description provided for @homeSampleDocName.
  ///
  /// In en, this message translates to:
  /// **'Invoice_2026.pdf'**
  String get homeSampleDocName;

  /// No description provided for @homeSampleDocMeta.
  ///
  /// In en, this message translates to:
  /// **'May 10, 2026 • 2.4 MB'**
  String get homeSampleDocMeta;

  /// No description provided for @scanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scanTitle;

  /// No description provided for @scanCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture'**
  String get scanCapture;

  /// No description provided for @scanImportGallery.
  ///
  /// In en, this message translates to:
  /// **'Import from gallery'**
  String get scanImportGallery;

  /// No description provided for @scanImportFiles.
  ///
  /// In en, this message translates to:
  /// **'Import file'**
  String get scanImportFiles;

  /// No description provided for @scanAddPage.
  ///
  /// In en, this message translates to:
  /// **'Add page'**
  String get scanAddPage;

  /// No description provided for @scanRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake'**
  String get scanRetake;

  /// No description provided for @scanCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get scanCrop;

  /// No description provided for @scanEnhance.
  ///
  /// In en, this message translates to:
  /// **'Enhance'**
  String get scanEnhance;

  /// No description provided for @scanDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get scanDone;

  /// No description provided for @scanPageCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 page} other{{count} pages}}'**
  String scanPageCount(int count);

  /// No description provided for @scanSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving scan…'**
  String get scanSaving;

  /// No description provided for @scanSaved.
  ///
  /// In en, this message translates to:
  /// **'Document saved'**
  String get scanSaved;

  /// No description provided for @ocrTitle.
  ///
  /// In en, this message translates to:
  /// **'Text recognition'**
  String get ocrTitle;

  /// No description provided for @ocrRun.
  ///
  /// In en, this message translates to:
  /// **'Recognize text'**
  String get ocrRun;

  /// No description provided for @ocrRunning.
  ///
  /// In en, this message translates to:
  /// **'Reading text…'**
  String get ocrRunning;

  /// No description provided for @ocrEmpty.
  ///
  /// In en, this message translates to:
  /// **'No text found in this image'**
  String get ocrEmpty;

  /// No description provided for @ocrCopySuccess.
  ///
  /// In en, this message translates to:
  /// **'Text copied'**
  String get ocrCopySuccess;

  /// No description provided for @ocrEditHint.
  ///
  /// In en, this message translates to:
  /// **'Edit recognized text'**
  String get ocrEditHint;

  /// No description provided for @translateTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateTitle;

  /// No description provided for @translateSourceLanguage.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get translateSourceLanguage;

  /// No description provided for @translateTargetLanguage.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get translateTargetLanguage;

  /// No description provided for @translateSwapLanguages.
  ///
  /// In en, this message translates to:
  /// **'Swap languages'**
  String get translateSwapLanguages;

  /// No description provided for @translateButton.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateButton;

  /// No description provided for @translateRunning.
  ///
  /// In en, this message translates to:
  /// **'Translating…'**
  String get translateRunning;

  /// No description provided for @translatePasteHint.
  ///
  /// In en, this message translates to:
  /// **'Paste or type text'**
  String get translatePasteHint;

  /// No description provided for @translateCopyResult.
  ///
  /// In en, this message translates to:
  /// **'Copy translation'**
  String get translateCopyResult;

  /// No description provided for @liveTitle.
  ///
  /// In en, this message translates to:
  /// **'Live translate'**
  String get liveTitle;

  /// No description provided for @liveStart.
  ///
  /// In en, this message translates to:
  /// **'Start camera'**
  String get liveStart;

  /// No description provided for @liveStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get liveStop;

  /// No description provided for @liveListening.
  ///
  /// In en, this message translates to:
  /// **'Listening…'**
  String get liveListening;

  /// No description provided for @livePointAtText.
  ///
  /// In en, this message translates to:
  /// **'Point camera at text'**
  String get livePointAtText;

  /// No description provided for @livePermissionNeeded.
  ///
  /// In en, this message translates to:
  /// **'Camera access is required for live translate'**
  String get livePermissionNeeded;

  /// No description provided for @documentsTitle.
  ///
  /// In en, this message translates to:
  /// **'My documents'**
  String get documentsTitle;

  /// No description provided for @documentRename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get documentRename;

  /// No description provided for @documentDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete document?'**
  String get documentDeleteConfirmTitle;

  /// No description provided for @documentDeleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This cannot be undone.'**
  String get documentDeleteConfirmMessage;

  /// No description provided for @documentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document deleted'**
  String get documentDeleted;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settingsAbout;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get settingsTerms;

  /// No description provided for @permissionCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera permission'**
  String get permissionCameraTitle;

  /// No description provided for @permissionCameraMessage.
  ///
  /// In en, this message translates to:
  /// **'Allow camera access to scan documents and use live translate.'**
  String get permissionCameraMessage;

  /// No description provided for @permissionStorageTitle.
  ///
  /// In en, this message translates to:
  /// **'Storage permission'**
  String get permissionStorageTitle;

  /// No description provided for @permissionStorageMessage.
  ///
  /// In en, this message translates to:
  /// **'Allow access to save and open your scans.'**
  String get permissionStorageMessage;

  /// No description provided for @permissionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get permissionOpenSettings;

  /// No description provided for @permissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Permission denied'**
  String get permissionDenied;

  /// No description provided for @errorCameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera is not available on this device'**
  String get errorCameraUnavailable;

  /// No description provided for @errorFileRead.
  ///
  /// In en, this message translates to:
  /// **'Could not read file'**
  String get errorFileRead;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get errorNetwork;

  /// No description provided for @errorOcrFailed.
  ///
  /// In en, this message translates to:
  /// **'Text recognition failed'**
  String get errorOcrFailed;

  /// No description provided for @errorTranslateFailed.
  ///
  /// In en, this message translates to:
  /// **'Translation failed'**
  String get errorTranslateFailed;

  /// No description provided for @proTitle.
  ///
  /// In en, this message translates to:
  /// **'Doc Scanner Pro'**
  String get proTitle;

  /// No description provided for @proSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Unlimited scans, OCR, languages, and live translate'**
  String get proSubtitle;

  /// No description provided for @proUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get proUpgradeButton;

  /// No description provided for @proRestorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get proRestorePurchases;

  /// No description provided for @proFeatureLocked.
  ///
  /// In en, this message translates to:
  /// **'Pro feature'**
  String get proFeatureLocked;

  /// No description provided for @proLimitPages.
  ///
  /// In en, this message translates to:
  /// **'Free plan allows up to {max} pages per document'**
  String proLimitPages(int max);

  /// No description provided for @proLimitOcr.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro for unlimited OCR'**
  String get proLimitOcr;

  /// No description provided for @proLimitTranslate.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro for all languages'**
  String get proLimitTranslate;

  /// No description provided for @proLimitLive.
  ///
  /// In en, this message translates to:
  /// **'Live translate is available in Pro'**
  String get proLimitLive;

  /// No description provided for @proPurchaseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Pro!'**
  String get proPurchaseSuccess;

  /// No description provided for @proPurchaseFailed.
  ///
  /// In en, this message translates to:
  /// **'Purchase could not be completed'**
  String get proPurchaseFailed;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @exportImage.
  ///
  /// In en, this message translates to:
  /// **'Export image'**
  String get exportImage;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export complete'**
  String get exportSuccess;

  /// No description provided for @exportFailed.
  ///
  /// In en, this message translates to:
  /// **'Export failed'**
  String get exportFailed;

  /// No description provided for @languageSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search language'**
  String get languageSearchHint;

  /// No description provided for @languageAuto.
  ///
  /// In en, this message translates to:
  /// **'Detect language'**
  String get languageAuto;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
