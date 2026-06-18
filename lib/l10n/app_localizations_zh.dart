// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => '确定';

  @override
  String get commonCancel => '取消';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '删除';

  @override
  String get commonShare => '分享';

  @override
  String get commonCopy => '复制';

  @override
  String get commonRetry => '重试';

  @override
  String get commonClose => '关闭';

  @override
  String get commonDone => '完成';

  @override
  String get commonLoading => '加载中…';

  @override
  String get commonError => '出错了';

  @override
  String get commonTryAgain => '请重试';

  @override
  String get navHome => '首页';

  @override
  String get navScan => '扫描';

  @override
  String get navDocuments => '文档';

  @override
  String get navTranslate => '翻译';

  @override
  String get navLive => '实况';

  @override
  String get navSettings => '设置';

  @override
  String homeGreeting(String name) {
    return '早上好，$name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI 文档';

  @override
  String get homeTitleHighlight => '扫描仪';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => '打开菜单';

  @override
  String get homeTagAiPowered => 'AI 驱动';

  @override
  String get homeTagFastOcr => '快速 OCR';

  @override
  String get homeTagSecure => '安全';

  @override
  String get homeTagSmartCrop => '智能裁剪';

  @override
  String get homeHeroBadge => 'AI 驱动';

  @override
  String get homeHeroTitle => '智能 AI OCR\n扫描仪';

  @override
  String get homeHeroSubtitle => '由 AI 驱动的 OCR，可在几秒钟内实现快速、准确 junction 的文本识别。';

  @override
  String get homeHeroButton => 'OCR 扫描仪';

  @override
  String get homeSearchHint => '在此搜索';

  @override
  String get homeFeatureOcrTitle => 'OCR 扫描仪';

  @override
  String get homeFeatureOcrSubtitle => '从图像或文档中扫描文本';

  @override
  String get homeFeaturePdfTitle => 'PDF 助手';

  @override
  String get homeFeaturePdfSubtitle => '翻译和转录 PDF';

  @override
  String get homeFeatureChatbotTitle => '询问 PDF';

  @override
  String get homeFeatureChatbotSubtitle => '上传 PDF 进行提问';

  @override
  String get homeFeatureCropTitle => '智能裁剪';

  @override
  String get homeFeatureCropSubtitle => '自动裁剪、清理和优化';

  @override
  String get homeRecentDocuments => '文档';

  @override
  String get homeSeeAll => '查看全部';

  @override
  String get homeEmptyDocuments => '暂无文档。点击“扫描”开始。';

  @override
  String get homeSampleDocName => '发票_2026.pdf';

  @override
  String get homeSampleDocMeta => '2026年5月10日 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => '图片';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      one: '1 个 file',
      zero: '0 个文件',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 个文件',
      one: '1 个文件',
      zero: '0 个文件',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => '图片';

  @override
  String get homeRecentAdded => '最近添加';

  @override
  String get homeRecentSelect => '选择';

  @override
  String get homeRecentSelectAll => '全选';

  @override
  String get homeRecentDeselectAll => '取消全选';

  @override
  String get homeRecentSearchPdfs => '搜索您的 PDF…';

  @override
  String get homeRecentSearchImages => '搜索您的图片…';

  @override
  String get homeRecentNoSearchResults => '没有找到符合搜索条件的文件';

  @override
  String get homeRecentToggleFavorite => '收藏';

  @override
  String get homeRecentUnfavorite => '取消收藏';

  @override
  String get homeRecentFavoriteAdded => '已添加到收藏';

  @override
  String get homeRecentFavoriteRemoved => '已从收藏中移除';

  @override
  String get homeRecentPdfEmptyTitle => '暂无最近 PDF';

  @override
  String get homeRecentPdfEmptySubtitle => '上传或扫描文档以创建您的第一个 PDF';

  @override
  String get homeRecentImageEmptyTitle => '暂无最近图片';

  @override
  String get homeRecentImageEmptySubtitle => '上传或扫描图片以在此处进行整理';

  @override
  String get homeRecentUploadPdf => '上传 PDF';

  @override
  String get homeRecentUploadImages => '上传图片';

  @override
  String get homeRecentScanDocument => '扫描文档';

  @override
  String get homeRecentDeleteImageTitle => '删除图片？';

  @override
  String get homeRecentDeleteImageMessage => '确定要删除此图片吗？此操作无法撤销。';

  @override
  String get homeRecentDeleteImagesTitle => '删除图片？';

  @override
  String get homeRecentDeleteImagesMessage => '确定要删除所选图片吗？此操作无法撤销。';

  @override
  String get scanTitle => '扫描';

  @override
  String get scanCapture => '拍摄';

  @override
  String get scanImportGallery => '从相册导入';

  @override
  String get scanImportFiles => '导入文件';

  @override
  String get scanAddPage => '添加页面';

  @override
  String get scanRetake => '重拍';

  @override
  String get scanCrop => '裁剪';

  @override
  String get scanEnhance => '优化';

  @override
  String get scanDone => '完成';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 页',
      one: '1 页',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => '正在保存扫描…';

  @override
  String get scanSaved => '文档已保存';

  @override
  String get ocrTitle => '文本识别';

  @override
  String get ocrRun => '识别文本';

  @override
  String get ocrRunning => '正在读取文本…';

  @override
  String get ocrEmpty => '未在此图片中找到文本';

  @override
  String get ocrCopySuccess => '文本已复制';

  @override
  String get ocrEditHint => '编辑识别出的文本';

  @override
  String get ocrInputMethodTitle => '选择输入方式';

  @override
  String get ocrInputMethodSubtitle => '选择您想要如何提取文本';

  @override
  String get ocrInputLiveCameraTitle => '实况相机';

  @override
  String get ocrInputLiveCameraDescription => '使用相机捕捉实时图像';

  @override
  String get ocrInputUploadImageTitle => '上传图片';

  @override
  String get ocrInputUploadImageDescription => '从相册上传图片';

  @override
  String get ocrLiveCameraTitle => '实况 OCR 相机';

  @override
  String get ocrLiveCameraTip => '提示：为获得更好的效果，请将文本放置在光线充足的地方';

  @override
  String get ocrLiveCameraClose => '关闭相机';

  @override
  String get ocrLiveCameraFlash => '切换闪光灯';

  @override
  String get ocrLiveCameraCapture => '拍摄图片以进行文本识别';

  @override
  String get ocrLiveCameraInitializing => '正在启动相机…';

  @override
  String get ocrAnalyzeTitle => 'OCR 扫描仪';

  @override
  String get ocrAnalyzeCopy => '复制';

  @override
  String get ocrAnalyzeTranslate => '翻译';

  @override
  String get ocrAnalyzeProcessing => '正在分析文本…';

  @override
  String get ocrAnalyzeTranslateNext => '接下来将打开翻译';

  @override
  String get ocrNoTextTitle => '未检测到可读文本';

  @override
  String get ocrNoTextHint => '请尝试更清晰的图片';

  @override
  String get ocrNoTextRetakePhoto => '重新拍照';

  @override
  String get ocrNoTextChooseGallery => '从相册选择';

  @override
  String get translateTitle => '翻译';

  @override
  String get translateSourceLanguage => '从';

  @override
  String get translateTargetLanguage => '至';

  @override
  String get translateSwapLanguages => '互换语言';

  @override
  String get translateButton => '翻译';

  @override
  String get translateRunning => '正在翻译…';

  @override
  String get translatePasteHint => '粘贴或输入文本';

  @override
  String get translateCopyResult => '复制翻译内容';

  @override
  String get translateResultTitle => '翻译文本';

  @override
  String get translateResultSubtitle => '将您选择的文本翻译成任何语言';

  @override
  String get translateSelectedText => '已选文本';

  @override
  String get translateSelectedLanguage => '已选语言';

  @override
  String get translateSelectLanguage => '选择语言';

  @override
  String get translateSearchLanguage => '搜索语言';

  @override
  String get translateRecentLanguages => '最近';

  @override
  String get translateNoLanguagesFound => '未找到语言';

  @override
  String get translateTranslatedText => '翻译结果';

  @override
  String get translatePlaceholder => '翻译内容将显示在这里…';

  @override
  String get translateSeeMore => '查看更多';

  @override
  String get translateReadAloud => '朗读';

  @override
  String get translateSavePdf => '保存为 PDF';

  @override
  String get translateSavePng => '保存为 PNG';

  @override
  String get translateSaveComingSoon => '保存功能即将推出';

  @override
  String get translateDownloadOptionTitle => '选择下载选项';

  @override
  String get translateDownloadOptionSubtitle => '选择您想要下载的内容';

  @override
  String get translateDownloadSelectedTextTitle => '下载已选文本';

  @override
  String get translateDownloadSelectedTextDescription => '仅下载所选文本';

  @override
  String get translateDownloadCompleteFileTitle => '下载完整文件';

  @override
  String get translateDownloadCompleteFileDescription => '下载整个文件';

  @override
  String get translateDownloadTranslatedTextTitle => '下载翻译文本';

  @override
  String get translateDownloadTranslatedTextDescription => '仅下载翻译后的文本';

  @override
  String get translateSavePdfSuccess => 'PDF 保存成功';

  @override
  String get translateSavePngSuccess => '图片保存成功';

  @override
  String get translateExportNeedsTranslation => '下载前请先翻译文本';

  @override
  String get liveTitle => '实时翻译';

  @override
  String get liveStart => '开启相机';

  @override
  String get liveStop => '停止';

  @override
  String get liveListening => '正在聆听…';

  @override
  String get livePointAtText => '将相机对准文本';

  @override
  String get livePermissionNeeded => '实时翻译需要相机访问权限';

  @override
  String get documentsTitle => '我的文档';

  @override
  String get documentRename => '重命名';

  @override
  String get documentDeleteConfirmTitle => '删除文档？';

  @override
  String get documentDeleteConfirmMessage => '此操作无法撤销。';

  @override
  String get documentDeleted => '文档已删除';

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsLanguage => '应用语言';

  @override
  String get settingsTheme => '主题';

  @override
  String get settingsAbout => '关于';

  @override
  String get settingsPrivacy => '隐私政策';

  @override
  String get settingsTerms => '条款与条件';

  @override
  String get settingsContactSupport => '联系支持';

  @override
  String get settingsMoreApps => '更多应用';

  @override
  String get settingsRateApp => '评价应用';

  @override
  String get settingsShareApp => '分享应用';

  @override
  String get settingsGreetingPrefix => '早上好，';

  @override
  String get settingsDefaultUserName => '阿卜杜拉';

  @override
  String get permissionCameraTitle => '相机权限';

  @override
  String get permissionCameraMessage => '允许访问相机以扫描文档和使用实时翻译。';

  @override
  String get permissionStorageTitle => '存储权限';

  @override
  String get permissionStorageMessage => '允许访问以保存和打开您的扫描件。';

  @override
  String get permissionOpenSettings => '打开设置';

  @override
  String get permissionDenied => '权限被拒绝';

  @override
  String get errorCameraUnavailable => '此设备上相机不可用';

  @override
  String get errorFileRead => '无法读取文件';

  @override
  String get errorNetwork => '请检查您的网络连接';

  @override
  String get errorNoInternetFeatures => '无网络连接。某些功能可能无法正常使用。';

  @override
  String get exitAppTitle => '退出应用';

  @override
  String get exitAppMessage => '确定要退出应用吗？';

  @override
  String get exitAppConfirm => '退出';

  @override
  String get errorOcrFailed => '文本识别失败';

  @override
  String get errorTranslateFailed => '翻译失败';

  @override
  String get errorTranslateModelDownload => '无法下载语言包。请检查您的连接并重试。';

  @override
  String get errorTranslateUnsupportedLanguage => '此语言不支持离线翻译。';

  @override
  String get proTitle => '文档扫描仪专业版';

  @override
  String get proSubtitle => '无限次扫描、OCR、语言和实时翻译';

  @override
  String get proUpgradeButton => '升级到 Pro';

  @override
  String get proRestorePurchases => '恢复购买';

  @override
  String get proFeatureLocked => 'Pro 功能';

  @override
  String proLimitPages(int max) {
    return '免费计划每份文档最多允许 $max 页';
  }

  @override
  String get proLimitOcr => '升级到 Pro 以获得无限次 OCR';

  @override
  String get proLimitTranslate => '升级到 Pro 以解锁所有语言';

  @override
  String get proLimitLive => '实时翻译在 Pro 版本中可用';

  @override
  String get proPurchaseSuccess => '欢迎加入 Pro！';

  @override
  String get proPurchaseFailed => '无法完成购买';

  @override
  String get proPaywallTitle => 'Get Pro Access';

  @override
  String get proPaywallTitleGet => 'Get';

  @override
  String get proPaywallTitlePro => 'Pro';

  @override
  String get proPaywallTitleAccess => 'Access';

  @override
  String get proEnableTrial => 'Enable Trial';

  @override
  String get proTrialPlanTitle => '3-Day Full Access';

  @override
  String get proYearlyPlanTitle => 'Yearly';

  @override
  String get proContinue => 'Continue';

  @override
  String proTrialDisclaimer(String price) {
    return 'After 3 days free - then weekly subscription for $price will start. Cancel anytime 24 hours before renewal.';
  }

  @override
  String proYearlyDisclaimer(String price) {
    return 'Yearly subscription for $price/year. Cancel anytime at least 24 hours before renewal.';
  }

  @override
  String proTrialThenPrice(String price) {
    return 'then $price/week';
  }

  @override
  String get proPerWeek => 'per week';

  @override
  String proYearlySubtitle(String price) {
    return 'just $price per year';
  }

  @override
  String get proSaveBadge => 'Save 86%';

  @override
  String get proFeatureUnlimitedScans => 'Unlimited Document Scans';

  @override
  String get proFeatureOcr => 'Accurate OCR Recognition';

  @override
  String get proFeaturePdf => 'Advanced PDF Tools';

  @override
  String get proFeatureAi => 'Smart AI Assistance';

  @override
  String get proStoreUnavailable =>
      'Store is not available right now. Please try again later.';

  @override
  String get proSplashEnable => 'Enable';

  @override
  String get proSplashTrialDays => '3-day trial';

  @override
  String get proSplashTrialEnabled => 'is enabled!';

  @override
  String get exportPdf => '导出 PDF';

  @override
  String get exportImage => '导出图片';

  @override
  String get exportSuccess => '导出完成';

  @override
  String get exportFailed => '导出失败';

  @override
  String get languageSearchHint => '搜索语言';

  @override
  String get languageAuto => '检测语言';

  @override
  String get chatbotTitle => 'AI 聊天机器人';

  @override
  String get chatbotHistoryButton => '聊天历史';

  @override
  String get chatbotBadge => '您的智能 AI 助手';

  @override
  String get chatbotHeadlineChat => '开始对话';

  @override
  String get chatbotHeadlineMiddle => ' 与您的 ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle => '上传 PDF 并随意提问 — 获取即时答案、摘要、解释等更多内容。';

  @override
  String get chatbotTryAsking => '试着问问';

  @override
  String get chatbotSuggestSummarize => '总结这份 PDF';

  @override
  String get chatbotSuggestKeyPoints => '这份 PDF 的关键点';

  @override
  String get chatbotSuggestExplain => '详细解释';

  @override
  String get chatbotSuggestTranslate => '翻译这份 PDF';

  @override
  String get chatbotAskQuestions => '提问关于这份 PDF 的问题';

  @override
  String get chatbotUploadHint => '上传 PDF…';

  @override
  String get chatbotSheetTitle => '与您的 PDF 对话';

  @override
  String get chatbotSheetSubtitle => '上传 PDF 并询问有关它的任何问题';

  @override
  String get chatbotChoosePdfTitle => '选择 PDF 文件';

  @override
  String get chatbotChoosePdfDescription => '在您的设备上浏览并选择 PDF';

  @override
  String get chatbotRecentFilesTitle => '最近文件';

  @override
  String get chatbotRecentFilesDescription => '从您最近的文件中选择';

  @override
  String get errorChatbotPdfPickFailed => '无法打开所选的 PDF';

  @override
  String get chatbotAnalyzingTitle => '正在分析您的文档…';

  @override
  String get chatbotAnalyzingSubtitle => '请稍候，我们正在阅读并\n理解您的 PDF';

  @override
  String get chatbotStepReadingPdf => '正在读取 PDF';

  @override
  String get chatbotStepExtractingText => '正在提取文本';

  @override
  String get chatbotStepUnderstandingContent => '正在理解内容';

  @override
  String get chatbotStepPreparingChat => '正在准备 AI 聊天';

  @override
  String get chatbotHistoryTitle => '历史记录';

  @override
  String get chatbotNoConversationsTitle => '暂无对话';

  @override
  String get chatbotNoConversationsSubtitle => '上传 PDF 开始与您的 AI 助手聊天。';

  @override
  String get chatbotUploadPdfButton => '上传 PDF';

  @override
  String get chatbotDocumentReadyTitle => '文档已就绪';

  @override
  String get chatbotDocumentReadySubtitle => '您现在可以与您的 PDF 进行对话了';

  @override
  String get chatbotCurrentSummary => '当前总结';

  @override
  String get chatbotStartChatting => '开始聊天';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 嗨！我是您的 AI 助手。关于这份 PDF，您可以向我提问任何问题，我会竭诚为您解答。';

  @override
  String get chatbotChatYouCanAsk => '您可以问我：';

  @override
  String get chatbotChatPromptSummarize => '总结这份文档';

  @override
  String get chatbotChatPromptHighlights => '有哪些核心亮点？';

  @override
  String get chatbotChatPromptFinancial => '向我展示财务数据';

  @override
  String get chatbotChatPromptDates => '提取重要日期';

  @override
  String get chatbotChatInputHint => '向 PDF 提问…';

  @override
  String get chatbotDeleteTitle => '删除聊天？';

  @override
  String get chatbotDeleteMessage => '这将从您的历史记录中删除该聊天和 PDF。此操作无法撤销。';

  @override
  String get chatbotRenameTitle => '重命名 PDF';

  @override
  String get chatbotRenameHint => '输入名称';

  @override
  String get chatbotHistorySearchHint => '搜索您的对话…';

  @override
  String get chatbotRenameSuccess => '重命名成功';

  @override
  String get chatbotDeleteSuccess => '删除成功';

  @override
  String get chatbotEmptyConversationPreview => '空对话…';

  @override
  String get chatbotAiThinking => 'AI 正在思考';

  @override
  String get chatbotTipsLabel => '提示';

  @override
  String get chatbotSuggestSummarizeChip => '总结\n这份 PDF';

  @override
  String get chatbotSuggestKeyPointsChip => '关键点\n这份 PDF';

  @override
  String get chatbotSuggestExplainChip => '详细\n解释';

  @override
  String get chatbotSuggestTranslateChip => '翻译\n这份 PDF';

  @override
  String get chatbotAnalyzeFailed => '无法分析此 PDF。请重试。';

  @override
  String get chatbotChatFailed => '无法获取回复。请重试。';

  @override
  String get errorChatbotPdfEmpty => '未在此 PDF 中找到文本';

  @override
  String get pdfAssistantTitle => 'PDF 助手';

  @override
  String get pdfAssistantSheetTitle => '上传 PDF';

  @override
  String get pdfAssistantSheetSubtitle => '选择您想要如何添加您的 PDF 文件';

  @override
  String get pdfAssistantChoosePdfTitle => '选择 PDF 文件';

  @override
  String get pdfAssistantChoosePdfDescription => '在您的设备上浏览并选择 PDF';

  @override
  String get pdfAssistantLinkTitle => '通过链接添加 PDF';

  @override
  String get pdfAssistantLinkDescription => '粘贴 PDF 链接直接上传';

  @override
  String get pdfAssistantLinkHint => '粘贴 PDF URL';

  @override
  String get pdfAssistantLinkButton => '下载 PDF';

  @override
  String get pdfAssistantTranslateTo => '翻译至';

  @override
  String get pdfAssistantTranslateToOptional => '翻译至（可选）';

  @override
  String get pdfAssistantNoTranslation => '不翻译';

  @override
  String get pdfAssistantExtractedPdfTitle => '提取的 PDF';

  @override
  String get pdfAssistantExtractedPdfDescription => '从 PDF 页面提取的文本';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => '提取的文本';

  @override
  String get pdfAssistantStepPreparingContent => '正在准备内容…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => '正在生成 PDF…';

  @override
  String get pdfAssistantStartProcessing => '开始处理';

  @override
  String get pdfAssistantNoFileSelected => '未选择文件';

  @override
  String get pdfAssistantSelectLanguage => '请选择目标语言';

  @override
  String get pdfAssistantProcessingTitle => '正在处理您的 PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => '请稍候。';

  @override
  String get pdfAssistantStepExtracting => '正在提取文本…';

  @override
  String get pdfAssistantStepTranslating => '正在翻译内容…';

  @override
  String get pdfAssistantStepGeneratingPdf => '正在生成翻译后的 PDF…';

  @override
  String get pdfAssistantStepFinalizing => '正在完成…';

  @override
  String get pdfAssistantResultTitle => '结果';

  @override
  String get pdfAssistantTranslatedPdfTitle => '翻译后的 PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => '保留原始布局并覆盖翻译文本';

  @override
  String get pdfAssistantExtractedTextTitle => '提取的翻译文本';

  @override
  String get pdfAssistantExtractedTextDescription => '简单的 A4 文本薄文档';

  @override
  String get pdfAssistantActionOpen => '打开';

  @override
  String get pdfAssistantActionDownload => '下载';

  @override
  String get pdfAssistantDeleteTitle => '删除结果？';

  @override
  String get pdfAssistantDeleteMessage => '这将从您的设备中删除翻译后的文件。';

  @override
  String get pdfAssistantDownloadSuccess => '已保存到下载';

  @override
  String get pdfAssistantOpenFailed => '无法打开文件';

  @override
  String get pdfAssistantProcessFailed => '无法处理此 PDF';

  @override
  String get errorPdfAssistantPickFailed => '无法打开所选的 PDF';

  @override
  String get errorPdfAssistantLinkFailed => '无法从此链接下载 PDF';

  @override
  String get errorPdfAssistantPdfEmpty => '未在此 PDF 中找到文本';

  @override
  String get pdfAssistantRemoveTitle => '移除 PDF';

  @override
  String get pdfAssistantRemoveWarning => '这将从您的设备中移除该 PDF。';

  @override
  String get pdfAssistantUploadPdf => '上传 PDF';

  @override
  String get cancel => '取消';

  @override
  String get remove => '移除';

  @override
  String get commonNext => '下一步';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonContinue => '继续';

  @override
  String get onboardingStart => '开始使用 →';

  @override
  String get splashTagline => 'AI 驱动的文档扫描';

  @override
  String get splashAdDisclaimer => '此操作可能会显示广告';

  @override
  String get adLoading => '广告加载中...';

  @override
  String get onboardingPage1Title => '几秒内\n扫描文字';

  @override
  String get onboardingPage1Description => '通过快速的 AI 驱动 OCR 扫描从图片中捕捉文本。';

  @override
  String get onboardingPage2Title => '智能 PDF\n助手';

  @override
  String get onboardingPage2Description => '利用 AI 翻译、提取和理解您的 PDF 文档。';

  @override
  String get onboardingPage3Title => '与您的\nPDF 对话';

  @override
  String get onboardingPage3Description => '提问、总结文档并获得即时的 AI 解答。';

  @override
  String get onboardingPage4Title => '几秒内\n智能裁剪';

  @override
  String get onboardingPage4Description => '自动裁剪多张图片并立即创建清晰的 PDF。';

  @override
  String get settingsChooseLanguage => '选择一种语言';

  @override
  String get settingsLanguageApply => '应用';

  @override
  String get commonSaving => '正在保存…';

  @override
  String get smartCropTitle => '智能裁剪';

  @override
  String get smartCropInputMethodTitle => '智能裁剪扫描仪';

  @override
  String get smartCropInputMethodSubtitle => '选择您想要如何裁剪您的文档';

  @override
  String get smartCropInputLiveCameraTitle => '实况相机';

  @override
  String get smartCropInputLiveCameraDescription => '谷歌扫描仪 — 自动识别边缘、裁剪和优化';

  @override
  String get smartCropInputUploadImageTitle => '上传图片';

  @override
  String get smartCropInputUploadImageDescription => '从相册上传文档图片';

  @override
  String get smartCropUploadIntroHeadline => '自动裁剪\n多张图片';

  @override
  String get smartCropUploadIntroSubtitle => '自动检测边缘，完美裁剪图片，一键创建 PDF。';

  @override
  String get smartCropUploadIntroStepSelect => '选择多张图片';

  @override
  String get smartCropUploadIntroStepCrop => '自动检测并裁剪';

  @override
  String get smartCropUploadIntroStepPdf => '立即创建 PDF';

  @override
  String get smartCropUploadIntroSelectImages => '选择图片';

  @override
  String get smartCropLiveCameraTitle => '智能裁剪相机';

  @override
  String get smartCropLiveCameraTip => '已检测到文档 — 点击拍摄';

  @override
  String get smartCropLiveCameraAlignTip => '将文档对齐在角落内';

  @override
  String get smartCropLiveCameraClose => '关闭相机';

  @override
  String get smartCropLiveCameraFlash => '切换闪光灯';

  @override
  String get smartCropLiveCameraCapture => '拍摄文档以进行智能裁剪';

  @override
  String get smartCropLiveCameraInitializing => '正在启动相机…';

  @override
  String get smartCropCapturedTitle => '已拍摄的文档';

  @override
  String get smartCropCapturedRetake => '重拍最后一张照片';

  @override
  String get smartCropCapturedAnotherPhoto => '添加另一张照片';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => '重拍另一张照片';

  @override
  String get smartCropCapturedPreview => '预览';

  @override
  String get smartCropPreviewTitle => '预览';

  @override
  String get smartCropCapturedCrop => '裁剪';

  @override
  String get smartCropAdjustCornersTitle => '调整角落';

  @override
  String get smartCropAdjustCornersHint => '拖动紫色角落以匹配文档边缘';

  @override
  String get smartCropAdjustCornersConfirm => '应用裁剪';

  @override
  String get smartCropPresetAuto => '自动检测';

  @override
  String get smartCropPresetCenter => '居中页面';

  @override
  String get smartCropPresetFull => '完整图片';

  @override
  String get smartCropUploadIntroGoogleScanner => 'Google Scanner（最佳裁剪）';

  @override
  String get smartCropDetectingEdges => '正在检测文档边缘…';

  @override
  String get smartCropAndroidOnly => '智能扫描仅在 Android 上可用。';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return '已达到最大照片张数 $max 张';
  }

  @override
  String get smartCropProcessingCrop => '正在应用神奇裁剪...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return '正在裁剪 $count 份文档…';
  }

  @override
  String get smartCropCroppedTitle => '已裁剪的文档';

  @override
  String get smartCropFilterOriginal => '原图';

  @override
  String get smartCropFilterLighten => '提亮';

  @override
  String get smartCropFilterMagic => '魔法优化';

  @override
  String get smartCropFilterGrayscale => '灰度';

  @override
  String get smartCropFilterMono => '黑白';

  @override
  String get smartCropFilterWarm => '暖色';

  @override
  String get smartCropActionCreatePdf => '创建 PDF';

  @override
  String get smartCropProcessingPdf => '正在生成 PDF 文档...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return '正在生成包含 $count 页的 PDF…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF 文档生成成功';

  @override
  String get smartCropPdfPagesLabel => '页';

  @override
  String get smartCropPdfSinglePageLabel => '1 页';

  @override
  String get smartCropImageCopied => '已复制';

  @override
  String get smartCropDeleteImageConfirm => '从文档中移除此页？';

  @override
  String get smartCropDeleteCapturedPageTitle => '删除页面';

  @override
  String get smartCropDeleteCapturedPageMessage => '确定要删除此页面吗？';

  @override
  String get smartCropDeleteDocumentTitle => '删除文档？';

  @override
  String get smartCropDeleteDocumentMessage => '确定要删除此文档吗？此操作无法撤销。';

  @override
  String get smartCropDeletePdfTitle => '删除 PDF？';

  @override
  String get smartCropDeletePdfMessage => '确定要删除此 PDF 吗？此操作无法撤销。';

  @override
  String get smartCropDeletePdfConfirm => '从您的设备中删除此 PDF？';

  @override
  String get smartCropPdfRenamed => 'PDF 已重命名';

  @override
  String get smartCropPdfFileName => '文件名';

  @override
  String get smartCropPdfFileSize => '文件大小';

  @override
  String get smartCropViewPdf => '查看 PDF';

  @override
  String get smartCropSavePdf => '保存 PDF';

  @override
  String get smartCropSavePdfSuccess => 'PDF 保存成功';

  @override
  String get smartCropRenamePdf => '重命名';

  @override
  String get smartCropRenamePdfHint => '文档名称';

  @override
  String get smartCropStepReadingImages => '正在读取图片';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return '正在读取 $done/$total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return '$total 张图片中有 $failed 张无法导入';
  }

  @override
  String get smartCropStepDetectingEdges => '正在检测边缘';

  @override
  String get smartCropStepCroppingImages => '正在裁剪';

  @override
  String get smartCropStepGeneratingPdf => '正在生成 PDF';

  @override
  String get smartCropProcessingPdfSubtitle => '正在将您裁剪的图片\n整理成高质量的 PDF';

  @override
  String get smartCropProcessingPdfTitle => '正在创建 PDF';

  @override
  String get commonUntitledDocument => '文档';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse => '点击浏览设备目录';

  @override
  String get errorPdfTextLoad => '加载文本出错。';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return '翻译：$language';
  }

  @override
  String get translateExportDocumentTranslation => '文档翻译';

  @override
  String get translateExportTranslatedBadge => '已翻译';

  @override
  String get translateExportVerifiedFooter => '已验证的离线翻译导出';

  @override
  String get translateExportPdfHeader => '翻译导出';

  @override
  String get translateExportPdfFooterLabel => '机密文档';

  @override
  String translateExportPageOf(int page, int total) {
    return '第 $page 页，共 $total 页';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return '第 $page 页';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size B';
  }

  @override
  String fileSizeKb(String size) {
    return '$size 知识库';
  }

  @override
  String fileSizeMb(String size) {
    return '$size MB';
  }

  @override
  String get translateLangName_en => '英语';

  @override
  String get translateLangName_ur => '乌尔都语';

  @override
  String get translateLangName_hi => '印地语';

  @override
  String get translateLangName_ar => '阿拉伯语';

  @override
  String get translateLangName_es => '西班牙语';

  @override
  String get translateLangName_fr => '法语';

  @override
  String get translateLangName_de => '德语';

  @override
  String get translateLangName_pt => '葡萄牙语';

  @override
  String get translateLangName_ru => '俄语';

  @override
  String get translateLangName_zh => '中文（简体）';

  @override
  String get translateLangName_zhTw => '中文（繁体）';

  @override
  String get translateLangName_ja => '日语';

  @override
  String get translateLangName_ko => '韩语';

  @override
  String get translateLangName_it => '意大利语';

  @override
  String get translateLangName_tr => '土耳其语';

  @override
  String get translateLangName_nl => '荷兰语';

  @override
  String get translateLangName_sv => '瑞典语';

  @override
  String get translateLangName_no => '挪威语';

  @override
  String get translateLangName_da => '丹麦语';

  @override
  String get translateLangName_fi => '芬兰语';

  @override
  String get translateLangName_el => '希腊语';

  @override
  String get translateLangName_pl => '波兰语';

  @override
  String get translateLangName_cs => '捷克语';

  @override
  String get translateLangName_hu => '匈牙利语';

  @override
  String get translateLangName_ro => '罗马尼亚语';

  @override
  String get translateLangName_bg => '保加利亚语';

  @override
  String get translateLangName_uk => '乌克兰语';

  @override
  String get translateLangName_fa => '波斯语';

  @override
  String get translateLangName_he => '希伯来语';

  @override
  String get translateLangName_th => '泰语';

  @override
  String get translateLangName_vi => '越南语';

  @override
  String get translateLangName_id => '印尼语';

  @override
  String get translateLangName_ms => '马来语';

  @override
  String get translateLangName_bn => '孟加拉语';

  @override
  String get translateLangName_ta => '泰米尔语';

  @override
  String get translateLangName_te => '泰卢固语';

  @override
  String get translateLangName_mr => '马拉地语';

  @override
  String get translateLangName_gu => '古吉拉特语';

  @override
  String get translateLangName_kn => '卡纳达语';

  @override
  String get translateLangName_ml => '马拉雅拉姆语';

  @override
  String get translateLangName_pa => '旁遮普语';

  @override
  String get translateLangName_sw => '斯瓦希里语';

  @override
  String get translateLangName_af => '南非荷兰语';

  @override
  String get translateLangName_ca => '加泰罗尼亚语';

  @override
  String get translateLangName_hr => '克罗地亚语';

  @override
  String get translateLangName_sk => '斯洛伐克语';

  @override
  String get translateLangName_sl => '斯洛文尼亚语';

  @override
  String get translateLangName_sr => '塞尔维亚语';

  @override
  String get translateLangName_lt => '立陶宛语';

  @override
  String get translateLangName_lv => '拉脱维亚语';

  @override
  String get translateLangName_et => '爱沙尼亚语';

  @override
  String get translateLangName_is => '冰岛语';

  @override
  String get translateLangName_ga => '爱尔兰语';

  @override
  String get translateLangName_mt => '马耳他语';

  @override
  String get translateLangName_sq => '阿尔巴尼亚语';

  @override
  String get translateLangName_mk => '马其顿语';

  @override
  String get translateLangName_be => '白俄罗斯语';

  @override
  String get translateLangName_kk => '哈萨克语';

  @override
  String get translateLangName_uz => '乌兹别克语';

  @override
  String get translateLangName_az => '阿塞拜疆语';

  @override
  String get translateLangName_hy => '亚美尼亚语';

  @override
  String get translateLangName_ka => '格鲁吉亚语';

  @override
  String get translateLangName_lo => '老挝语';

  @override
  String get translateLangName_km => '高棉语';

  @override
  String get translateLangName_my => '缅甸语';

  @override
  String get translateLangName_ne => '尼泊尔语';

  @override
  String get translateLangName_si => '僧伽罗语';

  @override
  String get translateLangName_am => '阿姆哈拉语';

  @override
  String get translateLangName_ha => '豪萨语';

  @override
  String get translateLangName_yo => '约鲁巴语';

  @override
  String get translateLangName_ig => '伊博语';

  @override
  String get translateLangName_zu => '祖鲁语';

  @override
  String get translateLangName_xh => '科萨语';

  @override
  String get translateLangName_st => '塞索托语';

  @override
  String get translateLangName_sn => '修纳语';

  @override
  String get translateLangName_rw => '卢旺达语';

  @override
  String get translateLangName_so => '索马里语';

  @override
  String get translateLangName_mg => '马拉加斯语';

  @override
  String get translateLangName_cy => '威尔士语';

  @override
  String get translateLangName_mn => '蒙古语';

  @override
  String get translateLangName_tl => '他加禄语/菲律宾语';

  @override
  String get translateLangName_ht => '海地克里奥尔语';

  @override
  String get translateLangName_eo => '世界语';

  @override
  String get translateLangName_la => '拉丁语';

  @override
  String get translateLangName_ku => '库尔德语';

  @override
  String get translateLangName_ps => '普什图语';

  @override
  String get translateLangName_faAf => '达里语';

  @override
  String get translateLangName_bs => '波斯尼亚语';

  @override
  String get translateLangName_mi => '毛利语';

  @override
  String get translateLangName_sm => '萨摩亚语';

  @override
  String get translateLangName_haw => '夏威夷语';

  @override
  String get translateLangName_lb => '卢森堡语';
}
