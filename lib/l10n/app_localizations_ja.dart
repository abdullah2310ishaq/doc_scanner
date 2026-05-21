// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ドキュメントスキャナー';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '削除';

  @override
  String get commonShare => '共有';

  @override
  String get commonCopy => 'コピー';

  @override
  String get commonRetry => '再試行';

  @override
  String get commonClose => '閉じる';

  @override
  String get commonLoading => '読み込み中…';

  @override
  String get commonError => 'エラーが発生しました';

  @override
  String get commonTryAgain => 'もう一度お試しください';

  @override
  String get navHome => 'ホーム';

  @override
  String get navScan => 'スキャン';

  @override
  String get navDocuments => 'ドキュメント';

  @override
  String get navTranslate => '翻訳';

  @override
  String get navLive => 'ライブ';

  @override
  String get navSettings => '設定';

  @override
  String homeGreeting(String name) {
    return 'おはようございます、$name 👋';
  }

  @override
  String get homeTitlePrefix => 'AIドキュメント';

  @override
  String get homeTitleHighlight => 'スキャナー';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'メニューを開く';

  @override
  String get homeTagAiPowered => 'AI搭載';

  @override
  String get homeTagFastOcr => '高速OCR';

  @override
  String get homeTagSecure => '安全';

  @override
  String get homeTagSmartCrop => 'スマートトリミング';

  @override
  String get homeHeroBadge => 'AI搭載';

  @override
  String get homeHeroTitle => 'スマートOCR\nスキャナー';

  @override
  String get homeHeroSubtitle => 'AI OCRで高速かつ正確に文字を認識します。';

  @override
  String get homeHeroButton => 'OCRスキャン';

  @override
  String get homeSearchHint => '検索';

  @override
  String get homeFeatureOcrTitle => 'OCRスキャナー';

  @override
  String get homeFeatureOcrSubtitle => '画像や書類からテキスト抽出';

  @override
  String get homeFeaturePdfTitle => 'PDFアシスタント';

  @override
  String get homeFeaturePdfSubtitle => '翻訳とテキスト抽出';

  @override
  String get homeFeatureChatbotTitle => 'AIチャットボット';

  @override
  String get homeFeatureChatbotSubtitle => 'PDFをアップロードして質問';

  @override
  String get homeFeatureCropTitle => 'スマートトリミング';

  @override
  String get homeFeatureCropSubtitle => '自動補正と改善';

  @override
  String get homeRecentDocuments => '最近のドキュメント';

  @override
  String get homeSeeAll => 'すべて見る';

  @override
  String get homeEmptyDocuments => 'ドキュメントがありません。スキャンを開始してください。';

  @override
  String get homeSampleDocName => '請求書_2026.pdf';

  @override
  String get homeSampleDocMeta => '2026年5月10日 • 2.4MB';

  @override
  String get scanTitle => 'スキャン';

  @override
  String get scanCapture => '撮影';

  @override
  String get scanImportGallery => 'ギャラリーから';

  @override
  String get scanImportFiles => 'ファイルを読み込む';

  @override
  String get scanAddPage => 'ページ追加';

  @override
  String get scanRetake => '再撮影';

  @override
  String get scanCrop => 'トリミング';

  @override
  String get scanEnhance => '補正';

  @override
  String get scanDone => '完了';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countページ',
      one: '1ページ',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => '保存中…';

  @override
  String get scanSaved => '保存しました';

  @override
  String get ocrTitle => '文字認識';

  @override
  String get ocrRun => 'テキスト認識';

  @override
  String get ocrRunning => '読み取り中…';

  @override
  String get ocrEmpty => 'テキストが見つかりません';

  @override
  String get ocrCopySuccess => 'コピーしました';

  @override
  String get ocrEditHint => '認識テキストを編集';

  @override
  String get ocrInputMethodTitle => '入力方法を選択';

  @override
  String get ocrInputMethodSubtitle => 'テキスト抽出方法を選択';

  @override
  String get ocrInputLiveCameraTitle => 'ライブカメラ';

  @override
  String get ocrInputLiveCameraDescription => 'カメラで撮影';

  @override
  String get ocrInputUploadImageTitle => '画像アップロード';

  @override
  String get ocrInputUploadImageDescription => 'ギャラリーから選択';

  @override
  String get ocrLiveCameraTitle => 'ライブOCRカメラ';

  @override
  String get ocrLiveCameraTip => 'ヒント：明るい場所で使用してください';

  @override
  String get ocrLiveCameraClose => 'カメラを閉じる';

  @override
  String get ocrLiveCameraFlash => 'フラッシュ';

  @override
  String get ocrLiveCameraCapture => '撮影';

  @override
  String get ocrLiveCameraInitializing => 'カメラ起動中…';

  @override
  String get ocrAnalyzeTitle => 'OCR解析';

  @override
  String get ocrAnalyzeCopy => 'コピー';

  @override
  String get ocrAnalyzeTranslate => '翻訳';

  @override
  String get ocrAnalyzeProcessing => '解析中…';

  @override
  String get ocrAnalyzeTranslateNext => '翻訳を開く';

  @override
  String get ocrNoTextTitle => 'テキストなし';

  @override
  String get ocrNoTextHint => 'より鮮明な画像を使用してください';

  @override
  String get ocrNoTextRetakePhoto => '再撮影';

  @override
  String get ocrNoTextChooseGallery => 'ギャラリー選択';

  @override
  String get translateTitle => '翻訳';

  @override
  String get translateSourceLanguage => '元';

  @override
  String get translateTargetLanguage => '先';

  @override
  String get translateSwapLanguages => '言語を入れ替え';

  @override
  String get translateButton => '翻訳';

  @override
  String get translateRunning => '翻訳中…';

  @override
  String get translatePasteHint => 'テキスト入力または貼り付け';

  @override
  String get translateCopyResult => '翻訳をコピー';

  @override
  String get translateResultTitle => '翻訳結果';

  @override
  String get translateResultSubtitle => 'テキストを任意の言語に翻訳';

  @override
  String get translateSelectedText => '選択テキスト';

  @override
  String get translateSelectedLanguage => '選択言語';

  @override
  String get translateSelectLanguage => '言語を選択';

  @override
  String get translateSearchLanguage => '言語を検索';

  @override
  String get translateRecentLanguages => '最近';

  @override
  String get translateNoLanguagesFound => '言語が見つかりません';

  @override
  String get translateTranslatedText => '翻訳テキスト';

  @override
  String get translatePlaceholder => 'ここに翻訳が表示されます…';

  @override
  String get translateSeeMore => 'もっと見る';

  @override
  String get translateReadAloud => '読み上げ';

  @override
  String get translateSavePdf => 'PDF保存';

  @override
  String get translateSavePng => '画像保存';

  @override
  String get translateSaveComingSoon => '近日公開';

  @override
  String get translateDownloadOptionTitle => 'ダウンロード選択';

  @override
  String get translateDownloadOptionSubtitle => 'ダウンロード内容を選択';

  @override
  String get translateDownloadSelectedTextTitle => '選択テキストをダウンロード';

  @override
  String get translateDownloadSelectedTextDescription => '選択部分のみ';

  @override
  String get translateDownloadCompleteFileTitle => 'ファイル全体をダウンロード';

  @override
  String get translateDownloadCompleteFileDescription => '全文書';

  @override
  String get translateSavePdfSuccess => 'PDFを保存しました';

  @override
  String get translateSavePngSuccess => '画像を保存しました';

  @override
  String get translateExportNeedsTranslation => '先に翻訳してください';

  @override
  String get liveTitle => 'ライブ翻訳';

  @override
  String get liveStart => 'カメラ開始';

  @override
  String get liveStop => '停止';

  @override
  String get liveListening => '認識中…';

  @override
  String get livePointAtText => 'テキストを映してください';

  @override
  String get livePermissionNeeded => 'カメラ権限が必要です';

  @override
  String get documentsTitle => 'マイドキュメント';

  @override
  String get documentRename => '名前変更';

  @override
  String get documentDeleteConfirmTitle => '削除しますか？';

  @override
  String get documentDeleteConfirmMessage => 'この操作は取り消せません。';

  @override
  String get documentDeleted => '削除しました';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => 'アプリ言語';

  @override
  String get settingsTheme => 'テーマ';

  @override
  String get settingsAbout => 'アプリについて';

  @override
  String get settingsPrivacy => 'プライバシー';

  @override
  String get settingsTerms => '利用規約';

  @override
  String get permissionCameraTitle => 'カメラ権限';

  @override
  String get permissionCameraMessage => 'スキャンのためにカメラを許可してください。';

  @override
  String get permissionStorageTitle => 'ストレージ権限';

  @override
  String get permissionStorageMessage => 'ファイル保存を許可してください。';

  @override
  String get permissionOpenSettings => '設定を開く';

  @override
  String get permissionDenied => '権限が拒否されました';

  @override
  String get errorCameraUnavailable => 'カメラが利用できません';

  @override
  String get errorFileRead => 'ファイルを読み込めません';

  @override
  String get errorNetwork => 'インターネット接続を確認してください';

  @override
  String get errorNoInternetFeatures => 'インターネット接続がありません';

  @override
  String get exitAppTitle => 'アプリ終了';

  @override
  String get exitAppMessage => '終了しますか？';

  @override
  String get exitAppConfirm => '終了';

  @override
  String get errorOcrFailed => 'OCRに失敗しました';

  @override
  String get errorTranslateFailed => '翻訳に失敗しました';

  @override
  String get errorTranslateModelDownload => '言語パックのダウンロードに失敗しました';

  @override
  String get errorTranslateUnsupportedLanguage => 'この言語は未対応です';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => '無制限スキャンとOCR';

  @override
  String get proUpgradeButton => 'Proにアップグレード';

  @override
  String get proRestorePurchases => '購入を復元';

  @override
  String get proFeatureLocked => 'Pro機能';

  @override
  String proLimitPages(int max) {
    return '無料版は最大$maxページまで';
  }

  @override
  String get proLimitOcr => 'ProでOCR無制限';

  @override
  String get proLimitTranslate => '全言語対応（Pro）';

  @override
  String get proLimitLive => 'ライブ翻訳はPro限定';

  @override
  String get proPurchaseSuccess => 'Proへようこそ！';

  @override
  String get proPurchaseFailed => '購入に失敗しました';

  @override
  String get exportPdf => 'PDFエクスポート';

  @override
  String get exportImage => '画像エクスポート';

  @override
  String get exportSuccess => 'エクスポート完了';

  @override
  String get exportFailed => 'エクスポート失敗';

  @override
  String get languageSearchHint => '言語検索';

  @override
  String get languageAuto => '自動検出';

  @override
  String get chatbotTitle => 'AIチャットボット';

  @override
  String get chatbotHistoryButton => '履歴';

  @override
  String get chatbotBadge => 'スマートAIアシスタント';

  @override
  String get chatbotHeadlineChat => 'チャット';

  @override
  String get chatbotHeadlineMiddle => ' と ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => '質問例';

  @override
  String get chatbotSuggestSummarize => 'PDF要約';

  @override
  String get chatbotSuggestKeyPoints => '重要ポイント';

  @override
  String get chatbotSuggestExplain => '詳しく説明';

  @override
  String get chatbotSuggestTranslate => 'PDF翻訳';

  @override
  String get chatbotUploadHint => 'PDFをアップロード...';

  @override
  String get chatbotSheetTitle => 'PDFチャット';

  @override
  String get chatbotSheetSubtitle => 'PDFをアップロードして質問';

  @override
  String get chatbotChoosePdfTitle => 'PDF選択';

  @override
  String get chatbotChoosePdfDescription => '端末から選択';

  @override
  String get chatbotRecentFilesTitle => '最近のファイル';

  @override
  String get chatbotRecentFilesDescription => '最近から選択';

  @override
  String get errorChatbotPdfPickFailed => 'PDFを開けません';

  @override
  String get chatbotAnalyzingTitle => '解析中...';

  @override
  String get chatbotAnalyzingSubtitle => 'しばらくお待ちください';

  @override
  String get chatbotStepReadingPdf => 'PDF読み込み';

  @override
  String get chatbotStepExtractingText => 'テキスト抽出';

  @override
  String get chatbotStepUnderstandingContent => '内容理解';

  @override
  String get chatbotStepPreparingChat => 'チャット準備';

  @override
  String get chatbotHistoryTitle => '履歴';

  @override
  String get chatbotNoConversationsTitle => '会話なし';

  @override
  String get chatbotNoConversationsSubtitle => 'PDFをアップロードしてください';

  @override
  String get chatbotUploadPdfButton => 'PDFアップロード';

  @override
  String get chatbotDocumentReadyTitle => '準備完了';

  @override
  String get chatbotDocumentReadySubtitle => '簡単な要約';

  @override
  String get chatbotCurrentSummary => '現在の要約';

  @override
  String get chatbotStartChatting => 'チャット開始';

  @override
  String get chatbotChatGreeting => '👋🏻 こんにちは！PDFについて質問してください。';

  @override
  String get chatbotChatYouCanAsk => '質問例：';

  @override
  String get chatbotChatPromptSummarize => '要約する';

  @override
  String get chatbotChatPromptHighlights => '重要ポイント';

  @override
  String get chatbotChatPromptFinancial => '財務データ';

  @override
  String get chatbotChatPromptDates => '重要な日付';

  @override
  String get chatbotChatInputHint => 'PDFについて質問…';

  @override
  String get chatbotDeleteTitle => 'チャットを削除？';

  @override
  String get chatbotDeleteMessage => 'この操作は元に戻せません。';

  @override
  String get chatbotRenameTitle => 'PDF名変更';

  @override
  String get chatbotRenameHint => '名前を入力';

  @override
  String get chatbotAnalyzeFailed => '解析失敗';

  @override
  String get chatbotChatFailed => '応答失敗';

  @override
  String get errorChatbotPdfEmpty => 'テキストなし';

  @override
  String get pdfAssistantTitle => 'PDFアシスタント';

  @override
  String get pdfAssistantSheetTitle => 'PDFをアップロード';

  @override
  String get pdfAssistantSheetSubtitle => 'PDFファイルの追加方法を選択してください';

  @override
  String get pdfAssistantChoosePdfTitle => 'PDF選択';

  @override
  String get pdfAssistantChoosePdfDescription => '端末から選択';

  @override
  String get pdfAssistantLinkTitle => 'PDFリンク追加';

  @override
  String get pdfAssistantLinkDescription => 'PDFリンクを貼り付けて直接アップロード';

  @override
  String get pdfAssistantLinkHint => 'URL貼り付け';

  @override
  String get pdfAssistantLinkButton => 'ダウンロード';

  @override
  String get pdfAssistantTranslateTo => '翻訳先';

  @override
  String get pdfAssistantStartProcessing => '開始';

  @override
  String get pdfAssistantNoFileSelected => 'ファイルなし';

  @override
  String get pdfAssistantSelectLanguage => '言語を選択';

  @override
  String get pdfAssistantProcessingTitle => '処理中…';

  @override
  String get pdfAssistantProcessingSubtitle => 'お待ちください';

  @override
  String get pdfAssistantStepExtracting => '抽出中…';

  @override
  String get pdfAssistantStepTranslating => '翻訳中…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'PDF生成中…';

  @override
  String get pdfAssistantStepFinalizing => '最終処理中…';

  @override
  String get pdfAssistantResultTitle => '結果';

  @override
  String get pdfAssistantTranslatedPdfTitle => '翻訳PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => '元レイアウト保持';

  @override
  String get pdfAssistantExtractedTextTitle => '抽出テキスト';

  @override
  String get pdfAssistantExtractedTextDescription => 'シンプル文書';

  @override
  String get pdfAssistantActionOpen => '開く';

  @override
  String get pdfAssistantActionDownload => 'ダウンロード';

  @override
  String get pdfAssistantDeleteTitle => '削除？';

  @override
  String get pdfAssistantDeleteMessage => '元に戻せません';

  @override
  String get pdfAssistantDownloadSuccess => '保存しました';

  @override
  String get pdfAssistantOpenFailed => '開けません';

  @override
  String get pdfAssistantProcessFailed => '処理失敗';

  @override
  String get errorPdfAssistantPickFailed => '選択失敗';

  @override
  String get errorPdfAssistantLinkFailed => 'リンクエラー';

  @override
  String get errorPdfAssistantPdfEmpty => '空のPDF';

  @override
  String get pdfAssistantRemoveTitle => 'PDFを削除';

  @override
  String get pdfAssistantRemoveWarning => 'デバイスからPDFが削除されます。';

  @override
  String get pdfAssistantUploadPdf => 'PDFをアップロード';

  @override
  String get cancel => 'キャンセル';

  @override
  String get remove => '削除';

  @override
  String get commonNext => '次へ';

  @override
  String get commonSkip => 'スキップ';

  @override
  String get commonContinue => '続ける';

  @override
  String get splashTagline => 'AI搭載ドキュメントスキャナー';

  @override
  String get onboardingPage1Title => '文書をスキャン';

  @override
  String get onboardingPage1Description => 'レシートやメモを素早く撮影。';

  @override
  String get onboardingPage2Title => 'OCRと翻訳';

  @override
  String get onboardingPage2Description => 'テキスト抽出と翻訳。';

  @override
  String get onboardingPage3Title => '保存とエクスポート';

  @override
  String get onboardingPage3Description => '簡単に管理できます。';

  @override
  String get settingsChooseLanguage => '言語選択';

  @override
  String get settingsLanguageApply => '適用';

  @override
  String get commonSaving => '保存中…';
}
