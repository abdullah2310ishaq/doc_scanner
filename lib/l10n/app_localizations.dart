import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// Application name shown in launcher and about
  ///
  /// In en, this message translates to:
  /// **'Doc Scanner'**
  String get appTitle;

  /// OK button text
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

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

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

  /// No description provided for @homeMenuButton.
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get homeMenuButton;

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
  /// **'Smart AI OCR\nScanner'**
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

  /// No description provided for @homeRecentPdfsFolder.
  ///
  /// In en, this message translates to:
  /// **'PDFs'**
  String get homeRecentPdfsFolder;

  /// No description provided for @homeRecentImagesFolder.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get homeRecentImagesFolder;

  /// No description provided for @homeRecentFileCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 files} =1{1 file} other{{count} files}}'**
  String homeRecentFileCount(int count);

  /// No description provided for @homeRecentFolderMeta.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{0 files} =1{1 file} other{{count} files}} • {size}'**
  String homeRecentFolderMeta(int count, String size);

  /// No description provided for @homeRecentPdfsTitle.
  ///
  /// In en, this message translates to:
  /// **'PDFs'**
  String get homeRecentPdfsTitle;

  /// No description provided for @homeRecentImagesTitle.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get homeRecentImagesTitle;

  /// No description provided for @homeRecentAdded.
  ///
  /// In en, this message translates to:
  /// **'Recent Added'**
  String get homeRecentAdded;

  /// No description provided for @homeRecentSelect.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get homeRecentSelect;

  /// No description provided for @homeRecentSearchPdfs.
  ///
  /// In en, this message translates to:
  /// **'Search your PDFs…'**
  String get homeRecentSearchPdfs;

  /// No description provided for @homeRecentSearchImages.
  ///
  /// In en, this message translates to:
  /// **'Search your images…'**
  String get homeRecentSearchImages;

  /// No description provided for @homeRecentNoSearchResults.
  ///
  /// In en, this message translates to:
  /// **'No files match your search'**
  String get homeRecentNoSearchResults;

  /// No description provided for @homeRecentToggleFavorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get homeRecentToggleFavorite;

  /// No description provided for @homeRecentUnfavorite.
  ///
  /// In en, this message translates to:
  /// **'Unfavorite'**
  String get homeRecentUnfavorite;

  /// No description provided for @homeRecentPdfEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No PDF yet'**
  String get homeRecentPdfEmptyTitle;

  /// No description provided for @homeRecentPdfEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload or scan documents to create your first PDF'**
  String get homeRecentPdfEmptySubtitle;

  /// No description provided for @homeRecentImageEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No Image yet'**
  String get homeRecentImageEmptyTitle;

  /// No description provided for @homeRecentImageEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload or scan images to organize them here'**
  String get homeRecentImageEmptySubtitle;

  /// No description provided for @homeRecentUploadPdf.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF'**
  String get homeRecentUploadPdf;

  /// No description provided for @homeRecentUploadImages.
  ///
  /// In en, this message translates to:
  /// **'Upload Images'**
  String get homeRecentUploadImages;

  /// No description provided for @homeRecentScanDocument.
  ///
  /// In en, this message translates to:
  /// **'Scan Document'**
  String get homeRecentScanDocument;

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

  /// No description provided for @ocrInputMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Input Method'**
  String get ocrInputMethodTitle;

  /// No description provided for @ocrInputMethodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select how you want to extract text'**
  String get ocrInputMethodSubtitle;

  /// No description provided for @ocrInputLiveCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Camera'**
  String get ocrInputLiveCameraTitle;

  /// No description provided for @ocrInputLiveCameraDescription.
  ///
  /// In en, this message translates to:
  /// **'Capture live image using camera'**
  String get ocrInputLiveCameraDescription;

  /// No description provided for @ocrInputUploadImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get ocrInputUploadImageTitle;

  /// No description provided for @ocrInputUploadImageDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload image from gallery'**
  String get ocrInputUploadImageDescription;

  /// No description provided for @ocrLiveCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Live OCR Camera'**
  String get ocrLiveCameraTitle;

  /// No description provided for @ocrLiveCameraTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: For better results, place the text in well-lit area'**
  String get ocrLiveCameraTip;

  /// No description provided for @ocrLiveCameraClose.
  ///
  /// In en, this message translates to:
  /// **'Close camera'**
  String get ocrLiveCameraClose;

  /// No description provided for @ocrLiveCameraFlash.
  ///
  /// In en, this message translates to:
  /// **'Toggle flash'**
  String get ocrLiveCameraFlash;

  /// No description provided for @ocrLiveCameraCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture image for text recognition'**
  String get ocrLiveCameraCapture;

  /// No description provided for @ocrLiveCameraInitializing.
  ///
  /// In en, this message translates to:
  /// **'Starting camera…'**
  String get ocrLiveCameraInitializing;

  /// No description provided for @ocrAnalyzeTitle.
  ///
  /// In en, this message translates to:
  /// **'OCR Scanner'**
  String get ocrAnalyzeTitle;

  /// No description provided for @ocrAnalyzeCopy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get ocrAnalyzeCopy;

  /// No description provided for @ocrAnalyzeTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get ocrAnalyzeTranslate;

  /// No description provided for @ocrAnalyzeProcessing.
  ///
  /// In en, this message translates to:
  /// **'Analyzing text…'**
  String get ocrAnalyzeProcessing;

  /// No description provided for @ocrAnalyzeTranslateNext.
  ///
  /// In en, this message translates to:
  /// **'Translate will open next'**
  String get ocrAnalyzeTranslateNext;

  /// No description provided for @ocrNoTextTitle.
  ///
  /// In en, this message translates to:
  /// **'No readable text detected'**
  String get ocrNoTextTitle;

  /// No description provided for @ocrNoTextHint.
  ///
  /// In en, this message translates to:
  /// **'Try a clearer image'**
  String get ocrNoTextHint;

  /// No description provided for @ocrNoTextRetakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake Photo'**
  String get ocrNoTextRetakePhoto;

  /// No description provided for @ocrNoTextChooseGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get ocrNoTextChooseGallery;

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

  /// No description provided for @translateResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Translate Text'**
  String get translateResultTitle;

  /// No description provided for @translateResultSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Translate your selected text into any language'**
  String get translateResultSubtitle;

  /// No description provided for @translateSelectedText.
  ///
  /// In en, this message translates to:
  /// **'Selected Text'**
  String get translateSelectedText;

  /// No description provided for @translateSelectedLanguage.
  ///
  /// In en, this message translates to:
  /// **'Selected Language'**
  String get translateSelectedLanguage;

  /// No description provided for @translateSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get translateSelectLanguage;

  /// No description provided for @translateSearchLanguage.
  ///
  /// In en, this message translates to:
  /// **'Search languages'**
  String get translateSearchLanguage;

  /// No description provided for @translateRecentLanguages.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get translateRecentLanguages;

  /// No description provided for @translateNoLanguagesFound.
  ///
  /// In en, this message translates to:
  /// **'No languages found'**
  String get translateNoLanguagesFound;

  /// No description provided for @translateTranslatedText.
  ///
  /// In en, this message translates to:
  /// **'Translated Text'**
  String get translateTranslatedText;

  /// No description provided for @translatePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Translation will appear here..'**
  String get translatePlaceholder;

  /// No description provided for @translateSeeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get translateSeeMore;

  /// No description provided for @translateReadAloud.
  ///
  /// In en, this message translates to:
  /// **'Read aloud'**
  String get translateReadAloud;

  /// No description provided for @translateSavePdf.
  ///
  /// In en, this message translates to:
  /// **'Save as PDF'**
  String get translateSavePdf;

  /// No description provided for @translateSavePng.
  ///
  /// In en, this message translates to:
  /// **'Save as PNG'**
  String get translateSavePng;

  /// No description provided for @translateSaveComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Save will be available soon'**
  String get translateSaveComingSoon;

  /// No description provided for @translateDownloadOptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose Download Option'**
  String get translateDownloadOptionTitle;

  /// No description provided for @translateDownloadOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select what you want to download'**
  String get translateDownloadOptionSubtitle;

  /// No description provided for @translateDownloadSelectedTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Download selected text'**
  String get translateDownloadSelectedTextTitle;

  /// No description provided for @translateDownloadSelectedTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Download only the selected text'**
  String get translateDownloadSelectedTextDescription;

  /// No description provided for @translateDownloadCompleteFileTitle.
  ///
  /// In en, this message translates to:
  /// **'Download complete file'**
  String get translateDownloadCompleteFileTitle;

  /// No description provided for @translateDownloadCompleteFileDescription.
  ///
  /// In en, this message translates to:
  /// **'Download the entire file'**
  String get translateDownloadCompleteFileDescription;

  /// No description provided for @translateDownloadTranslatedTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Download translated text'**
  String get translateDownloadTranslatedTextTitle;

  /// No description provided for @translateDownloadTranslatedTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Download only the translated text'**
  String get translateDownloadTranslatedTextDescription;

  /// No description provided for @translateSavePdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'PDF saved successfully'**
  String get translateSavePdfSuccess;

  /// No description provided for @translateSavePngSuccess.
  ///
  /// In en, this message translates to:
  /// **'Image saved successfully'**
  String get translateSavePngSuccess;

  /// No description provided for @translateExportNeedsTranslation.
  ///
  /// In en, this message translates to:
  /// **'Translate the text before downloading'**
  String get translateExportNeedsTranslation;

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

  /// No description provided for @settingsRateApp.
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get settingsRateApp;

  /// No description provided for @settingsShareApp.
  ///
  /// In en, this message translates to:
  /// **'Share App'**
  String get settingsShareApp;

  /// No description provided for @settingsGreetingPrefix.
  ///
  /// In en, this message translates to:
  /// **'Good Morning,'**
  String get settingsGreetingPrefix;

  /// No description provided for @settingsDefaultUserName.
  ///
  /// In en, this message translates to:
  /// **'Abdullah'**
  String get settingsDefaultUserName;

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

  /// No description provided for @errorNoInternetFeatures.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Some features may not work properly.'**
  String get errorNoInternetFeatures;

  /// No description provided for @exitAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitAppTitle;

  /// No description provided for @exitAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to exit?'**
  String get exitAppMessage;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitAppConfirm;

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

  /// No description provided for @errorTranslateModelDownload.
  ///
  /// In en, this message translates to:
  /// **'Could not download the language pack. Check your connection and try again.'**
  String get errorTranslateModelDownload;

  /// No description provided for @errorTranslateUnsupportedLanguage.
  ///
  /// In en, this message translates to:
  /// **'This language is not available for offline translation.'**
  String get errorTranslateUnsupportedLanguage;

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

  /// No description provided for @chatbotTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Chatbot'**
  String get chatbotTitle;

  /// No description provided for @chatbotHistoryButton.
  ///
  /// In en, this message translates to:
  /// **'Chat history'**
  String get chatbotHistoryButton;

  /// No description provided for @chatbotBadge.
  ///
  /// In en, this message translates to:
  /// **'Your Smart AI Assistant'**
  String get chatbotBadge;

  /// No description provided for @chatbotHeadlineChat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatbotHeadlineChat;

  /// No description provided for @chatbotHeadlineMiddle.
  ///
  /// In en, this message translates to:
  /// **' with your '**
  String get chatbotHeadlineMiddle;

  /// No description provided for @chatbotHeadlinePdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get chatbotHeadlinePdf;

  /// No description provided for @chatbotTryAsking.
  ///
  /// In en, this message translates to:
  /// **'Try asking'**
  String get chatbotTryAsking;

  /// No description provided for @chatbotSuggestSummarize.
  ///
  /// In en, this message translates to:
  /// **'Summarize this PDF'**
  String get chatbotSuggestSummarize;

  /// No description provided for @chatbotSuggestKeyPoints.
  ///
  /// In en, this message translates to:
  /// **'Key Points of this PDF'**
  String get chatbotSuggestKeyPoints;

  /// No description provided for @chatbotSuggestExplain.
  ///
  /// In en, this message translates to:
  /// **'Explain in detail'**
  String get chatbotSuggestExplain;

  /// No description provided for @chatbotSuggestTranslate.
  ///
  /// In en, this message translates to:
  /// **'Translate this PDF'**
  String get chatbotSuggestTranslate;

  /// No description provided for @chatbotAskQuestions.
  ///
  /// In en, this message translates to:
  /// **'Ask Questions About this PDF'**
  String get chatbotAskQuestions;

  /// No description provided for @chatbotUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF...'**
  String get chatbotUploadHint;

  /// No description provided for @chatbotSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with your PDF'**
  String get chatbotSheetTitle;

  /// No description provided for @chatbotSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF and ask anything about it'**
  String get chatbotSheetSubtitle;

  /// No description provided for @chatbotChoosePdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose PDF file'**
  String get chatbotChoosePdfTitle;

  /// No description provided for @chatbotChoosePdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse and select PDF from your device'**
  String get chatbotChoosePdfDescription;

  /// No description provided for @chatbotRecentFilesTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent Files'**
  String get chatbotRecentFilesTitle;

  /// No description provided for @chatbotRecentFilesDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose from your recent files'**
  String get chatbotRecentFilesDescription;

  /// No description provided for @errorChatbotPdfPickFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the selected PDF'**
  String get errorChatbotPdfPickFailed;

  /// No description provided for @chatbotAnalyzingTitle.
  ///
  /// In en, this message translates to:
  /// **'Analyzing Your Document...'**
  String get chatbotAnalyzingTitle;

  /// No description provided for @chatbotAnalyzingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please wait while we read and\nunderstand your PDF'**
  String get chatbotAnalyzingSubtitle;

  /// No description provided for @chatbotStepReadingPdf.
  ///
  /// In en, this message translates to:
  /// **'Reading PDF'**
  String get chatbotStepReadingPdf;

  /// No description provided for @chatbotStepExtractingText.
  ///
  /// In en, this message translates to:
  /// **'Extracting Text'**
  String get chatbotStepExtractingText;

  /// No description provided for @chatbotStepUnderstandingContent.
  ///
  /// In en, this message translates to:
  /// **'Understanding Content'**
  String get chatbotStepUnderstandingContent;

  /// No description provided for @chatbotStepPreparingChat.
  ///
  /// In en, this message translates to:
  /// **'Preparing AI Chat'**
  String get chatbotStepPreparingChat;

  /// No description provided for @chatbotHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get chatbotHistoryTitle;

  /// No description provided for @chatbotNoConversationsTitle.
  ///
  /// In en, this message translates to:
  /// **'No conversations yet'**
  String get chatbotNoConversationsTitle;

  /// No description provided for @chatbotNoConversationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF to start chatting with your AI assistant.'**
  String get chatbotNoConversationsSubtitle;

  /// No description provided for @chatbotUploadPdfButton.
  ///
  /// In en, this message translates to:
  /// **'Upload a PDF'**
  String get chatbotUploadPdfButton;

  /// No description provided for @chatbotDocumentReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Document Ready'**
  String get chatbotDocumentReadyTitle;

  /// No description provided for @chatbotDocumentReadySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can now chat with your PDF'**
  String get chatbotDocumentReadySubtitle;

  /// No description provided for @chatbotCurrentSummary.
  ///
  /// In en, this message translates to:
  /// **'Current Summary'**
  String get chatbotCurrentSummary;

  /// No description provided for @chatbotStartChatting.
  ///
  /// In en, this message translates to:
  /// **'Start Chatting'**
  String get chatbotStartChatting;

  /// No description provided for @chatbotChatGreeting.
  ///
  /// In en, this message translates to:
  /// **'👋🏻 Hi! I\'m your AI assistant. Ask me anything about this PDF and I\'ll help you.'**
  String get chatbotChatGreeting;

  /// No description provided for @chatbotChatYouCanAsk.
  ///
  /// In en, this message translates to:
  /// **'You can ask me:'**
  String get chatbotChatYouCanAsk;

  /// No description provided for @chatbotChatPromptSummarize.
  ///
  /// In en, this message translates to:
  /// **'Summarize this document'**
  String get chatbotChatPromptSummarize;

  /// No description provided for @chatbotChatPromptHighlights.
  ///
  /// In en, this message translates to:
  /// **'What are the key highlights?'**
  String get chatbotChatPromptHighlights;

  /// No description provided for @chatbotChatPromptFinancial.
  ///
  /// In en, this message translates to:
  /// **'Show me financial data'**
  String get chatbotChatPromptFinancial;

  /// No description provided for @chatbotChatPromptDates.
  ///
  /// In en, this message translates to:
  /// **'Extract important dates'**
  String get chatbotChatPromptDates;

  /// No description provided for @chatbotChatInputHint.
  ///
  /// In en, this message translates to:
  /// **'Ask about this PDF...'**
  String get chatbotChatInputHint;

  /// No description provided for @chatbotDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete chat?'**
  String get chatbotDeleteTitle;

  /// No description provided for @chatbotDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove the chat and PDF from your history. This cannot be undone.'**
  String get chatbotDeleteMessage;

  /// No description provided for @chatbotRenameTitle.
  ///
  /// In en, this message translates to:
  /// **'Rename PDF'**
  String get chatbotRenameTitle;

  /// No description provided for @chatbotRenameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get chatbotRenameHint;

  /// No description provided for @chatbotHistorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search your conversations…'**
  String get chatbotHistorySearchHint;

  /// No description provided for @chatbotRenameSuccess.
  ///
  /// In en, this message translates to:
  /// **'Renamed successfully'**
  String get chatbotRenameSuccess;

  /// No description provided for @chatbotDeleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Deleted successfully'**
  String get chatbotDeleteSuccess;

  /// No description provided for @chatbotEmptyConversationPreview.
  ///
  /// In en, this message translates to:
  /// **'Empty conversation…'**
  String get chatbotEmptyConversationPreview;

  /// No description provided for @chatbotAiThinking.
  ///
  /// In en, this message translates to:
  /// **'AI is thinking'**
  String get chatbotAiThinking;

  /// No description provided for @chatbotTipsLabel.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get chatbotTipsLabel;

  /// No description provided for @chatbotSuggestSummarizeChip.
  ///
  /// In en, this message translates to:
  /// **'Summarize\nthis PDF'**
  String get chatbotSuggestSummarizeChip;

  /// No description provided for @chatbotSuggestKeyPointsChip.
  ///
  /// In en, this message translates to:
  /// **'Key Points\nof this PDF'**
  String get chatbotSuggestKeyPointsChip;

  /// No description provided for @chatbotSuggestExplainChip.
  ///
  /// In en, this message translates to:
  /// **'Explain\nin detail'**
  String get chatbotSuggestExplainChip;

  /// No description provided for @chatbotSuggestTranslateChip.
  ///
  /// In en, this message translates to:
  /// **'Translate\nthis PDF'**
  String get chatbotSuggestTranslateChip;

  /// No description provided for @chatbotAnalyzeFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not analyze this PDF. Please try again.'**
  String get chatbotAnalyzeFailed;

  /// No description provided for @chatbotChatFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not get a response. Try again.'**
  String get chatbotChatFailed;

  /// No description provided for @errorChatbotPdfEmpty.
  ///
  /// In en, this message translates to:
  /// **'No text found in this PDF'**
  String get errorChatbotPdfEmpty;

  /// No description provided for @pdfAssistantTitle.
  ///
  /// In en, this message translates to:
  /// **'PDF Assistant'**
  String get pdfAssistantTitle;

  /// No description provided for @pdfAssistantSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF'**
  String get pdfAssistantSheetTitle;

  /// No description provided for @pdfAssistantSheetSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to add your PDF file'**
  String get pdfAssistantSheetSubtitle;

  /// No description provided for @pdfAssistantChoosePdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose PDF file'**
  String get pdfAssistantChoosePdfTitle;

  /// No description provided for @pdfAssistantChoosePdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse and select PDF from your device'**
  String get pdfAssistantChoosePdfDescription;

  /// No description provided for @pdfAssistantLinkTitle.
  ///
  /// In en, this message translates to:
  /// **'Add PDF from link'**
  String get pdfAssistantLinkTitle;

  /// No description provided for @pdfAssistantLinkDescription.
  ///
  /// In en, this message translates to:
  /// **'Paste a PDF link to upload directly'**
  String get pdfAssistantLinkDescription;

  /// No description provided for @pdfAssistantLinkHint.
  ///
  /// In en, this message translates to:
  /// **'Paste PDF URL'**
  String get pdfAssistantLinkHint;

  /// No description provided for @pdfAssistantLinkButton.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get pdfAssistantLinkButton;

  /// No description provided for @pdfAssistantTranslateTo.
  ///
  /// In en, this message translates to:
  /// **'Translate To'**
  String get pdfAssistantTranslateTo;

  /// No description provided for @pdfAssistantTranslateToOptional.
  ///
  /// In en, this message translates to:
  /// **'Translate To (optional)'**
  String get pdfAssistantTranslateToOptional;

  /// No description provided for @pdfAssistantNoTranslation.
  ///
  /// In en, this message translates to:
  /// **'No translation'**
  String get pdfAssistantNoTranslation;

  /// No description provided for @pdfAssistantExtractedPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Extracted PDF'**
  String get pdfAssistantExtractedPdfTitle;

  /// No description provided for @pdfAssistantExtractedPdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Text extracted from your PDF pages'**
  String get pdfAssistantExtractedPdfDescription;

  /// No description provided for @pdfAssistantExtractedTextOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Extracted text'**
  String get pdfAssistantExtractedTextOnlyTitle;

  /// No description provided for @pdfAssistantStepPreparingContent.
  ///
  /// In en, this message translates to:
  /// **'Preparing content…'**
  String get pdfAssistantStepPreparingContent;

  /// No description provided for @pdfAssistantStepGeneratingPdfNeutral.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF…'**
  String get pdfAssistantStepGeneratingPdfNeutral;

  /// No description provided for @pdfAssistantStartProcessing.
  ///
  /// In en, this message translates to:
  /// **'Start Processing'**
  String get pdfAssistantStartProcessing;

  /// No description provided for @pdfAssistantNoFileSelected.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get pdfAssistantNoFileSelected;

  /// No description provided for @pdfAssistantSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please select a target language'**
  String get pdfAssistantSelectLanguage;

  /// No description provided for @pdfAssistantProcessingTitle.
  ///
  /// In en, this message translates to:
  /// **'Processing your PDF…'**
  String get pdfAssistantProcessingTitle;

  /// No description provided for @pdfAssistantProcessingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please wait.'**
  String get pdfAssistantProcessingSubtitle;

  /// No description provided for @pdfAssistantStepExtracting.
  ///
  /// In en, this message translates to:
  /// **'Extracting text…'**
  String get pdfAssistantStepExtracting;

  /// No description provided for @pdfAssistantStepTranslating.
  ///
  /// In en, this message translates to:
  /// **'Translating content…'**
  String get pdfAssistantStepTranslating;

  /// No description provided for @pdfAssistantStepGeneratingPdf.
  ///
  /// In en, this message translates to:
  /// **'Generating translated PDF…'**
  String get pdfAssistantStepGeneratingPdf;

  /// No description provided for @pdfAssistantStepFinalizing.
  ///
  /// In en, this message translates to:
  /// **'Finalizing…'**
  String get pdfAssistantStepFinalizing;

  /// No description provided for @pdfAssistantResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get pdfAssistantResultTitle;

  /// No description provided for @pdfAssistantTranslatedPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Translated PDF'**
  String get pdfAssistantTranslatedPdfTitle;

  /// No description provided for @pdfAssistantTranslatedPdfDescription.
  ///
  /// In en, this message translates to:
  /// **'Original layout with translated text overlay'**
  String get pdfAssistantTranslatedPdfDescription;

  /// No description provided for @pdfAssistantExtractedTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Extracted translated text'**
  String get pdfAssistantExtractedTextTitle;

  /// No description provided for @pdfAssistantExtractedTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Simple A4 text document'**
  String get pdfAssistantExtractedTextDescription;

  /// No description provided for @pdfAssistantActionOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get pdfAssistantActionOpen;

  /// No description provided for @pdfAssistantActionDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get pdfAssistantActionDownload;

  /// No description provided for @pdfAssistantDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete results?'**
  String get pdfAssistantDeleteTitle;

  /// No description provided for @pdfAssistantDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove the translated files from your device.'**
  String get pdfAssistantDeleteMessage;

  /// No description provided for @pdfAssistantDownloadSuccess.
  ///
  /// In en, this message translates to:
  /// **'Saved to Downloads'**
  String get pdfAssistantDownloadSuccess;

  /// No description provided for @pdfAssistantOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open file'**
  String get pdfAssistantOpenFailed;

  /// No description provided for @pdfAssistantProcessFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not process this PDF'**
  String get pdfAssistantProcessFailed;

  /// No description provided for @errorPdfAssistantPickFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not open the selected PDF'**
  String get errorPdfAssistantPickFailed;

  /// No description provided for @errorPdfAssistantLinkFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not download PDF from this link'**
  String get errorPdfAssistantLinkFailed;

  /// No description provided for @errorPdfAssistantPdfEmpty.
  ///
  /// In en, this message translates to:
  /// **'No text found in this PDF'**
  String get errorPdfAssistantPdfEmpty;

  /// No description provided for @pdfAssistantRemoveTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove PDF'**
  String get pdfAssistantRemoveTitle;

  /// No description provided for @pdfAssistantRemoveWarning.
  ///
  /// In en, this message translates to:
  /// **'This will remove the PDF from your device.'**
  String get pdfAssistantRemoveWarning;

  /// No description provided for @pdfAssistantUploadPdf.
  ///
  /// In en, this message translates to:
  /// **'Upload PDF'**
  String get pdfAssistantUploadPdf;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @commonNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get commonNext;

  /// No description provided for @commonSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get commonSkip;

  /// No description provided for @commonContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get commonContinue;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started With →'**
  String get onboardingStart;

  /// No description provided for @splashTagline.
  ///
  /// In en, this message translates to:
  /// **'AI-powered document scanning'**
  String get splashTagline;

  /// No description provided for @onboardingPage1Title.
  ///
  /// In en, this message translates to:
  /// **'Scan Text \nin Seconds'**
  String get onboardingPage1Title;

  /// No description provided for @onboardingPage1Description.
  ///
  /// In en, this message translates to:
  /// **'Capture text from images with fast AI-powered OCR scanning.'**
  String get onboardingPage1Description;

  /// No description provided for @onboardingPage2Title.
  ///
  /// In en, this message translates to:
  /// **'Smart PDF \nAssistant'**
  String get onboardingPage2Title;

  /// No description provided for @onboardingPage2Description.
  ///
  /// In en, this message translates to:
  /// **'Translate, extract and understand\nyour PDF documents with AI.'**
  String get onboardingPage2Description;

  /// No description provided for @onboardingPage3Title.
  ///
  /// In en, this message translates to:
  /// **'Chat with \nYour PDFs'**
  String get onboardingPage3Title;

  /// No description provided for @onboardingPage3Description.
  ///
  /// In en, this message translates to:
  /// **'Ask questions, summarize documents\nand get instant AI answers.'**
  String get onboardingPage3Description;

  /// No description provided for @onboardingPage4Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop \nin Seconds'**
  String get onboardingPage4Title;

  /// No description provided for @onboardingPage4Description.
  ///
  /// In en, this message translates to:
  /// **'Auto-crop multiple images and\ncreate clean PDFs instantly.'**
  String get onboardingPage4Description;

  /// No description provided for @settingsChooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose a language'**
  String get settingsChooseLanguage;

  /// No description provided for @settingsLanguageApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get settingsLanguageApply;

  /// No description provided for @commonSaving.
  ///
  /// In en, this message translates to:
  /// **'Saving…'**
  String get commonSaving;

  /// No description provided for @smartCropTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop'**
  String get smartCropTitle;

  /// No description provided for @smartCropInputMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop Scanner'**
  String get smartCropInputMethodTitle;

  /// No description provided for @smartCropInputMethodSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to crop your document'**
  String get smartCropInputMethodSubtitle;

  /// No description provided for @smartCropInputLiveCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Live Camera'**
  String get smartCropInputLiveCameraTitle;

  /// No description provided for @smartCropInputLiveCameraDescription.
  ///
  /// In en, this message translates to:
  /// **'Google scanner — auto edges, crop and enhance'**
  String get smartCropInputLiveCameraDescription;

  /// No description provided for @smartCropInputUploadImageTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload Image'**
  String get smartCropInputUploadImageTitle;

  /// No description provided for @smartCropInputUploadImageDescription.
  ///
  /// In en, this message translates to:
  /// **'Upload document image from gallery'**
  String get smartCropInputUploadImageDescription;

  /// No description provided for @smartCropUploadIntroHeadline.
  ///
  /// In en, this message translates to:
  /// **'Crop Multiple Images\nAutomatically'**
  String get smartCropUploadIntroHeadline;

  /// No description provided for @smartCropUploadIntroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Automatically detect edges, crop images perfectly and create a PDF in one tap.'**
  String get smartCropUploadIntroSubtitle;

  /// No description provided for @smartCropUploadIntroStepSelect.
  ///
  /// In en, this message translates to:
  /// **'Select multiple images'**
  String get smartCropUploadIntroStepSelect;

  /// No description provided for @smartCropUploadIntroStepCrop.
  ///
  /// In en, this message translates to:
  /// **'Auto detect and crop'**
  String get smartCropUploadIntroStepCrop;

  /// No description provided for @smartCropUploadIntroStepPdf.
  ///
  /// In en, this message translates to:
  /// **'Create PDF instantly'**
  String get smartCropUploadIntroStepPdf;

  /// No description provided for @smartCropUploadIntroSelectImages.
  ///
  /// In en, this message translates to:
  /// **'Select Images'**
  String get smartCropUploadIntroSelectImages;

  /// No description provided for @smartCropLiveCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Crop Camera'**
  String get smartCropLiveCameraTitle;

  /// No description provided for @smartCropLiveCameraTip.
  ///
  /// In en, this message translates to:
  /// **'Document detected — tap to capture'**
  String get smartCropLiveCameraTip;

  /// No description provided for @smartCropLiveCameraAlignTip.
  ///
  /// In en, this message translates to:
  /// **'Align document inside the corners'**
  String get smartCropLiveCameraAlignTip;

  /// No description provided for @smartCropLiveCameraClose.
  ///
  /// In en, this message translates to:
  /// **'Close camera'**
  String get smartCropLiveCameraClose;

  /// No description provided for @smartCropLiveCameraFlash.
  ///
  /// In en, this message translates to:
  /// **'Toggle flash'**
  String get smartCropLiveCameraFlash;

  /// No description provided for @smartCropLiveCameraCapture.
  ///
  /// In en, this message translates to:
  /// **'Capture document for smart cropping'**
  String get smartCropLiveCameraCapture;

  /// No description provided for @smartCropLiveCameraInitializing.
  ///
  /// In en, this message translates to:
  /// **'Starting camera…'**
  String get smartCropLiveCameraInitializing;

  /// No description provided for @smartCropCapturedTitle.
  ///
  /// In en, this message translates to:
  /// **'Captured Document'**
  String get smartCropCapturedTitle;

  /// No description provided for @smartCropCapturedRetake.
  ///
  /// In en, this message translates to:
  /// **'Retake last photo'**
  String get smartCropCapturedRetake;

  /// No description provided for @smartCropCapturedAnotherPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add another photo'**
  String get smartCropCapturedAnotherPhoto;

  /// No description provided for @smartCropCapturedRetakeAnotherPhoto.
  ///
  /// In en, this message translates to:
  /// **'Retake another photo'**
  String get smartCropCapturedRetakeAnotherPhoto;

  /// No description provided for @smartCropCapturedPreview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get smartCropCapturedPreview;

  /// No description provided for @smartCropPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get smartCropPreviewTitle;

  /// No description provided for @smartCropCapturedCrop.
  ///
  /// In en, this message translates to:
  /// **'Crop'**
  String get smartCropCapturedCrop;

  /// No description provided for @smartCropAdjustCornersTitle.
  ///
  /// In en, this message translates to:
  /// **'Adjust corners'**
  String get smartCropAdjustCornersTitle;

  /// No description provided for @smartCropAdjustCornersHint.
  ///
  /// In en, this message translates to:
  /// **'Drag the purple corners to match the document edges'**
  String get smartCropAdjustCornersHint;

  /// No description provided for @smartCropAdjustCornersConfirm.
  ///
  /// In en, this message translates to:
  /// **'Apply crop'**
  String get smartCropAdjustCornersConfirm;

  /// No description provided for @smartCropDetectingEdges.
  ///
  /// In en, this message translates to:
  /// **'Detecting document edges…'**
  String get smartCropDetectingEdges;

  /// No description provided for @smartCropAndroidOnly.
  ///
  /// In en, this message translates to:
  /// **'Smart scan is available on Android only.'**
  String get smartCropAndroidOnly;

  /// No description provided for @smartCropPageIndicator.
  ///
  /// In en, this message translates to:
  /// **'{current}/{total}'**
  String smartCropPageIndicator(int current, int total);

  /// No description provided for @smartCropMaxPagesReached.
  ///
  /// In en, this message translates to:
  /// **'Maximum {max} photos reached'**
  String smartCropMaxPagesReached(int max);

  /// No description provided for @smartCropProcessingCrop.
  ///
  /// In en, this message translates to:
  /// **'Applying magical crop...'**
  String get smartCropProcessingCrop;

  /// No description provided for @smartCropProcessingCropMultiple.
  ///
  /// In en, this message translates to:
  /// **'Cropping {count} documents…'**
  String smartCropProcessingCropMultiple(int count);

  /// No description provided for @smartCropCroppedTitle.
  ///
  /// In en, this message translates to:
  /// **'Cropped Document'**
  String get smartCropCroppedTitle;

  /// No description provided for @smartCropFilterOriginal.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get smartCropFilterOriginal;

  /// No description provided for @smartCropFilterLighten.
  ///
  /// In en, this message translates to:
  /// **'Lighten'**
  String get smartCropFilterLighten;

  /// No description provided for @smartCropFilterMagic.
  ///
  /// In en, this message translates to:
  /// **'Magic'**
  String get smartCropFilterMagic;

  /// No description provided for @smartCropFilterGrayscale.
  ///
  /// In en, this message translates to:
  /// **'Grayscale'**
  String get smartCropFilterGrayscale;

  /// No description provided for @smartCropFilterMono.
  ///
  /// In en, this message translates to:
  /// **'B&W'**
  String get smartCropFilterMono;

  /// No description provided for @smartCropFilterWarm.
  ///
  /// In en, this message translates to:
  /// **'Warm'**
  String get smartCropFilterWarm;

  /// No description provided for @smartCropActionCreatePdf.
  ///
  /// In en, this message translates to:
  /// **'Create PDF'**
  String get smartCropActionCreatePdf;

  /// No description provided for @smartCropProcessingPdf.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF document...'**
  String get smartCropProcessingPdf;

  /// No description provided for @smartCropProcessingPdfMultiple.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF with {count} pages…'**
  String smartCropProcessingPdfMultiple(int count);

  /// No description provided for @smartCropPdfSuccess.
  ///
  /// In en, this message translates to:
  /// **'PDF document generated successfully'**
  String get smartCropPdfSuccess;

  /// No description provided for @smartCropPdfPagesLabel.
  ///
  /// In en, this message translates to:
  /// **'pages'**
  String get smartCropPdfPagesLabel;

  /// No description provided for @smartCropPdfSinglePageLabel.
  ///
  /// In en, this message translates to:
  /// **'1 page'**
  String get smartCropPdfSinglePageLabel;

  /// No description provided for @smartCropImageCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get smartCropImageCopied;

  /// No description provided for @smartCropDeleteImageConfirm.
  ///
  /// In en, this message translates to:
  /// **'Remove this page from the document?'**
  String get smartCropDeleteImageConfirm;

  /// No description provided for @smartCropDeletePdfConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete this PDF from your device?'**
  String get smartCropDeletePdfConfirm;

  /// No description provided for @smartCropPdfRenamed.
  ///
  /// In en, this message translates to:
  /// **'PDF renamed'**
  String get smartCropPdfRenamed;

  /// No description provided for @smartCropPdfFileName.
  ///
  /// In en, this message translates to:
  /// **'File name'**
  String get smartCropPdfFileName;

  /// No description provided for @smartCropPdfFileSize.
  ///
  /// In en, this message translates to:
  /// **'File size'**
  String get smartCropPdfFileSize;

  /// No description provided for @smartCropViewPdf.
  ///
  /// In en, this message translates to:
  /// **'View PDF'**
  String get smartCropViewPdf;

  /// No description provided for @smartCropSavePdf.
  ///
  /// In en, this message translates to:
  /// **'Save PDF'**
  String get smartCropSavePdf;

  /// No description provided for @smartCropRenamePdf.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get smartCropRenamePdf;

  /// No description provided for @smartCropRenamePdfHint.
  ///
  /// In en, this message translates to:
  /// **'Document name'**
  String get smartCropRenamePdfHint;

  /// No description provided for @smartCropStepReadingImages.
  ///
  /// In en, this message translates to:
  /// **'Reading Images'**
  String get smartCropStepReadingImages;

  /// No description provided for @smartCropStepDetectingEdges.
  ///
  /// In en, this message translates to:
  /// **'Detecting document edges'**
  String get smartCropStepDetectingEdges;

  /// No description provided for @smartCropStepCroppingImages.
  ///
  /// In en, this message translates to:
  /// **'Cropping Images'**
  String get smartCropStepCroppingImages;

  /// No description provided for @smartCropStepGeneratingPdf.
  ///
  /// In en, this message translates to:
  /// **'Generating PDF'**
  String get smartCropStepGeneratingPdf;

  /// No description provided for @smartCropProcessingPdfSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We are organizing your cropped images\ninto a high quality PDF'**
  String get smartCropProcessingPdfSubtitle;

  /// No description provided for @smartCropProcessingPdfTitle.
  ///
  /// In en, this message translates to:
  /// **'Creating Your PDF'**
  String get smartCropProcessingPdfTitle;

  /// No description provided for @commonUntitledDocument.
  ///
  /// In en, this message translates to:
  /// **'document'**
  String get commonUntitledDocument;

  /// No description provided for @pdfAssistantDefaultFileLabel.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdfAssistantDefaultFileLabel;

  /// No description provided for @pdfAssistantTapToBrowse.
  ///
  /// In en, this message translates to:
  /// **'Tap to browse device directory'**
  String get pdfAssistantTapToBrowse;

  /// No description provided for @errorPdfTextLoad.
  ///
  /// In en, this message translates to:
  /// **'Error loading text.'**
  String get errorPdfTextLoad;

  /// No description provided for @commonProgressPercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}%'**
  String commonProgressPercent(int percent);

  /// No description provided for @translateExportTranslationTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation: {language}'**
  String translateExportTranslationTitle(String language);

  /// No description provided for @translateExportDocumentTranslation.
  ///
  /// In en, this message translates to:
  /// **'Document Translation'**
  String get translateExportDocumentTranslation;

  /// No description provided for @translateExportTranslatedBadge.
  ///
  /// In en, this message translates to:
  /// **'Translated'**
  String get translateExportTranslatedBadge;

  /// No description provided for @translateExportVerifiedFooter.
  ///
  /// In en, this message translates to:
  /// **'Verified offline translation export'**
  String get translateExportVerifiedFooter;

  /// No description provided for @translateExportPdfHeader.
  ///
  /// In en, this message translates to:
  /// **'Translation Export'**
  String get translateExportPdfHeader;

  /// No description provided for @translateExportPdfFooterLabel.
  ///
  /// In en, this message translates to:
  /// **'Confidential Document'**
  String get translateExportPdfFooterLabel;

  /// No description provided for @translateExportPageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {total}'**
  String translateExportPageOf(int page, int total);

  /// No description provided for @pdfAssistantPageLabel.
  ///
  /// In en, this message translates to:
  /// **'Page {page}'**
  String pdfAssistantPageLabel(int page);

  /// No description provided for @fileSizeBytes.
  ///
  /// In en, this message translates to:
  /// **'{size} B'**
  String fileSizeBytes(String size);

  /// No description provided for @fileSizeKb.
  ///
  /// In en, this message translates to:
  /// **'{size} KB'**
  String fileSizeKb(String size);

  /// No description provided for @fileSizeMb.
  ///
  /// In en, this message translates to:
  /// **'{size} MB'**
  String fileSizeMb(String size);

  /// No description provided for @translateLangName_en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get translateLangName_en;

  /// No description provided for @translateLangName_ur.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get translateLangName_ur;

  /// No description provided for @translateLangName_hi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get translateLangName_hi;

  /// No description provided for @translateLangName_ar.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get translateLangName_ar;

  /// No description provided for @translateLangName_es.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get translateLangName_es;

  /// No description provided for @translateLangName_fr.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get translateLangName_fr;

  /// No description provided for @translateLangName_de.
  ///
  /// In en, this message translates to:
  /// **'German'**
  String get translateLangName_de;

  /// No description provided for @translateLangName_pt.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get translateLangName_pt;

  /// No description provided for @translateLangName_ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get translateLangName_ru;

  /// No description provided for @translateLangName_zh.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Simplified)'**
  String get translateLangName_zh;

  /// No description provided for @translateLangName_zhTw.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Traditional)'**
  String get translateLangName_zhTw;

  /// No description provided for @translateLangName_ja.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get translateLangName_ja;

  /// No description provided for @translateLangName_ko.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get translateLangName_ko;

  /// No description provided for @translateLangName_it.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get translateLangName_it;

  /// No description provided for @translateLangName_tr.
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get translateLangName_tr;

  /// No description provided for @translateLangName_nl.
  ///
  /// In en, this message translates to:
  /// **'Dutch'**
  String get translateLangName_nl;

  /// No description provided for @translateLangName_sv.
  ///
  /// In en, this message translates to:
  /// **'Swedish'**
  String get translateLangName_sv;

  /// No description provided for @translateLangName_no.
  ///
  /// In en, this message translates to:
  /// **'Norwegian'**
  String get translateLangName_no;

  /// No description provided for @translateLangName_da.
  ///
  /// In en, this message translates to:
  /// **'Danish'**
  String get translateLangName_da;

  /// No description provided for @translateLangName_fi.
  ///
  /// In en, this message translates to:
  /// **'Finnish'**
  String get translateLangName_fi;

  /// No description provided for @translateLangName_el.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get translateLangName_el;

  /// No description provided for @translateLangName_pl.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get translateLangName_pl;

  /// No description provided for @translateLangName_cs.
  ///
  /// In en, this message translates to:
  /// **'Czech'**
  String get translateLangName_cs;

  /// No description provided for @translateLangName_hu.
  ///
  /// In en, this message translates to:
  /// **'Hungarian'**
  String get translateLangName_hu;

  /// No description provided for @translateLangName_ro.
  ///
  /// In en, this message translates to:
  /// **'Romanian'**
  String get translateLangName_ro;

  /// No description provided for @translateLangName_bg.
  ///
  /// In en, this message translates to:
  /// **'Bulgarian'**
  String get translateLangName_bg;

  /// No description provided for @translateLangName_uk.
  ///
  /// In en, this message translates to:
  /// **'Ukrainian'**
  String get translateLangName_uk;

  /// No description provided for @translateLangName_fa.
  ///
  /// In en, this message translates to:
  /// **'Persian'**
  String get translateLangName_fa;

  /// No description provided for @translateLangName_he.
  ///
  /// In en, this message translates to:
  /// **'Hebrew'**
  String get translateLangName_he;

  /// No description provided for @translateLangName_th.
  ///
  /// In en, this message translates to:
  /// **'Thai'**
  String get translateLangName_th;

  /// No description provided for @translateLangName_vi.
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get translateLangName_vi;

  /// No description provided for @translateLangName_id.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get translateLangName_id;

  /// No description provided for @translateLangName_ms.
  ///
  /// In en, this message translates to:
  /// **'Malay'**
  String get translateLangName_ms;

  /// No description provided for @translateLangName_bn.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get translateLangName_bn;

  /// No description provided for @translateLangName_ta.
  ///
  /// In en, this message translates to:
  /// **'Tamil'**
  String get translateLangName_ta;

  /// No description provided for @translateLangName_te.
  ///
  /// In en, this message translates to:
  /// **'Telugu'**
  String get translateLangName_te;

  /// No description provided for @translateLangName_mr.
  ///
  /// In en, this message translates to:
  /// **'Marathi'**
  String get translateLangName_mr;

  /// No description provided for @translateLangName_gu.
  ///
  /// In en, this message translates to:
  /// **'Gujarati'**
  String get translateLangName_gu;

  /// No description provided for @translateLangName_kn.
  ///
  /// In en, this message translates to:
  /// **'Kannada'**
  String get translateLangName_kn;

  /// No description provided for @translateLangName_ml.
  ///
  /// In en, this message translates to:
  /// **'Malayalam'**
  String get translateLangName_ml;

  /// No description provided for @translateLangName_pa.
  ///
  /// In en, this message translates to:
  /// **'Punjabi'**
  String get translateLangName_pa;

  /// No description provided for @translateLangName_sw.
  ///
  /// In en, this message translates to:
  /// **'Swahili'**
  String get translateLangName_sw;

  /// No description provided for @translateLangName_af.
  ///
  /// In en, this message translates to:
  /// **'Afrikaans'**
  String get translateLangName_af;

  /// No description provided for @translateLangName_ca.
  ///
  /// In en, this message translates to:
  /// **'Catalan'**
  String get translateLangName_ca;

  /// No description provided for @translateLangName_hr.
  ///
  /// In en, this message translates to:
  /// **'Croatian'**
  String get translateLangName_hr;

  /// No description provided for @translateLangName_sk.
  ///
  /// In en, this message translates to:
  /// **'Slovak'**
  String get translateLangName_sk;

  /// No description provided for @translateLangName_sl.
  ///
  /// In en, this message translates to:
  /// **'Slovenian'**
  String get translateLangName_sl;

  /// No description provided for @translateLangName_sr.
  ///
  /// In en, this message translates to:
  /// **'Serbian'**
  String get translateLangName_sr;

  /// No description provided for @translateLangName_lt.
  ///
  /// In en, this message translates to:
  /// **'Lithuanian'**
  String get translateLangName_lt;

  /// No description provided for @translateLangName_lv.
  ///
  /// In en, this message translates to:
  /// **'Latvian'**
  String get translateLangName_lv;

  /// No description provided for @translateLangName_et.
  ///
  /// In en, this message translates to:
  /// **'Estonian'**
  String get translateLangName_et;

  /// No description provided for @translateLangName_is.
  ///
  /// In en, this message translates to:
  /// **'Icelandic'**
  String get translateLangName_is;

  /// No description provided for @translateLangName_ga.
  ///
  /// In en, this message translates to:
  /// **'Irish'**
  String get translateLangName_ga;

  /// No description provided for @translateLangName_mt.
  ///
  /// In en, this message translates to:
  /// **'Maltese'**
  String get translateLangName_mt;

  /// No description provided for @translateLangName_sq.
  ///
  /// In en, this message translates to:
  /// **'Albanian'**
  String get translateLangName_sq;

  /// No description provided for @translateLangName_mk.
  ///
  /// In en, this message translates to:
  /// **'Macedonian'**
  String get translateLangName_mk;

  /// No description provided for @translateLangName_be.
  ///
  /// In en, this message translates to:
  /// **'Belarusian'**
  String get translateLangName_be;

  /// No description provided for @translateLangName_kk.
  ///
  /// In en, this message translates to:
  /// **'Kazakh'**
  String get translateLangName_kk;

  /// No description provided for @translateLangName_uz.
  ///
  /// In en, this message translates to:
  /// **'Uzbek'**
  String get translateLangName_uz;

  /// No description provided for @translateLangName_az.
  ///
  /// In en, this message translates to:
  /// **'Azerbaijani'**
  String get translateLangName_az;

  /// No description provided for @translateLangName_hy.
  ///
  /// In en, this message translates to:
  /// **'Armenian'**
  String get translateLangName_hy;

  /// No description provided for @translateLangName_ka.
  ///
  /// In en, this message translates to:
  /// **'Georgian'**
  String get translateLangName_ka;

  /// No description provided for @translateLangName_lo.
  ///
  /// In en, this message translates to:
  /// **'Lao'**
  String get translateLangName_lo;

  /// No description provided for @translateLangName_km.
  ///
  /// In en, this message translates to:
  /// **'Khmer'**
  String get translateLangName_km;

  /// No description provided for @translateLangName_my.
  ///
  /// In en, this message translates to:
  /// **'Burmese'**
  String get translateLangName_my;

  /// No description provided for @translateLangName_ne.
  ///
  /// In en, this message translates to:
  /// **'Nepali'**
  String get translateLangName_ne;

  /// No description provided for @translateLangName_si.
  ///
  /// In en, this message translates to:
  /// **'Sinhala'**
  String get translateLangName_si;

  /// No description provided for @translateLangName_am.
  ///
  /// In en, this message translates to:
  /// **'Amharic'**
  String get translateLangName_am;

  /// No description provided for @translateLangName_ha.
  ///
  /// In en, this message translates to:
  /// **'Hausa'**
  String get translateLangName_ha;

  /// No description provided for @translateLangName_yo.
  ///
  /// In en, this message translates to:
  /// **'Yoruba'**
  String get translateLangName_yo;

  /// No description provided for @translateLangName_ig.
  ///
  /// In en, this message translates to:
  /// **'Igbo'**
  String get translateLangName_ig;

  /// No description provided for @translateLangName_zu.
  ///
  /// In en, this message translates to:
  /// **'Zulu'**
  String get translateLangName_zu;

  /// No description provided for @translateLangName_xh.
  ///
  /// In en, this message translates to:
  /// **'Xhosa'**
  String get translateLangName_xh;

  /// No description provided for @translateLangName_st.
  ///
  /// In en, this message translates to:
  /// **'Sesotho'**
  String get translateLangName_st;

  /// No description provided for @translateLangName_sn.
  ///
  /// In en, this message translates to:
  /// **'Shona'**
  String get translateLangName_sn;

  /// No description provided for @translateLangName_rw.
  ///
  /// In en, this message translates to:
  /// **'Kinyarwanda'**
  String get translateLangName_rw;

  /// No description provided for @translateLangName_so.
  ///
  /// In en, this message translates to:
  /// **'Somali'**
  String get translateLangName_so;

  /// No description provided for @translateLangName_mg.
  ///
  /// In en, this message translates to:
  /// **'Malagasy'**
  String get translateLangName_mg;

  /// No description provided for @translateLangName_cy.
  ///
  /// In en, this message translates to:
  /// **'Welsh'**
  String get translateLangName_cy;

  /// No description provided for @translateLangName_mn.
  ///
  /// In en, this message translates to:
  /// **'Mongolian'**
  String get translateLangName_mn;

  /// No description provided for @translateLangName_tl.
  ///
  /// In en, this message translates to:
  /// **'Filipino'**
  String get translateLangName_tl;

  /// No description provided for @translateLangName_ht.
  ///
  /// In en, this message translates to:
  /// **'Haitian Creole'**
  String get translateLangName_ht;

  /// No description provided for @translateLangName_eo.
  ///
  /// In en, this message translates to:
  /// **'Esperanto'**
  String get translateLangName_eo;

  /// No description provided for @translateLangName_la.
  ///
  /// In en, this message translates to:
  /// **'Latin'**
  String get translateLangName_la;

  /// No description provided for @translateLangName_ku.
  ///
  /// In en, this message translates to:
  /// **'Kurdish'**
  String get translateLangName_ku;

  /// No description provided for @translateLangName_ps.
  ///
  /// In en, this message translates to:
  /// **'Pashto'**
  String get translateLangName_ps;

  /// No description provided for @translateLangName_faAf.
  ///
  /// In en, this message translates to:
  /// **'Dari'**
  String get translateLangName_faAf;

  /// No description provided for @translateLangName_bs.
  ///
  /// In en, this message translates to:
  /// **'Bosnian'**
  String get translateLangName_bs;

  /// No description provided for @translateLangName_mi.
  ///
  /// In en, this message translates to:
  /// **'Maori'**
  String get translateLangName_mi;

  /// No description provided for @translateLangName_sm.
  ///
  /// In en, this message translates to:
  /// **'Samoan'**
  String get translateLangName_sm;

  /// No description provided for @translateLangName_haw.
  ///
  /// In en, this message translates to:
  /// **'Hawaiian'**
  String get translateLangName_haw;

  /// No description provided for @translateLangName_lb.
  ///
  /// In en, this message translates to:
  /// **'Luxembourgish'**
  String get translateLangName_lb;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
