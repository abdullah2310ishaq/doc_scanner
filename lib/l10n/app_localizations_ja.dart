// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'キャンセル';

  @override
  String get commonSave => '保存';

  @override
  String get commonDelete => '消去';

  @override
  String get commonShare => '共有';

  @override
  String get commonCopy => 'コピー';

  @override
  String get commonRetry => 'リトライ';

  @override
  String get commonClose => '近い';

  @override
  String get commonDone => '完了';

  @override
  String get commonLoading => '読み込み中…';

  @override
  String get commonError => '何か問題が発生しました';

  @override
  String get commonTryAgain => 'もう一度試してください';

  @override
  String get navHome => '家';

  @override
  String get navScan => 'スキャン';

  @override
  String get navDocuments => '書類';

  @override
  String get navTranslate => '翻訳する';

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
  String get homeTagAiPowered => 'AI を活用した';

  @override
  String get homeTagFastOcr => '高速OCR';

  @override
  String get homeTagSecure => '安全な';

  @override
  String get homeTagSmartCrop => 'スマートクロップ';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => 'スマートAI OCR\nスキャナー';

  @override
  String get homeHeroSubtitle => 'AI を活用した OCR により、数秒で高速かつ正確なテキスト認識が可能です。';

  @override
  String get homeHeroButton => 'OCRスキャナ';

  @override
  String get homeSearchHint => 'ここで検索してください';

  @override
  String get homeFeatureOcrTitle => 'OCRスキャナ';

  @override
  String get homeFeatureOcrSubtitle => '画像またはドキュメントからテキストをスキャン';

  @override
  String get homeFeaturePdfTitle => 'PDFアシスタント';

  @override
  String get homeFeaturePdfSubtitle => 'PDFの翻訳と転写';

  @override
  String get homeFeatureChatbotTitle => 'PDFに質問';

  @override
  String get homeFeatureChatbotSubtitle => 'PDFをアップロードして質問する';

  @override
  String get homeFeatureCropTitle => 'スマートクロップ';

  @override
  String get homeFeatureCropSubtitle => '自動トリミング、クリーン、補正';

  @override
  String get homeRecentDocuments => 'キュメント';

  @override
  String get homeSeeAll => 'すべて見る';

  @override
  String get homeEmptyDocuments => 'まだ書類がありません。 「スキャン」をタップして開始します。';

  @override
  String get homeSampleDocName => 'Invoice_2026.pdf';

  @override
  String get homeSampleDocMeta => 'May 10, 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => '画像';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個のファイル',
      one: '1個のファイル',
      zero: '0個のファイル',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count個のファイル',
      one: '1個のファイル',
      zero: '0個のファイル',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDFs';

  @override
  String get homeRecentImagesTitle => '画像';

  @override
  String get homeRecentAdded => '最近追加されたもの';

  @override
  String get homeRecentSelect => '選択';

  @override
  String get homeRecentSelectAll => 'すべて選択';

  @override
  String get homeRecentDeselectAll => '選択解除';

  @override
  String get homeRecentSearchPdfs => 'PDF を検索…';

  @override
  String get homeRecentSearchImages => '画像を検索してください…';

  @override
  String get homeRecentNoSearchResults => '検索に一致するファイルはありません';

  @override
  String get homeRecentToggleFavorite => 'お気に入り';

  @override
  String get homeRecentUnfavorite => '気に入らない';

  @override
  String get homeRecentFavoriteAdded => 'お気に入りに追加しました';

  @override
  String get homeRecentFavoriteRemoved => 'お気に入りから削除しました';

  @override
  String get homeRecentPdfEmptyTitle => 'PDFはまだありません';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'ドキュメントをアップロードまたはスキャンして、最初の PDF を作成します';

  @override
  String get homeRecentImageEmptyTitle => 'まだ画像がありません';

  @override
  String get homeRecentImageEmptySubtitle => '画像をアップロードまたはスキャンしてここで整理します';

  @override
  String get homeRecentUploadPdf => 'PDFをアップロードする';

  @override
  String get homeRecentUploadImages => '画像をアップロードする';

  @override
  String get homeRecentScanDocument => 'ドキュメントをスキャンする';

  @override
  String get scanTitle => 'スキャン';

  @override
  String get scanCapture => '捕獲';

  @override
  String get scanImportGallery => 'ギャラリーからインポート';

  @override
  String get scanImportFiles => 'インポートファイル';

  @override
  String get scanAddPage => 'ページを追加';

  @override
  String get scanRetake => 'リテイク';

  @override
  String get scanCrop => '作物';

  @override
  String get scanEnhance => '強化する';

  @override
  String get scanDone => '終わり';

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
  String get scanSaving => 'スキャンを保存中…';

  @override
  String get scanSaved => '文書が保存されました';

  @override
  String get ocrTitle => 'テキスト認識';

  @override
  String get ocrRun => 'テキストを認識する';

  @override
  String get ocrRunning => 'テキストを読んでいます…';

  @override
  String get ocrEmpty => 'この画像にはテキストが見つかりません';

  @override
  String get ocrCopySuccess => 'コピーされたテキスト';

  @override
  String get ocrEditHint => '認識されたテキストを編集する';

  @override
  String get ocrInputMethodTitle => '入力方法の選択';

  @override
  String get ocrInputMethodSubtitle => 'テキストを抽出する方法を選択します';

  @override
  String get ocrInputLiveCameraTitle => 'ライブカメラ';

  @override
  String get ocrInputLiveCameraDescription => 'カメラを使用してライブ画像をキャプチャする';

  @override
  String get ocrInputUploadImageTitle => '画像をアップロードする';

  @override
  String get ocrInputUploadImageDescription => 'ギャラリーから画像をアップロード';

  @override
  String get ocrLiveCameraTitle => 'ライブOCRカメラ';

  @override
  String get ocrLiveCameraTip => 'ヒント: より良い結果を得るには、テキストを明るい場所に配置します。';

  @override
  String get ocrLiveCameraClose => 'カメラを閉じる';

  @override
  String get ocrLiveCameraFlash => 'フラッシュの切り替え';

  @override
  String get ocrLiveCameraCapture => 'テキスト認識用に画像をキャプチャする';

  @override
  String get ocrLiveCameraInitializing => 'カメラを起動中…';

  @override
  String get ocrAnalyzeTitle => 'OCRスキャナ';

  @override
  String get ocrAnalyzeCopy => 'コピー';

  @override
  String get ocrAnalyzeTranslate => '翻訳する';

  @override
  String get ocrAnalyzeProcessing => 'テキストを分析中…';

  @override
  String get ocrAnalyzeTranslateNext => '次に翻訳が開きます';

  @override
  String get ocrNoTextTitle => '判読可能なテキストが検出されませんでした';

  @override
  String get ocrNoTextHint => 'より鮮明な画像を試してください';

  @override
  String get ocrNoTextRetakePhoto => '写真を撮り直す';

  @override
  String get ocrNoTextChooseGallery => 'ギャラリーから選ぶ';

  @override
  String get translateTitle => '翻訳する';

  @override
  String get translateSourceLanguage => 'から';

  @override
  String get translateTargetLanguage => 'に';

  @override
  String get translateSwapLanguages => '言語を交換する';

  @override
  String get translateButton => '翻訳する';

  @override
  String get translateRunning => '翻訳中…';

  @override
  String get translatePasteHint => 'テキストを貼り付けるか入力します';

  @override
  String get translateCopyResult => '翻訳をコピーする';

  @override
  String get translateResultTitle => 'テキストを翻訳する';

  @override
  String get translateResultSubtitle => '選択したテキストを任意の言語に翻訳します';

  @override
  String get translateSelectedText => '選択したテキスト';

  @override
  String get translateSelectedLanguage => '選択した言語';

  @override
  String get translateSelectLanguage => '言語の選択';

  @override
  String get translateSearchLanguage => '検索言語';

  @override
  String get translateRecentLanguages => '最近の';

  @override
  String get translateNoLanguagesFound => '言語が見つかりません';

  @override
  String get translateTranslatedText => '翻訳されたテキスト';

  @override
  String get translatePlaceholder => 'ここに翻訳が表示されます。';

  @override
  String get translateSeeMore => 'もっと見る';

  @override
  String get translateReadAloud => '声に出して読む';

  @override
  String get translateSavePdf => 'PDFとして保存';

  @override
  String get translateSavePng => 'PNG として保存';

  @override
  String get translateSaveComingSoon => '保存はすぐに利用可能になります';

  @override
  String get translateDownloadOptionTitle => 'ダウンロードオプションを選択してください';

  @override
  String get translateDownloadOptionSubtitle => 'ダウンロードしたいものを選択してください';

  @override
  String get translateDownloadSelectedTextTitle => '選択したテキストをダウンロードする';

  @override
  String get translateDownloadSelectedTextDescription => '選択したテキストのみをダウンロードする';

  @override
  String get translateDownloadCompleteFileTitle => '完全なファイルをダウンロードする';

  @override
  String get translateDownloadCompleteFileDescription => 'ファイル全体をダウンロードする';

  @override
  String get translateDownloadTranslatedTextTitle => '翻訳されたテキストをダウンロードする';

  @override
  String get translateDownloadTranslatedTextDescription =>
      '翻訳されたテキストのみをダウンロードする';

  @override
  String get translateSavePdfSuccess => 'PDF が正常に保存されました';

  @override
  String get translateSavePngSuccess => '画像は正常に保存されました';

  @override
  String get translateExportNeedsTranslation => 'ダウンロードする前にテキストを翻訳してください';

  @override
  String get liveTitle => 'ライブ翻訳';

  @override
  String get liveStart => 'カメラを起動する';

  @override
  String get liveStop => '停止';

  @override
  String get liveListening => 'リスニング…';

  @override
  String get livePointAtText => 'カメラをテキストに向ける';

  @override
  String get livePermissionNeeded => 'ライブ翻訳にはカメラへのアクセスが必要です';

  @override
  String get documentsTitle => '私の書類';

  @override
  String get documentRename => '名前の変更';

  @override
  String get documentDeleteConfirmTitle => '文書を削除しますか?';

  @override
  String get documentDeleteConfirmMessage => 'これを元に戻すことはできません。';

  @override
  String get documentDeleted => '文書が削除されました';

  @override
  String get settingsTitle => '設定';

  @override
  String get settingsLanguage => 'アプリ言語';

  @override
  String get settingsTheme => 'テーマ';

  @override
  String get settingsAbout => 'について';

  @override
  String get settingsPrivacy => 'プライバシーポリシー';

  @override
  String get settingsTerms => '利用規約';

  @override
  String get settingsContactSupport => 'サポートに連絡';

  @override
  String get settingsMoreApps => 'その他のアプリ';

  @override
  String get settingsRateApp => 'アプリを評価';

  @override
  String get settingsShareApp => 'アプリを共有';

  @override
  String get settingsGreetingPrefix => 'おはよう、';

  @override
  String get settingsDefaultUserName => 'アブドラ';

  @override
  String get permissionCameraTitle => 'カメラの許可';

  @override
  String get permissionCameraMessage =>
      'ドキュメントをスキャンし、ライブ翻訳を使用するためのカメラ アクセスを許可します。';

  @override
  String get permissionStorageTitle => 'ストレージ許可';

  @override
  String get permissionStorageMessage => 'スキャンを保存して開くためのアクセスを許可します。';

  @override
  String get permissionOpenSettings => '設定を開く';

  @override
  String get permissionDenied => '許可が拒否されました';

  @override
  String get errorCameraUnavailable => 'このデバイスではカメラが利用できません';

  @override
  String get errorFileRead => 'ファイルを読み取れませんでした';

  @override
  String get errorNetwork => 'インターネット接続を確認してください';

  @override
  String get errorNoInternetFeatures =>
      'インターネット接続がありません。一部の機能が正しく動作しない可能性があります。';

  @override
  String get exitAppTitle => 'アプリを終了する';

  @override
  String get exitAppMessage => '終了してもよろしいですか?';

  @override
  String get exitAppConfirm => '出口';

  @override
  String get errorOcrFailed => 'テキスト認識に失敗しました';

  @override
  String get errorTranslateFailed => '翻訳に失敗しました';

  @override
  String get errorTranslateModelDownload =>
      '言語パックをダウンロードできませんでした。接続を確認して、もう一度試してください。';

  @override
  String get errorTranslateUnsupportedLanguage => 'この言語はオフライン翻訳には使用できません。';

  @override
  String get proTitle => 'ドキュメントスキャナープロ';

  @override
  String get proSubtitle => '無制限のスキャン、OCR、言語、ライブ翻訳';

  @override
  String get proUpgradeButton => 'プロにアップグレード';

  @override
  String get proRestorePurchases => '購入したものを復元する';

  @override
  String get proFeatureLocked => 'プロの機能';

  @override
  String proLimitPages(int max) {
    return '無料プランでは、ドキュメントあたり最大 $max ページまで許可されます';
  }

  @override
  String get proLimitOcr => 'Pro にアップグレードすると、無制限の OCR が利用できます';

  @override
  String get proLimitTranslate => 'すべての言語で Pro にアップグレード';

  @override
  String get proLimitLive => 'ライブ翻訳はProで利用可能です';

  @override
  String get proPurchaseSuccess => 'プロへようこそ!';

  @override
  String get proPurchaseFailed => '購入を完了できませんでした';

  @override
  String get exportPdf => 'PDFをエクスポート';

  @override
  String get exportImage => '画像のエクスポート';

  @override
  String get exportSuccess => 'エクスポートが完了しました';

  @override
  String get exportFailed => 'エクスポートに失敗しました';

  @override
  String get languageSearchHint => '検索言語';

  @override
  String get languageAuto => '言語の検出';

  @override
  String get chatbotTitle => 'AIチャットボット';

  @override
  String get chatbotHistoryButton => 'チャット履歴';

  @override
  String get chatbotBadge => 'あなたのスマート AI アシスタント';

  @override
  String get chatbotHeadlineChat => 'チャット';

  @override
  String get chatbotHeadlineMiddle => 'あなたと一緒に';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => '聞いてみてください';

  @override
  String get chatbotSuggestSummarize => 'このPDFを要約してください';

  @override
  String get chatbotSuggestKeyPoints => 'この PDF の重要なポイント';

  @override
  String get chatbotSuggestExplain => '詳しく説明してください';

  @override
  String get chatbotSuggestTranslate => 'この PDF を翻訳する';

  @override
  String get chatbotAskQuestions => 'この PDF について質問する';

  @override
  String get chatbotUploadHint => 'PDF をアップロード...';

  @override
  String get chatbotSheetTitle => 'PDF を使ってチャットする';

  @override
  String get chatbotSheetSubtitle => 'PDF をアップロードして、それについて何でも質問してください';

  @override
  String get chatbotChoosePdfTitle => 'PDFファイルを選択してください';

  @override
  String get chatbotChoosePdfDescription => 'デバイスから PDF を参照して選択します';

  @override
  String get chatbotRecentFilesTitle => '最近のファイル';

  @override
  String get chatbotRecentFilesDescription => '最近使用したファイルから選択してください';

  @override
  String get errorChatbotPdfPickFailed => '選択した PDF を開けませんでした';

  @override
  String get chatbotAnalyzingTitle => 'ドキュメントを分析しています...';

  @override
  String get chatbotAnalyzingSubtitle => '読み進めるまでお待ちください。\nPDF を理解する';

  @override
  String get chatbotStepReadingPdf => 'PDFを読む';

  @override
  String get chatbotStepExtractingText => 'テキストの抽出';

  @override
  String get chatbotStepUnderstandingContent => 'コンテンツの理解';

  @override
  String get chatbotStepPreparingChat => 'AIチャットの準備';

  @override
  String get chatbotHistoryTitle => '歴史';

  @override
  String get chatbotNoConversationsTitle => 'まだ会話はありません';

  @override
  String get chatbotNoConversationsSubtitle =>
      'PDF をアップロードして、AI アシスタントとのチャットを開始します。';

  @override
  String get chatbotUploadPdfButton => 'PDFをアップロードする';

  @override
  String get chatbotDocumentReadyTitle => 'ドキュメントの準備完了';

  @override
  String get chatbotDocumentReadySubtitle => 'PDF を使用してチャットできるようになりました';

  @override
  String get chatbotCurrentSummary => '現在の概要';

  @override
  String get chatbotStartChatting => 'チャットを開始する';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 こんにちは！私はあなたの AI アシスタントです。この PDF について何でも質問してください。お手伝いします。';

  @override
  String get chatbotChatYouCanAsk => 'あなたは私に尋ねることができます：';

  @override
  String get chatbotChatPromptSummarize => 'この文書を要約します';

  @override
  String get chatbotChatPromptHighlights => '重要なハイライトは何ですか?';

  @override
  String get chatbotChatPromptFinancial => '財務データを見せてください';

  @override
  String get chatbotChatPromptDates => '重要な日付を抽出する';

  @override
  String get chatbotChatInputHint => 'この PDF について質問する...';

  @override
  String get chatbotDeleteTitle => 'チャットを削除しますか?';

  @override
  String get chatbotDeleteMessage =>
      'これにより、チャットと PDF が履歴から削除されます。これを元に戻すことはできません。';

  @override
  String get chatbotRenameTitle => 'PDF の名前を変更';

  @override
  String get chatbotRenameHint => '名前を入力してください';

  @override
  String get chatbotHistorySearchHint => '会話を検索してください…';

  @override
  String get chatbotRenameSuccess => '名前が正常に変更されました';

  @override
  String get chatbotDeleteSuccess => '正常に削除されました';

  @override
  String get chatbotEmptyConversationPreview => '空虚な会話…';

  @override
  String get chatbotAiThinking => 'AIが考えている';

  @override
  String get chatbotTipsLabel => 'ヒント';

  @override
  String get chatbotSuggestSummarizeChip => '要約する\nこのPDF';

  @override
  String get chatbotSuggestKeyPointsChip => '重要なポイント\nこのPDFの';

  @override
  String get chatbotSuggestExplainChip => '説明する\n詳細に';

  @override
  String get chatbotSuggestTranslateChip => '翻訳する\nこのPDF';

  @override
  String get chatbotAnalyzeFailed => 'この PDF を分析できませんでした。もう一度試してください。';

  @override
  String get chatbotChatFailed => '応答が得られませんでした。もう一度やり直してください。';

  @override
  String get errorChatbotPdfEmpty => 'この PDF にはテキストが見つかりません';

  @override
  String get pdfAssistantTitle => 'PDFアシスタント';

  @override
  String get pdfAssistantSheetTitle => 'PDFをアップロードする';

  @override
  String get pdfAssistantSheetSubtitle => 'PDF ファイルを追加する方法を選択してください';

  @override
  String get pdfAssistantChoosePdfTitle => 'PDFファイルを選択してください';

  @override
  String get pdfAssistantChoosePdfDescription => 'デバイスから PDF を参照して選択します';

  @override
  String get pdfAssistantLinkTitle => 'リンクからPDFを追加';

  @override
  String get pdfAssistantLinkDescription => 'PDF リンクを貼り付けて直接アップロードします';

  @override
  String get pdfAssistantLinkHint => 'PDF URLを貼り付け';

  @override
  String get pdfAssistantLinkButton => 'PDFをダウンロード';

  @override
  String get pdfAssistantTranslateTo => '翻訳先';

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
  String get pdfAssistantStartProcessing => '処理の開始';

  @override
  String get pdfAssistantNoFileSelected => 'ファイルが選択されていません';

  @override
  String get pdfAssistantSelectLanguage => 'ターゲット言語を選択してください';

  @override
  String get pdfAssistantProcessingTitle => 'PDF を処理しています…';

  @override
  String get pdfAssistantProcessingSubtitle => 'お待ちください。';

  @override
  String get pdfAssistantStepExtracting => 'テキストを抽出中…';

  @override
  String get pdfAssistantStepTranslating => 'コンテンツを翻訳中…';

  @override
  String get pdfAssistantStepGeneratingPdf => '翻訳された PDF を生成しています…';

  @override
  String get pdfAssistantStepFinalizing => '仕上げ中…';

  @override
  String get pdfAssistantResultTitle => '結果';

  @override
  String get pdfAssistantTranslatedPdfTitle => '翻訳されたPDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => '元のレイアウトと翻訳されたテキストのオーバーレイ';

  @override
  String get pdfAssistantExtractedTextTitle => '抽出された翻訳テキスト';

  @override
  String get pdfAssistantExtractedTextDescription => 'シンプルなA4テキスト文書';

  @override
  String get pdfAssistantActionOpen => '開ける';

  @override
  String get pdfAssistantActionDownload => 'ダウンロード';

  @override
  String get pdfAssistantDeleteTitle => '結果を削除しますか?';

  @override
  String get pdfAssistantDeleteMessage => 'これにより、翻訳されたファイルがデバイスから削除されます。';

  @override
  String get pdfAssistantDownloadSuccess => 'ダウンロードに保存されました';

  @override
  String get pdfAssistantOpenFailed => 'ファイルを開けませんでした';

  @override
  String get pdfAssistantProcessFailed => 'この PDF を処理できませんでした';

  @override
  String get errorPdfAssistantPickFailed => '選択した PDF を開けませんでした';

  @override
  String get errorPdfAssistantLinkFailed => 'このリンクから PDF をダウンロードできませんでした';

  @override
  String get errorPdfAssistantPdfEmpty => 'この PDF にはテキストが見つかりません';

  @override
  String get pdfAssistantRemoveTitle => 'PDF を削除する';

  @override
  String get pdfAssistantRemoveWarning => 'これにより、デバイスから PDF が削除されます。';

  @override
  String get pdfAssistantUploadPdf => 'PDFをアップロードする';

  @override
  String get cancel => 'キャンセル';

  @override
  String get remove => '取り除く';

  @override
  String get commonNext => '次';

  @override
  String get commonSkip => 'スキップ';

  @override
  String get commonContinue => '続く';

  @override
  String get onboardingStart => '始めましょう →';

  @override
  String get splashTagline => 'AIを活用したドキュメントスキャン';

  @override
  String get onboardingPage1Title => '数秒で\nテキストスキャン';

  @override
  String get onboardingPage1Description =>
      'AI を活用した高速 OCR スキャンで画像からテキストをキャプチャします。';

  @override
  String get onboardingPage2Title => 'スマートPDF \nアシスタント';

  @override
  String get onboardingPage2Description =>
      '翻訳、抽出、理解する\nAI を使用して PDF ドキュメントを作成します。';

  @override
  String get onboardingPage3Title => 'とチャットする \nあなたの PDF';

  @override
  String get onboardingPage3Description => '質問したり、書類をまとめたり\nAI による即座の回答が得られます。';

  @override
  String get onboardingPage4Title => 'スマートクロップ \n数秒で';

  @override
  String get onboardingPage4Description =>
      '複数の画像を自動トリミングし、\nきれいな PDF を瞬時に作成します。';

  @override
  String get settingsChooseLanguage => '言語を選択してください';

  @override
  String get settingsLanguageApply => '適用する';

  @override
  String get commonSaving => '保存中…';

  @override
  String get smartCropTitle => 'スマート切り抜き';

  @override
  String get smartCropInputMethodTitle => 'スマートクロップスキャナー';

  @override
  String get smartCropInputMethodSubtitle => 'ドキュメントをトリミングする方法を選択します';

  @override
  String get smartCropInputLiveCameraTitle => 'ライブカメラ';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Google スキャナー - 自動エッジ、切り抜き、強化';

  @override
  String get smartCropInputUploadImageTitle => '画像をアップロードする';

  @override
  String get smartCropInputUploadImageDescription => 'ギャラリーからドキュメント画像をアップロード';

  @override
  String get smartCropUploadIntroHeadline => '複数の画像をトリミングする\n自動的に';

  @override
  String get smartCropUploadIntroSubtitle =>
      '自動的にエッジを検出し、画像を完全に切り抜き、ワンタップで PDF を作成します。';

  @override
  String get smartCropUploadIntroStepSelect => '複数の画像を選択する';

  @override
  String get smartCropUploadIntroStepCrop => '自動検出とトリミング';

  @override
  String get smartCropUploadIntroStepPdf => 'PDFを瞬時に作成';

  @override
  String get smartCropUploadIntroSelectImages => '画像の選択';

  @override
  String get smartCropLiveCameraTitle => 'スマートクロップカメラ';

  @override
  String get smartCropLiveCameraTip => 'ドキュメントが検出されました — タップしてキャプチャします';

  @override
  String get smartCropLiveCameraAlignTip => '書類を角の内側に揃えます';

  @override
  String get smartCropLiveCameraClose => 'カメラを閉じる';

  @override
  String get smartCropLiveCameraFlash => 'フラッシュの切り替え';

  @override
  String get smartCropLiveCameraCapture => 'ドキュメントをキャプチャしてスマートにトリミングする';

  @override
  String get smartCropLiveCameraInitializing => 'カメラを起動中…';

  @override
  String get smartCropCapturedTitle => 'キャプチャされたドキュメント';

  @override
  String get smartCropCapturedRetake => '最後の写真を撮り直す';

  @override
  String get smartCropCapturedAnotherPhoto => '別の写真を追加';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => '別の写真を撮り直す';

  @override
  String get smartCropCapturedPreview => 'プレビュー';

  @override
  String get smartCropPreviewTitle => 'プレビュー';

  @override
  String get smartCropCapturedCrop => '作物';

  @override
  String get smartCropAdjustCornersTitle => 'コーナーを調整する';

  @override
  String get smartCropAdjustCornersHint => '紫色の角をドラッグして文書の端に合わせます';

  @override
  String get smartCropAdjustCornersConfirm => 'クロップを適用する';

  @override
  String get smartCropDetectingEdges => '原稿の端を検出中…';

  @override
  String get smartCropAndroidOnly => 'スマート スキャンは Android でのみ使用できます。';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return '最大$max枚の写真に達しました';
  }

  @override
  String get smartCropProcessingCrop => '魔法の作物を適用しています...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return '$count ドキュメントをトリミングしています…';
  }

  @override
  String get smartCropCroppedTitle => 'トリミングされたドキュメント';

  @override
  String get smartCropFilterOriginal => 'オリジナル';

  @override
  String get smartCropFilterLighten => '明るくする';

  @override
  String get smartCropFilterMagic => '魔法';

  @override
  String get smartCropFilterGrayscale => 'グレースケール';

  @override
  String get smartCropFilterMono => '白黒';

  @override
  String get smartCropFilterWarm => '暖かい';

  @override
  String get smartCropActionCreatePdf => 'PDFの作成';

  @override
  String get smartCropProcessingPdf => 'PDF ドキュメントを生成しています...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return '$count ページの PDF を生成しています…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF ドキュメントが正常に生成されました';

  @override
  String get smartCropPdfPagesLabel => 'ページ';

  @override
  String get smartCropPdfSinglePageLabel => '1ページ';

  @override
  String get smartCropImageCopied => 'コピーされました';

  @override
  String get smartCropDeleteImageConfirm => 'このページをドキュメントから削除しますか?';

  @override
  String get smartCropDeletePdfConfirm => 'この PDF をデバイスから削除しますか?';

  @override
  String get smartCropPdfRenamed => 'PDF の名前が変更されました';

  @override
  String get smartCropPdfFileName => 'ファイル名';

  @override
  String get smartCropPdfFileSize => 'ファイルサイズ';

  @override
  String get smartCropViewPdf => 'PDFを見る';

  @override
  String get smartCropSavePdf => 'PDFを保存';

  @override
  String get smartCropRenamePdf => '名前の変更';

  @override
  String get smartCropRenamePdfHint => '文書名';

  @override
  String get smartCropStepReadingImages => '画像の読み取り';

  @override
  String get smartCropStepDetectingEdges => '原稿の端を検出する';

  @override
  String get smartCropStepCroppingImages => '画像のトリミング';

  @override
  String get smartCropStepGeneratingPdf => 'PDFの生成';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'トリミングされた画像を整理しています\n高品質の PDF に変換';

  @override
  String get smartCropProcessingPdfTitle => 'PDF の作成';

  @override
  String get commonUntitledDocument => '書類';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse => 'タップしてデバイス ディレクトリを参照します';

  @override
  String get errorPdfTextLoad => 'テキストの読み込み中にエラーが発生しました。';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return '翻訳: $language';
  }

  @override
  String get translateExportDocumentTranslation => '文書翻訳';

  @override
  String get translateExportTranslatedBadge => '翻訳済み';

  @override
  String get translateExportVerifiedFooter => '検証済みのオフライン翻訳エクスポート';

  @override
  String get translateExportPdfHeader => '翻訳のエクスポート';

  @override
  String get translateExportPdfFooterLabel => '機密文書';

  @override
  String translateExportPageOf(int page, int total) {
    return 'ページ $page / $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'ページ$page';
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
  String get translateLangName_en => '英語';

  @override
  String get translateLangName_ur => 'ウルドゥー語';

  @override
  String get translateLangName_hi => 'ヒンディー語';

  @override
  String get translateLangName_ar => 'アラビア語';

  @override
  String get translateLangName_es => 'スペイン語';

  @override
  String get translateLangName_fr => 'フランス語';

  @override
  String get translateLangName_de => 'ドイツ語';

  @override
  String get translateLangName_pt => 'ポルトガル語';

  @override
  String get translateLangName_ru => 'ロシア';

  @override
  String get translateLangName_zh => '中国語（簡体字）';

  @override
  String get translateLangName_zhTw => '中国語（繁体字）';

  @override
  String get translateLangName_ja => '日本語';

  @override
  String get translateLangName_ko => '韓国人';

  @override
  String get translateLangName_it => 'イタリア語';

  @override
  String get translateLangName_tr => 'トルコ語';

  @override
  String get translateLangName_nl => 'オランダ語';

  @override
  String get translateLangName_sv => 'スウェーデン語';

  @override
  String get translateLangName_no => 'ノルウェー語';

  @override
  String get translateLangName_da => 'デンマーク語';

  @override
  String get translateLangName_fi => 'フィンランド語';

  @override
  String get translateLangName_el => 'ギリシャ語';

  @override
  String get translateLangName_pl => '研磨';

  @override
  String get translateLangName_cs => 'チェコ語';

  @override
  String get translateLangName_hu => 'ハンガリー語';

  @override
  String get translateLangName_ro => 'ルーマニア語';

  @override
  String get translateLangName_bg => 'ブルガリア語';

  @override
  String get translateLangName_uk => 'ウクライナ語';

  @override
  String get translateLangName_fa => 'ペルシア語';

  @override
  String get translateLangName_he => 'ヘブライ語';

  @override
  String get translateLangName_th => 'タイ語';

  @override
  String get translateLangName_vi => 'ベトナム語';

  @override
  String get translateLangName_id => 'インドネシア語';

  @override
  String get translateLangName_ms => 'マレー語';

  @override
  String get translateLangName_bn => 'ベンガル語';

  @override
  String get translateLangName_ta => 'タミル語';

  @override
  String get translateLangName_te => 'テルグ語';

  @override
  String get translateLangName_mr => 'マラーティー語';

  @override
  String get translateLangName_gu => 'グジャラート語';

  @override
  String get translateLangName_kn => 'カンナダ語';

  @override
  String get translateLangName_ml => 'マラヤーラム語';

  @override
  String get translateLangName_pa => 'パンジャブ語';

  @override
  String get translateLangName_sw => 'スワヒリ語';

  @override
  String get translateLangName_af => 'アフリカーンス語';

  @override
  String get translateLangName_ca => 'カタルーニャ語';

  @override
  String get translateLangName_hr => 'クロアチア語';

  @override
  String get translateLangName_sk => 'スロバキア語';

  @override
  String get translateLangName_sl => 'スロベニア語';

  @override
  String get translateLangName_sr => 'セルビア語';

  @override
  String get translateLangName_lt => 'リトアニア語';

  @override
  String get translateLangName_lv => 'ラトビア語';

  @override
  String get translateLangName_et => 'エストニア語';

  @override
  String get translateLangName_is => 'アイスランド語';

  @override
  String get translateLangName_ga => 'アイルランド人';

  @override
  String get translateLangName_mt => 'マルタ語';

  @override
  String get translateLangName_sq => 'アルバニア人';

  @override
  String get translateLangName_mk => 'マケドニア語';

  @override
  String get translateLangName_be => 'ベラルーシ語';

  @override
  String get translateLangName_kk => 'カザフ語';

  @override
  String get translateLangName_uz => 'ウズベク語';

  @override
  String get translateLangName_az => 'アゼルバイジャン語';

  @override
  String get translateLangName_hy => 'アルメニア語';

  @override
  String get translateLangName_ka => 'グルジア語';

  @override
  String get translateLangName_lo => 'ラオ語';

  @override
  String get translateLangName_km => 'クメール語';

  @override
  String get translateLangName_my => 'ビルマ語';

  @override
  String get translateLangName_ne => 'ネパール語';

  @override
  String get translateLangName_si => 'シンハラ語';

  @override
  String get translateLangName_am => 'アムハラ語';

  @override
  String get translateLangName_ha => 'ハウサ語';

  @override
  String get translateLangName_yo => 'ヨルバ語';

  @override
  String get translateLangName_ig => 'イボ語';

  @override
  String get translateLangName_zu => 'ズールー語';

  @override
  String get translateLangName_xh => 'コサ語';

  @override
  String get translateLangName_st => 'セソト';

  @override
  String get translateLangName_sn => 'ショナ';

  @override
  String get translateLangName_rw => 'ルワンダ';

  @override
  String get translateLangName_so => 'ソマリ語';

  @override
  String get translateLangName_mg => 'マダガスカル';

  @override
  String get translateLangName_cy => 'ウェールズ語';

  @override
  String get translateLangName_mn => 'モンゴル語';

  @override
  String get translateLangName_tl => 'フィリピン人';

  @override
  String get translateLangName_ht => 'ハイチ クレオール';

  @override
  String get translateLangName_eo => 'エスペラント';

  @override
  String get translateLangName_la => 'ラテン';

  @override
  String get translateLangName_ku => 'クルド';

  @override
  String get translateLangName_ps => 'パシュトゥー語';

  @override
  String get translateLangName_faAf => 'ダリ';

  @override
  String get translateLangName_bs => 'ボスニア語';

  @override
  String get translateLangName_mi => 'マオリ語';

  @override
  String get translateLangName_sm => 'サモア語';

  @override
  String get translateLangName_haw => 'ハワイアン';

  @override
  String get translateLangName_lb => 'ルクセンブルク語';
}
