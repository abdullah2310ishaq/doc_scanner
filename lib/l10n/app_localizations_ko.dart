// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '문서 스캐너';

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
  String get commonRetry => '다시 시도';

  @override
  String get commonClose => '닫기';

  @override
  String get commonLoading => '로딩 중…';

  @override
  String get commonError => '문제가 발생했습니다';

  @override
  String get commonTryAgain => '다시 시도해주세요';

  @override
  String get navHome => '홈';

  @override
  String get navScan => '스캔';

  @override
  String get navDocuments => '문서';

  @override
  String get navTranslate => '번역';

  @override
  String get navLive => '실시간';

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
  String get homeTagSecure => '보안';

  @override
  String get homeTagSmartCrop => '스마트 자르기';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => '스마트 OCR\n스캐너';

  @override
  String get homeHeroSubtitle => 'AI 기반 OCR로 빠르고 정확하게 텍스트를 인식합니다.';

  @override
  String get homeHeroButton => 'OCR 스캔';

  @override
  String get homeSearchHint => '검색';

  @override
  String get homeFeatureOcrTitle => 'OCR 스캐너';

  @override
  String get homeFeatureOcrSubtitle => '이미지 또는 문서에서 텍스트 추출';

  @override
  String get homeFeaturePdfTitle => 'PDF 도우미';

  @override
  String get homeFeaturePdfSubtitle => 'PDF 번역 및 텍스트 추출';

  @override
  String get homeFeatureChatbotTitle => 'AI 챗봇';

  @override
  String get homeFeatureChatbotSubtitle => 'PDF를 업로드하고 질문하기';

  @override
  String get homeFeatureCropTitle => '스마트 자르기';

  @override
  String get homeFeatureCropSubtitle => '자동 보정 및 향상';

  @override
  String get homeRecentDocuments => '최근 문서';

  @override
  String get homeSeeAll => '전체 보기';

  @override
  String get homeEmptyDocuments => '문서가 없습니다. 스캔을 시작하세요.';

  @override
  String get homeSampleDocName => '청구서_2026.pdf';

  @override
  String get homeSampleDocMeta => '2026년 5월 10일 • 2.4MB';

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
  String get scanEnhance => '향상';

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
  String get ocrRun => '텍스트 인식';

  @override
  String get ocrRunning => '텍스트 읽는 중…';

  @override
  String get ocrEmpty => '텍스트를 찾을 수 없습니다';

  @override
  String get ocrCopySuccess => '텍스트가 복사되었습니다';

  @override
  String get ocrEditHint => '인식된 텍스트 수정';

  @override
  String get ocrInputMethodTitle => '입력 방법 선택';

  @override
  String get ocrInputMethodSubtitle => '텍스트 추출 방법 선택';

  @override
  String get ocrInputLiveCameraTitle => '실시간 카메라';

  @override
  String get ocrInputLiveCameraDescription => '카메라로 촬영';

  @override
  String get ocrInputUploadImageTitle => '이미지 업로드';

  @override
  String get ocrInputUploadImageDescription => '갤러리에서 선택';

  @override
  String get ocrLiveCameraTitle => '실시간 OCR 카메라';

  @override
  String get ocrLiveCameraTip => '팁: 밝은 환경에서 사용하세요';

  @override
  String get ocrLiveCameraClose => '카메라 닫기';

  @override
  String get ocrLiveCameraFlash => '플래시';

  @override
  String get ocrLiveCameraCapture => '촬영';

  @override
  String get ocrLiveCameraInitializing => '카메라 시작 중…';

  @override
  String get ocrAnalyzeTitle => 'OCR 분석';

  @override
  String get ocrAnalyzeCopy => '복사';

  @override
  String get ocrAnalyzeTranslate => '번역';

  @override
  String get ocrAnalyzeProcessing => '분석 중…';

  @override
  String get ocrAnalyzeTranslateNext => '번역 열기';

  @override
  String get ocrNoTextTitle => '텍스트 없음';

  @override
  String get ocrNoTextHint => '더 선명한 이미지를 사용하세요';

  @override
  String get ocrNoTextRetakePhoto => '다시 촬영';

  @override
  String get ocrNoTextChooseGallery => '갤러리 선택';

  @override
  String get translateTitle => '번역';

  @override
  String get translateSourceLanguage => '원본';

  @override
  String get translateTargetLanguage => '대상';

  @override
  String get translateSwapLanguages => '언어 전환';

  @override
  String get translateButton => '번역';

  @override
  String get translateRunning => '번역 중…';

  @override
  String get translatePasteHint => '텍스트 입력 또는 붙여넣기';

  @override
  String get translateCopyResult => '번역 복사';

  @override
  String get translateResultTitle => '번역 결과';

  @override
  String get translateResultSubtitle => '텍스트를 다양한 언어로 번역';

  @override
  String get translateSelectedText => '선택한 텍스트';

  @override
  String get translateSelectedLanguage => '선택된 언어';

  @override
  String get translateSelectLanguage => '언어 선택';

  @override
  String get translateSearchLanguage => '언어 검색';

  @override
  String get translateRecentLanguages => '최근';

  @override
  String get translateNoLanguagesFound => '언어를 찾을 수 없음';

  @override
  String get translateTranslatedText => '번역된 텍스트';

  @override
  String get translatePlaceholder => '여기에 번역이 표시됩니다…';

  @override
  String get translateSeeMore => '더 보기';

  @override
  String get translateReadAloud => '읽어주기';

  @override
  String get translateSavePdf => 'PDF 저장';

  @override
  String get translateSavePng => '이미지 저장';

  @override
  String get translateSaveComingSoon => '곧 제공 예정';

  @override
  String get translateDownloadOptionTitle => '다운로드 선택';

  @override
  String get translateDownloadOptionSubtitle => '다운로드할 항목 선택';

  @override
  String get translateDownloadSelectedTextTitle => '선택한 텍스트 다운로드';

  @override
  String get translateDownloadSelectedTextDescription => '선택한 텍스트만';

  @override
  String get translateDownloadCompleteFileTitle => '전체 파일 다운로드';

  @override
  String get translateDownloadCompleteFileDescription => '전체 문서';

  @override
  String get translateSavePdfSuccess => 'PDF 저장 완료';

  @override
  String get translateSavePngSuccess => '이미지 저장 완료';

  @override
  String get translateExportNeedsTranslation => '먼저 번역이 필요합니다';

  @override
  String get liveTitle => '실시간 번역';

  @override
  String get liveStart => '카메라 시작';

  @override
  String get liveStop => '중지';

  @override
  String get liveListening => '인식 중…';

  @override
  String get livePointAtText => '텍스트를 비추세요';

  @override
  String get livePermissionNeeded => '카메라 권한이 필요합니다';

  @override
  String get documentsTitle => '내 문서';

  @override
  String get documentRename => '이름 변경';

  @override
  String get documentDeleteConfirmTitle => '문서를 삭제하시겠습니까?';

  @override
  String get documentDeleteConfirmMessage => '이 작업은 되돌릴 수 없습니다.';

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
  String get settingsPrivacy => '개인정보 정책';

  @override
  String get settingsTerms => '이용약관';

  @override
  String get permissionCameraTitle => '카메라 권한';

  @override
  String get permissionCameraMessage => '문서 스캔을 위해 카메라 접근을 허용하세요.';

  @override
  String get permissionStorageTitle => '저장소 권한';

  @override
  String get permissionStorageMessage => '파일 저장을 허용하세요.';

  @override
  String get permissionOpenSettings => '설정 열기';

  @override
  String get permissionDenied => '권한 거부됨';

  @override
  String get errorCameraUnavailable => '카메라를 사용할 수 없습니다';

  @override
  String get errorFileRead => '파일을 읽을 수 없습니다';

  @override
  String get errorNetwork => '인터넷 연결을 확인하세요';

  @override
  String get errorNoInternetFeatures => '인터넷이 없습니다';

  @override
  String get exitAppTitle => '앱 종료';

  @override
  String get exitAppMessage => '종료하시겠습니까?';

  @override
  String get exitAppConfirm => '종료';

  @override
  String get errorOcrFailed => 'OCR 실패';

  @override
  String get errorTranslateFailed => '번역 실패';

  @override
  String get errorTranslateModelDownload => '언어 패키지 다운로드 실패';

  @override
  String get errorTranslateUnsupportedLanguage => '지원되지 않는 언어입니다';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => '무제한 스캔 및 OCR';

  @override
  String get proUpgradeButton => 'Pro 업그레이드';

  @override
  String get proRestorePurchases => '구매 복원';

  @override
  String get proFeatureLocked => 'Pro 기능';

  @override
  String proLimitPages(int max) {
    return '무료 버전은 최대 $max페이지까지 지원';
  }

  @override
  String get proLimitOcr => 'Pro에서 무제한 OCR';

  @override
  String get proLimitTranslate => '모든 언어 지원 (Pro)';

  @override
  String get proLimitLive => '실시간 번역은 Pro 전용';

  @override
  String get proPurchaseSuccess => 'Pro에 오신 것을 환영합니다!';

  @override
  String get proPurchaseFailed => '구매 실패';

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
  String get languageAuto => '자동 감지';

  @override
  String get chatbotTitle => 'AI 챗봇';

  @override
  String get chatbotHistoryButton => '채팅 기록';

  @override
  String get chatbotBadge => '스마트 AI 어시스턴트';

  @override
  String get chatbotHeadlineChat => '채팅';

  @override
  String get chatbotHeadlineMiddle => ' 와 ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => '질문해보세요';

  @override
  String get chatbotSuggestSummarize => 'PDF 요약';

  @override
  String get chatbotSuggestKeyPoints => '핵심 포인트';

  @override
  String get chatbotSuggestExplain => '자세히 설명';

  @override
  String get chatbotSuggestTranslate => 'PDF 번역';

  @override
  String get chatbotUploadHint => 'PDF 업로드...';

  @override
  String get chatbotSheetTitle => 'PDF와 채팅';

  @override
  String get chatbotSheetSubtitle => 'PDF를 업로드하고 질문하세요';

  @override
  String get chatbotChoosePdfTitle => 'PDF 선택';

  @override
  String get chatbotChoosePdfDescription => '기기에서 선택';

  @override
  String get chatbotRecentFilesTitle => '최근 파일';

  @override
  String get chatbotRecentFilesDescription => '최근 파일 선택';

  @override
  String get errorChatbotPdfPickFailed => 'PDF를 열 수 없습니다';

  @override
  String get chatbotAnalyzingTitle => '문서 분석 중...';

  @override
  String get chatbotAnalyzingSubtitle => '잠시만 기다려주세요';

  @override
  String get chatbotStepReadingPdf => 'PDF 읽기';

  @override
  String get chatbotStepExtractingText => '텍스트 추출';

  @override
  String get chatbotStepUnderstandingContent => '내용 분석';

  @override
  String get chatbotStepPreparingChat => '채팅 준비';

  @override
  String get chatbotHistoryTitle => '기록';

  @override
  String get chatbotNoConversationsTitle => '대화 없음';

  @override
  String get chatbotNoConversationsSubtitle => 'PDF를 업로드하세요';

  @override
  String get chatbotUploadPdfButton => 'PDF 업로드';

  @override
  String get chatbotDocumentReadyTitle => '문서 준비 완료';

  @override
  String get chatbotDocumentReadySubtitle => '간단 요약';

  @override
  String get chatbotCurrentSummary => '현재 요약';

  @override
  String get chatbotStartChatting => '채팅 시작';

  @override
  String get chatbotChatGreeting => '👋🏻 안녕하세요! PDF에 대해 질문하세요.';

  @override
  String get chatbotChatYouCanAsk => '질문 예시:';

  @override
  String get chatbotChatPromptSummarize => '문서 요약';

  @override
  String get chatbotChatPromptHighlights => '핵심 내용';

  @override
  String get chatbotChatPromptFinancial => '재무 데이터';

  @override
  String get chatbotChatPromptDates => '중요 날짜';

  @override
  String get chatbotChatInputHint => 'PDF에 대해 질문하세요...';

  @override
  String get chatbotDeleteTitle => '채팅 삭제?';

  @override
  String get chatbotDeleteMessage => '이 작업은 취소할 수 없습니다.';

  @override
  String get chatbotRenameTitle => 'PDF 이름 변경';

  @override
  String get chatbotRenameHint => '이름 입력';

  @override
  String get chatbotAnalyzeFailed => '분석 실패';

  @override
  String get chatbotChatFailed => '응답 실패';

  @override
  String get errorChatbotPdfEmpty => '텍스트 없음';

  @override
  String get pdfAssistantTitle => 'PDF 도우미';

  @override
  String get pdfAssistantSheetTitle => 'PDF 도우미';

  @override
  String get pdfAssistantSheetSubtitle => 'PDF 번역';

  @override
  String get pdfAssistantChoosePdfTitle => 'PDF 선택';

  @override
  String get pdfAssistantChoosePdfDescription => '기기에서 선택';

  @override
  String get pdfAssistantLinkTitle => 'PDF 링크 추가';

  @override
  String get pdfAssistantLinkHint => 'URL 붙여넣기';

  @override
  String get pdfAssistantLinkButton => '다운로드';

  @override
  String get pdfAssistantTranslateTo => '번역 대상';

  @override
  String get pdfAssistantStartProcessing => '시작';

  @override
  String get pdfAssistantNoFileSelected => '파일 없음';

  @override
  String get pdfAssistantSelectLanguage => '언어 선택';

  @override
  String get pdfAssistantProcessingTitle => '처리 중…';

  @override
  String get pdfAssistantProcessingSubtitle => '잠시만 기다려주세요';

  @override
  String get pdfAssistantStepExtracting => '추출 중…';

  @override
  String get pdfAssistantStepTranslating => '번역 중…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'PDF 생성 중…';

  @override
  String get pdfAssistantStepFinalizing => '마무리 중…';

  @override
  String get pdfAssistantResultTitle => '결과';

  @override
  String get pdfAssistantTranslatedPdfTitle => '번역된 PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => '원본 레이아웃 유지';

  @override
  String get pdfAssistantExtractedTextTitle => '추출된 텍스트';

  @override
  String get pdfAssistantExtractedTextDescription => '단순 문서';

  @override
  String get pdfAssistantActionOpen => '열기';

  @override
  String get pdfAssistantActionDownload => '다운로드';

  @override
  String get pdfAssistantDeleteTitle => '삭제?';

  @override
  String get pdfAssistantDeleteMessage => '되돌릴 수 없습니다';

  @override
  String get pdfAssistantDownloadSuccess => '저장 완료';

  @override
  String get pdfAssistantOpenFailed => '열 수 없음';

  @override
  String get pdfAssistantProcessFailed => '처리 실패';

  @override
  String get errorPdfAssistantPickFailed => '선택 실패';

  @override
  String get errorPdfAssistantLinkFailed => '링크 오류';

  @override
  String get errorPdfAssistantPdfEmpty => '빈 PDF';

  @override
  String get commonNext => '다음';

  @override
  String get commonSkip => '건너뛰기';

  @override
  String get commonContinue => '계속';

  @override
  String get splashTagline => 'AI 기반 문서 스캐너';

  @override
  String get onboardingPage1Title => '문서 스캔';

  @override
  String get onboardingPage1Description => '영수증과 메모를 빠르게 촬영하세요.';

  @override
  String get onboardingPage2Title => 'OCR 및 번역';

  @override
  String get onboardingPage2Description => '텍스트를 추출하고 번역하세요.';

  @override
  String get onboardingPage3Title => '저장 및 내보내기';

  @override
  String get onboardingPage3Description => '문서를 쉽게 관리하세요.';

  @override
  String get settingsChooseLanguage => '언어 선택';

  @override
  String get settingsLanguageApply => '적용';
}
