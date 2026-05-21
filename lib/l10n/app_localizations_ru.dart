// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Сканер документов';

  @override
  String get commonOk => 'ОК';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonShare => 'Поделиться';

  @override
  String get commonCopy => 'Копировать';

  @override
  String get commonRetry => 'Повторить';

  @override
  String get commonClose => 'Закрыть';

  @override
  String get commonLoading => 'Загрузка…';

  @override
  String get commonError => 'Что-то пошло не так';

  @override
  String get commonTryAgain => 'Попробуйте снова';

  @override
  String get navHome => 'Главная';

  @override
  String get navScan => 'Сканирование';

  @override
  String get navDocuments => 'Документы';

  @override
  String get navTranslate => 'Перевод';

  @override
  String get navLive => 'Онлайн';

  @override
  String get navSettings => 'Настройки';

  @override
  String homeGreeting(String name) {
    return 'Доброе утро, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI документ';

  @override
  String get homeTitleHighlight => 'Сканер';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Открыть меню';

  @override
  String get homeTagAiPowered => 'На базе ИИ';

  @override
  String get homeTagFastOcr => 'Быстрый OCR';

  @override
  String get homeTagSecure => 'Безопасно';

  @override
  String get homeTagSmartCrop => 'Умная обрезка';

  @override
  String get homeHeroBadge => 'AI POWERED';

  @override
  String get homeHeroTitle => 'Умный OCR\nсканер';

  @override
  String get homeHeroSubtitle =>
      'ИИ OCR для быстрого и точного распознавания текста за секунды.';

  @override
  String get homeHeroButton => 'OCR сканер';

  @override
  String get homeSearchHint => 'Поиск';

  @override
  String get homeFeatureOcrTitle => 'OCR сканер';

  @override
  String get homeFeatureOcrSubtitle =>
      'Извлечение текста из изображений и документов';

  @override
  String get homeFeaturePdfTitle => 'PDF ассистент';

  @override
  String get homeFeaturePdfSubtitle => 'Перевод и распознавание PDF';

  @override
  String get homeFeatureChatbotTitle => 'ИИ чат-бот';

  @override
  String get homeFeatureChatbotSubtitle => 'Загрузите PDF и задавайте вопросы';

  @override
  String get homeFeatureCropTitle => 'Умная обрезка';

  @override
  String get homeFeatureCropSubtitle => 'Автообрезка и улучшение';

  @override
  String get homeRecentDocuments => 'Недавние документы';

  @override
  String get homeSeeAll => 'Смотреть все';

  @override
  String get homeEmptyDocuments =>
      'Нет документов. Нажмите «Сканировать», чтобы начать.';

  @override
  String get homeSampleDocName => 'Счёт_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 мая 2026 • 2.4 МБ';

  @override
  String get scanTitle => 'Сканирование';

  @override
  String get scanCapture => 'Снять';

  @override
  String get scanImportGallery => 'Из галереи';

  @override
  String get scanImportFiles => 'Импорт файла';

  @override
  String get scanAddPage => 'Добавить страницу';

  @override
  String get scanRetake => 'Переснять';

  @override
  String get scanCrop => 'Обрезать';

  @override
  String get scanEnhance => 'Улучшить';

  @override
  String get scanDone => 'Готово';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count страниц',
      few: '$count страницы',
      one: '1 страница',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'Сохранение скана…';

  @override
  String get scanSaved => 'Документ сохранён';

  @override
  String get ocrTitle => 'Распознавание текста';

  @override
  String get ocrRun => 'Распознать текст';

  @override
  String get ocrRunning => 'Чтение текста…';

  @override
  String get ocrEmpty => 'Текст не найден';

  @override
  String get ocrCopySuccess => 'Текст скопирован';

  @override
  String get ocrEditHint => 'Редактировать текст';

  @override
  String get ocrInputMethodTitle => 'Выбор ввода';

  @override
  String get ocrInputMethodSubtitle => 'Выберите способ извлечения текста';

  @override
  String get ocrInputLiveCameraTitle => 'Камера';

  @override
  String get ocrInputLiveCameraDescription => 'Съёмка с камеры';

  @override
  String get ocrInputUploadImageTitle => 'Загрузить изображение';

  @override
  String get ocrInputUploadImageDescription => 'Выбрать из галереи';

  @override
  String get ocrLiveCameraTitle => 'OCR камера';

  @override
  String get ocrLiveCameraTip => 'Совет: используйте хорошее освещение';

  @override
  String get ocrLiveCameraClose => 'Закрыть камеру';

  @override
  String get ocrLiveCameraFlash => 'Вспышка';

  @override
  String get ocrLiveCameraCapture => 'Сканировать';

  @override
  String get ocrLiveCameraInitializing => 'Запуск камеры…';

  @override
  String get ocrAnalyzeTitle => 'OCR сканер';

  @override
  String get ocrAnalyzeCopy => 'Копировать';

  @override
  String get ocrAnalyzeTranslate => 'Перевести';

  @override
  String get ocrAnalyzeProcessing => 'Анализ…';

  @override
  String get ocrAnalyzeTranslateNext => 'Открытие перевода';

  @override
  String get ocrNoTextTitle => 'Текст не найден';

  @override
  String get ocrNoTextHint => 'Попробуйте более чёткое изображение';

  @override
  String get ocrNoTextRetakePhoto => 'Переснять';

  @override
  String get ocrNoTextChooseGallery => 'Выбрать из галереи';

  @override
  String get translateTitle => 'Перевод';

  @override
  String get translateSourceLanguage => 'С';

  @override
  String get translateTargetLanguage => 'На';

  @override
  String get translateSwapLanguages => 'Поменять языки';

  @override
  String get translateButton => 'Перевести';

  @override
  String get translateRunning => 'Перевод…';

  @override
  String get translatePasteHint => 'Введите или вставьте текст';

  @override
  String get translateCopyResult => 'Копировать перевод';

  @override
  String get translateResultTitle => 'Перевод';

  @override
  String get translateResultSubtitle => 'Перевод текста на любой язык';

  @override
  String get translateSelectedText => 'Выбранный текст';

  @override
  String get translateSelectedLanguage => 'Выбранный язык';

  @override
  String get translateSelectLanguage => 'Выбрать язык';

  @override
  String get translateSearchLanguage => 'Поиск языка';

  @override
  String get translateRecentLanguages => 'Недавние';

  @override
  String get translateNoLanguagesFound => 'Языки не найдены';

  @override
  String get translateTranslatedText => 'Переведённый текст';

  @override
  String get translatePlaceholder => 'Перевод появится здесь…';

  @override
  String get translateSeeMore => 'Показать ещё';

  @override
  String get translateReadAloud => 'Озвучить';

  @override
  String get translateSavePdf => 'Сохранить PDF';

  @override
  String get translateSavePng => 'Сохранить изображение';

  @override
  String get translateSaveComingSoon => 'Скоро';

  @override
  String get translateDownloadOptionTitle => 'Выберите загрузку';

  @override
  String get translateDownloadOptionSubtitle => 'Что вы хотите скачать';

  @override
  String get translateDownloadSelectedTextTitle => 'Скачать выделенный текст';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Только выделенный текст';

  @override
  String get translateDownloadCompleteFileTitle => 'Скачать весь файл';

  @override
  String get translateDownloadCompleteFileDescription => 'Полный файл';

  @override
  String get translateSavePdfSuccess => 'PDF сохранён';

  @override
  String get translateSavePngSuccess => 'Изображение сохранено';

  @override
  String get translateExportNeedsTranslation => 'Сначала переведите текст';

  @override
  String get liveTitle => 'Живой перевод';

  @override
  String get liveStart => 'Запустить камеру';

  @override
  String get liveStop => 'Стоп';

  @override
  String get liveListening => 'Распознавание…';

  @override
  String get livePointAtText => 'Наведите на текст';

  @override
  String get livePermissionNeeded => 'Требуется доступ к камере';

  @override
  String get documentsTitle => 'Мои документы';

  @override
  String get documentRename => 'Переименовать';

  @override
  String get documentDeleteConfirmTitle => 'Удалить документ?';

  @override
  String get documentDeleteConfirmMessage => 'Это действие нельзя отменить.';

  @override
  String get documentDeleted => 'Документ удалён';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык приложения';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsPrivacy => 'Конфиденциальность';

  @override
  String get settingsTerms => 'Условия использования';

  @override
  String get permissionCameraTitle => 'Разрешение камеры';

  @override
  String get permissionCameraMessage =>
      'Разрешите доступ к камере для сканирования.';

  @override
  String get permissionStorageTitle => 'Разрешение памяти';

  @override
  String get permissionStorageMessage => 'Разрешите сохранение файлов.';

  @override
  String get permissionOpenSettings => 'Открыть настройки';

  @override
  String get permissionDenied => 'Доступ запрещён';

  @override
  String get errorCameraUnavailable => 'Камера недоступна';

  @override
  String get errorFileRead => 'Не удалось прочитать файл';

  @override
  String get errorNetwork => 'Проверьте интернет-соединение';

  @override
  String get errorNoInternetFeatures => 'Нет интернета';

  @override
  String get exitAppTitle => 'Выход';

  @override
  String get exitAppMessage => 'Вы действительно хотите выйти?';

  @override
  String get exitAppConfirm => 'Выйти';

  @override
  String get errorOcrFailed => 'Ошибка OCR';

  @override
  String get errorTranslateFailed => 'Ошибка перевода';

  @override
  String get errorTranslateModelDownload => 'Ошибка загрузки языкового пакета';

  @override
  String get errorTranslateUnsupportedLanguage => 'Язык не поддерживается';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'Безлимитное сканирование и OCR';

  @override
  String get proUpgradeButton => 'Перейти на Pro';

  @override
  String get proRestorePurchases => 'Восстановить покупки';

  @override
  String get proFeatureLocked => 'Функция Pro';

  @override
  String proLimitPages(int max) {
    return 'Бесплатно до $max страниц';
  }

  @override
  String get proLimitOcr => 'Неограниченный OCR в Pro';

  @override
  String get proLimitTranslate => 'Все языки в Pro';

  @override
  String get proLimitLive => 'Живой перевод только в Pro';

  @override
  String get proPurchaseSuccess => 'Добро пожаловать в Pro!';

  @override
  String get proPurchaseFailed => 'Ошибка покупки';

  @override
  String get exportPdf => 'Экспорт PDF';

  @override
  String get exportImage => 'Экспорт изображения';

  @override
  String get exportSuccess => 'Экспорт завершён';

  @override
  String get exportFailed => 'Ошибка экспорта';

  @override
  String get languageSearchHint => 'Поиск языка';

  @override
  String get languageAuto => 'Автоопределение';

  @override
  String get chatbotTitle => 'ИИ чат-бот';

  @override
  String get chatbotHistoryButton => 'История';

  @override
  String get chatbotBadge => 'Ваш ИИ ассистент';

  @override
  String get chatbotHeadlineChat => 'Чат';

  @override
  String get chatbotHeadlineMiddle => ' с вашим ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Попробуйте спросить';

  @override
  String get chatbotSuggestSummarize => 'Суммировать PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Ключевые моменты';

  @override
  String get chatbotSuggestExplain => 'Объяснить подробно';

  @override
  String get chatbotSuggestTranslate => 'Перевести PDF';

  @override
  String get chatbotUploadHint => 'Загрузите PDF...';

  @override
  String get chatbotSheetTitle => 'Чат с PDF';

  @override
  String get chatbotSheetSubtitle => 'Загрузите PDF и задавайте вопросы';

  @override
  String get chatbotChoosePdfTitle => 'Выбрать PDF';

  @override
  String get chatbotChoosePdfDescription => 'С устройства';

  @override
  String get chatbotRecentFilesTitle => 'Недавние файлы';

  @override
  String get chatbotRecentFilesDescription => 'Выбрать из недавних';

  @override
  String get errorChatbotPdfPickFailed => 'Не удалось открыть PDF';

  @override
  String get chatbotAnalyzingTitle => 'Анализ документа...';

  @override
  String get chatbotAnalyzingSubtitle => 'Пожалуйста, подождите';

  @override
  String get chatbotStepReadingPdf => 'Чтение PDF';

  @override
  String get chatbotStepExtractingText => 'Извлечение текста';

  @override
  String get chatbotStepUnderstandingContent => 'Анализ содержания';

  @override
  String get chatbotStepPreparingChat => 'Подготовка чата';

  @override
  String get chatbotHistoryTitle => 'История';

  @override
  String get chatbotNoConversationsTitle => 'Нет диалогов';

  @override
  String get chatbotNoConversationsSubtitle => 'Загрузите PDF для начала';

  @override
  String get chatbotUploadPdfButton => 'Загрузить PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Документ готов';

  @override
  String get chatbotDocumentReadySubtitle => 'Краткое резюме';

  @override
  String get chatbotCurrentSummary => 'Текущее резюме';

  @override
  String get chatbotStartChatting => 'Начать чат';

  @override
  String get chatbotChatGreeting => '👋🏻 Привет! Задайте вопрос по PDF.';

  @override
  String get chatbotChatYouCanAsk => 'Вы можете спросить:';

  @override
  String get chatbotChatPromptSummarize => 'Суммировать документ';

  @override
  String get chatbotChatPromptHighlights => 'Ключевые моменты';

  @override
  String get chatbotChatPromptFinancial => 'Финансовые данные';

  @override
  String get chatbotChatPromptDates => 'Важные даты';

  @override
  String get chatbotChatInputHint => 'Спросите про PDF...';

  @override
  String get chatbotDeleteTitle => 'Удалить чат?';

  @override
  String get chatbotDeleteMessage => 'Это нельзя отменить.';

  @override
  String get chatbotRenameTitle => 'Переименовать PDF';

  @override
  String get chatbotRenameHint => 'Введите имя';

  @override
  String get chatbotAnalyzeFailed => 'Ошибка анализа';

  @override
  String get chatbotChatFailed => 'Ошибка ответа';

  @override
  String get errorChatbotPdfEmpty => 'Текст не найден';

  @override
  String get pdfAssistantTitle => 'PDF ассистент';

  @override
  String get pdfAssistantSheetTitle => 'Загрузить PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Выберите, как вы хотите добавить свой PDF-файл';

  @override
  String get pdfAssistantChoosePdfTitle => 'Выбрать PDF';

  @override
  String get pdfAssistantChoosePdfDescription => 'С устройства';

  @override
  String get pdfAssistantLinkTitle => 'Добавить ссылку PDF';

  @override
  String get pdfAssistantLinkDescription =>
      'Вставьте ссылку на PDF для прямой загрузки';

  @override
  String get pdfAssistantLinkHint => 'Вставьте URL';

  @override
  String get pdfAssistantLinkButton => 'Скачать';

  @override
  String get pdfAssistantTranslateTo => 'Перевести на';

  @override
  String get pdfAssistantStartProcessing => 'Начать';

  @override
  String get pdfAssistantNoFileSelected => 'Файл не выбран';

  @override
  String get pdfAssistantSelectLanguage => 'Выберите язык';

  @override
  String get pdfAssistantProcessingTitle => 'Обработка…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Пожалуйста, подождите';

  @override
  String get pdfAssistantStepExtracting => 'Извлечение…';

  @override
  String get pdfAssistantStepTranslating => 'Перевод…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Создание PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Завершение…';

  @override
  String get pdfAssistantResultTitle => 'Результат';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'Переведённый PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'Оригинальный макет';

  @override
  String get pdfAssistantExtractedTextTitle => 'Извлечённый текст';

  @override
  String get pdfAssistantExtractedTextDescription => 'Простой документ';

  @override
  String get pdfAssistantActionOpen => 'Открыть';

  @override
  String get pdfAssistantActionDownload => 'Скачать';

  @override
  String get pdfAssistantDeleteTitle => 'Удалить?';

  @override
  String get pdfAssistantDeleteMessage => 'Это нельзя отменить';

  @override
  String get pdfAssistantDownloadSuccess => 'Сохранено';

  @override
  String get pdfAssistantOpenFailed => 'Не удалось открыть';

  @override
  String get pdfAssistantProcessFailed => 'Ошибка обработки';

  @override
  String get errorPdfAssistantPickFailed => 'Ошибка выбора';

  @override
  String get errorPdfAssistantLinkFailed => 'Неверная ссылка';

  @override
  String get errorPdfAssistantPdfEmpty => 'Пустой PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Удалить PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Это приведет к удалению PDF с вашего устройства.';

  @override
  String get pdfAssistantUploadPdf => 'Загрузить PDF';

  @override
  String get cancel => 'Отмена';

  @override
  String get remove => 'Удалить';

  @override
  String get commonNext => 'Далее';

  @override
  String get commonSkip => 'Пропустить';

  @override
  String get commonContinue => 'Продолжить';

  @override
  String get splashTagline => 'AI-сканер документов';

  @override
  String get onboardingPage1Title => 'Сканируйте документы';

  @override
  String get onboardingPage1Description =>
      'Быстро захватывайте чеки и заметки.';

  @override
  String get onboardingPage2Title => 'OCR и перевод';

  @override
  String get onboardingPage2Description => 'Извлекайте и переводите текст.';

  @override
  String get onboardingPage3Title => 'Сохранение и экспорт';

  @override
  String get onboardingPage3Description => 'Управляйте документами легко.';

  @override
  String get settingsChooseLanguage => 'Выберите язык';

  @override
  String get settingsLanguageApply => 'Применить';

  @override
  String get commonSaving => 'Сохранение…';
}
