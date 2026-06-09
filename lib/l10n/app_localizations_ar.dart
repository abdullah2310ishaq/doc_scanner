// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'يلغي';

  @override
  String get commonSave => 'يحفظ';

  @override
  String get commonDelete => 'يمسح';

  @override
  String get commonShare => 'يشارك';

  @override
  String get commonCopy => 'ينسخ';

  @override
  String get commonRetry => 'أعد المحاولة';

  @override
  String get commonClose => 'يغلق';

  @override
  String get commonDone => 'تم';

  @override
  String get commonLoading => 'تحميل…';

  @override
  String get commonError => 'حدث خطأ ما';

  @override
  String get commonTryAgain => 'يرجى المحاولة مرة أخرى';

  @override
  String get navHome => 'بيت';

  @override
  String get navScan => 'مسح';

  @override
  String get navDocuments => 'وثائق';

  @override
  String get navTranslate => 'يترجم';

  @override
  String get navLive => 'يعيش';

  @override
  String get navSettings => 'إعدادات';

  @override
  String homeGreeting(String name) {
    return 'صباح الخير $name 👋';
  }

  @override
  String get homeTitlePrefix => 'وثيقة منظمة العفو الدولية';

  @override
  String get homeTitleHighlight => 'الماسح الضوئي';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'فتح القائمة';

  @override
  String get homeTagAiPowered => 'مدعوم بالذكاء الاصطناعي';

  @override
  String get homeTagFastOcr => 'التعرف الضوئي على الحروف بسرعة';

  @override
  String get homeTagSecure => 'يؤمن';

  @override
  String get homeTagSmartCrop => 'المحاصيل الذكية';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle =>
      'الذكاء الاصطناعي للتعرف الضوئي على الحروف (OCR) الذكي\nالماسح الضوئي';

  @override
  String get homeHeroSubtitle =>
      'التعرف الضوئي على الحروف المدعوم بالذكاء الاصطناعي مع التعرف السريع والدقيق على النص في ثوانٍ.';

  @override
  String get homeHeroButton => 'الماسح الضوئي للتعرف الضوئي على الحروف (OCR).';

  @override
  String get homeSearchHint => 'ابحث هنا';

  @override
  String get homeFeatureOcrTitle =>
      'الماسح الضوئي للتعرف الضوئي على الحروف (OCR).';

  @override
  String get homeFeatureOcrSubtitle => 'مسح النص من الصورة أو المستندات';

  @override
  String get homeFeaturePdfTitle => 'مساعد قوات الدفاع الشعبي';

  @override
  String get homeFeaturePdfSubtitle => 'ترجمة ونسخ PDF';

  @override
  String get homeFeatureChatbotTitle => 'آي شابوت';

  @override
  String get homeFeatureChatbotSubtitle => 'قم بتحميل ملف PDF لطرح الأسئلة';

  @override
  String get homeFeatureCropTitle => 'المحاصيل الذكية';

  @override
  String get homeFeatureCropSubtitle => 'الاقتصاص التلقائي والتنظيف والتحسين';

  @override
  String get homeRecentDocuments => 'المستندات الحديثة';

  @override
  String get homeSeeAll => 'رؤية الكل';

  @override
  String get homeEmptyDocuments =>
      'لا توجد وثائق حتى الآن. اضغط على المسح الضوئي للبدء.';

  @override
  String get homeSampleDocName => 'Invoice_2026.pdf';

  @override
  String get homeSampleDocMeta => 'May 10, 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => 'صور';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملفات',
      one: 'ملف',
      zero: '0 ملف',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count',
      one: '1',
      zero: '0',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => 'صور';

  @override
  String get homeRecentAdded => 'أضيف مؤخراً';

  @override
  String get homeRecentSelect => 'تحديد';

  @override
  String get homeRecentSelectAll => 'تحديد الكل';

  @override
  String get homeRecentDeselectAll => 'إلغاء تحديد الكل';

  @override
  String get homeRecentSearchPdfs => 'ابحث في PDF…';

  @override
  String get homeRecentSearchImages => 'ابحث في الصور…';

  @override
  String get homeRecentNoSearchResults => 'لا توجد نتائج';

  @override
  String get homeRecentToggleFavorite => 'مفضلة';

  @override
  String get homeRecentUnfavorite => 'إلغاء';

  @override
  String get homeRecentPdfEmptyTitle => 'لا PDF';

  @override
  String get homeRecentPdfEmptySubtitle => 'ارفع أو امسح لإنشاء PDF';

  @override
  String get homeRecentImageEmptyTitle => 'لا صور';

  @override
  String get homeRecentImageEmptySubtitle => 'ارفع أو امسح الصور هنا';

  @override
  String get homeRecentUploadPdf => 'رفع PDF';

  @override
  String get homeRecentUploadImages => 'رفع صور';

  @override
  String get homeRecentScanDocument => 'مسح';

  @override
  String get scanTitle => 'مسح';

  @override
  String get scanCapture => 'يأسر';

  @override
  String get scanImportGallery => 'استيراد من المعرض';

  @override
  String get scanImportFiles => 'استيراد الملف';

  @override
  String get scanAddPage => 'إضافة صفحة';

  @override
  String get scanRetake => 'إعادة الالتقاط';

  @override
  String get scanCrop => 'اقتصاص';

  @override
  String get scanEnhance => 'يحسن';

  @override
  String get scanDone => 'منتهي';

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
  String get ocrRunning => 'قراءة النص…';

  @override
  String get ocrEmpty => 'لم يتم العثور على نص في هذه الصورة';

  @override
  String get ocrCopySuccess => 'تم نسخ النص';

  @override
  String get ocrEditHint => 'تحرير النص الذي تم التعرف عليه';

  @override
  String get ocrInputMethodTitle => 'اختر طريقة الإدخال';

  @override
  String get ocrInputMethodSubtitle => 'حدد الطريقة التي تريد بها استخراج النص';

  @override
  String get ocrInputLiveCameraTitle => 'الكاميرا الحية';

  @override
  String get ocrInputLiveCameraDescription =>
      'التقاط صورة حية باستخدام الكاميرا';

  @override
  String get ocrInputUploadImageTitle => 'تحميل الصورة';

  @override
  String get ocrInputUploadImageDescription => 'تحميل الصورة من المعرض';

  @override
  String get ocrLiveCameraTitle => 'كاميرا التعرف الضوئي على الحروف الحية';

  @override
  String get ocrLiveCameraTip =>
      'نصيحة: للحصول على نتائج أفضل، ضع النص في منطقة مضاءة جيدًا';

  @override
  String get ocrLiveCameraClose => 'إغلاق الكاميرا';

  @override
  String get ocrLiveCameraFlash => 'تبديل الفلاش';

  @override
  String get ocrLiveCameraCapture => 'التقاط صورة للتعرف على النص';

  @override
  String get ocrLiveCameraInitializing => 'جارٍ تشغيل الكاميرا…';

  @override
  String get ocrAnalyzeTitle => 'الماسح الضوئي للتعرف الضوئي على الحروف (OCR).';

  @override
  String get ocrAnalyzeCopy => 'ينسخ';

  @override
  String get ocrAnalyzeTranslate => 'يترجم';

  @override
  String get ocrAnalyzeProcessing => 'جارٍ تحليل النص…';

  @override
  String get ocrAnalyzeTranslateNext => 'سيتم فتح الترجمة بعد ذلك';

  @override
  String get ocrNoTextTitle => 'لم يتم اكتشاف نص قابل للقراءة';

  @override
  String get ocrNoTextHint => 'حاول الحصول على صورة أوضح';

  @override
  String get ocrNoTextRetakePhoto => 'إعادة التقاط الصورة';

  @override
  String get ocrNoTextChooseGallery => 'اختر من المعرض';

  @override
  String get translateTitle => 'يترجم';

  @override
  String get translateSourceLanguage => 'من';

  @override
  String get translateTargetLanguage => 'ل';

  @override
  String get translateSwapLanguages => 'تبادل اللغات';

  @override
  String get translateButton => 'يترجم';

  @override
  String get translateRunning => 'ترجمة…';

  @override
  String get translatePasteHint => 'الصق النص أو اكتبه';

  @override
  String get translateCopyResult => 'نسخ الترجمة';

  @override
  String get translateResultTitle => 'ترجمة النص';

  @override
  String get translateResultSubtitle => 'ترجمة النص الذي اخترته إلى أي لغة';

  @override
  String get translateSelectedText => 'النص المحدد';

  @override
  String get translateSelectedLanguage => 'اللغة المختارة';

  @override
  String get translateSelectLanguage => 'اختر اللغة';

  @override
  String get translateSearchLanguage => 'لغات البحث';

  @override
  String get translateRecentLanguages => 'مؤخرًا';

  @override
  String get translateNoLanguagesFound => 'لم يتم العثور على لغات';

  @override
  String get translateTranslatedText => 'النص المترجم';

  @override
  String get translatePlaceholder => 'ستظهر الترجمة هنا..';

  @override
  String get translateSeeMore => 'شاهد المزيد';

  @override
  String get translateReadAloud => 'اقرأ بصوت عالٍ';

  @override
  String get translateSavePdf => 'حفظ بصيغة PDF';

  @override
  String get translateSavePng => 'حفظ بصيغة PNG';

  @override
  String get translateSaveComingSoon => 'سيكون الحفظ متاحًا قريبًا';

  @override
  String get translateDownloadOptionTitle => 'اختر خيار التنزيل';

  @override
  String get translateDownloadOptionSubtitle => 'حدد ما تريد تنزيله';

  @override
  String get translateDownloadSelectedTextTitle => 'تنزيل النص المحدد';

  @override
  String get translateDownloadSelectedTextDescription =>
      'قم بتنزيل النص المحدد فقط';

  @override
  String get translateDownloadCompleteFileTitle => 'تحميل الملف كاملا';

  @override
  String get translateDownloadCompleteFileDescription =>
      'قم بتنزيل الملف بأكمله';

  @override
  String get translateDownloadTranslatedTextTitle => 'تحميل النص المترجم';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'قم بتنزيل النص المترجم فقط';

  @override
  String get translateSavePdfSuccess => 'تم حفظ ملف PDF بنجاح';

  @override
  String get translateSavePngSuccess => 'تم حفظ الصورة بنجاح';

  @override
  String get translateExportNeedsTranslation => 'ترجمة النص قبل التنزيل';

  @override
  String get liveTitle => 'ترجمة حية';

  @override
  String get liveStart => 'تشغيل الكاميرا';

  @override
  String get liveStop => 'قف';

  @override
  String get liveListening => 'جاري الاستماع…';

  @override
  String get livePointAtText => 'قم بتوجيه الكاميرا نحو النص';

  @override
  String get livePermissionNeeded =>
      'الوصول إلى الكاميرا مطلوب للترجمة المباشرة';

  @override
  String get documentsTitle => 'المستندات الخاصة بي';

  @override
  String get documentRename => 'إعادة تسمية';

  @override
  String get documentDeleteConfirmTitle => 'هل تريد حذف المستند؟';

  @override
  String get documentDeleteConfirmMessage => 'لا يمكن التراجع عن هذا.';

  @override
  String get documentDeleted => 'تم حذف المستند';

  @override
  String get settingsTitle => 'إعدادات';

  @override
  String get settingsLanguage => 'لغة التطبيق';

  @override
  String get settingsTheme => 'سمة';

  @override
  String get settingsAbout => 'عن';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsTerms => 'شروط الاستخدام';

  @override
  String get settingsRateApp => 'قيّم التطبيق';

  @override
  String get settingsShareApp => 'شارك';

  @override
  String get settingsGreetingPrefix => 'صباح الخير،';

  @override
  String get settingsDefaultUserName => 'عبدالله';

  @override
  String get permissionCameraTitle => 'إذن الكاميرا';

  @override
  String get permissionCameraMessage =>
      'السماح بالوصول إلى الكاميرا لمسح المستندات ضوئيًا واستخدام الترجمة المباشرة.';

  @override
  String get permissionStorageTitle => 'إذن التخزين';

  @override
  String get permissionStorageMessage =>
      'السماح بالوصول لحفظ وفتح عمليات المسح الخاصة بك.';

  @override
  String get permissionOpenSettings => 'افتح الإعدادات';

  @override
  String get permissionDenied => 'تم رفض الإذن';

  @override
  String get errorCameraUnavailable => 'الكاميرا غير متوفرة على هذا الجهاز';

  @override
  String get errorFileRead => 'لا يمكن قراءة الملف';

  @override
  String get errorNetwork => 'تحقق من اتصالك بالإنترنت';

  @override
  String get errorNoInternetFeatures =>
      'لا يوجد اتصال بالإنترنت. قد لا تعمل بعض الميزات بشكل صحيح.';

  @override
  String get exitAppTitle => 'الخروج من التطبيق';

  @override
  String get exitAppMessage => 'هل أنت متأكد أنك تريد الخروج؟';

  @override
  String get exitAppConfirm => 'مخرج';

  @override
  String get errorOcrFailed => 'فشل التعرف على النص';

  @override
  String get errorTranslateFailed => 'فشلت الترجمة';

  @override
  String get errorTranslateModelDownload =>
      'تعذر تنزيل حزمة اللغة. تحقق من اتصالك وحاول مرة أخرى.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'هذه اللغة غير متاحة للترجمة دون الاتصال بالإنترنت.';

  @override
  String get proTitle => 'وثيقة الماسح الضوئي برو';

  @override
  String get proSubtitle =>
      'عمليات مسح غير محدودة، التعرف الضوئي على الحروف، اللغات، والترجمة المباشرة';

  @override
  String get proUpgradeButton => 'الترقية إلى برو';

  @override
  String get proRestorePurchases => 'استعادة المشتريات';

  @override
  String get proFeatureLocked => 'ميزة احترافية';

  @override
  String proLimitPages(int max) {
    return 'تسمح الخطة المجانية بما يصل إلى $max صفحة لكل مستند';
  }

  @override
  String get proLimitOcr => 'الترقية إلى Pro للحصول على OCR غير محدود';

  @override
  String get proLimitTranslate => 'الترقية إلى Pro لجميع اللغات';

  @override
  String get proLimitLive => 'الترجمة المباشرة متاحة في Pro';

  @override
  String get proPurchaseSuccess => 'مرحبا بكم في برو!';

  @override
  String get proPurchaseFailed => 'لا يمكن إكمال عملية الشراء';

  @override
  String get exportPdf => 'تصدير قوات الدفاع الشعبي';

  @override
  String get exportImage => 'تصدير الصورة';

  @override
  String get exportSuccess => 'اكتمل التصدير';

  @override
  String get exportFailed => 'فشل التصدير';

  @override
  String get languageSearchHint => 'لغة البحث';

  @override
  String get languageAuto => 'كشف اللغة';

  @override
  String get chatbotTitle => 'روبوت الدردشة بالذكاء الاصطناعي';

  @override
  String get chatbotHistoryButton => 'تاريخ الدردشة';

  @override
  String get chatbotBadge => 'مساعد الذكاء الاصطناعي الذكي الخاص بك';

  @override
  String get chatbotHeadlineChat => 'محادثة';

  @override
  String get chatbotHeadlineMiddle => 'مع الخاص بك';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'حاول أن تسأل';

  @override
  String get chatbotSuggestSummarize => 'تلخيص هذا PDF';

  @override
  String get chatbotSuggestKeyPoints => 'النقاط الرئيسية لهذا PDF';

  @override
  String get chatbotSuggestExplain => 'اشرح بالتفصيل';

  @override
  String get chatbotSuggestTranslate => 'ترجمة هذا PDF';

  @override
  String get chatbotAskQuestions => 'اطرح أسئلة حول ملف PDF هذا';

  @override
  String get chatbotUploadHint => 'تحميل ملف PDF...';

  @override
  String get chatbotSheetTitle => 'الدردشة مع ملف PDF الخاص بك';

  @override
  String get chatbotSheetSubtitle => 'قم بتحميل ملف PDF واسأل أي شيء عنه';

  @override
  String get chatbotChoosePdfTitle => 'اختر ملف PDF';

  @override
  String get chatbotChoosePdfDescription => 'تصفح وحدد PDF من جهازك';

  @override
  String get chatbotRecentFilesTitle => 'الملفات الأخيرة';

  @override
  String get chatbotRecentFilesDescription => 'اختر من ملفاتك الأخيرة';

  @override
  String get errorChatbotPdfPickFailed => 'لا يمكن فتح ملف PDF المحدد';

  @override
  String get chatbotAnalyzingTitle => 'جارٍ تحليل المستند...';

  @override
  String get chatbotAnalyzingSubtitle =>
      'يرجى الانتظار بينما نقرأ و\nفهم ملف PDF الخاص بك';

  @override
  String get chatbotStepReadingPdf => 'قراءة قوات الدفاع الشعبي';

  @override
  String get chatbotStepExtractingText => 'استخراج النص';

  @override
  String get chatbotStepUnderstandingContent => 'فهم المحتوى';

  @override
  String get chatbotStepPreparingChat => 'إعداد دردشة الذكاء الاصطناعي';

  @override
  String get chatbotHistoryTitle => 'تاريخ';

  @override
  String get chatbotNoConversationsTitle => 'لا توجد محادثات حتى الآن';

  @override
  String get chatbotNoConversationsSubtitle =>
      'قم بتحميل ملف PDF لبدء الدردشة مع مساعد الذكاء الاصطناعي الخاص بك.';

  @override
  String get chatbotUploadPdfButton => 'قم بتحميل ملف PDF';

  @override
  String get chatbotDocumentReadyTitle => 'الوثيقة جاهزة';

  @override
  String get chatbotDocumentReadySubtitle =>
      'يمكنك الآن الدردشة مع ملف PDF الخاص بك';

  @override
  String get chatbotCurrentSummary => 'الملخص الحالي';

  @override
  String get chatbotStartChatting => 'ابدأ الدردشة';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 مرحبًا! أنا مساعد الذكاء الاصطناعي الخاص بك. اسألني أي شيء عن ملف PDF هذا وسأساعدك.';

  @override
  String get chatbotChatYouCanAsk => 'يمكنك أن تسألني:';

  @override
  String get chatbotChatPromptSummarize => 'تلخيص هذه الوثيقة';

  @override
  String get chatbotChatPromptHighlights => 'ما هي أبرز النقاط؟';

  @override
  String get chatbotChatPromptFinancial => 'أرني البيانات المالية';

  @override
  String get chatbotChatPromptDates => 'استخراج التواريخ الهامة';

  @override
  String get chatbotChatInputHint => 'اسأل عن ملف PDF هذا...';

  @override
  String get chatbotDeleteTitle => 'هل تريد حذف الدردشة؟';

  @override
  String get chatbotDeleteMessage =>
      'سيؤدي هذا إلى إزالة الدردشة وملف PDF من سجلك. لا يمكن التراجع عن هذا.';

  @override
  String get chatbotRenameTitle => 'إعادة تسمية قوات الدفاع الشعبي';

  @override
  String get chatbotRenameHint => 'أدخل اسما';

  @override
  String get chatbotHistorySearchHint => 'ابحث في المحادثات…';

  @override
  String get chatbotRenameSuccess => 'تمت إعادة التسمية';

  @override
  String get chatbotDeleteSuccess => 'تم الحذف';

  @override
  String get chatbotEmptyConversationPreview => 'محادثة فارغة…';

  @override
  String get chatbotAiThinking => 'الذكاء يفكر';

  @override
  String get chatbotTipsLabel => 'نصائح';

  @override
  String get chatbotSuggestSummarizeChip => 'تلخيص\nهذا PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'النقاط الرئيسية\nمن هذا PDF';

  @override
  String get chatbotSuggestExplainChip => 'اشرح\nبالتفصيل';

  @override
  String get chatbotSuggestTranslateChip => 'ترجمة\nهذا PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'لا يمكن تحليل ملف PDF هذا. يرجى المحاولة مرة أخرى.';

  @override
  String get chatbotChatFailed => 'لا يمكن الحصول على رد. حاول ثانية.';

  @override
  String get errorChatbotPdfEmpty => 'لم يتم العثور على نص في ملف PDF هذا';

  @override
  String get pdfAssistantTitle => 'مساعد قوات الدفاع الشعبي';

  @override
  String get pdfAssistantSheetTitle => 'تحميل PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'اختر الطريقة التي تريد بها إضافة ملف PDF الخاص بك';

  @override
  String get pdfAssistantChoosePdfTitle => 'اختر ملف PDF';

  @override
  String get pdfAssistantChoosePdfDescription => 'تصفح وحدد PDF من جهازك';

  @override
  String get pdfAssistantLinkTitle => 'أضف ملف PDF من الرابط';

  @override
  String get pdfAssistantLinkDescription => 'الصق رابط PDF للتحميل مباشرة';

  @override
  String get pdfAssistantLinkHint => 'لصق عنوان URL لملف PDF';

  @override
  String get pdfAssistantLinkButton => 'تحميل قوات الدفاع الشعبي';

  @override
  String get pdfAssistantTranslateTo => 'ترجمة إلى';

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
  String get pdfAssistantStartProcessing => 'ابدأ المعالجة';

  @override
  String get pdfAssistantNoFileSelected => 'لم يتم تحديد أي ملف';

  @override
  String get pdfAssistantSelectLanguage => 'الرجاء تحديد اللغة المستهدفة';

  @override
  String get pdfAssistantProcessingTitle => 'جارٍ معالجة ملف PDF الخاص بك...';

  @override
  String get pdfAssistantProcessingSubtitle => 'انتظر من فضلك.';

  @override
  String get pdfAssistantStepExtracting => 'استخراج النص...';

  @override
  String get pdfAssistantStepTranslating => 'ترجمة المحتوى...';

  @override
  String get pdfAssistantStepGeneratingPdf => 'جارٍ إنشاء ملف PDF مترجم...';

  @override
  String get pdfAssistantStepFinalizing => 'جارٍ الانتهاء…';

  @override
  String get pdfAssistantResultTitle => 'نتائج';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF مترجم';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'التصميم الأصلي مع تراكب النص المترجم';

  @override
  String get pdfAssistantExtractedTextTitle => 'استخراج النص المترجم';

  @override
  String get pdfAssistantExtractedTextDescription => 'وثيقة نصية بسيطة A4';

  @override
  String get pdfAssistantActionOpen => 'يفتح';

  @override
  String get pdfAssistantActionDownload => 'تحميل';

  @override
  String get pdfAssistantDeleteTitle => 'هل تريد حذف النتائج؟';

  @override
  String get pdfAssistantDeleteMessage =>
      'سيؤدي هذا إلى إزالة الملفات المترجمة من جهازك.';

  @override
  String get pdfAssistantDownloadSuccess => 'تم الحفظ في التنزيلات';

  @override
  String get pdfAssistantOpenFailed => 'لا يمكن فتح الملف';

  @override
  String get pdfAssistantProcessFailed => 'تعذرت معالجة ملف PDF هذا';

  @override
  String get errorPdfAssistantPickFailed => 'لا يمكن فتح ملف PDF المحدد';

  @override
  String get errorPdfAssistantLinkFailed => 'لا يمكن تحميل PDF من هذا الرابط';

  @override
  String get errorPdfAssistantPdfEmpty => 'لم يتم العثور على نص في ملف PDF هذا';

  @override
  String get pdfAssistantRemoveTitle => 'إزالة قوات الدفاع الشعبي';

  @override
  String get pdfAssistantRemoveWarning =>
      'سيؤدي هذا إلى إزالة ملف PDF من جهازك.';

  @override
  String get pdfAssistantUploadPdf => 'تحميل PDF';

  @override
  String get cancel => 'يلغي';

  @override
  String get remove => 'يزيل';

  @override
  String get commonNext => 'التالي';

  @override
  String get commonSkip => 'يتخطى';

  @override
  String get commonContinue => 'يكمل';

  @override
  String get onboardingStart => 'ابدأ الآن →';

  @override
  String get splashTagline => 'مسح المستندات ضوئيًا باستخدام الذكاء الاصطناعي';

  @override
  String get onboardingPage1Title => 'مسح النص\nبالثواني';

  @override
  String get onboardingPage1Description => 'استخراج النص من الصور بسرعة.';

  @override
  String get onboardingPage2Title => 'مساعد PDF\nالذكي';

  @override
  String get onboardingPage2Description => 'ترجمة واستخراج وفهم\nمستندات PDF.';

  @override
  String get onboardingPage3Title => 'دردشة مع\nPDF';

  @override
  String get onboardingPage3Description => 'أسئلة وملخصات\nوإجابات فورية.';

  @override
  String get onboardingPage4Title => 'قص ذكي\nبالثواني';

  @override
  String get onboardingPage4Description => 'قص صور متعددة\nوإنشاء PDF.';

  @override
  String get settingsChooseLanguage => 'اختر لغة';

  @override
  String get settingsLanguageApply => 'يتقدم';

  @override
  String get commonSaving => 'توفير…';

  @override
  String get smartCropTitle => 'قص ذكي';

  @override
  String get smartCropInputMethodTitle => 'الماسح الضوئي الذكي للمحاصيل';

  @override
  String get smartCropInputMethodSubtitle =>
      'اختر الطريقة التي تريد بها اقتصاص المستند الخاص بك';

  @override
  String get smartCropInputLiveCameraTitle => 'الكاميرا الحية';

  @override
  String get smartCropInputLiveCameraDescription =>
      'الماسح الضوئي من Google - الحواف التلقائية والقص والتحسين';

  @override
  String get smartCropInputUploadImageTitle => 'تحميل الصورة';

  @override
  String get smartCropInputUploadImageDescription =>
      'تحميل صورة الوثيقة من المعرض';

  @override
  String get smartCropUploadIntroHeadline => 'قص صور متعددة\nتلقائيا';

  @override
  String get smartCropUploadIntroSubtitle =>
      'اكتشاف الحواف تلقائيًا، واقتصاص الصور بشكل مثالي وإنشاء ملف PDF بنقرة واحدة.';

  @override
  String get smartCropUploadIntroStepSelect => 'حدد صور متعددة';

  @override
  String get smartCropUploadIntroStepCrop => 'الكشف التلقائي والمحاصيل';

  @override
  String get smartCropUploadIntroStepPdf => 'إنشاء PDF على الفور';

  @override
  String get smartCropUploadIntroSelectImages => 'حدد الصور';

  @override
  String get smartCropLiveCameraTitle => 'كاميرا المحاصيل الذكية';

  @override
  String get smartCropLiveCameraTip => 'تم اكتشاف مستند — انقر لالتقاطه';

  @override
  String get smartCropLiveCameraAlignTip => 'قم بمحاذاة المستند داخل الزوايا';

  @override
  String get smartCropLiveCameraClose => 'إغلاق الكاميرا';

  @override
  String get smartCropLiveCameraFlash => 'تبديل الفلاش';

  @override
  String get smartCropLiveCameraCapture => 'التقط مستندًا للاقتصاص الذكي';

  @override
  String get smartCropLiveCameraInitializing => 'جارٍ تشغيل الكاميرا…';

  @override
  String get smartCropCapturedTitle => 'الوثيقة الملتقطة';

  @override
  String get smartCropCapturedRetake => 'إعادة التقاط الصورة الأخيرة';

  @override
  String get smartCropCapturedAnotherPhoto => 'أضف صورة أخرى';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'أعد التقاط صورة أخرى';

  @override
  String get smartCropCapturedPreview => 'معاينة';

  @override
  String get smartCropPreviewTitle => 'معاينة';

  @override
  String get smartCropCapturedCrop => 'اقتصاص';

  @override
  String get smartCropAdjustCornersTitle => 'ضبط الزوايا';

  @override
  String get smartCropAdjustCornersHint =>
      'اسحب الزوايا الأرجوانية لتتناسب مع حواف المستند';

  @override
  String get smartCropAdjustCornersConfirm => 'تطبيق المحاصيل';

  @override
  String get smartCropDetectingEdges => 'جارٍ اكتشاف حواف المستند...';

  @override
  String get smartCropAndroidOnly => 'الفحص الذكي متاح على نظام Android فقط.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'تم الوصول إلى الحد الأقصى لعدد $max من الصور';
  }

  @override
  String get smartCropProcessingCrop => 'تطبيق الاقتصاص السحري...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'جارٍ اقتصاص مستندات $count...';
  }

  @override
  String get smartCropCroppedTitle => 'مستند تم اقتصاصه';

  @override
  String get smartCropFilterOriginal => 'إبداعي';

  @override
  String get smartCropFilterLighten => 'تفتيح';

  @override
  String get smartCropFilterMagic => 'سحر';

  @override
  String get smartCropFilterGrayscale => 'تدرج الرمادي';

  @override
  String get smartCropFilterMono => 'أبيض وأسود';

  @override
  String get smartCropFilterWarm => 'دافيء';

  @override
  String get smartCropActionCreatePdf => 'إنشاء قوات الدفاع الشعبي';

  @override
  String get smartCropProcessingPdf => 'جارٍ إنشاء مستند PDF...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'جارٍ إنشاء ملف PDF بصفحات $count...';
  }

  @override
  String get smartCropPdfSuccess => 'تم إنشاء مستند PDF بنجاح';

  @override
  String get smartCropPdfPagesLabel => 'الصفحات';

  @override
  String get smartCropPdfSinglePageLabel => '1 صفحة';

  @override
  String get smartCropImageCopied => 'منقول';

  @override
  String get smartCropDeleteImageConfirm =>
      'هل تريد إزالة هذه الصفحة من المستند؟';

  @override
  String get smartCropDeletePdfConfirm => 'هل تريد حذف ملف PDF هذا من جهازك؟';

  @override
  String get smartCropPdfRenamed => 'تمت إعادة تسمية PDF';

  @override
  String get smartCropPdfFileName => 'اسم الملف';

  @override
  String get smartCropPdfFileSize => 'حجم الملف';

  @override
  String get smartCropViewPdf => 'عرض قوات الدفاع الشعبي';

  @override
  String get smartCropSavePdf => 'حفظ قوات الدفاع الشعبي';

  @override
  String get smartCropRenamePdf => 'إعادة تسمية';

  @override
  String get smartCropRenamePdfHint => 'اسم المستند';

  @override
  String get smartCropStepReadingImages => 'قراءة الصور';

  @override
  String get smartCropStepDetectingEdges => 'كشف الحواف';

  @override
  String get smartCropStepCroppingImages => 'قص الصور';

  @override
  String get smartCropStepGeneratingPdf => 'إنشاء PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'تنظيم الصور\nفي PDF عالي الجودة';

  @override
  String get smartCropProcessingPdfTitle => 'إنشاء PDF';

  @override
  String get commonUntitledDocument => 'وثيقة';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse => 'انقر لتصفح دليل الجهاز';

  @override
  String get errorPdfTextLoad => 'حدث خطأ أثناء تحميل النص.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'الترجمة: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'ترجمة المستندات';

  @override
  String get translateExportTranslatedBadge => 'مترجم';

  @override
  String get translateExportVerifiedFooter =>
      'تم التحقق من تصدير الترجمة دون اتصال بالإنترنت';

  @override
  String get translateExportPdfHeader => 'تصدير الترجمة';

  @override
  String get translateExportPdfFooterLabel => 'وثيقة سرية';

  @override
  String translateExportPageOf(int page, int total) {
    return 'الصفحة $page من $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'الصفحة $page';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size ب';
  }

  @override
  String fileSizeKb(String size) {
    return '$size كيلو بايت';
  }

  @override
  String fileSizeMb(String size) {
    return '$size ميغابايت';
  }

  @override
  String get translateLangName_en => 'إنجليزي';

  @override
  String get translateLangName_ur => 'الأردية';

  @override
  String get translateLangName_hi => 'الهندية';

  @override
  String get translateLangName_ar => 'عربي';

  @override
  String get translateLangName_es => 'الأسبانية';

  @override
  String get translateLangName_fr => 'فرنسي';

  @override
  String get translateLangName_de => 'الألمانية';

  @override
  String get translateLangName_pt => 'البرتغالية';

  @override
  String get translateLangName_ru => 'الروسية';

  @override
  String get translateLangName_zh => 'الصينية (المبسطة)';

  @override
  String get translateLangName_zhTw => 'الصينية (التقليدية)';

  @override
  String get translateLangName_ja => 'اليابانية';

  @override
  String get translateLangName_ko => 'كوري';

  @override
  String get translateLangName_it => 'ايطالي';

  @override
  String get translateLangName_tr => 'تركي';

  @override
  String get translateLangName_nl => 'هولندي';

  @override
  String get translateLangName_sv => 'السويدية';

  @override
  String get translateLangName_no => 'النرويجية';

  @override
  String get translateLangName_da => 'دانماركي';

  @override
  String get translateLangName_fi => 'الفنلندية';

  @override
  String get translateLangName_el => 'اليونانية';

  @override
  String get translateLangName_pl => 'بولندي';

  @override
  String get translateLangName_cs => 'التشيكية';

  @override
  String get translateLangName_hu => 'المجرية';

  @override
  String get translateLangName_ro => 'روماني';

  @override
  String get translateLangName_bg => 'البلغارية';

  @override
  String get translateLangName_uk => 'الأوكرانية';

  @override
  String get translateLangName_fa => 'الفارسية';

  @override
  String get translateLangName_he => 'العبرية';

  @override
  String get translateLangName_th => 'التايلاندية';

  @override
  String get translateLangName_vi => 'الفيتنامية';

  @override
  String get translateLangName_id => 'الاندونيسية';

  @override
  String get translateLangName_ms => 'لغة الملايو';

  @override
  String get translateLangName_bn => 'البنغالية';

  @override
  String get translateLangName_ta => 'التاميل';

  @override
  String get translateLangName_te => 'التيلجو';

  @override
  String get translateLangName_mr => 'المهاراتية';

  @override
  String get translateLangName_gu => 'الغوجاراتية';

  @override
  String get translateLangName_kn => 'الكانادا';

  @override
  String get translateLangName_ml => 'المالايالامية';

  @override
  String get translateLangName_pa => 'البنجابية';

  @override
  String get translateLangName_sw => 'السواحلية';

  @override
  String get translateLangName_af => 'الأفريكانية';

  @override
  String get translateLangName_ca => 'الكاتالونية';

  @override
  String get translateLangName_hr => 'الكرواتية';

  @override
  String get translateLangName_sk => 'السلوفاكية';

  @override
  String get translateLangName_sl => 'السلوفينية';

  @override
  String get translateLangName_sr => 'الصربية';

  @override
  String get translateLangName_lt => 'الليتوانية';

  @override
  String get translateLangName_lv => 'لاتفيا';

  @override
  String get translateLangName_et => 'الإستونية';

  @override
  String get translateLangName_is => 'الأيسلندية';

  @override
  String get translateLangName_ga => 'الأيرلندية';

  @override
  String get translateLangName_mt => 'المالطية';

  @override
  String get translateLangName_sq => 'الألبانية';

  @override
  String get translateLangName_mk => 'المقدونية';

  @override
  String get translateLangName_be => 'البيلاروسية';

  @override
  String get translateLangName_kk => 'الكازاخستانية';

  @override
  String get translateLangName_uz => 'الأوزبكية';

  @override
  String get translateLangName_az => 'أذربيجاني';

  @override
  String get translateLangName_hy => 'الأرمينية';

  @override
  String get translateLangName_ka => 'الجورجية';

  @override
  String get translateLangName_lo => 'لاو';

  @override
  String get translateLangName_km => 'الخمير';

  @override
  String get translateLangName_my => 'البورمية';

  @override
  String get translateLangName_ne => 'النيبالية';

  @override
  String get translateLangName_si => 'السنهالية';

  @override
  String get translateLangName_am => 'الأمهرية';

  @override
  String get translateLangName_ha => 'الهوسا';

  @override
  String get translateLangName_yo => 'اليوروبا';

  @override
  String get translateLangName_ig => 'الإيغبو';

  @override
  String get translateLangName_zu => 'الزولو';

  @override
  String get translateLangName_xh => 'خوسا';

  @override
  String get translateLangName_st => 'سيسوتو';

  @override
  String get translateLangName_sn => 'شونا';

  @override
  String get translateLangName_rw => 'الكينيارواندية';

  @override
  String get translateLangName_so => 'الصومالية';

  @override
  String get translateLangName_mg => 'مدغشقر';

  @override
  String get translateLangName_cy => 'الويلزية';

  @override
  String get translateLangName_mn => 'المنغولية';

  @override
  String get translateLangName_tl => 'فلبينية';

  @override
  String get translateLangName_ht => 'الكريول الهايتية';

  @override
  String get translateLangName_eo => 'الاسبرانتو';

  @override
  String get translateLangName_la => 'اللاتينية';

  @override
  String get translateLangName_ku => 'كردي';

  @override
  String get translateLangName_ps => 'الباشتو';

  @override
  String get translateLangName_faAf => 'داري';

  @override
  String get translateLangName_bs => 'البوسنية';

  @override
  String get translateLangName_mi => 'الماوري';

  @override
  String get translateLangName_sm => 'ساموا';

  @override
  String get translateLangName_haw => 'هاواي';

  @override
  String get translateLangName_lb => 'اللوكسمبرجية';
}
