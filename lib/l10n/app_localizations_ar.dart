// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'ماسح المستندات';

  @override
  String get commonOk => 'حسناً';

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonSave => 'حفظ';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonShare => 'مشاركة';

  @override
  String get commonCopy => 'نسخ';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get commonLoading => 'جارٍ التحميل…';

  @override
  String get commonError => 'حدث خطأ ما';

  @override
  String get commonTryAgain => 'يرجى المحاولة مرة أخرى';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navScan => 'مسح';

  @override
  String get navDocuments => 'المستندات';

  @override
  String get navTranslate => 'ترجمة';

  @override
  String get navLive => 'مباشر';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String homeGreeting(String name) {
    return 'صباح الخير، $name 👋';
  }

  @override
  String get homeTitlePrefix => 'مستندات ذكية';

  @override
  String get homeTitleHighlight => 'ماسح';

  @override
  String get homeProBadge => 'برو';

  @override
  String get homeMenuButton => 'فتح القائمة';

  @override
  String get homeTagAiPowered => 'مدعوم بالذكاء الاصطناعي';

  @override
  String get homeTagFastOcr => 'OCR سريع';

  @override
  String get homeTagSecure => 'آمن';

  @override
  String get homeTagSmartCrop => 'قص ذكي';

  @override
  String get homeHeroBadge => 'مدعوم بالذكاء';

  @override
  String get homeHeroTitle => 'ماسح OCR ذكي\nبالتقنية الذكية';

  @override
  String get homeHeroSubtitle =>
      'تقنية OCR بالذكاء الاصطناعي لاستخراج النصوص بدقة وسرعة.';

  @override
  String get homeHeroButton => 'مسح OCR';

  @override
  String get homeSearchHint => 'ابحث هنا';

  @override
  String get homeFeatureOcrTitle => 'ماسح OCR';

  @override
  String get homeFeatureOcrSubtitle => 'استخراج النص من الصور أو المستندات';

  @override
  String get homeFeaturePdfTitle => 'مساعد PDF';

  @override
  String get homeFeaturePdfSubtitle => 'ترجمة ونسخ PDF';

  @override
  String get homeFeatureChatbotTitle => 'مساعد ذكي';

  @override
  String get homeFeatureChatbotSubtitle => 'رفع PDF وطرح الأسئلة';

  @override
  String get homeFeatureCropTitle => 'قص ذكي';

  @override
  String get homeFeatureCropSubtitle => 'تحسين وقص تلقائي';

  @override
  String get homeRecentDocuments => 'المستندات الأخيرة';

  @override
  String get homeSeeAll => 'عرض الكل';

  @override
  String get homeEmptyDocuments => 'لا توجد مستندات. اضغط على مسح للبدء.';

  @override
  String get homeSampleDocName => 'فاتورة_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 مايو 2026 • 2.4 ميغابايت';

  @override
  String get scanTitle => 'المسح';

  @override
  String get scanCapture => 'التقاط';

  @override
  String get scanImportGallery => 'استيراد من المعرض';

  @override
  String get scanImportFiles => 'استيراد ملف';

  @override
  String get scanAddPage => 'إضافة صفحة';

  @override
  String get scanRetake => 'إعادة الالتقاط';

  @override
  String get scanCrop => 'قص';

  @override
  String get scanEnhance => 'تحسين';

  @override
  String get scanDone => 'تم';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صفحات',
      one: 'صفحة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'جارٍ حفظ المسح…';

  @override
  String get scanSaved => 'تم حفظ المستند';

  @override
  String get ocrTitle => 'التعرف على النص';

  @override
  String get ocrRun => 'التعرف على النص';

  @override
  String get ocrRunning => 'جارٍ قراءة النص…';

  @override
  String get ocrEmpty => 'لم يتم العثور على نص';

  @override
  String get ocrCopySuccess => 'تم نسخ النص';

  @override
  String get ocrEditHint => 'تعديل النص المستخرج';

  @override
  String get ocrInputMethodTitle => 'اختر طريقة الإدخال';

  @override
  String get ocrInputMethodSubtitle => 'حدد طريقة استخراج النص';

  @override
  String get ocrInputLiveCameraTitle => 'الكاميرا المباشرة';

  @override
  String get ocrInputLiveCameraDescription => 'التقاط صورة بالكاميرا';

  @override
  String get ocrInputUploadImageTitle => 'رفع صورة';

  @override
  String get ocrInputUploadImageDescription => 'اختيار من المعرض';

  @override
  String get ocrLiveCameraTitle => 'كاميرا OCR مباشرة';

  @override
  String get ocrLiveCameraTip => 'نصيحة: الإضاءة الجيدة تحسن النتائج';

  @override
  String get ocrLiveCameraClose => 'إغلاق الكاميرا';

  @override
  String get ocrLiveCameraFlash => 'تشغيل/إيقاف الفلاش';

  @override
  String get ocrLiveCameraCapture => 'التقاط للصورة';

  @override
  String get ocrLiveCameraInitializing => 'جاري تشغيل الكاميرا…';

  @override
  String get ocrAnalyzeTitle => 'ماسح OCR';

  @override
  String get ocrAnalyzeCopy => 'نسخ';

  @override
  String get ocrAnalyzeTranslate => 'ترجمة';

  @override
  String get ocrAnalyzeProcessing => 'جارٍ التحليل…';

  @override
  String get ocrAnalyzeTranslateNext => 'فتح الترجمة';

  @override
  String get ocrNoTextTitle => 'لا يوجد نص مقروء';

  @override
  String get ocrNoTextHint => 'جرّب صورة أوضح';

  @override
  String get ocrNoTextRetakePhoto => 'إعادة التصوير';

  @override
  String get ocrNoTextChooseGallery => 'اختيار من المعرض';

  @override
  String get translateTitle => 'ترجمة';

  @override
  String get translateSourceLanguage => 'من';

  @override
  String get translateTargetLanguage => 'إلى';

  @override
  String get translateSwapLanguages => 'تبديل اللغات';

  @override
  String get translateButton => 'ترجمة';

  @override
  String get translateRunning => 'جارٍ الترجمة…';

  @override
  String get translatePasteHint => 'أدخل أو الصق النص';

  @override
  String get translateCopyResult => 'نسخ الترجمة';

  @override
  String get translateResultTitle => 'الترجمة';

  @override
  String get translateResultSubtitle => 'ترجم النص إلى أي لغة';

  @override
  String get translateSelectedText => 'النص المحدد';

  @override
  String get translateSelectedLanguage => 'اللغة المحددة';

  @override
  String get translateSelectLanguage => 'اختر اللغة';

  @override
  String get translateSearchLanguage => 'ابحث عن لغة';

  @override
  String get translateRecentLanguages => 'الأخيرة';

  @override
  String get translateNoLanguagesFound => 'لا توجد لغات';

  @override
  String get translateTranslatedText => 'النص المترجم';

  @override
  String get translatePlaceholder => 'ستظهر الترجمة هنا…';

  @override
  String get translateSeeMore => 'عرض المزيد';

  @override
  String get translateReadAloud => 'قراءة صوتية';

  @override
  String get translateSavePdf => 'حفظ PDF';

  @override
  String get translateSavePng => 'حفظ صورة';

  @override
  String get translateSaveComingSoon => 'قريباً';

  @override
  String get translateDownloadOptionTitle => 'اختر خيار التحميل';

  @override
  String get translateDownloadOptionSubtitle => 'حدد ما تريد تحميله';

  @override
  String get translateDownloadSelectedTextTitle => 'تحميل النص المحدد';

  @override
  String get translateDownloadSelectedTextDescription => 'النص المحدد فقط';

  @override
  String get translateDownloadCompleteFileTitle => 'تحميل الملف الكامل';

  @override
  String get translateDownloadCompleteFileDescription => 'الملف بالكامل';

  @override
  String get translateSavePdfSuccess => 'تم حفظ PDF';

  @override
  String get translateSavePngSuccess => 'تم حفظ الصورة';

  @override
  String get translateExportNeedsTranslation => 'يرجى الترجمة أولاً';

  @override
  String get liveTitle => 'الترجمة المباشرة';

  @override
  String get liveStart => 'تشغيل الكاميرا';

  @override
  String get liveStop => 'إيقاف';

  @override
  String get liveListening => 'جارٍ التحليل…';

  @override
  String get livePointAtText => 'وجّه الكاميرا للنص';

  @override
  String get livePermissionNeeded => 'مطلوب إذن الكاميرا';

  @override
  String get documentsTitle => 'مستنداتي';

  @override
  String get documentRename => 'إعادة تسمية';

  @override
  String get documentDeleteConfirmTitle => 'حذف المستند؟';

  @override
  String get documentDeleteConfirmMessage => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get documentDeleted => 'تم حذف المستند';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsLanguage => 'لغة التطبيق';

  @override
  String get settingsTheme => 'المظهر';

  @override
  String get settingsAbout => 'حول';

  @override
  String get settingsPrivacy => 'الخصوصية';

  @override
  String get settingsTerms => 'شروط الاستخدام';

  @override
  String get permissionCameraTitle => 'إذن الكاميرا';

  @override
  String get permissionCameraMessage => 'السماح بالوصول إلى الكاميرا للمسح.';

  @override
  String get permissionStorageTitle => 'إذن التخزين';

  @override
  String get permissionStorageMessage => 'السماح بحفظ الملفات.';

  @override
  String get permissionOpenSettings => 'فتح الإعدادات';

  @override
  String get permissionDenied => 'تم رفض الإذن';

  @override
  String get errorCameraUnavailable => 'الكاميرا غير متاحة';

  @override
  String get errorFileRead => 'تعذر قراءة الملف';

  @override
  String get errorNetwork => 'تحقق من الاتصال بالإنترنت';

  @override
  String get errorNoInternetFeatures => 'لا يوجد اتصال بالإنترنت';

  @override
  String get exitAppTitle => 'الخروج من التطبيق';

  @override
  String get exitAppMessage => 'هل تريد الخروج؟';

  @override
  String get exitAppConfirm => 'خروج';

  @override
  String get errorOcrFailed => 'فشل التعرف على النص';

  @override
  String get errorTranslateFailed => 'فشل الترجمة';

  @override
  String get errorTranslateModelDownload => 'فشل تحميل حزمة اللغة';

  @override
  String get errorTranslateUnsupportedLanguage => 'اللغة غير مدعومة';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'مسح وOCR غير محدود';

  @override
  String get proUpgradeButton => 'الترقية إلى برو';

  @override
  String get proRestorePurchases => 'استعادة المشتريات';

  @override
  String get proFeatureLocked => 'ميزة برو';

  @override
  String proLimitPages(int max) {
    return 'النسخة المجانية حتى $max صفحات';
  }

  @override
  String get proLimitOcr => 'OCR غير محدود مع برو';

  @override
  String get proLimitTranslate => 'جميع اللغات مع برو';

  @override
  String get proLimitLive => 'الترجمة المباشرة لبرو فقط';

  @override
  String get proPurchaseSuccess => 'مرحباً بك في برو!';

  @override
  String get proPurchaseFailed => 'فشل الشراء';

  @override
  String get exportPdf => 'تصدير PDF';

  @override
  String get exportImage => 'تصدير صورة';

  @override
  String get exportSuccess => 'تم التصدير';

  @override
  String get exportFailed => 'فشل التصدير';

  @override
  String get languageSearchHint => 'ابحث عن لغة';

  @override
  String get languageAuto => 'تحديد تلقائي';

  @override
  String get chatbotTitle => 'المساعد الذكي';

  @override
  String get chatbotHistoryButton => 'السجل';

  @override
  String get chatbotBadge => 'مساعدك الذكي';

  @override
  String get chatbotHeadlineChat => 'دردشة';

  @override
  String get chatbotHeadlineMiddle => ' مع ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'جرّب السؤال';

  @override
  String get chatbotSuggestSummarize => 'تلخيص PDF';

  @override
  String get chatbotSuggestKeyPoints => 'النقاط الرئيسية';

  @override
  String get chatbotSuggestExplain => 'شرح مفصل';

  @override
  String get chatbotSuggestTranslate => 'ترجمة PDF';

  @override
  String get chatbotUploadHint => 'رفع PDF...';

  @override
  String get chatbotSheetTitle => 'الدردشة مع PDF';

  @override
  String get chatbotSheetSubtitle => 'ارفع ملف PDF وابدأ الأسئلة';

  @override
  String get chatbotChoosePdfTitle => 'اختر PDF';

  @override
  String get chatbotChoosePdfDescription => 'من الجهاز';

  @override
  String get chatbotRecentFilesTitle => 'الملفات الأخيرة';

  @override
  String get chatbotRecentFilesDescription => 'اختر من الأخيرة';

  @override
  String get errorChatbotPdfPickFailed => 'تعذر فتح PDF';

  @override
  String get chatbotAnalyzingTitle => 'جارٍ تحليل المستند...';

  @override
  String get chatbotAnalyzingSubtitle => 'يرجى الانتظار';

  @override
  String get chatbotStepReadingPdf => 'قراءة PDF';

  @override
  String get chatbotStepExtractingText => 'استخراج النص';

  @override
  String get chatbotStepUnderstandingContent => 'فهم المحتوى';

  @override
  String get chatbotStepPreparingChat => 'تحضير الدردشة';

  @override
  String get chatbotHistoryTitle => 'السجل';

  @override
  String get chatbotNoConversationsTitle => 'لا توجد محادثات';

  @override
  String get chatbotNoConversationsSubtitle => 'ارفع PDF للبدء';

  @override
  String get chatbotUploadPdfButton => 'رفع PDF';

  @override
  String get chatbotDocumentReadyTitle => 'المستند جاهز';

  @override
  String get chatbotDocumentReadySubtitle => 'ملخص سريع';

  @override
  String get chatbotCurrentSummary => 'الملخص';

  @override
  String get chatbotStartChatting => 'ابدأ الدردشة';

  @override
  String get chatbotChatGreeting => '👋🏻 مرحباً! اسألني عن ملف PDF.';

  @override
  String get chatbotChatYouCanAsk => 'يمكنك السؤال:';

  @override
  String get chatbotChatPromptSummarize => 'تلخيص المستند';

  @override
  String get chatbotChatPromptHighlights => 'أهم النقاط';

  @override
  String get chatbotChatPromptFinancial => 'البيانات المالية';

  @override
  String get chatbotChatPromptDates => 'التواريخ المهمة';

  @override
  String get chatbotChatInputHint => 'اسأل عن PDF...';

  @override
  String get chatbotDeleteTitle => 'حذف الدردشة؟';

  @override
  String get chatbotDeleteMessage => 'لا يمكن التراجع.';

  @override
  String get chatbotRenameTitle => 'إعادة تسمية PDF';

  @override
  String get chatbotRenameHint => 'أدخل اسم';

  @override
  String get chatbotAnalyzeFailed => 'فشل التحليل';

  @override
  String get chatbotChatFailed => 'فشل الرد';

  @override
  String get errorChatbotPdfEmpty => 'لا يوجد نص';

  @override
  String get pdfAssistantTitle => 'مساعد PDF';

  @override
  String get pdfAssistantSheetTitle => 'مساعد PDF';

  @override
  String get pdfAssistantSheetSubtitle => 'ترجمة PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'اختر PDF';

  @override
  String get pdfAssistantChoosePdfDescription => 'من الجهاز';

  @override
  String get pdfAssistantLinkTitle => 'إضافة رابط PDF';

  @override
  String get pdfAssistantLinkHint => 'الصق الرابط';

  @override
  String get pdfAssistantLinkButton => 'تحميل';

  @override
  String get pdfAssistantTranslateTo => 'ترجم إلى';

  @override
  String get pdfAssistantStartProcessing => 'ابدأ';

  @override
  String get pdfAssistantNoFileSelected => 'لا يوجد ملف';

  @override
  String get pdfAssistantSelectLanguage => 'اختر اللغة';

  @override
  String get pdfAssistantProcessingTitle => 'جارٍ المعالجة…';

  @override
  String get pdfAssistantProcessingSubtitle => 'يرجى الانتظار';

  @override
  String get pdfAssistantStepExtracting => 'استخراج…';

  @override
  String get pdfAssistantStepTranslating => 'ترجمة…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'إنشاء PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'إنهاء…';

  @override
  String get pdfAssistantResultTitle => 'النتيجة';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF مترجم';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'التصميم الأصلي';

  @override
  String get pdfAssistantExtractedTextTitle => 'النص المستخرج';

  @override
  String get pdfAssistantExtractedTextDescription => 'مستند بسيط';

  @override
  String get pdfAssistantActionOpen => 'فتح';

  @override
  String get pdfAssistantActionDownload => 'تحميل';

  @override
  String get pdfAssistantDeleteTitle => 'حذف؟';

  @override
  String get pdfAssistantDeleteMessage => 'لا يمكن التراجع';

  @override
  String get pdfAssistantDownloadSuccess => 'تم الحفظ';

  @override
  String get pdfAssistantOpenFailed => 'تعذر الفتح';

  @override
  String get pdfAssistantProcessFailed => 'فشل المعالجة';

  @override
  String get errorPdfAssistantPickFailed => 'فشل الاختيار';

  @override
  String get errorPdfAssistantLinkFailed => 'رابط غير صالح';

  @override
  String get errorPdfAssistantPdfEmpty => 'ملف PDF فارغ';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonSkip => 'تخطي';

  @override
  String get commonContinue => 'متابعة';

  @override
  String get splashTagline => 'ماسح مستندات مدعوم بالذكاء الاصطناعي';

  @override
  String get onboardingPage1Title => 'مسح أي مستند';

  @override
  String get onboardingPage1Description => 'التقاط الإيصالات والملاحظات بسرعة.';

  @override
  String get onboardingPage2Title => 'OCR والترجمة';

  @override
  String get onboardingPage2Description => 'استخراج النص وترجمته بسهولة.';

  @override
  String get onboardingPage3Title => 'حفظ وتصدير';

  @override
  String get onboardingPage3Description => 'إدارة كل شيء في مكان واحد.';

  @override
  String get settingsChooseLanguage => 'اختر اللغة';

  @override
  String get settingsLanguageApply => 'تطبيق';
}
