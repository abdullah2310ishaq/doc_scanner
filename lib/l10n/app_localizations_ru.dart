// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

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
  String get commonDone => 'Готово';

  @override
  String get commonLoading => 'Загрузка…';

  @override
  String get commonError => 'Что-то пошло не так';

  @override
  String get commonTryAgain => 'Пожалуйста, попробуйте еще раз';

  @override
  String get navHome => 'Главная';

  @override
  String get navScan => 'Сканировать';

  @override
  String get navDocuments => 'Документы';

  @override
  String get navTranslate => 'Перевод';

  @override
  String get navLive => 'Камера';

  @override
  String get navSettings => 'Настройки';

  @override
  String homeGreeting(String name) {
    return 'Доброе утро, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'AI Документ';

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
  String get homeHeroBadge => 'НА БАЗЕ ИИ';

  @override
  String get homeHeroTitle => 'Умный ИИ OCR\nСканер';

  @override
  String get homeHeroSubtitle =>
      'Распознавание текста (OCR) на базе ИИ: быстро и точно за считанные секунды.';

  @override
  String get homeHeroButton => 'OCR Сканер';

  @override
  String get homeSearchHint => 'Искать здесь';

  @override
  String get homeFeatureOcrTitle => 'OCR Сканер';

  @override
  String get homeFeatureOcrSubtitle =>
      'Сканируйте текст с изображений или документов';

  @override
  String get homeFeaturePdfTitle => 'PDF Ассистент';

  @override
  String get homeFeaturePdfSubtitle => 'Перевод и транскрибация PDF';

  @override
  String get homeFeatureChatbotTitle => 'Спросить PDF';

  @override
  String get homeFeatureChatbotSubtitle =>
      'Загрузите PDF, чтобы задавать вопросы';

  @override
  String get homeFeatureCropTitle => 'Умная обрезка';

  @override
  String get homeFeatureCropSubtitle => 'Автообрезка, очистка и улучшение';

  @override
  String get homeRecentDocuments => 'документы';

  @override
  String get homeSeeAll => 'Смотреть все';

  @override
  String get homeEmptyDocuments =>
      'Документов пока нет. Нажмите «Сканировать», чтобы начать.';

  @override
  String get homeSampleDocName => 'Счет_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 мая 2026 г. • 2.4 МБ';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => 'Изображения';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      many: '$count файлов',
      few: '$count файла',
      one: '1 файл',
      zero: '0 файлов',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count файла',
      many: '$count файлов',
      few: '$count файла',
      one: '1 файл',
      zero: '0 файлов',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDF';

  @override
  String get homeRecentImagesTitle => 'Изображения';

  @override
  String get homeRecentAdded => 'Недавно добавленные';

  @override
  String get homeRecentSelect => 'Выбрать';

  @override
  String get homeRecentSelectAll => 'Выбрать все';

  @override
  String get homeRecentDeselectAll => 'Снять выделение';

  @override
  String get homeRecentSearchPdfs => 'Искать в PDF…';

  @override
  String get homeRecentSearchImages => 'Искать в изображениях…';

  @override
  String get homeRecentNoSearchResults => 'Файлы не найдены';

  @override
  String get homeRecentToggleFavorite => 'Избранное';

  @override
  String get homeRecentUnfavorite => 'Удалить из избранного';

  @override
  String get homeRecentFavoriteAdded => 'Добавлено в избранное';

  @override
  String get homeRecentFavoriteRemoved => 'Удалено из избранного';

  @override
  String get homeRecentPdfEmptyTitle => 'PDF-файлов пока нет';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Загрузите или отсканируйте документы, чтобы создать свой первый PDF';

  @override
  String get homeRecentImageEmptyTitle => 'Изображений пока нет';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Загрузите или отсканируйте изображения, чтобы упорядочить их здесь';

  @override
  String get homeRecentUploadPdf => 'Загрузить PDF';

  @override
  String get homeRecentUploadImages => 'Загрузить изображения';

  @override
  String get homeRecentScanDocument => 'Сканировать документ';

  @override
  String get scanTitle => 'Сканировать';

  @override
  String get scanCapture => 'Снимок';

  @override
  String get scanImportGallery => 'Импорт из галереи';

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
      other: '$count страницы',
      many: '$count страниц',
      few: '$count страницы',
      one: '1 страница',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'Сохранение скана…';

  @override
  String get scanSaved => 'Документ сохранен';

  @override
  String get ocrTitle => 'Распознавание текста';

  @override
  String get ocrRun => 'Распознать текст';

  @override
  String get ocrRunning => 'Чтение текста…';

  @override
  String get ocrEmpty => 'Текст на изображении не найден';

  @override
  String get ocrCopySuccess => 'Текст скопирован';

  @override
  String get ocrEditHint => 'Редактировать распознанный текст';

  @override
  String get ocrInputMethodTitle => 'Выберите метод ввода';

  @override
  String get ocrInputMethodSubtitle => 'Выберите способ извлечения текста';

  @override
  String get ocrInputLiveCameraTitle => 'Камера';

  @override
  String get ocrInputLiveCameraDescription =>
      'Сделайте снимок с помощью камеры в реальном времени';

  @override
  String get ocrInputUploadImageTitle => 'Загрузить изображение';

  @override
  String get ocrInputUploadImageDescription =>
      'Загрузите изображение из галереи';

  @override
  String get ocrLiveCameraTitle => 'OCR Камера';

  @override
  String get ocrLiveCameraTip =>
      'Совет: Для лучшего результата поместите текст в хорошо освещенное место';

  @override
  String get ocrLiveCameraClose => 'Закрыть камеру';

  @override
  String get ocrLiveCameraFlash => 'Вспышка';

  @override
  String get ocrLiveCameraCapture => 'Сделать снимок для распознавания текста';

  @override
  String get ocrLiveCameraInitializing => 'Запуск камеры…';

  @override
  String get ocrAnalyzeTitle => 'OCR Сканер';

  @override
  String get ocrAnalyzeCopy => 'Копировать';

  @override
  String get ocrAnalyzeTranslate => 'Перевести';

  @override
  String get ocrAnalyzeProcessing => 'Анализ текста…';

  @override
  String get ocrAnalyzeTranslateNext => 'Далее откроется Переводчик';

  @override
  String get ocrNoTextTitle => 'Читаемый текст не обнаружен';

  @override
  String get ocrNoTextHint => 'Попробуйте сделать более четкий снимок';

  @override
  String get ocrNoTextRetakePhoto => 'Переснять фото';

  @override
  String get ocrNoTextChooseGallery => 'Выбрать из галереи';

  @override
  String get translateTitle => 'Перевод';

  @override
  String get translateSourceLanguage => 'С';

  @override
  String get translateTargetLanguage => 'На';

  @override
  String get translateSwapLanguages => 'Поменять языки местами';

  @override
  String get translateButton => 'Перевести';

  @override
  String get translateRunning => 'Перевод…';

  @override
  String get translatePasteHint => 'Вставьте или введите текст';

  @override
  String get translateCopyResult => 'Копировать перевод';

  @override
  String get translateResultTitle => 'Перевести текст';

  @override
  String get translateResultSubtitle =>
      'Переводите выбранный текст на любой язык';

  @override
  String get translateSelectedText => 'Выбранный текст';

  @override
  String get translateSelectedLanguage => 'Выбранный язык';

  @override
  String get translateSelectLanguage => 'Выберите язык';

  @override
  String get translateSearchLanguage => 'Поиск языков';

  @override
  String get translateRecentLanguages => 'Последние';

  @override
  String get translateNoLanguagesFound => 'Языки не найдены';

  @override
  String get translateTranslatedText => 'Переведенный текст';

  @override
  String get translatePlaceholder => 'Перевод появится здесь…';

  @override
  String get translateSeeMore => 'Подробнее';

  @override
  String get translateReadAloud => 'Озвучить';

  @override
  String get translateSavePdf => 'Сохранить как PDF';

  @override
  String get translateSavePng => 'Сохранить как PNG';

  @override
  String get translateSaveComingSoon =>
      'Функция сохранения будет доступна в ближайшее время';

  @override
  String get translateDownloadOptionTitle => 'Выберите вариант загрузки';

  @override
  String get translateDownloadOptionSubtitle =>
      'Выберите то, что вы хотите загрузить';

  @override
  String get translateDownloadSelectedTextTitle => 'Скачать выбранный текст';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Скачать только выбранный текст';

  @override
  String get translateDownloadCompleteFileTitle => 'Скачать весь файл';

  @override
  String get translateDownloadCompleteFileDescription => 'Скачать файл целиком';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Скачать переведенный текст';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Скачать только переведенный текст';

  @override
  String get translateSavePdfSuccess => 'PDF успешно сохранен';

  @override
  String get translateSavePngSuccess => 'Изображение успешно сохранено';

  @override
  String get translateExportNeedsTranslation =>
      'Переведите текст перед скачиванием';

  @override
  String get liveTitle => 'Мгновенный перевод';

  @override
  String get liveStart => 'Запустить камеру';

  @override
  String get liveStop => 'Остановить';

  @override
  String get liveListening => 'Прослушивание…';

  @override
  String get livePointAtText => 'Наведите камеру на текст';

  @override
  String get livePermissionNeeded =>
      'Для мгновенного перевода требуется доступ к камере';

  @override
  String get documentsTitle => 'Мои документы';

  @override
  String get documentRename => 'Переименовать';

  @override
  String get documentDeleteConfirmTitle => 'Удалить документ?';

  @override
  String get documentDeleteConfirmMessage => 'Это действие нельзя отменить.';

  @override
  String get documentDeleted => 'Документ удален';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык приложения';

  @override
  String get settingsTheme => 'Тема';

  @override
  String get settingsAbout => 'О приложении';

  @override
  String get settingsPrivacy => 'Политика конфиденциальности';

  @override
  String get settingsTerms => 'Условия использования';

  @override
  String get settingsContactSupport => 'Связаться с поддержкой';

  @override
  String get settingsMoreApps => 'Другие приложения';

  @override
  String get settingsRateApp => 'Оценить';

  @override
  String get settingsShareApp => 'Поделиться';

  @override
  String get settingsGreetingPrefix => 'Доброе утро,';

  @override
  String get settingsDefaultUserName => 'Абдулла';

  @override
  String get permissionCameraTitle => 'Доступ к камере';

  @override
  String get permissionCameraMessage =>
      'Разрешите доступ к камере для сканирования документов и использования мгновенного перевода.';

  @override
  String get permissionStorageTitle => 'Доступ к памяти';

  @override
  String get permissionStorageMessage =>
      'Разрешите доступ для сохранения и открытия ваших сканов.';

  @override
  String get permissionOpenSettings => 'Открыть настройки';

  @override
  String get permissionDenied => 'Доступ запрещен';

  @override
  String get errorCameraUnavailable => 'Камера недоступна на этом устройстве';

  @override
  String get errorFileRead => 'Не удалось прочитать файл';

  @override
  String get errorNetwork => 'Проверьте интернет-соединение';

  @override
  String get errorNoInternetFeatures =>
      'Нет интернет-соединения. Некоторые функции могут работать некорректно.';

  @override
  String get exitAppTitle => 'Выйти из приложения';

  @override
  String get exitAppMessage => 'Вы уверены, что хотите выйти?';

  @override
  String get exitAppConfirm => 'Выйти';

  @override
  String get errorOcrFailed => 'Сбой распознавания текста';

  @override
  String get errorTranslateFailed => 'Сбой перевода';

  @override
  String get errorTranslateModelDownload =>
      'Не удалось скачать языковой пакет. Проверьте соединение и попробуйте снова.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Этот язык недоступен для офлайн-перевода.';

  @override
  String get proTitle => 'Сканер документов Pro';

  @override
  String get proSubtitle =>
      'Безлимитные сканы, OCR, языки и мгновенный перевод';

  @override
  String get proUpgradeButton => 'Перейти на Pro';

  @override
  String get proRestorePurchases => 'Восстановить покупки';

  @override
  String get proFeatureLocked => 'Функция Pro';

  @override
  String proLimitPages(int max) {
    return 'Бесплатный тариф позволяет добавлять до $max страниц в один документ';
  }

  @override
  String get proLimitOcr =>
      'Обновитесь до Pro для безлимитного распознавания текста (OCR)';

  @override
  String get proLimitTranslate =>
      'Обновитесь до Pro для доступа ко всем языкам';

  @override
  String get proLimitLive => 'Мгновенный перевод доступен в версии Pro';

  @override
  String get proPurchaseSuccess => 'Добро пожаловать в Pro!';

  @override
  String get proPurchaseFailed => 'Не удалось завершить покупку';

  @override
  String get exportPdf => 'Экспорт в PDF';

  @override
  String get exportImage => 'Экспорт в изображение';

  @override
  String get exportSuccess => 'Экспорт завершен';

  @override
  String get exportFailed => 'Ошибка экспорта';

  @override
  String get languageSearchHint => 'Поиск языка';

  @override
  String get languageAuto => 'Определить язык';

  @override
  String get chatbotTitle => 'ИИ Чат-бот';

  @override
  String get chatbotHistoryButton => 'История чатов';

  @override
  String get chatbotBadge => 'Ваш умный ИИ-помощник';

  @override
  String get chatbotHeadlineChat => 'Общайтесь';

  @override
  String get chatbotHeadlineMiddle => ' со своим ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Попробуйте спросить';

  @override
  String get chatbotSuggestSummarize => 'Сделай краткое содержание этого PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Главные тезисы этого PDF';

  @override
  String get chatbotSuggestExplain => 'Объясни подробно';

  @override
  String get chatbotSuggestTranslate => 'Переведи этот PDF';

  @override
  String get chatbotAskQuestions => 'Задайте вопросы по этому PDF';

  @override
  String get chatbotUploadHint => 'Загрузить PDF...';

  @override
  String get chatbotSheetTitle => 'Чат с вашим PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Загрузите PDF и задавайте любые вопросы по его содержанию';

  @override
  String get chatbotChoosePdfTitle => 'Выберите PDF-файл';

  @override
  String get chatbotChoosePdfDescription =>
      'Найдите и выберите PDF на своем устройстве';

  @override
  String get chatbotRecentFilesTitle => 'Последние файлы';

  @override
  String get chatbotRecentFilesDescription =>
      'Выберите из ваших последних файлов';

  @override
  String get errorChatbotPdfPickFailed => 'Не удалось открыть выбранный PDF';

  @override
  String get chatbotAnalyzingTitle => 'Анализ вашего документа…';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Пожалуйста, подождите, пока мы читаем и\nанализируем ваш PDF';

  @override
  String get chatbotStepReadingPdf => 'Чтение PDF';

  @override
  String get chatbotStepExtractingText => 'Извлечение текста';

  @override
  String get chatbotStepUnderstandingContent => 'Осмысление контента';

  @override
  String get chatbotStepPreparingChat => 'Подготовка ИИ-чата';

  @override
  String get chatbotHistoryTitle => 'История';

  @override
  String get chatbotNoConversationsTitle => 'Чатов пока нет';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Загрузите PDF, чтобы начать чат со своим ИИ-помощником.';

  @override
  String get chatbotUploadPdfButton => 'Загрузить PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Документ готов';

  @override
  String get chatbotDocumentReadySubtitle =>
      'Теперь вы можете общаться со своим PDF';

  @override
  String get chatbotCurrentSummary => 'Текущее резюме';

  @override
  String get chatbotStartChatting => 'Начать чат';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Привет! Я ваш ИИ-помощник. Задавайте мне любые вопросы по этому PDF, и я помогу вам.';

  @override
  String get chatbotChatYouCanAsk => 'Вы можете спросить меня:';

  @override
  String get chatbotChatPromptSummarize => 'Составь резюме этого документа';

  @override
  String get chatbotChatPromptHighlights => 'Каковы основные моменты?';

  @override
  String get chatbotChatPromptFinancial => 'Покажи финансовые данные';

  @override
  String get chatbotChatPromptDates => 'Извлеки важные даты';

  @override
  String get chatbotChatInputHint => 'Спросить об этом PDF…';

  @override
  String get chatbotDeleteTitle => 'Удалить чат?';

  @override
  String get chatbotDeleteMessage =>
      'Это удалит чат и PDF из вашей истории. Это действие нельзя отменить.';

  @override
  String get chatbotRenameTitle => 'Переименовать PDF';

  @override
  String get chatbotRenameHint => 'Введите имя';

  @override
  String get chatbotHistorySearchHint => 'Поиск по вашим чатам…';

  @override
  String get chatbotRenameSuccess => 'Успешно переименовано';

  @override
  String get chatbotDeleteSuccess => 'Успешно удалено';

  @override
  String get chatbotEmptyConversationPreview => 'Пустой чат…';

  @override
  String get chatbotAiThinking => 'ИИ думает';

  @override
  String get chatbotTipsLabel => 'Советы';

  @override
  String get chatbotSuggestSummarizeChip => 'Краткое резюме\nэтого PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Главные тезисы\nэтого PDF';

  @override
  String get chatbotSuggestExplainChip => 'Объяснить\nподробно';

  @override
  String get chatbotSuggestTranslateChip => 'Перевести\nэтот PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Не удалось проанализировать PDF. Пожалуйста, попробуйте еще раз.';

  @override
  String get chatbotChatFailed =>
      'Не удалось получить ответ. Попробуйте еще раз.';

  @override
  String get errorChatbotPdfEmpty => 'Текст в этом PDF не найден';

  @override
  String get pdfAssistantTitle => 'PDF Ассистент';

  @override
  String get pdfAssistantSheetTitle => 'Загрузить PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Выберите способ добавления PDF-файла';

  @override
  String get pdfAssistantChoosePdfTitle => 'Выберите PDF-файл';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Найдите и выберите PDF на своем устройстве';

  @override
  String get pdfAssistantLinkTitle => 'Добавить PDF по ссылке';

  @override
  String get pdfAssistantLinkDescription =>
      'Вставьте ссылку на PDF для прямой загрузки';

  @override
  String get pdfAssistantLinkHint => 'Вставьте URL-адрес PDF';

  @override
  String get pdfAssistantLinkButton => 'Скачать PDF';

  @override
  String get pdfAssistantTranslateTo => 'Перевести на';

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
  String get pdfAssistantStartProcessing => 'Начать обработку';

  @override
  String get pdfAssistantNoFileSelected => 'Файл не выбран';

  @override
  String get pdfAssistantSelectLanguage => 'Пожалуйста, выберите целевой язык';

  @override
  String get pdfAssistantProcessingTitle => 'Обработка вашего PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Пожалуйста, подождите.';

  @override
  String get pdfAssistantStepExtracting => 'Извлечение текста…';

  @override
  String get pdfAssistantStepTranslating => 'Перевод контента…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Создание переведенного PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Завершение…';

  @override
  String get pdfAssistantResultTitle => 'Результаты';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'Переведенный PDF';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Оригинальная верстка с наложением переведенного текста';

  @override
  String get pdfAssistantExtractedTextTitle => 'Извлеченный переведенный текст';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Простой текстовый документ формата A4';

  @override
  String get pdfAssistantActionOpen => 'Открыть';

  @override
  String get pdfAssistantActionDownload => 'Скачать';

  @override
  String get pdfAssistantDeleteTitle => 'Удалить результаты?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Это удалит переведенные файлы с вашего устройства.';

  @override
  String get pdfAssistantDownloadSuccess => 'Сохранено в «Загрузки»';

  @override
  String get pdfAssistantOpenFailed => 'Не удалось открыть файл';

  @override
  String get pdfAssistantProcessFailed => 'Не удалось обработать этот PDF';

  @override
  String get errorPdfAssistantPickFailed => 'Не удалось открыть выбранный PDF';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Не удалось скачать PDF по этой ссылке';

  @override
  String get errorPdfAssistantPdfEmpty => 'Текст в этом PDF не найден';

  @override
  String get pdfAssistantRemoveTitle => 'Удалить PDF';

  @override
  String get pdfAssistantRemoveWarning => 'Это удалит PDF с вашего устройства.';

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
  String get onboardingStart => 'Начать с →';

  @override
  String get splashTagline => 'Сканирование документов на базе ИИ';

  @override
  String get onboardingPage1Title => 'Скан текста\nза секунды';

  @override
  String get onboardingPage1Description =>
      'Распознавайте текст на изображениях с помощью быстрого OCR на базе ИИ.';

  @override
  String get onboardingPage2Title => 'Умный PDF\nассистент';

  @override
  String get onboardingPage2Description =>
      'Переводите, извлекайте и анализируйте ваши PDF-документы с помощью ИИ.';

  @override
  String get onboardingPage3Title => 'Чат с вашими\nPDF-файлами';

  @override
  String get onboardingPage3Description =>
      'Задавайте вопросы, создавайте резюме и получайте мгновенные ответы от ИИ.';

  @override
  String get onboardingPage4Title => 'Умная обрезка\nза секунды';

  @override
  String get onboardingPage4Description =>
      'Автоматически обрезайте несколько изображений и мгновенно создавайте чистые PDF.';

  @override
  String get settingsChooseLanguage => 'Выберите язык';

  @override
  String get settingsLanguageApply => 'Применить';

  @override
  String get commonSaving => 'Сохранение…';

  @override
  String get smartCropTitle => 'Умная обрезка';

  @override
  String get smartCropInputMethodTitle => 'Сканер с умной обрезкой';

  @override
  String get smartCropInputMethodSubtitle =>
      'Выберите способ обрезки документа';

  @override
  String get smartCropInputLiveCameraTitle => 'Камера';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Сканер Google — автоопределение краев, обрезка и улучшение';

  @override
  String get smartCropInputUploadImageTitle => 'Загрузить изображение';

  @override
  String get smartCropInputUploadImageDescription =>
      'Загрузите изображение документа из галереи';

  @override
  String get smartCropUploadIntroHeadline =>
      'Автоматическая обрезка\nнескольких изображений';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Автоматически определяйте края, идеально обрезайте изображения и создавайте PDF в одно касание.';

  @override
  String get smartCropUploadIntroStepSelect => 'Выберите несколько изображений';

  @override
  String get smartCropUploadIntroStepCrop => 'Автоопределение и обрезка';

  @override
  String get smartCropUploadIntroStepPdf => 'Мгновенное создание PDF';

  @override
  String get smartCropUploadIntroSelectImages => 'Выбрать изображения';

  @override
  String get smartCropLiveCameraTitle => 'Камера с умной обрезкой';

  @override
  String get smartCropLiveCameraTip =>
      'Документ обнаружен — нажмите, чтобы снять';

  @override
  String get smartCropLiveCameraAlignTip => 'Выровняйте документ внутри углов';

  @override
  String get smartCropLiveCameraClose => 'Закрыть камеру';

  @override
  String get smartCropLiveCameraFlash => 'Вспышка';

  @override
  String get smartCropLiveCameraCapture => 'Снять документ для умной обрезки';

  @override
  String get smartCropLiveCameraInitializing => 'Запуск камеры…';

  @override
  String get smartCropCapturedTitle => 'Снятый документ';

  @override
  String get smartCropCapturedRetake => 'Переснять последнее фото';

  @override
  String get smartCropCapturedAnotherPhoto => 'Добавить еще одно фото';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Переснять другое фото';

  @override
  String get smartCropCapturedPreview => 'Предпросмотр';

  @override
  String get smartCropPreviewTitle => 'Предпросмотр';

  @override
  String get smartCropCapturedCrop => 'Обрезать';

  @override
  String get smartCropAdjustCornersTitle => 'Корректировка углов';

  @override
  String get smartCropAdjustCornersHint =>
      'Перетащите фиолетовые углы так, чтобы они совпадали с краями документа';

  @override
  String get smartCropAdjustCornersConfirm => 'Применить обрезку';

  @override
  String get smartCropDetectingEdges => 'Определение краев документа…';

  @override
  String get smartCropAndroidOnly =>
      'Умное сканирование доступно только на Android.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Достигнут лимит в $max фото';
  }

  @override
  String get smartCropProcessingCrop => 'Применение «магической» обрезки…';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Обрезка $count документов…';
  }

  @override
  String get smartCropCroppedTitle => 'Обрезанный документ';

  @override
  String get smartCropFilterOriginal => 'Оригинал';

  @override
  String get smartCropFilterLighten => 'Осветление';

  @override
  String get smartCropFilterMagic => 'Магия';

  @override
  String get smartCropFilterGrayscale => 'Оттенки серого';

  @override
  String get smartCropFilterMono => 'Ч/Б';

  @override
  String get smartCropFilterWarm => 'Теплый';

  @override
  String get smartCropActionCreatePdf => 'Создать PDF';

  @override
  String get smartCropProcessingPdf => 'Создание PDF-документа…';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Создание PDF-файла из $count страниц…';
  }

  @override
  String get smartCropPdfSuccess => 'PDF-документ успешно создан';

  @override
  String get smartCropPdfPagesLabel => 'страниц';

  @override
  String get smartCropPdfSinglePageLabel => '1 страница';

  @override
  String get smartCropImageCopied => 'Скопировано';

  @override
  String get smartCropDeleteImageConfirm =>
      'Удалить эту страницу из документа?';

  @override
  String get smartCropDeletePdfConfirm =>
      'Удалить этот PDF с вашего устройства?';

  @override
  String get smartCropPdfRenamed => 'PDF переименован';

  @override
  String get smartCropPdfFileName => 'Имя файла';

  @override
  String get smartCropPdfFileSize => 'Размер файла';

  @override
  String get smartCropViewPdf => 'Просмотреть PDF';

  @override
  String get smartCropSavePdf => 'Сохранить PDF';

  @override
  String get smartCropRenamePdf => 'Переименовать';

  @override
  String get smartCropRenamePdfHint => 'Имя документа';

  @override
  String get smartCropStepReadingImages => 'Чтение изображений';

  @override
  String get smartCropStepDetectingEdges => 'Определение краев';

  @override
  String get smartCropStepCroppingImages => 'Обрезка';

  @override
  String get smartCropStepGeneratingPdf => 'Создание PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Упорядочивание изображений\nв качественный PDF-файл';

  @override
  String get smartCropProcessingPdfTitle => 'Создание PDF';

  @override
  String get commonUntitledDocument => 'документ';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Нажмите, чтобы просмотреть папки устройства';

  @override
  String get errorPdfTextLoad => 'Ошибка загрузки текста.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Перевод: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Перевод документа';

  @override
  String get translateExportTranslatedBadge => 'Переведено';

  @override
  String get translateExportVerifiedFooter =>
      'Проверенный экспорт офлайн-перевода';

  @override
  String get translateExportPdfHeader => 'Экспорт перевода';

  @override
  String get translateExportPdfFooterLabel => 'Конфиденциальный документ';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Страница $page из $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Страница $page';
  }

  @override
  String fileSizeBytes(String size) {
    return '$size Б';
  }

  @override
  String fileSizeKb(String size) {
    return '$size КБ';
  }

  @override
  String fileSizeMb(String size) {
    return '$size МБ';
  }

  @override
  String get translateLangName_en => 'Английский';

  @override
  String get translateLangName_ur => 'Урду';

  @override
  String get translateLangName_hi => 'Хинди';

  @override
  String get translateLangName_ar => 'Арабский';

  @override
  String get translateLangName_es => 'Испанский';

  @override
  String get translateLangName_fr => 'Французский';

  @override
  String get translateLangName_de => 'Немецкий';

  @override
  String get translateLangName_pt => 'Португальский';

  @override
  String get translateLangName_ru => 'Русский';

  @override
  String get translateLangName_zh => 'Китайский (упрощенный)';

  @override
  String get translateLangName_zhTw => 'Китайский (традиционный)';

  @override
  String get translateLangName_ja => 'Японский';

  @override
  String get translateLangName_ko => 'Корейский';

  @override
  String get translateLangName_it => 'Итальянский';

  @override
  String get translateLangName_tr => 'Турецкий';

  @override
  String get translateLangName_nl => 'Нидерландский';

  @override
  String get translateLangName_sv => 'Шведский';

  @override
  String get translateLangName_no => 'Норвежский';

  @override
  String get translateLangName_da => 'Датский';

  @override
  String get translateLangName_fi => 'Финский';

  @override
  String get translateLangName_el => 'Греческий';

  @override
  String get translateLangName_pl => 'Польский';

  @override
  String get translateLangName_cs => 'Чешский';

  @override
  String get translateLangName_hu => 'Венгерский';

  @override
  String get translateLangName_ro => 'Румынский';

  @override
  String get translateLangName_bg => 'Болгарский';

  @override
  String get translateLangName_uk => 'Украинский';

  @override
  String get translateLangName_fa => 'Персидский';

  @override
  String get translateLangName_he => 'Иврит';

  @override
  String get translateLangName_th => 'Тайский';

  @override
  String get translateLangName_vi => 'Вьетнамский';

  @override
  String get translateLangName_id => 'Индонезийский';

  @override
  String get translateLangName_ms => 'Малайский';

  @override
  String get translateLangName_bn => 'Бенгальский';

  @override
  String get translateLangName_ta => 'Тамильский';

  @override
  String get translateLangName_te => 'Телугу';

  @override
  String get translateLangName_mr => 'Маратхи';

  @override
  String get translateLangName_gu => 'Гуджарати';

  @override
  String get translateLangName_kn => 'Каннада';

  @override
  String get translateLangName_ml => 'Малаялам';

  @override
  String get translateLangName_pa => 'Панджаби';

  @override
  String get translateLangName_sw => 'Суахили';

  @override
  String get translateLangName_af => 'Африкаанс';

  @override
  String get translateLangName_ca => 'Каталанский';

  @override
  String get translateLangName_hr => 'Хорватский';

  @override
  String get translateLangName_sk => 'Словацкий';

  @override
  String get translateLangName_sl => 'Словенский';

  @override
  String get translateLangName_sr => 'Сербский';

  @override
  String get translateLangName_lt => 'Литовский';

  @override
  String get translateLangName_lv => 'Латышский';

  @override
  String get translateLangName_et => 'Эстонский';

  @override
  String get translateLangName_is => 'Исландский';

  @override
  String get translateLangName_ga => 'Ирландский';

  @override
  String get translateLangName_mt => 'Мальтийский';

  @override
  String get translateLangName_sq => 'Албанский';

  @override
  String get translateLangName_mk => 'Македонский';

  @override
  String get translateLangName_be => 'Белорусский';

  @override
  String get translateLangName_kk => 'Казахский';

  @override
  String get translateLangName_uz => 'Узбекский';

  @override
  String get translateLangName_az => 'Азербайджанский';

  @override
  String get translateLangName_hy => 'Армянский';

  @override
  String get translateLangName_ka => 'Грузинский';

  @override
  String get translateLangName_lo => 'Лаосский';

  @override
  String get translateLangName_km => 'Кхмерский';

  @override
  String get translateLangName_my => 'Бирманский';

  @override
  String get translateLangName_ne => 'Непальский';

  @override
  String get translateLangName_si => 'Сингальский';

  @override
  String get translateLangName_am => 'Амхарский';

  @override
  String get translateLangName_ha => 'Хауса';

  @override
  String get translateLangName_yo => 'Йоруба';

  @override
  String get translateLangName_ig => 'Игбо';

  @override
  String get translateLangName_zu => 'Зулу';

  @override
  String get translateLangName_xh => 'Коса';

  @override
  String get translateLangName_st => 'Сесото';

  @override
  String get translateLangName_sn => 'Шона';

  @override
  String get translateLangName_rw => 'Киньяруанда';

  @override
  String get translateLangName_so => 'Сомалийский';

  @override
  String get translateLangName_mg => 'Малагасийский';

  @override
  String get translateLangName_cy => 'Валлийский';

  @override
  String get translateLangName_mn => 'Монгольский';

  @override
  String get translateLangName_tl => 'Тагальский / Филиппинский';

  @override
  String get translateLangName_ht => 'Гаитянский креольский';

  @override
  String get translateLangName_eo => 'Эсперанто';

  @override
  String get translateLangName_la => 'Латынь';

  @override
  String get translateLangName_ku => 'Курдский';

  @override
  String get translateLangName_ps => 'Пушту';

  @override
  String get translateLangName_faAf => 'Дари';

  @override
  String get translateLangName_bs => 'Боснийский';

  @override
  String get translateLangName_mi => 'Маори';

  @override
  String get translateLangName_sm => 'Самоанский';

  @override
  String get translateLangName_haw => 'Гавайский';

  @override
  String get translateLangName_lb => 'Люксембургский';
}
