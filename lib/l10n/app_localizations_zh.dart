// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '文档扫描器';

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
  String get commonLoading => '加载中…';

  @override
  String get commonError => '出现错误';

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
  String get navLive => '实时';

  @override
  String get navSettings => '设置';

  @override
  String homeGreeting(String name) {
    return '早上好，$name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI 文档';

  @override
  String get homeTitleHighlight => '扫描器';

  @override
  String get homeProBadge => '专业版';

  @override
  String get homeMenuButton => '打开菜单';

  @override
  String get homeTagAiPowered => 'AI 驱动';

  @override
  String get homeTagFastOcr => '快速OCR';

  @override
  String get homeTagSecure => '安全';

  @override
  String get homeTagSmartCrop => '智能裁剪';

  @override
  String get homeHeroBadge => 'AI 驱动';

  @override
  String get homeHeroTitle => '智能OCR\n扫描器';

  @override
  String get homeHeroSubtitle => 'AI OCR快速精准识别文字，仅需几秒。';

  @override
  String get homeHeroButton => 'OCR扫描';

  @override
  String get homeSearchHint => '搜索';

  @override
  String get homeFeatureOcrTitle => 'OCR扫描';

  @override
  String get homeFeatureOcrSubtitle => '从图片或文档提取文字';

  @override
  String get homeFeaturePdfTitle => 'PDF助手';

  @override
  String get homeFeaturePdfSubtitle => '翻译与转写PDF';

  @override
  String get homeFeatureChatbotTitle => 'AI聊天机器人';

  @override
  String get homeFeatureChatbotSubtitle => '上传PDF并提问';

  @override
  String get homeFeatureCropTitle => '智能裁剪';

  @override
  String get homeFeatureCropSubtitle => '自动裁剪与增强';

  @override
  String get homeRecentDocuments => '最近文档';

  @override
  String get homeSeeAll => '查看全部';

  @override
  String get homeEmptyDocuments => '暂无文档，点击扫描开始。';

  @override
  String get homeSampleDocName => '发票_2026.pdf';

  @override
  String get homeSampleDocMeta => '2026年5月10日 • 2.4 MB';

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
  String get scanEnhance => '增强';

  @override
  String get scanDone => '完成';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count页',
      one: '1页',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => '正在保存扫描…';

  @override
  String get scanSaved => '文档已保存';

  @override
  String get ocrTitle => '文字识别';

  @override
  String get ocrRun => '识别文字';

  @override
  String get ocrRunning => '正在读取文字…';

  @override
  String get ocrEmpty => '未找到文字';

  @override
  String get ocrCopySuccess => '已复制';

  @override
  String get ocrEditHint => '编辑识别文本';

  @override
  String get ocrInputMethodTitle => '选择输入方式';

  @override
  String get ocrInputMethodSubtitle => '选择提取文字的方式';

  @override
  String get ocrInputLiveCameraTitle => '实时相机';

  @override
  String get ocrInputLiveCameraDescription => '使用相机拍摄';

  @override
  String get ocrInputUploadImageTitle => '上传图片';

  @override
  String get ocrInputUploadImageDescription => '从相册选择';

  @override
  String get ocrLiveCameraTitle => '实时OCR相机';

  @override
  String get ocrLiveCameraTip => '提示：光线充足效果更佳';

  @override
  String get ocrLiveCameraClose => '关闭相机';

  @override
  String get ocrLiveCameraFlash => '闪光灯切换';

  @override
  String get ocrLiveCameraCapture => '拍摄识别';

  @override
  String get ocrLiveCameraInitializing => '正在启动相机…';

  @override
  String get ocrAnalyzeTitle => 'OCR扫描';

  @override
  String get ocrAnalyzeCopy => '复制';

  @override
  String get ocrAnalyzeTranslate => '翻译';

  @override
  String get ocrAnalyzeProcessing => '正在分析…';

  @override
  String get ocrAnalyzeTranslateNext => '正在打开翻译';

  @override
  String get ocrNoTextTitle => '未检测到文字';

  @override
  String get ocrNoTextHint => '请尝试更清晰的图片';

  @override
  String get ocrNoTextRetakePhoto => '重新拍摄';

  @override
  String get ocrNoTextChooseGallery => '选择相册';

  @override
  String get translateTitle => '翻译';

  @override
  String get translateSourceLanguage => '源语言';

  @override
  String get translateTargetLanguage => '目标语言';

  @override
  String get translateSwapLanguages => '切换语言';

  @override
  String get translateButton => '翻译';

  @override
  String get translateRunning => '翻译中…';

  @override
  String get translatePasteHint => '输入或粘贴文本';

  @override
  String get translateCopyResult => '复制翻译';

  @override
  String get translateResultTitle => '翻译结果';

  @override
  String get translateResultSubtitle => '将文本翻译为任意语言';

  @override
  String get translateSelectedText => '选中文本';

  @override
  String get translateSelectedLanguage => '选择语言';

  @override
  String get translateSelectLanguage => '选择语言';

  @override
  String get translateSearchLanguage => '搜索语言';

  @override
  String get translateRecentLanguages => '最近';

  @override
  String get translateNoLanguagesFound => '未找到语言';

  @override
  String get translateTranslatedText => '翻译文本';

  @override
  String get translatePlaceholder => '翻译将显示在这里…';

  @override
  String get translateSeeMore => '查看更多';

  @override
  String get translateReadAloud => '朗读';

  @override
  String get translateSavePdf => '保存PDF';

  @override
  String get translateSavePng => '保存图片';

  @override
  String get translateSaveComingSoon => '即将上线';

  @override
  String get translateDownloadOptionTitle => '选择下载方式';

  @override
  String get translateDownloadOptionSubtitle => '选择要下载的内容';

  @override
  String get translateDownloadSelectedTextTitle => '下载选中文本';

  @override
  String get translateDownloadSelectedTextDescription => '仅下载选中文本';

  @override
  String get translateDownloadCompleteFileTitle => '下载完整文件';

  @override
  String get translateDownloadCompleteFileDescription => '下载整个文件';

  @override
  String get translateSavePdfSuccess => 'PDF保存成功';

  @override
  String get translateSavePngSuccess => '图片保存成功';

  @override
  String get translateExportNeedsTranslation => '请先翻译文本';

  @override
  String get liveTitle => '实时翻译';

  @override
  String get liveStart => '启动相机';

  @override
  String get liveStop => '停止';

  @override
  String get liveListening => '识别中…';

  @override
  String get livePointAtText => '对准文字';

  @override
  String get livePermissionNeeded => '需要相机权限';

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
  String get settingsTerms => '使用条款';

  @override
  String get permissionCameraTitle => '相机权限';

  @override
  String get permissionCameraMessage => '允许访问相机以扫描文档。';

  @override
  String get permissionStorageTitle => '存储权限';

  @override
  String get permissionStorageMessage => '允许保存文件。';

  @override
  String get permissionOpenSettings => '打开设置';

  @override
  String get permissionDenied => '权限被拒绝';

  @override
  String get errorCameraUnavailable => '相机不可用';

  @override
  String get errorFileRead => '无法读取文件';

  @override
  String get errorNetwork => '请检查网络连接';

  @override
  String get errorNoInternetFeatures => '无网络连接';

  @override
  String get exitAppTitle => '退出应用';

  @override
  String get exitAppMessage => '确定要退出吗？';

  @override
  String get exitAppConfirm => '退出';

  @override
  String get errorOcrFailed => 'OCR失败';

  @override
  String get errorTranslateFailed => '翻译失败';

  @override
  String get errorTranslateModelDownload => '语言包下载失败';

  @override
  String get errorTranslateUnsupportedLanguage => '不支持该语言';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => '无限扫描与OCR';

  @override
  String get proUpgradeButton => '升级专业版';

  @override
  String get proRestorePurchases => '恢复购买';

  @override
  String get proFeatureLocked => '专业功能';

  @override
  String proLimitPages(int max) {
    return '免费版最多 $max 页';
  }

  @override
  String get proLimitOcr => '专业版无限OCR';

  @override
  String get proLimitTranslate => '专业版支持所有语言';

  @override
  String get proLimitLive => '实时翻译仅限专业版';

  @override
  String get proPurchaseSuccess => '欢迎使用专业版！';

  @override
  String get proPurchaseFailed => '购买失败';

  @override
  String get exportPdf => '导出PDF';

  @override
  String get exportImage => '导出图片';

  @override
  String get exportSuccess => '导出成功';

  @override
  String get exportFailed => '导出失败';

  @override
  String get languageSearchHint => '搜索语言';

  @override
  String get languageAuto => '自动检测';

  @override
  String get chatbotTitle => 'AI聊天机器人';

  @override
  String get chatbotHistoryButton => '历史记录';

  @override
  String get chatbotBadge => '智能AI助手';

  @override
  String get chatbotHeadlineChat => '聊天';

  @override
  String get chatbotHeadlineMiddle => ' 与你的 ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => '试试问';

  @override
  String get chatbotSuggestSummarize => '总结PDF';

  @override
  String get chatbotSuggestKeyPoints => '关键点';

  @override
  String get chatbotSuggestExplain => '详细解释';

  @override
  String get chatbotSuggestTranslate => '翻译PDF';

  @override
  String get chatbotUploadHint => '上传PDF...';

  @override
  String get chatbotSheetTitle => 'PDF聊天';

  @override
  String get chatbotSheetSubtitle => '上传PDF并提问';

  @override
  String get chatbotChoosePdfTitle => '选择PDF';

  @override
  String get chatbotChoosePdfDescription => '从设备选择';

  @override
  String get chatbotRecentFilesTitle => '最近文件';

  @override
  String get chatbotRecentFilesDescription => '选择最近文件';

  @override
  String get errorChatbotPdfPickFailed => '无法打开PDF';

  @override
  String get chatbotAnalyzingTitle => '正在分析文档...';

  @override
  String get chatbotAnalyzingSubtitle => '请稍候';

  @override
  String get chatbotStepReadingPdf => '读取PDF';

  @override
  String get chatbotStepExtractingText => '提取文本';

  @override
  String get chatbotStepUnderstandingContent => '理解内容';

  @override
  String get chatbotStepPreparingChat => '准备聊天';

  @override
  String get chatbotHistoryTitle => '历史';

  @override
  String get chatbotNoConversationsTitle => '暂无对话';

  @override
  String get chatbotNoConversationsSubtitle => '上传PDF开始聊天';

  @override
  String get chatbotUploadPdfButton => '上传PDF';

  @override
  String get chatbotDocumentReadyTitle => '文档已准备';

  @override
  String get chatbotDocumentReadySubtitle => '快速摘要';

  @override
  String get chatbotCurrentSummary => '当前摘要';

  @override
  String get chatbotStartChatting => '开始聊天';

  @override
  String get chatbotChatGreeting => '👋🏻 你好！可以问我关于PDF的问题。';

  @override
  String get chatbotChatYouCanAsk => '你可以问：';

  @override
  String get chatbotChatPromptSummarize => '总结文档';

  @override
  String get chatbotChatPromptHighlights => '关键点';

  @override
  String get chatbotChatPromptFinancial => '财务数据';

  @override
  String get chatbotChatPromptDates => '重要日期';

  @override
  String get chatbotChatInputHint => '询问PDF内容...';

  @override
  String get chatbotDeleteTitle => '删除聊天？';

  @override
  String get chatbotDeleteMessage => '无法撤销。';

  @override
  String get chatbotRenameTitle => '重命名PDF';

  @override
  String get chatbotRenameHint => '输入名称';

  @override
  String get chatbotAnalyzeFailed => '分析失败';

  @override
  String get chatbotChatFailed => '回复失败';

  @override
  String get errorChatbotPdfEmpty => '未找到文本';

  @override
  String get pdfAssistantTitle => 'PDF助手';

  @override
  String get pdfAssistantSheetTitle => 'PDF助手';

  @override
  String get pdfAssistantSheetSubtitle => '翻译PDF';

  @override
  String get pdfAssistantChoosePdfTitle => '选择PDF';

  @override
  String get pdfAssistantChoosePdfDescription => '从设备选择';

  @override
  String get pdfAssistantLinkTitle => '添加PDF链接';

  @override
  String get pdfAssistantLinkHint => '粘贴URL';

  @override
  String get pdfAssistantLinkButton => '下载';

  @override
  String get pdfAssistantTranslateTo => '翻译为';

  @override
  String get pdfAssistantStartProcessing => '开始';

  @override
  String get pdfAssistantNoFileSelected => '未选择文件';

  @override
  String get pdfAssistantSelectLanguage => '请选择语言';

  @override
  String get pdfAssistantProcessingTitle => '处理中…';

  @override
  String get pdfAssistantProcessingSubtitle => '请稍候';

  @override
  String get pdfAssistantStepExtracting => '提取中…';

  @override
  String get pdfAssistantStepTranslating => '翻译中…';

  @override
  String get pdfAssistantStepGeneratingPdf => '生成PDF…';

  @override
  String get pdfAssistantStepFinalizing => '完成中…';

  @override
  String get pdfAssistantResultTitle => '结果';

  @override
  String get pdfAssistantTranslatedPdfTitle => '已翻译PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => '原始布局';

  @override
  String get pdfAssistantExtractedTextTitle => '提取文本';

  @override
  String get pdfAssistantExtractedTextDescription => '简单文档';

  @override
  String get pdfAssistantActionOpen => '打开';

  @override
  String get pdfAssistantActionDownload => '下载';

  @override
  String get pdfAssistantDeleteTitle => '删除？';

  @override
  String get pdfAssistantDeleteMessage => '无法撤销';

  @override
  String get pdfAssistantDownloadSuccess => '已保存';

  @override
  String get pdfAssistantOpenFailed => '无法打开';

  @override
  String get pdfAssistantProcessFailed => '处理失败';

  @override
  String get errorPdfAssistantPickFailed => '选择失败';

  @override
  String get errorPdfAssistantLinkFailed => '链接无效';

  @override
  String get errorPdfAssistantPdfEmpty => '空PDF';

  @override
  String get commonNext => '下一步';

  @override
  String get commonSkip => '跳过';

  @override
  String get commonContinue => '继续';

  @override
  String get splashTagline => 'AI驱动文档扫描';

  @override
  String get onboardingPage1Title => '扫描任何文档';

  @override
  String get onboardingPage1Description => '快速捕捉收据和笔记。';

  @override
  String get onboardingPage2Title => 'OCR与翻译';

  @override
  String get onboardingPage2Description => '提取并翻译文本。';

  @override
  String get onboardingPage3Title => '保存与导出';

  @override
  String get onboardingPage3Description => '集中管理文件。';

  @override
  String get settingsChooseLanguage => '选择语言';

  @override
  String get settingsLanguageApply => '应用';
}
