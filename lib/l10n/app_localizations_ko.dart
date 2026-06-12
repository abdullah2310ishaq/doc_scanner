// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => '확인';

  @override
  String get commonCancel => '취소';

  @override
  String get commonSave => '저장';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonShare => '공유';

  @override
  String get commonCopy => '복사';

  @override
  String get commonRetry => '재시도';

  @override
  String get commonClose => '닫기';

  @override
  String get commonDone => '완료';

  @override
  String get commonLoading => '로딩 중…';

  @override
  String get commonError => '문제가 발생했습니다';

  @override
  String get commonTryAgain => '다시 시도해 주세요';

  @override
  String get navHome => '홈';

  @override
  String get navScan => '스캔';

  @override
  String get navDocuments => '문서';

  @override
  String get navTranslate => '번역';

  @override
  String get navLive => '라이브';

  @override
  String get navSettings => '설정';

  @override
  String homeGreeting(String name) {
    return '좋은 아침입니다, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI 문서';

  @override
  String get homeTitleHighlight => '스캐너';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => '메뉴 열기';

  @override
  String get homeTagAiPowered => 'AI 기반';

  @override
  String get homeTagFastOcr => '빠른 OCR';

  @override
  String get homeTagSecure => '보안성';

  @override
  String get homeTagSmartCrop => '스마트 자르기';

  @override
  String get homeHeroBadge => 'AI 기반';

  @override
  String get homeHeroTitle => '스마트 AI OCR\n스캐너';

  @override
  String get homeHeroSubtitle => '몇 초 만에 빠르고 정확하게 텍스트를 인식하는 AI 기반 OCR입니다.';

  @override
  String get homeHeroButton => 'OCR 스캐너';

  @override
  String get homeSearchHint => '여기서 검색';

  @override
  String get homeFeatureOcrTitle => 'OCR 스캐너';

  @override
  String get homeFeatureOcrSubtitle => '이미지 또는 문서에서 텍스트 스캔';

  @override
  String get homeFeaturePdfTitle => 'PDF 어시스턴트';

  @override
  String get homeFeaturePdfSubtitle => 'PDF 번역 및 텍스트 변환';

  @override
  String get homeFeatureChatbotTitle => 'PDF에게 질문';

  @override
  String get homeFeatureChatbotSubtitle => 'PDF를 업로드하여 질문하기';

  @override
  String get homeFeatureCropTitle => '스마트 자르기';

  @override
  String get homeFeatureCropSubtitle => '자동 자르기, 정리 및 보정';

  @override
  String get homeRecentDocuments => '문서';

  @override
  String get homeSeeAll => '모두 보기';

  @override
  String get homeEmptyDocuments => '아직 문서가 없습니다. 스캔을 눌러 시작하세요.';

  @override
  String get homeSampleDocName => '청구서_2026.pdf';

  @override
  String get homeSampleDocMeta => '2026년 5월 10일 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => '이미지';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 파일',
      one: '1개 파일',
      zero: '0개 파일',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count개 파일',
      one: '1개 파일',
      zero: '0개 파일',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => '이미지';

  @override
  String get homeRecentAdded => '최근 추가됨';

  @override
  String get homeRecentSelect => '선택';

  @override
  String get homeRecentSelectAll => '모두 선택';

  @override
  String get homeRecentDeselectAll => '선택 해제';

  @override
  String get homeRecentSearchPdfs => 'PDF 검색…';

  @override
  String get homeRecentSearchImages => '이미지 검색…';

  @override
  String get homeRecentNoSearchResults => '검색 조건에 맞는 파일이 없습니다';

  @override
  String get homeRecentToggleFavorite => '즐겨찾기';

  @override
  String get homeRecentUnfavorite => '즐겨찾기 해제';

  @override
  String get homeRecentFavoriteAdded => '즐겨찾기에 추가됨';

  @override
  String get homeRecentFavoriteRemoved => '즐겨찾기에서 제거됨';

  @override
  String get homeRecentPdfEmptyTitle => '최근 PDF가 없습니다';

  @override
  String get homeRecentPdfEmptySubtitle => '문서를 업로드하거나 스캔하여 첫 번째 PDF를 만들어보세요';

  @override
  String get homeRecentImageEmptyTitle => '최근 이미지가 없습니다';

  @override
  String get homeRecentImageEmptySubtitle => '이미지를 업로드하거나 스캔하여 여기에 정리해보세요';

  @override
  String get homeRecentUploadPdf => 'PDF 업로드';

  @override
  String get homeRecentUploadImages => '이미지 업로드';

  @override
  String get homeRecentScanDocument => '문서 스캔';

  @override
  String get homeRecentDeleteImageTitle => '이미지를 삭제하시겠습니까?';

  @override
  String get homeRecentDeleteImageMessage =>
      '이 이미지를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get homeRecentDeleteImagesTitle => '이미지를 삭제하시겠습니까?';

  @override
  String get homeRecentDeleteImagesMessage =>
      '선택한 이미지를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get scanTitle => '스캔';

  @override
  String get scanCapture => '촬영';

  @override
  String get scanImportGallery => '갤러리에서 가져오기';

  @override
  String get scanImportFiles => '파일 가져오기';

  @override
  String get scanAddPage => '페이지 추가';

  @override
  String get scanRetake => '다시 촬영';

  @override
  String get scanCrop => '자르기';

  @override
  String get scanEnhance => '보정';

  @override
  String get scanDone => '완료';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count페이지',
      one: '1페이지',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => '스캔 저장 중…';

  @override
  String get scanSaved => '문서가 저장되었습니다';

  @override
  String get ocrTitle => '텍스트 인식';

  @override
  String get ocrRun => '텍스트 인식하기';

  @override
  String get ocrRunning => '텍스트 읽는 중…';

  @override
  String get ocrEmpty => '이미지에서 텍스트를 찾을 수 없습니다';

  @override
  String get ocrCopySuccess => '텍스트가 복사되었습니다';

  @override
  String get ocrEditHint => '인식된 텍스트 편집';

  @override
  String get ocrInputMethodTitle => '입력 방법 선택';

  @override
  String get ocrInputMethodSubtitle => '텍스트를 추출할 방법을 선택하세요';

  @override
  String get ocrInputLiveCameraTitle => '라이브 카메라';

  @override
  String get ocrInputLiveCameraDescription => '카메라를 사용하여 실시간 이미지 촬영';

  @override
  String get ocrInputUploadImageTitle => '이미지 업로드';

  @override
  String get ocrInputUploadImageDescription => '갤러리에서 이미지 업로드';

  @override
  String get ocrLiveCameraTitle => '라이브 OCR 카메라';

  @override
  String get ocrLiveCameraTip => '팁: 더 나은 결과를 위해 텍스트를 밝은 곳에 두세요';

  @override
  String get ocrLiveCameraClose => '카메라 닫기';

  @override
  String get ocrLiveCameraFlash => '플래시 켜기/끄기';

  @override
  String get ocrLiveCameraCapture => '텍스트 인식을 위한 이미지 촬영';

  @override
  String get ocrLiveCameraInitializing => '카메라 시작 중…';

  @override
  String get ocrAnalyzeTitle => 'OCR 스캐너';

  @override
  String get ocrAnalyzeCopy => '복사';

  @override
  String get ocrAnalyzeTranslate => '번역';

  @override
  String get ocrAnalyzeProcessing => '텍스트 분석 중…';

  @override
  String get ocrAnalyzeTranslateNext => '다음 화면에서 번역이 열립니다';

  @override
  String get ocrNoTextTitle => '읽을 수 있는 텍스트가 감지되지 않았습니다';

  @override
  String get ocrNoTextHint => '더 선명한 이미지로 시도해 보세요';

  @override
  String get ocrNoTextRetakePhoto => '사진 다시 촬영';

  @override
  String get ocrNoTextChooseGallery => '갤러리에서 선택';

  @override
  String get translateTitle => '번역';

  @override
  String get translateSourceLanguage => '번역 원본';

  @override
  String get translateTargetLanguage => '번역 대상';

  @override
  String get translateSwapLanguages => '언어 바꾸기';

  @override
  String get translateButton => '번역하기';

  @override
  String get translateRunning => '번역 중…';

  @override
  String get translatePasteHint => '텍스트를 붙여넣거나 입력하세요';

  @override
  String get translateCopyResult => '번역 복사';

  @override
  String get translateResultTitle => '텍스트 번역';

  @override
  String get translateResultSubtitle => '선택한 텍스트를 원하는 언어로 번역하세요';

  @override
  String get translateSelectedText => '선택된 텍스트';

  @override
  String get translateSelectedLanguage => '선택된 언어';

  @override
  String get translateSelectLanguage => '언어 선택';

  @override
  String get translateSearchLanguage => '언어 검색';

  @override
  String get translateRecentLanguages => '최근 사용';

  @override
  String get translateNoLanguagesFound => '언어를 찾을 수 없습니다';

  @override
  String get translateTranslatedText => '번역된 텍스트';

  @override
  String get translatePlaceholder => '번역 결과가 여기에 표시됩니다…';

  @override
  String get translateSeeMore => '더 보기';

  @override
  String get translateReadAloud => '소리 내어 읽기';

  @override
  String get translateSavePdf => 'PDF로 저장';

  @override
  String get translateSavePng => 'PNG로 저장';

  @override
  String get translateSaveComingSoon => '저장 기능은 곧 제공될 예정입니다';

  @override
  String get translateDownloadOptionTitle => '다운로드 옵션 선택';

  @override
  String get translateDownloadOptionSubtitle => '다운로드할 항목을 선택하세요';

  @override
  String get translateDownloadSelectedTextTitle => '선택한 텍스트 다운로드';

  @override
  String get translateDownloadSelectedTextDescription => '선택한 텍스트만 다운로드';

  @override
  String get translateDownloadCompleteFileTitle => '전체 파일 다운로드';

  @override
  String get translateDownloadCompleteFileDescription => '파일 전체 다운로드';

  @override
  String get translateDownloadTranslatedTextTitle => '번역된 텍스트 다운로드';

  @override
  String get translateDownloadTranslatedTextDescription => '번역된 텍스트만 다운로드';

  @override
  String get translateSavePdfSuccess => 'PDF가 성공적으로 저장되었습니다';

  @override
  String get translateSavePngSuccess => '이미지가 성공적으로 저장되었습니다';

  @override
  String get translateExportNeedsTranslation => '다운로드하기 전에 텍스트를 번역해 주세요';

  @override
  String get liveTitle => '라이브 번역';

  @override
  String get liveStart => '카메라 시작';

  @override
  String get liveStop => '중지';

  @override
  String get liveListening => '듣는 중…';

  @override
  String get livePointAtText => '카메라를 텍스트에 비추세요';

  @override
  String get livePermissionNeeded => '라이브 번역을 이용하려면 카메라 접근 권한이 필요합니다';

  @override
  String get documentsTitle => '내 문서';

  @override
  String get documentRename => '이름 바꾸기';

  @override
  String get documentDeleteConfirmTitle => '문서를 삭제하시겠습니까?';

  @override
  String get documentDeleteConfirmMessage => '이 작업은 취소할 수 없습니다.';

  @override
  String get documentDeleted => '문서가 삭제되었습니다';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsLanguage => '앱 언어';

  @override
  String get settingsTheme => '테마';

  @override
  String get settingsAbout => '정보';

  @override
  String get settingsPrivacy => '개인정보 처리방침';

  @override
  String get settingsTerms => '이용약관';

  @override
  String get settingsContactSupport => '고객 지원 문의';

  @override
  String get settingsMoreApps => '더 많은 앱';

  @override
  String get settingsRateApp => '앱 평가';

  @override
  String get settingsShareApp => '앱 공유';

  @override
  String get settingsGreetingPrefix => '좋은 아침입니다,';

  @override
  String get settingsDefaultUserName => '압둘라';

  @override
  String get permissionCameraTitle => '카메라 권한';

  @override
  String get permissionCameraMessage =>
      '문서 스캔 및 라이브 번역을 사용하려면 카메라 접근을 허용해 주세요.';

  @override
  String get permissionStorageTitle => '저장공간 권한';

  @override
  String get permissionStorageMessage => '스캔한 내용을 저장하고 열려면 접근을 허용해 주세요.';

  @override
  String get permissionOpenSettings => '설정 열기';

  @override
  String get permissionDenied => '권한이 거부되었습니다';

  @override
  String get errorCameraUnavailable => '이 기기에서는 카메라를 사용할 수 없습니다';

  @override
  String get errorFileRead => '파일을 읽을 수 없습니다';

  @override
  String get errorNetwork => '인터넷 연결을 확인해 주세요';

  @override
  String get errorNoInternetFeatures =>
      '인터넷에 연결되어 있지 않습니다. 일부 기능이 제대로 작동하지 않을 수 있습니다.';

  @override
  String get exitAppTitle => '앱 종료';

  @override
  String get exitAppMessage => '정말 종료하시겠습니까?';

  @override
  String get exitAppConfirm => '종료';

  @override
  String get errorOcrFailed => '텍스트 인식에 실패했습니다';

  @override
  String get errorTranslateFailed => '번역에 실패했습니다';

  @override
  String get errorTranslateModelDownload =>
      '언어 팩을 다운로드할 수 없습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get errorTranslateUnsupportedLanguage => '이 언어는 오프라인 번역을 지원하지 않습니다.';

  @override
  String get proTitle => '문서 스캐너 프로';

  @override
  String get proSubtitle => '무제한 스캔, OCR, 언어 지원 및 라이브 번역';

  @override
  String get proUpgradeButton => 'Pro로 업그레이드';

  @override
  String get proRestorePurchases => '구매 내역 복원';

  @override
  String get proFeatureLocked => 'Pro 전용 기능';

  @override
  String proLimitPages(int max) {
    return '무료 플랜은 문서당 최대 $max페이지까지 허용됩니다';
  }

  @override
  String get proLimitOcr => '무제한 OCR을 이용하려면 Pro로 업그레이드하세요';

  @override
  String get proLimitTranslate => '모든 언어를 지원받으려면 Pro로 업그레이드하세요';

  @override
  String get proLimitLive => '라이브 번역은 Pro에서만 사용할 수 있습니다';

  @override
  String get proPurchaseSuccess => 'Pro 플랜에 오신 것을 환영합니다!';

  @override
  String get proPurchaseFailed => '구매를 완료할 수 없습니다';

  @override
  String get exportPdf => 'PDF 내보내기';

  @override
  String get exportImage => '이미지 내보내기';

  @override
  String get exportSuccess => '내보내기 완료';

  @override
  String get exportFailed => '내보내기 실패';

  @override
  String get languageSearchHint => '언어 검색';

  @override
  String get languageAuto => '언어 감지';

  @override
  String get chatbotTitle => 'AI 챗봇';

  @override
  String get chatbotHistoryButton => '채팅 기록';

  @override
  String get chatbotBadge => '스마트 AI 어시스턴트';

  @override
  String get chatbotHeadlineChat => '나의 ';

  @override
  String get chatbotHeadlineMiddle => '';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'PDF를 업로드하고 무엇이든 질문하세요 — 즉각적인 답변, 요약, 설명 등을 받아보세요.';

  @override
  String get chatbotTryAsking => '이렇게 물어보세요';

  @override
  String get chatbotSuggestSummarize => '이 PDF 요약하기';

  @override
  String get chatbotSuggestKeyPoints => '이 PDF의 핵심 포인트';

  @override
  String get chatbotSuggestExplain => '자세히 설명하기';

  @override
  String get chatbotSuggestTranslate => '이 PDF 번역하기';

  @override
  String get chatbotAskQuestions => '이 PDF에 대해 질문하기';

  @override
  String get chatbotUploadHint => 'PDF 업로드…';

  @override
  String get chatbotSheetTitle => 'PDF와 채팅하기';

  @override
  String get chatbotSheetSubtitle => 'PDF를 업로드하고 무엇이든 물어보세요';

  @override
  String get chatbotChoosePdfTitle => 'PDF 파일 선택';

  @override
  String get chatbotChoosePdfDescription => '기기에서 PDF를 찾아 선택하세요';

  @override
  String get chatbotRecentFilesTitle => '최근 파일';

  @override
  String get chatbotRecentFilesDescription => '최근 파일에서 선택';

  @override
  String get errorChatbotPdfPickFailed => '선택한 PDF를 열 수 없습니다';

  @override
  String get chatbotAnalyzingTitle => '문서 분석 중…';

  @override
  String get chatbotAnalyzingSubtitle => 'PDF를 읽고 이해하는 동안\n잠시만 기다려 주세요';

  @override
  String get chatbotStepReadingPdf => 'PDF 읽는 중';

  @override
  String get chatbotStepExtractingText => '텍스트 추출 중';

  @override
  String get chatbotStepUnderstandingContent => '콘텐츠 이해 중';

  @override
  String get chatbotStepPreparingChat => 'AI 채팅 준비 중';

  @override
  String get chatbotHistoryTitle => '기록';

  @override
  String get chatbotNoConversationsTitle => '아직 대화가 없습니다';

  @override
  String get chatbotNoConversationsSubtitle =>
      'PDF를 업로드하여 AI 어시스턴트와 대화를 시작해 보세요.';

  @override
  String get chatbotUploadPdfButton => 'PDF 업로드';

  @override
  String get chatbotDocumentReadyTitle => '문서 준비 완료';

  @override
  String get chatbotDocumentReadySubtitle => '이제 PDF와 대화할 수 있습니다';

  @override
  String get chatbotCurrentSummary => '현재 요약';

  @override
  String get chatbotStartChatting => '채팅 시작하기';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 안녕하세요! 저는 당신의 AI 어시스턴트입니다. 이 PDF에 대해 궁금한 점을 물어보시면 도와드리겠습니다.';

  @override
  String get chatbotChatYouCanAsk => '이렇게 질문할 수 있습니다:';

  @override
  String get chatbotChatPromptSummarize => '이 문서 요약해 줘';

  @override
  String get chatbotChatPromptHighlights => '주요 핵심 내용은 뭐야?';

  @override
  String get chatbotChatPromptFinancial => '재무 데이터를 보여줘';

  @override
  String get chatbotChatPromptDates => '중요한 날짜 추출해 줘';

  @override
  String get chatbotChatInputHint => '이 PDF에 대해 질문하기…';

  @override
  String get chatbotDeleteTitle => '채팅을 삭제하시겠습니까?';

  @override
  String get chatbotDeleteMessage => '기록에서 채팅과 PDF가 제거됩니다. 이 작업은 취소할 수 없습니다.';

  @override
  String get chatbotRenameTitle => 'PDF 이름 바꾸기';

  @override
  String get chatbotRenameHint => '이름 입력';

  @override
  String get chatbotHistorySearchHint => '대화 검색…';

  @override
  String get chatbotRenameSuccess => '이름이 성공적으로 변경되었습니다';

  @override
  String get chatbotDeleteSuccess => '성공적으로 삭제되었습니다';

  @override
  String get chatbotEmptyConversationPreview => '빈 대화…';

  @override
  String get chatbotAiThinking => 'AI가 생각 중';

  @override
  String get chatbotTipsLabel => '팁';

  @override
  String get chatbotSuggestSummarizeChip => '이 PDF\n요약하기';

  @override
  String get chatbotSuggestKeyPointsChip => '이 PDF의\n핵심 포인트';

  @override
  String get chatbotSuggestExplainChip => '자세히\n설명하기';

  @override
  String get chatbotSuggestTranslateChip => '이 PDF\n번역하기';

  @override
  String get chatbotAnalyzeFailed => '이 PDF를 분석할 수 없습니다. 다시 시도해 주세요.';

  @override
  String get chatbotChatFailed => '응답을 받을 수 없습니다. 다시 시도해 주세요.';

  @override
  String get errorChatbotPdfEmpty => '이 PDF에서 텍스트를 찾을 수 없습니다';

  @override
  String get pdfAssistantTitle => 'PDF 어시스턴트';

  @override
  String get pdfAssistantSheetTitle => 'PDF 업로드';

  @override
  String get pdfAssistantSheetSubtitle => 'PDF 파일을 추가할 방법을 선택하세요';

  @override
  String get pdfAssistantChoosePdfTitle => 'PDF 파일 선택';

  @override
  String get pdfAssistantChoosePdfDescription => '기기에서 PDF를 찾아 선택하세요';

  @override
  String get pdfAssistantLinkTitle => '링크로 PDF 추가';

  @override
  String get pdfAssistantLinkDescription => 'PDF 링크를 붙여넣어 직접 업로드하세요';

  @override
  String get pdfAssistantLinkHint => 'PDF URL 붙여넣기';

  @override
  String get pdfAssistantLinkButton => 'PDF 다운로드';

  @override
  String get pdfAssistantTranslateTo => '번역 대상 언어';

  @override
  String get pdfAssistantTranslateToOptional => '번역 대상 (선택 사항)';

  @override
  String get pdfAssistantNoTranslation => '번역 없음';

  @override
  String get pdfAssistantExtractedPdfTitle => '추출된 PDF';

  @override
  String get pdfAssistantExtractedPdfDescription => 'PDF 페이지에서 추출한 텍스트';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => '추출된 텍스트';

  @override
  String get pdfAssistantStepPreparingContent => '콘텐츠 준비 중…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'PDF 생성 중…';

  @override
  String get pdfAssistantStartProcessing => '처리 시작';

  @override
  String get pdfAssistantNoFileSelected => '선택된 파일 없음';

  @override
  String get pdfAssistantSelectLanguage => '대상 언어를 선택해 주세요';

  @override
  String get pdfAssistantProcessingTitle => 'PDF 처리 중…';

  @override
  String get pdfAssistantProcessingSubtitle => '잠시만 기다려 주세요.';

  @override
  String get pdfAssistantStepExtracting => '텍스트 추출 중…';

  @override
  String get pdfAssistantStepTranslating => '콘텐츠 번역 중…';

  @override
  String get pdfAssistantStepGeneratingPdf => '번역된 PDF 생성 중…';

  @override
  String get pdfAssistantStepFinalizing => '마무리 중…';

  @override
  String get pdfAssistantResultTitle => '결과';

  @override
  String get pdfAssistantTranslatedPdfTitle => '번역된 PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      '원본 레이아웃 위에 번역된 텍스트가 오버레이됨';

  @override
  String get pdfAssistantExtractedTextTitle => '추출된 번역 텍스트';

  @override
  String get pdfAssistantExtractedTextDescription => '일반 A4 텍스트 문서';

  @override
  String get pdfAssistantActionOpen => '열기';

  @override
  String get pdfAssistantActionDownload => '다운로드';

  @override
  String get pdfAssistantDeleteTitle => '결과를 삭제하시겠습니까?';

  @override
  String get pdfAssistantDeleteMessage => '기기에서 번역된 파일이 삭제됩니다.';

  @override
  String get pdfAssistantDownloadSuccess => '다운로드 폴더에 저장되었습니다';

  @override
  String get pdfAssistantOpenFailed => '파일을 열 수 없습니다';

  @override
  String get pdfAssistantProcessFailed => '이 PDF를 처리할 수 없습니다';

  @override
  String get errorPdfAssistantPickFailed => '선택한 PDF를 열 수 없습니다';

  @override
  String get errorPdfAssistantLinkFailed => '이 링크에서 PDF를 다운로드할 수 없습니다';

  @override
  String get errorPdfAssistantPdfEmpty => '이 PDF에서 텍스트를 찾을 수 없습니다';

  @override
  String get pdfAssistantRemoveTitle => 'PDF 제거';

  @override
  String get pdfAssistantRemoveWarning => '기기에서 PDF가 제거됩니다.';

  @override
  String get pdfAssistantUploadPdf => 'PDF 업로드';

  @override
  String get cancel => '취소';

  @override
  String get remove => '제거';

  @override
  String get commonNext => '다음';

  @override
  String get commonSkip => '건너뛰기';

  @override
  String get commonContinue => '계속';

  @override
  String get onboardingStart => '시작하기 →';

  @override
  String get splashTagline => 'AI 기반 문서 스캔';

  @override
  String get onboardingPage1Title => '몇 초 만에\n텍스트 스캔';

  @override
  String get onboardingPage1Description =>
      '빠른 AI 기반 OCR 스캔으로 이미지에서 텍스트를 캡처하세요.';

  @override
  String get onboardingPage2Title => '스마트한\nPDF 어시스턴트';

  @override
  String get onboardingPage2Description => 'AI를 활용하여 PDF 문서를 번역하고 추출하며 이해하세요.';

  @override
  String get onboardingPage3Title => 'PDF와\n채팅하기';

  @override
  String get onboardingPage3Description => '질문하고, 문서를 요약하며 실시간 AI 답변을 받아보세요.';

  @override
  String get onboardingPage4Title => '몇 초 만에\n스마트 자르기';

  @override
  String get onboardingPage4Description =>
      '여러 이미지를 자동으로 자르고 깔끔한 PDF를 즉시 생성하세요.';

  @override
  String get settingsChooseLanguage => '언어 선택';

  @override
  String get settingsLanguageApply => '적용';

  @override
  String get commonSaving => '저장 중…';

  @override
  String get smartCropTitle => '스마트 자르기';

  @override
  String get smartCropInputMethodTitle => '스마트 자르기 스캐너';

  @override
  String get smartCropInputMethodSubtitle => '문서를 자를 방법을 선택하세요';

  @override
  String get smartCropInputLiveCameraTitle => '라이브 카메라';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Google 스캐너 — 자동 가장자리 감지, 자르기 및 보정';

  @override
  String get smartCropInputUploadImageTitle => '이미지 업로드';

  @override
  String get smartCropInputUploadImageDescription => '갤러리에서 문서 이미지 업로드';

  @override
  String get smartCropUploadIntroHeadline => '여러 이미지를\n자동으로 자르기';

  @override
  String get smartCropUploadIntroSubtitle =>
      '자동으로 가장자리를 감지하여 이미지를 완벽하게 자르고, 한 번의 탭으로 PDF를 만듭니다.';

  @override
  String get smartCropUploadIntroStepSelect => '여러 이미지 선택';

  @override
  String get smartCropUploadIntroStepCrop => '자동 감지 및 자르기';

  @override
  String get smartCropUploadIntroStepPdf => '즉시 PDF 생성';

  @override
  String get smartCropUploadIntroSelectImages => '이미지 선택';

  @override
  String get smartCropLiveCameraTitle => '스마트 자르기 카메라';

  @override
  String get smartCropLiveCameraTip => '문서가 감지되었습니다 — 촬영하려면 탭하세요';

  @override
  String get smartCropLiveCameraAlignTip => '문서를 모서리 안쪽에 맞춰주세요';

  @override
  String get smartCropLiveCameraClose => '카메라 닫기';

  @override
  String get smartCropLiveCameraFlash => '플래시 켜기/끄기';

  @override
  String get smartCropLiveCameraCapture => '스마트 자르기를 위한 문서 촬영';

  @override
  String get smartCropLiveCameraInitializing => '카메라 시작 중…';

  @override
  String get smartCropCapturedTitle => '촬영된 문서';

  @override
  String get smartCropCapturedRetake => '마지막 사진 다시 촬영';

  @override
  String get smartCropCapturedAnotherPhoto => '다른 사진 추가';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => '다른 사진 다시 촬영';

  @override
  String get smartCropCapturedPreview => '미리보기';

  @override
  String get smartCropPreviewTitle => '미리보기';

  @override
  String get smartCropCapturedCrop => '자르기';

  @override
  String get smartCropAdjustCornersTitle => '모서리 조정';

  @override
  String get smartCropAdjustCornersHint => '보라색 모서리를 드래그하여 문서 가장자리에 맞추세요';

  @override
  String get smartCropAdjustCornersConfirm => '자르기 적용';

  @override
  String get smartCropDetectingEdges => '문서 가장자리 감지 중…';

  @override
  String get smartCropAndroidOnly => '스마트 스캔은 Android에서만 사용할 수 있습니다.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return '최대 사진 수($max장)에 도달했습니다';
  }

  @override
  String get smartCropProcessingCrop => '마법 자르기 적용 중...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return '$count개의 문서 자르는 중…';
  }

  @override
  String get smartCropCroppedTitle => '잘린 문서';

  @override
  String get smartCropFilterOriginal => '원본';

  @override
  String get smartCropFilterLighten => '밝게';

  @override
  String get smartCropFilterMagic => '매직 필터';

  @override
  String get smartCropFilterGrayscale => '회색조';

  @override
  String get smartCropFilterMono => '흑백';

  @override
  String get smartCropFilterWarm => '따뜻하게';

  @override
  String get smartCropActionCreatePdf => 'PDF 생성';

  @override
  String get smartCropProcessingPdf => 'PDF 문서 생성 중...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return '$count페이지의 PDF 생성 중…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF 문서가 성공적으로 생성되었습니다';

  @override
  String get smartCropPdfPagesLabel => '페이지';

  @override
  String get smartCropPdfSinglePageLabel => '1페이지';

  @override
  String get smartCropImageCopied => '복사됨';

  @override
  String get smartCropDeleteImageConfirm => '이 페이지를 문서에서 제거하시겠습니까?';

  @override
  String get smartCropDeleteDocumentTitle => '문서를 삭제하시겠습니까?';

  @override
  String get smartCropDeleteDocumentMessage =>
      '이 문서를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get smartCropDeletePdfTitle => 'PDF를 삭제하시겠습니까?';

  @override
  String get smartCropDeletePdfMessage => '이 PDF를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get smartCropDeletePdfConfirm => '기기에서 이 PDF를 삭제하시겠습니까?';

  @override
  String get smartCropPdfRenamed => 'PDF 이름이 변경되었습니다';

  @override
  String get smartCropPdfFileName => '파일 이름';

  @override
  String get smartCropPdfFileSize => '파일 크기';

  @override
  String get smartCropViewPdf => 'PDF 보기';

  @override
  String get smartCropSavePdf => 'PDF 저장';

  @override
  String get smartCropSavePdfSuccess => 'PDF가 성공적으로 저장되었습니다';

  @override
  String get smartCropRenamePdf => '이름 바꾸기';

  @override
  String get smartCropRenamePdfHint => '문서 이름';

  @override
  String get smartCropStepReadingImages => '이미지 읽는 중';

  @override
  String get smartCropStepDetectingEdges => '가장자리 감지 중';

  @override
  String get smartCropStepCroppingImages => '이미지 자르는 중';

  @override
  String get smartCropStepGeneratingPdf => 'PDF 생성 중';

  @override
  String get smartCropProcessingPdfSubtitle => '잘린 이미지들을 고품질 PDF로\n정리하고 있습니다';

  @override
  String get smartCropProcessingPdfTitle => 'PDF 생성 중';

  @override
  String get commonUntitledDocument => '문서';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse => '기기 디렉토리를 찾아보려면 탭하세요';

  @override
  String get errorPdfTextLoad => '텍스트를 불러오는 중 오류가 발생했습니다.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return '번역: $language';
  }

  @override
  String get translateExportDocumentTranslation => '문서 번역';

  @override
  String get translateExportTranslatedBadge => '번역됨';

  @override
  String get translateExportVerifiedFooter => '검증된 오프라인 번역 내보내기';

  @override
  String get translateExportPdfHeader => '번역 내보내기';

  @override
  String get translateExportPdfFooterLabel => '대외비 문서';

  @override
  String translateExportPageOf(int page, int total) {
    return '$total페이지 중 $page페이지';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return '$page페이지';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size B';
  }

  @override
  String fileSizeKb(String size) {
    return '${size}KB';
  }

  @override
  String fileSizeMb(String size) {
    return '${size}MB';
  }

  @override
  String get translateLangName_en => '영어';

  @override
  String get translateLangName_ur => '우르두어';

  @override
  String get translateLangName_hi => '힌디어';

  @override
  String get translateLangName_ar => '아랍어';

  @override
  String get translateLangName_es => '스페인어';

  @override
  String get translateLangName_fr => '프랑스어';

  @override
  String get translateLangName_de => '독일어';

  @override
  String get translateLangName_pt => '포르투갈어';

  @override
  String get translateLangName_ru => '러시아어';

  @override
  String get translateLangName_zh => '중국어(간체)';

  @override
  String get translateLangName_zhTw => '중국어(번체)';

  @override
  String get translateLangName_ja => '일본어';

  @override
  String get translateLangName_ko => '한국어';

  @override
  String get translateLangName_it => '이탈리아어';

  @override
  String get translateLangName_tr => '터키어';

  @override
  String get translateLangName_nl => '네덜란드어';

  @override
  String get translateLangName_sv => '스웨덴어';

  @override
  String get translateLangName_no => '노르웨이어';

  @override
  String get translateLangName_da => '덴마크어';

  @override
  String get translateLangName_fi => '핀란드어';

  @override
  String get translateLangName_el => '그리스어';

  @override
  String get translateLangName_pl => '폴란드어';

  @override
  String get translateLangName_cs => '체코어';

  @override
  String get translateLangName_hu => '헝가리어';

  @override
  String get translateLangName_ro => '루마니아어';

  @override
  String get translateLangName_bg => '불가리아어';

  @override
  String get translateLangName_uk => '우크라이나어';

  @override
  String get translateLangName_fa => '페르시아어';

  @override
  String get translateLangName_he => '히브리어';

  @override
  String get translateLangName_th => '태국어';

  @override
  String get translateLangName_vi => '베트남어';

  @override
  String get translateLangName_id => '인도네시아어';

  @override
  String get translateLangName_ms => '말레이어';

  @override
  String get translateLangName_bn => '벵골어';

  @override
  String get translateLangName_ta => '타밀어';

  @override
  String get translateLangName_te => '텔루구어';

  @override
  String get translateLangName_mr => '마라티어';

  @override
  String get translateLangName_gu => '구자라트어';

  @override
  String get translateLangName_kn => '칸나다어';

  @override
  String get translateLangName_ml => '말라얄람어';

  @override
  String get translateLangName_pa => '펀자브어';

  @override
  String get translateLangName_sw => '스وا힐리어';

  @override
  String get translateLangName_af => '아프리칸스어';

  @override
  String get translateLangName_ca => '카탈루냐어';

  @override
  String get translateLangName_hr => '크로아티아어';

  @override
  String get translateLangName_sk => '슬로바키아어';

  @override
  String get translateLangName_sl => '슬로베니아어';

  @override
  String get translateLangName_sr => '세르비아어';

  @override
  String get translateLangName_lt => '리투아니아어';

  @override
  String get translateLangName_lv => '라트비아어';

  @override
  String get translateLangName_et => '에스토니아어';

  @override
  String get translateLangName_is => '아이슬란드어';

  @override
  String get translateLangName_ga => '아일랜드어';

  @override
  String get translateLangName_mt => '몰타어';

  @override
  String get translateLangName_sq => '알바니아어';

  @override
  String get translateLangName_mk => '마케도니아어';

  @override
  String get translateLangName_be => '벨라루스어';

  @override
  String get translateLangName_kk => '카자흐어';

  @override
  String get translateLangName_uz => '우즈베크어';

  @override
  String get translateLangName_az => '아제르바이잔어';

  @override
  String get translateLangName_hy => '아르메니아어';

  @override
  String get translateLangName_ka => '조지아어';

  @override
  String get translateLangName_lo => '라오어';

  @override
  String get translateLangName_km => '크메르어';

  @override
  String get translateLangName_my => '미얀마어';

  @override
  String get translateLangName_ne => '네팔어';

  @override
  String get translateLangName_si => '싱할라어';

  @override
  String get translateLangName_am => '암하라어';

  @override
  String get translateLangName_ha => '하우사어';

  @override
  String get translateLangName_yo => '요루바어';

  @override
  String get translateLangName_ig => '이보어';

  @override
  String get translateLangName_zu => '줄루어';

  @override
  String get translateLangName_xh => '코사어';

  @override
  String get translateLangName_st => '세소토어';

  @override
  String get translateLangName_sn => '쇼나어';

  @override
  String get translateLangName_rw => '키냐르완다어';

  @override
  String get translateLangName_so => '소말리어';

  @override
  String get translateLangName_mg => '말라가시어';

  @override
  String get translateLangName_cy => '웨일스어';

  @override
  String get translateLangName_mn => '몽골어';

  @override
  String get translateLangName_tl => '필리핀어';

  @override
  String get translateLangName_ht => '아이티 크레올어';

  @override
  String get translateLangName_eo => '에스페란토어';

  @override
  String get translateLangName_la => '라틴어';

  @override
  String get translateLangName_ku => '쿠르드어';

  @override
  String get translateLangName_ps => '파슈토어';

  @override
  String get translateLangName_faAf => '다리어';

  @override
  String get translateLangName_bs => '보스니아어';

  @override
  String get translateLangName_mi => '마오리어';

  @override
  String get translateLangName_sm => '사모아어';

  @override
  String get translateLangName_haw => '하와이어';

  @override
  String get translateLangName_lb => '룩셈부르크어';
}
