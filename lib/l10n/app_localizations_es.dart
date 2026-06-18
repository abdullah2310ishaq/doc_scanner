// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonShare => 'Compartir';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonClose => 'Cerrar';

  @override
  String get commonDone => 'Listo';

  @override
  String get commonLoading => 'Cargando…';

  @override
  String get commonError => 'Algo salió mal';

  @override
  String get commonTryAgain => 'Por favor, inténtalo de nuevo';

  @override
  String get navHome => 'Inicio';

  @override
  String get navScan => 'Escanear';

  @override
  String get navDocuments => 'Documentos';

  @override
  String get navTranslate => 'Traducir';

  @override
  String get navLive => 'En vivo';

  @override
  String get navSettings => 'Ajustes';

  @override
  String homeGreeting(String name) {
    return 'Buenos días, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'Documento IA';

  @override
  String get homeTitleHighlight => 'Escáner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Abrir menú';

  @override
  String get homeTagAiPowered => 'Con tecnología de IA';

  @override
  String get homeTagFastOcr => 'OCR rápido';

  @override
  String get homeTagSecure => 'Seguro';

  @override
  String get homeTagSmartCrop => 'Recorte inteligente';

  @override
  String get homeHeroBadge => 'CON TECNOLOGÍA DE IA';

  @override
  String get homeHeroTitle => 'Escáner OCR\ninteligente con IA';

  @override
  String get homeHeroSubtitle =>
      'OCR con tecnología de IA para un reconocimiento de texto rápido y preciso en segundos.';

  @override
  String get homeHeroButton => 'Escáner OCR';

  @override
  String get homeSearchHint => 'Buscar aquí';

  @override
  String get homeFeatureOcrTitle => 'Escáner OCR';

  @override
  String get homeFeatureOcrSubtitle => 'Escanea texto de imágenes o documentos';

  @override
  String get homeFeaturePdfTitle => 'Asistente PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traducir y transcribir PDF';

  @override
  String get homeFeatureChatbotTitle => 'Preguntar al PDF';

  @override
  String get homeFeatureChatbotSubtitle => 'Sube un PDF para hacer preguntas';

  @override
  String get homeFeatureCropTitle => 'Recorte inteligente';

  @override
  String get homeFeatureCropSubtitle =>
      'Recorta, limpia y mejora automáticamente';

  @override
  String get homeRecentDocuments => 'Recientes';

  @override
  String get homeSeeAll => 'Ver todo';

  @override
  String get homeEmptyDocuments =>
      'Aún no hay documentos. Toca Escanear para comenzar.';

  @override
  String get homeSampleDocName => 'Factura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 de mayo de 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDF';

  @override
  String get homeRecentImagesFolder => 'Imágenes';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '1 archivo',
      zero: '0 archivos',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count archivos',
      one: '1 archivo',
      zero: '0 archivos',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDFs';

  @override
  String get homeRecentImagesTitle => 'Imágenes';

  @override
  String get homeRecentAdded => 'Recientes';

  @override
  String get homeRecentSelect => 'Seleccionar';

  @override
  String get homeRecentSelectAll => 'Seleccionar todo';

  @override
  String get homeRecentDeselectAll => 'Deseleccionar todo';

  @override
  String get homeRecentSearchPdfs => 'Buscar PDF…';

  @override
  String get homeRecentSearchImages => 'Buscar imágenes…';

  @override
  String get homeRecentNoSearchResults => 'Sin resultados';

  @override
  String get homeRecentToggleFavorite => 'Favorito';

  @override
  String get homeRecentUnfavorite => 'Quitar';

  @override
  String get homeRecentFavoriteAdded => 'Añadido a favoritos';

  @override
  String get homeRecentFavoriteRemoved => 'Eliminado de favoritos';

  @override
  String get homeRecentPdfEmptyTitle => 'No hay PDFs recientes';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Sube o escanea documentos para crear tu primer PDF';

  @override
  String get homeRecentImageEmptyTitle => 'No hay imágenes recientes';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Sube o escanea imágenes para organizarlas aquí';

  @override
  String get homeRecentUploadPdf => 'Subir un PDF';

  @override
  String get homeRecentUploadImages => 'Subir imágenes';

  @override
  String get homeRecentScanDocument => 'Escanear documento';

  @override
  String get homeRecentDeleteImageTitle => '¿Eliminar imagen?';

  @override
  String get homeRecentDeleteImageMessage =>
      '¿Estás seguro de que quieres eliminar esta imagen? Esta acción no se puede deshacer.';

  @override
  String get homeRecentDeleteImagesTitle => '¿Eliminar imágenes?';

  @override
  String get homeRecentDeleteImagesMessage =>
      '¿Estás seguro de que quieres eliminar las imágenes seleccionadas? Esta acción no se puede deshacer.';

  @override
  String get scanTitle => 'Escanear';

  @override
  String get scanCapture => 'Capturar';

  @override
  String get scanImportGallery => 'Importar de la galería';

  @override
  String get scanImportFiles => 'Importar archivo';

  @override
  String get scanAddPage => 'Añadir página';

  @override
  String get scanRetake => 'Volver a tomar';

  @override
  String get scanCrop => 'Recortar';

  @override
  String get scanEnhance => 'Mejorar';

  @override
  String get scanDone => 'Listo';

  @override
  String scanPageCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
    );
    return '$_temp0';
  }

  @override
  String get scanSaving => 'Guardando escaneo…';

  @override
  String get scanSaved => 'Documento guardado';

  @override
  String get ocrTitle => 'Reconocimiento de texto';

  @override
  String get ocrRun => 'Reconocer texto';

  @override
  String get ocrRunning => 'Leyendo texto…';

  @override
  String get ocrEmpty => 'No se encontró texto en esta imagen';

  @override
  String get ocrCopySuccess => 'Texto copiado';

  @override
  String get ocrEditHint => 'Editar texto reconocido';

  @override
  String get ocrInputMethodTitle => 'Elegir método de entrada';

  @override
  String get ocrInputMethodSubtitle =>
      'Selecciona cómo deseas extraer el texto';

  @override
  String get ocrInputLiveCameraTitle => 'Cámara en vivo';

  @override
  String get ocrInputLiveCameraDescription =>
      'Captura una imagen en vivo con la cámara';

  @override
  String get ocrInputUploadImageTitle => 'Subir imagen';

  @override
  String get ocrInputUploadImageDescription =>
      'Sube una imagen desde la galería';

  @override
  String get ocrLiveCameraTitle => 'Cámara OCR en vivo';

  @override
  String get ocrLiveCameraTip =>
      'Consejo: Para obtener mejores resultados, coloca el texto en un área bien iluminada';

  @override
  String get ocrLiveCameraClose => 'Cerrar cámara';

  @override
  String get ocrLiveCameraFlash => 'Alternar flash';

  @override
  String get ocrLiveCameraCapture =>
      'Capturar imagen para reconocimiento de texto';

  @override
  String get ocrLiveCameraInitializing => 'Iniciando cámara…';

  @override
  String get ocrAnalyzeTitle => 'Escáner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copiar';

  @override
  String get ocrAnalyzeTranslate => 'Traducir';

  @override
  String get ocrAnalyzeProcessing => 'Analizando texto…';

  @override
  String get ocrAnalyzeTranslateNext => 'Traducción se abrirá a continuación';

  @override
  String get ocrNoTextTitle => 'No se detectó texto legible';

  @override
  String get ocrNoTextHint => 'Prueba con una imagen más clara';

  @override
  String get ocrNoTextRetakePhoto => 'Volver a tomar foto';

  @override
  String get ocrNoTextChooseGallery => 'Elegir de la galería';

  @override
  String get translateTitle => 'Traducir';

  @override
  String get translateSourceLanguage => 'De';

  @override
  String get translateTargetLanguage => 'A';

  @override
  String get translateSwapLanguages => 'Intercambiar idiomas';

  @override
  String get translateButton => 'Traducir';

  @override
  String get translateRunning => 'Traduciendo…';

  @override
  String get translatePasteHint => 'Pega o escribe texto';

  @override
  String get translateCopyResult => 'Copiar traducción';

  @override
  String get translateResultTitle => 'Traducir texto';

  @override
  String get translateResultSubtitle =>
      'Traduce el texto seleccionado a cualquier idioma';

  @override
  String get translateSelectedText => 'Texto seleccionado';

  @override
  String get translateSelectedLanguage => 'Idioma seleccionado';

  @override
  String get translateSelectLanguage => 'Seleccionar idioma';

  @override
  String get translateSearchLanguage => 'Buscar idiomas';

  @override
  String get translateRecentLanguages => 'Recientes';

  @override
  String get translateNoLanguagesFound => 'No se encontraron idiomas';

  @override
  String get translateTranslatedText => 'Texto traducido';

  @override
  String get translatePlaceholder => 'La traducción aparecerá aquí...';

  @override
  String get translateSeeMore => 'Ver más';

  @override
  String get translateReadAloud => 'Leer en voz alta';

  @override
  String get translateSavePdf => 'Guardar como PDF';

  @override
  String get translateSavePng => 'Guardar como PNG';

  @override
  String get translateSaveComingSoon =>
      'La opción de guardar estará disponible pronto';

  @override
  String get translateDownloadOptionTitle => 'Elegir opción de descarga';

  @override
  String get translateDownloadOptionSubtitle =>
      'Selecciona lo que deseas descargar';

  @override
  String get translateDownloadSelectedTextTitle =>
      'Descargar texto seleccionado';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Descargar solo el texto seleccionado';

  @override
  String get translateDownloadCompleteFileTitle => 'Descargar archivo completo';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Descargar todo el archivo';

  @override
  String get translateDownloadTranslatedTextTitle =>
      'Descargar texto traducido';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Descargar solo el texto traducido';

  @override
  String get translateSavePdfSuccess => 'PDF guardado correctamente';

  @override
  String get translateSavePngSuccess => 'Imagen guardada correctamente';

  @override
  String get translateExportNeedsTranslation =>
      'Traduce el texto antes de descargarlo';

  @override
  String get liveTitle => 'Traducción en vivo';

  @override
  String get liveStart => 'Iniciar cámara';

  @override
  String get liveStop => 'Detener';

  @override
  String get liveListening => 'Escuchando…';

  @override
  String get livePointAtText => 'Apunta la cámara al texto';

  @override
  String get livePermissionNeeded =>
      'Se requiere acceso a la cámara para la traducción en vivo';

  @override
  String get documentsTitle => 'Mis documentos';

  @override
  String get documentRename => 'Renombrar';

  @override
  String get documentDeleteConfirmTitle => '¿Eliminar documento?';

  @override
  String get documentDeleteConfirmMessage =>
      'Esta acción no se puede deshacer.';

  @override
  String get documentDeleted => 'Documento eliminado';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsLanguage => 'Idioma de la app';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsAbout => 'Acerca de';

  @override
  String get settingsPrivacy => 'Política de privacidad';

  @override
  String get settingsTerms => 'Términos y condiciones';

  @override
  String get settingsContactSupport => 'Contactar soporte';

  @override
  String get settingsMoreApps => 'Más aplicaciones';

  @override
  String get settingsRateApp => 'Valorar app';

  @override
  String get settingsShareApp => 'Compartir app';

  @override
  String get settingsGreetingPrefix => 'Buenos días,';

  @override
  String get settingsDefaultUserName => 'abdulá';

  @override
  String get permissionCameraTitle => 'Permiso de la cámara';

  @override
  String get permissionCameraMessage =>
      'Permite el acceso a la cámara para escanear documentos y usar la traducción en vivo.';

  @override
  String get permissionStorageTitle => 'Permiso de almacenamiento';

  @override
  String get permissionStorageMessage =>
      'Permite el acceso para guardar y abrir tus escaneos.';

  @override
  String get permissionOpenSettings => 'Abrir ajustes';

  @override
  String get permissionDenied => 'Permiso denegado';

  @override
  String get errorCameraUnavailable =>
      'La cámara no está disponible en este dispositivo';

  @override
  String get errorFileRead => 'No se pudo leer el archivo';

  @override
  String get errorNetwork => 'Comprueba tu conexión a internet';

  @override
  String get errorNoInternetFeatures =>
      'Sin conexión a internet. Es posible que algunas funciones no vayan correctamente.';

  @override
  String get exitAppTitle => 'Salir de la app';

  @override
  String get exitAppMessage => '¿Seguro que quieres salir?';

  @override
  String get exitAppConfirm => 'Salir';

  @override
  String get errorOcrFailed => 'Error en el reconocimiento de texto';

  @override
  String get errorTranslateFailed => 'Error en la traducción';

  @override
  String get errorTranslateModelDownload =>
      'No se pudo descargar el paquete de idioma. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Este idioma no está disponible para traducción sin conexión.';

  @override
  String get proTitle => 'Escáner de documentos Pro';

  @override
  String get proSubtitle =>
      'Escaneos, OCR, idiomas y traducción en vivo ilimitados';

  @override
  String get proUpgradeButton => 'Actualizar a Pro';

  @override
  String get proRestorePurchases => 'Restaurar compras';

  @override
  String get proFeatureLocked => 'Función Pro';

  @override
  String proLimitPages(int max) {
    return 'El plan gratuito permite hasta $max páginas por documento';
  }

  @override
  String get proLimitOcr => 'Actualiza a Pro para obtener OCR ilimitado';

  @override
  String get proLimitTranslate =>
      'Actualiza a Pro para acceder a todos los idiomas';

  @override
  String get proLimitLive => 'La traducción en vivo está disponible en Pro';

  @override
  String get proPurchaseSuccess => '¡Bienvenido a Pro!';

  @override
  String get proPurchaseFailed => 'No se pudo completar la compra';

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
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportImage => 'Exportar imagen';

  @override
  String get exportSuccess => 'Exportación completada';

  @override
  String get exportFailed => 'Error al exportar';

  @override
  String get languageSearchHint => 'Buscar idioma';

  @override
  String get languageAuto => 'Detectar idioma';

  @override
  String get chatbotTitle => 'Chatbot con IA';

  @override
  String get chatbotHistoryButton => 'Historial de chat';

  @override
  String get chatbotBadge => 'Tu asistente inteligente con IA';

  @override
  String get chatbotHeadlineChat => 'Chatea';

  @override
  String get chatbotHeadlineMiddle => ' con tu ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Sube un PDF y pregunta lo que quieras: obtén respuestas instantáneas, resúmenes, explicaciones y más.';

  @override
  String get chatbotTryAsking => 'Prueba a preguntar';

  @override
  String get chatbotSuggestSummarize => 'Resume este PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Puntos clave de este PDF';

  @override
  String get chatbotSuggestExplain => 'Explica en detalle';

  @override
  String get chatbotSuggestTranslate => 'Traduce este PDF';

  @override
  String get chatbotAskQuestions => 'Haz preguntas sobre este PDF';

  @override
  String get chatbotUploadHint => 'Sube un PDF...';

  @override
  String get chatbotSheetTitle => 'Chatea con tu PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Sube un PDF y pregunta cualquier cosa sobre él';

  @override
  String get chatbotChoosePdfTitle => 'Elegir archivo PDF';

  @override
  String get chatbotChoosePdfDescription =>
      'Busca y selecciona un PDF desde tu dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'Archivos recientes';

  @override
  String get chatbotRecentFilesDescription =>
      'Elige entre tus archivos recientes';

  @override
  String get errorChatbotPdfPickFailed =>
      'No se pudo abrir el PDF seleccionado';

  @override
  String get chatbotAnalyzingTitle => 'Analizando tu documento...';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Por favor, espera mientras leemos y\ncomprendemos tu PDF';

  @override
  String get chatbotStepReadingPdf => 'Leyendo PDF';

  @override
  String get chatbotStepExtractingText => 'Extrayendo texto';

  @override
  String get chatbotStepUnderstandingContent => 'Comprendiendo el contenido';

  @override
  String get chatbotStepPreparingChat => 'Preparando chat de IA';

  @override
  String get chatbotHistoryTitle => 'Historial';

  @override
  String get chatbotNoConversationsTitle => 'Aún no hay conversaciones';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Sube un PDF para comenzar a chatear con tu asistente de IA.';

  @override
  String get chatbotUploadPdfButton => 'Subir un PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento listo';

  @override
  String get chatbotDocumentReadySubtitle => 'Ahora puedes chatear con tu PDF';

  @override
  String get chatbotCurrentSummary => 'Resumen actual';

  @override
  String get chatbotStartChatting => 'Comenzar a chatear';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 ¡Hola! Soy tu asistente de IA. Pregúntame cualquier cosa sobre este PDF y te ayudaré.';

  @override
  String get chatbotChatYouCanAsk => 'Puedes preguntarme:';

  @override
  String get chatbotChatPromptSummarize => 'Resume este documento';

  @override
  String get chatbotChatPromptHighlights =>
      '¿Cuáles son los aspectos más destacados?';

  @override
  String get chatbotChatPromptFinancial => 'Muéstrame datos financieros';

  @override
  String get chatbotChatPromptDates => 'Extrae fechas importantes';

  @override
  String get chatbotChatInputHint => 'Pregunta sobre este PDF...';

  @override
  String get chatbotDeleteTitle => '¿Eliminar chat?';

  @override
  String get chatbotDeleteMessage =>
      'Esto eliminará el chat y el PDF de tu historial. Esta acción no se puede deshacer.';

  @override
  String get chatbotRenameTitle => 'Renombrar PDF';

  @override
  String get chatbotRenameHint => 'Introduce un nombre';

  @override
  String get chatbotHistorySearchHint => 'Buscar en tus conversaciones…';

  @override
  String get chatbotRenameSuccess => 'Renombrado correctamente';

  @override
  String get chatbotDeleteSuccess => 'Eliminado correctamente';

  @override
  String get chatbotEmptyConversationPreview => 'Conversación vacía…';

  @override
  String get chatbotAiThinking => 'La IA está pensando';

  @override
  String get chatbotTipsLabel => 'Consejos';

  @override
  String get chatbotSuggestSummarizeChip => 'Resumir\neste PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Puntos clave\nde este PDF';

  @override
  String get chatbotSuggestExplainChip => 'Explicar\nen detalle';

  @override
  String get chatbotSuggestTranslateChip => 'Traducir\neste PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'No se pudo analizar este PDF. Por favor, inténtalo de nuevo.';

  @override
  String get chatbotChatFailed =>
      'No se pudo obtener respuesta. Inténtalo de nuevo.';

  @override
  String get errorChatbotPdfEmpty => 'No se encontró texto en este PDF';

  @override
  String get pdfAssistantTitle => 'Asistente PDF';

  @override
  String get pdfAssistantSheetTitle => 'Subir PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Elige cómo deseas añadir tu archivo PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Elegir archivo PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Busca y selecciona un PDF desde tu dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Añadir PDF desde enlace';

  @override
  String get pdfAssistantLinkDescription =>
      'Pega un enlace de PDF para subirlo directamente';

  @override
  String get pdfAssistantLinkHint => 'Pegar URL del PDF';

  @override
  String get pdfAssistantLinkButton => 'Descargar PDF';

  @override
  String get pdfAssistantTranslateTo => 'Traducir a';

  @override
  String get pdfAssistantTranslateToOptional => 'Traducir a (opcional)';

  @override
  String get pdfAssistantNoTranslation => 'Sin traducción';

  @override
  String get pdfAssistantExtractedPdfTitle => 'PDF extraído';

  @override
  String get pdfAssistantExtractedPdfDescription =>
      'Texto extraído de las páginas de tu PDF';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => 'Texto extraído';

  @override
  String get pdfAssistantStepPreparingContent => 'Preparando contenido…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'Generando PDF…';

  @override
  String get pdfAssistantStartProcessing => 'Iniciar procesamiento';

  @override
  String get pdfAssistantNoFileSelected => 'Ningún archivo seleccionado';

  @override
  String get pdfAssistantSelectLanguage =>
      'Por favor, selecciona un idioma de destino';

  @override
  String get pdfAssistantProcessingTitle => 'Procesando tu PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Por favor, espera.';

  @override
  String get pdfAssistantStepExtracting => 'Extrayendo texto…';

  @override
  String get pdfAssistantStepTranslating => 'Traduciendo contenido…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Generando PDF traducido…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizando…';

  @override
  String get pdfAssistantResultTitle => 'Resultados';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF traducido';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Diseño original con superposición de texto traducido';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texto traducido extraído';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Documento de texto simple en A4';

  @override
  String get pdfAssistantActionOpen => 'Abrir';

  @override
  String get pdfAssistantActionDownload => 'Descargar';

  @override
  String get pdfAssistantDeleteTitle => '¿Eliminar resultados?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Esto eliminará los archivos traducidos de tu dispositivo.';

  @override
  String get pdfAssistantDownloadSuccess => 'Guardado en Descargas';

  @override
  String get pdfAssistantOpenFailed => 'No se pudo abrir el archivo';

  @override
  String get pdfAssistantProcessFailed => 'No se pudo procesar este PDF';

  @override
  String get errorPdfAssistantPickFailed =>
      'No se pudo abrir el PDF seleccionado';

  @override
  String get errorPdfAssistantLinkFailed =>
      'No se pudo descargar el PDF desde este enlace';

  @override
  String get errorPdfAssistantPdfEmpty => 'No se encontró texto en este PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Quitar PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Esto eliminará el PDF de tu dispositivo.';

  @override
  String get pdfAssistantUploadPdf => 'Subir PDF';

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Quitar';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonSkip => 'Omitir';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get onboardingStart => 'Comienza con →';

  @override
  String get splashTagline => 'Escaneo de documentos con tecnología de IA';

  @override
  String get splashAdDisclaimer => 'Esta acción puede mostrar un anuncio';

  @override
  String get adLoading => 'Cargando anuncio...';

  @override
  String get onboardingPage1Title => 'Escanea texto\nen segundos';

  @override
  String get onboardingPage1Description =>
      'Captura texto de imágenes con OCR rápido.';

  @override
  String get onboardingPage2Title => 'Asistente PDF\ninteligente';

  @override
  String get onboardingPage2Description =>
      'Traduce y entiende\ntus PDF con IA.';

  @override
  String get onboardingPage3Title => 'Chatea con\ntus PDF';

  @override
  String get onboardingPage3Description =>
      'Pregunta, resume\ny obtén respuestas.';

  @override
  String get onboardingPage4Title => 'Recorte inteligente\nen segundos';

  @override
  String get onboardingPage4Description =>
      'Recorta imágenes\ny crea PDF al instante.';

  @override
  String get settingsChooseLanguage => 'Elegir un idioma';

  @override
  String get settingsLanguageApply => 'Aplicar';

  @override
  String get commonSaving => 'Guardando…';

  @override
  String get smartCropTitle => 'Recorte inteligente';

  @override
  String get smartCropInputMethodTitle => 'Escáner de recorte inteligente';

  @override
  String get smartCropInputMethodSubtitle =>
      'Elige cómo deseas recortar tu documento';

  @override
  String get smartCropInputLiveCameraTitle => 'Cámara en vivo';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Escáner de Google — detecta bordes, recorta y mejora automáticamente';

  @override
  String get smartCropInputUploadImageTitle => 'Subir imagen';

  @override
  String get smartCropInputUploadImageDescription =>
      'Sube la imagen del documento desde la galería';

  @override
  String get smartCropUploadIntroHeadline =>
      'Recorta múltiples imágenes\nautomáticamente';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Detecta bordes automáticamente, recorta imágenes a la perfección y crea un PDF con un solo toque.';

  @override
  String get smartCropUploadIntroStepSelect => 'Selecciona múltiples imágenes';

  @override
  String get smartCropUploadIntroStepCrop => 'Detección y recorte automáticos';

  @override
  String get smartCropUploadIntroStepPdf => 'Crea un PDF al instante';

  @override
  String get smartCropUploadIntroSelectImages => 'Seleccionar imágenes';

  @override
  String get smartCropLiveCameraTitle => 'Cámara de recorte inteligente';

  @override
  String get smartCropLiveCameraTip =>
      'Documento detectado — toca para capturar';

  @override
  String get smartCropLiveCameraAlignTip =>
      'Alinea el documento dentro de las esquinas';

  @override
  String get smartCropLiveCameraClose => 'Cerrar cámara';

  @override
  String get smartCropLiveCameraFlash => 'Alternar flash';

  @override
  String get smartCropLiveCameraCapture =>
      'Capturar documento para recorte inteligente';

  @override
  String get smartCropLiveCameraInitializing => 'Iniciando cámara…';

  @override
  String get smartCropCapturedTitle => 'Documento capturado';

  @override
  String get smartCropCapturedRetake => 'Volver a tomar última foto';

  @override
  String get smartCropCapturedAnotherPhoto => 'Añadir otra foto';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Volver a tomar otra foto';

  @override
  String get smartCropCapturedPreview => 'Vista previa';

  @override
  String get smartCropPreviewTitle => 'Vista previa';

  @override
  String get smartCropCapturedCrop => 'Recortar';

  @override
  String get smartCropAdjustCornersTitle => 'Ajustar esquinas';

  @override
  String get smartCropAdjustCornersHint =>
      'Arrastra las esquinas moradas para que coincidan con los bordes del documento';

  @override
  String get smartCropAdjustCornersConfirm => 'Aplicar recorte';

  @override
  String get smartCropPresetAuto => 'Detección automática';

  @override
  String get smartCropPresetCenter => 'Página centrada';

  @override
  String get smartCropPresetFull => 'Imagen completa';

  @override
  String get smartCropUploadIntroGoogleScanner =>
      'Google Scanner (Mejor recorte)';

  @override
  String get smartCropDetectingEdges => 'Detectando bordes del documento…';

  @override
  String get smartCropAndroidOnly =>
      'El escaneo inteligente solo está disponible en Android.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Se alcanzó el máximo de $max fotos';
  }

  @override
  String get smartCropProcessingCrop => 'Aplicando recorte mágico...';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Recortando $count documentos…';
  }

  @override
  String get smartCropCroppedTitle => 'Documento recortado';

  @override
  String get smartCropFilterOriginal => 'Original';

  @override
  String get smartCropFilterLighten => 'Aclarar';

  @override
  String get smartCropFilterMagic => 'Mágico';

  @override
  String get smartCropFilterGrayscale => 'Escala de grises';

  @override
  String get smartCropFilterMono => 'B/N';

  @override
  String get smartCropFilterWarm => 'Cálido';

  @override
  String get smartCropActionCreatePdf => 'Crear PDF';

  @override
  String get smartCropProcessingPdf => 'Generando documento PDF...';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Generando PDF con $count páginas…';
  }

  @override
  String get smartCropPdfSuccess => 'Documento PDF generado correctamente';

  @override
  String get smartCropPdfPagesLabel => 'páginas';

  @override
  String get smartCropPdfSinglePageLabel => '1 página';

  @override
  String get smartCropImageCopied => 'Copiado';

  @override
  String get smartCropDeleteImageConfirm =>
      '¿Quitar esta página del documento?';

  @override
  String get smartCropDeleteCapturedPageTitle => 'Eliminar página';

  @override
  String get smartCropDeleteCapturedPageMessage =>
      '¿Estás seguro de que quieres eliminar esta página ?';

  @override
  String get smartCropDeleteDocumentTitle => '¿Eliminar documento?';

  @override
  String get smartCropDeleteDocumentMessage =>
      '¿Estás seguro de que quieres eliminar este documento? Esta acción no se puede deshacer.';

  @override
  String get smartCropDeletePdfTitle => '¿Eliminar PDF?';

  @override
  String get smartCropDeletePdfMessage =>
      '¿Estás seguro de que quieres eliminar este PDF? Esta acción no se puede deshacer.';

  @override
  String get smartCropDeletePdfConfirm =>
      '¿Eliminar este PDF de tu dispositivo?';

  @override
  String get smartCropPdfRenamed => 'PDF renombrado';

  @override
  String get smartCropPdfFileName => 'Nombre del archivo';

  @override
  String get smartCropPdfFileSize => 'Tamaño del archivo';

  @override
  String get smartCropViewPdf => 'Ver PDF';

  @override
  String get smartCropSavePdf => 'Guardar PDF';

  @override
  String get smartCropSavePdfSuccess => 'PDF guardado correctamente';

  @override
  String get smartCropRenamePdf => 'Renombrar';

  @override
  String get smartCropRenamePdfHint => 'Nombre del documento';

  @override
  String get smartCropStepReadingImages => 'Leyendo imágenes';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return 'Leyendo $done de $total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return 'No se pudieron importar $failed de $total imágenes';
  }

  @override
  String get smartCropStepDetectingEdges => 'Detectando bordes';

  @override
  String get smartCropStepCroppingImages => 'Recortando';

  @override
  String get smartCropStepGeneratingPdf => 'Generando PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Organizando imágenes\nen un PDF de calidad';

  @override
  String get smartCropProcessingPdfTitle => 'Creando PDF';

  @override
  String get commonUntitledDocument => 'documento';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Toca para explorar el directorio del dispositivo';

  @override
  String get errorPdfTextLoad => 'Error al cargar el texto.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Traducción: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Traducción de documento';

  @override
  String get translateExportTranslatedBadge => 'Traducido';

  @override
  String get translateExportVerifiedFooter =>
      'Exportación de traducción sin conexión verificada';

  @override
  String get translateExportPdfHeader => 'Exportación de traducción';

  @override
  String get translateExportPdfFooterLabel => 'Documento confidencial';

  @override
  String translateExportPageOf(int page, int total) {
    return 'Página $page de $total';
  }

  @override
  String pdfAssistantPageLabel(int page) {
    return 'Página $page';
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
    return '${size}MB';
  }

  @override
  String get translateLangName_en => 'Inglés';

  @override
  String get translateLangName_ur => 'urdu';

  @override
  String get translateLangName_hi => 'hindi';

  @override
  String get translateLangName_ar => 'Árabe';

  @override
  String get translateLangName_es => 'Español';

  @override
  String get translateLangName_fr => 'Francés';

  @override
  String get translateLangName_de => 'Alemán';

  @override
  String get translateLangName_pt => 'Portugués';

  @override
  String get translateLangName_ru => 'Ruso';

  @override
  String get translateLangName_zh => 'Chino (Simplificado)';

  @override
  String get translateLangName_zhTw => 'Chino (Tradicional)';

  @override
  String get translateLangName_ja => 'Japonés';

  @override
  String get translateLangName_ko => 'Coreano';

  @override
  String get translateLangName_it => 'Italiano';

  @override
  String get translateLangName_tr => 'Turco';

  @override
  String get translateLangName_nl => 'Neerlandés';

  @override
  String get translateLangName_sv => 'Sueco';

  @override
  String get translateLangName_no => 'Noruego';

  @override
  String get translateLangName_da => 'Danés';

  @override
  String get translateLangName_fi => 'Finés';

  @override
  String get translateLangName_el => 'Griego';

  @override
  String get translateLangName_pl => 'Polaco';

  @override
  String get translateLangName_cs => 'Checo';

  @override
  String get translateLangName_hu => 'Húngaro';

  @override
  String get translateLangName_ro => 'Rumano';

  @override
  String get translateLangName_bg => 'Búlgaro';

  @override
  String get translateLangName_uk => 'Ucraniano';

  @override
  String get translateLangName_fa => 'Persa';

  @override
  String get translateLangName_he => 'Hebreo';

  @override
  String get translateLangName_th => 'Tailandés';

  @override
  String get translateLangName_vi => 'Vietnamita';

  @override
  String get translateLangName_id => 'Indonesio';

  @override
  String get translateLangName_ms => 'Malayo';

  @override
  String get translateLangName_bn => 'Bengalí';

  @override
  String get translateLangName_ta => 'Tamil';

  @override
  String get translateLangName_te => 'Télugu';

  @override
  String get translateLangName_mr => 'Maratí';

  @override
  String get translateLangName_gu => 'Guyaratí';

  @override
  String get translateLangName_kn => 'Canarés';

  @override
  String get translateLangName_ml => 'malayalam';

  @override
  String get translateLangName_pa => 'Panyabí';

  @override
  String get translateLangName_sw => 'Suajili';

  @override
  String get translateLangName_af => 'Afrikáans';

  @override
  String get translateLangName_ca => 'Catalán';

  @override
  String get translateLangName_hr => 'Croata';

  @override
  String get translateLangName_sk => 'Eslovaco';

  @override
  String get translateLangName_sl => 'Esloveno';

  @override
  String get translateLangName_sr => 'Serbio';

  @override
  String get translateLangName_lt => 'Lituano';

  @override
  String get translateLangName_lv => 'Letón';

  @override
  String get translateLangName_et => 'Estonio';

  @override
  String get translateLangName_is => 'Islandés';

  @override
  String get translateLangName_ga => 'Irlandés';

  @override
  String get translateLangName_mt => 'Maltés';

  @override
  String get translateLangName_sq => 'Albanés';

  @override
  String get translateLangName_mk => 'Macedonio';

  @override
  String get translateLangName_be => 'Bielorruso';

  @override
  String get translateLangName_kk => 'Kazajo';

  @override
  String get translateLangName_uz => 'Uzbeko';

  @override
  String get translateLangName_az => 'Azerbaiyano';

  @override
  String get translateLangName_hy => 'Armenio';

  @override
  String get translateLangName_ka => 'Georgiano';

  @override
  String get translateLangName_lo => 'laosiano';

  @override
  String get translateLangName_km => 'Jemer';

  @override
  String get translateLangName_my => 'Birmano';

  @override
  String get translateLangName_ne => 'Nepalí';

  @override
  String get translateLangName_si => 'Cingalés';

  @override
  String get translateLangName_am => 'Amhárico';

  @override
  String get translateLangName_ha => 'Hausa';

  @override
  String get translateLangName_yo => 'yoruba';

  @override
  String get translateLangName_ig => 'igbo';

  @override
  String get translateLangName_zu => 'Zulú';

  @override
  String get translateLangName_xh => 'xhosa';

  @override
  String get translateLangName_st => 'Sesoto';

  @override
  String get translateLangName_sn => 'Shona';

  @override
  String get translateLangName_rw => 'Kinyarwanda';

  @override
  String get translateLangName_so => 'Somalí';

  @override
  String get translateLangName_mg => 'Malgache';

  @override
  String get translateLangName_cy => 'Galés';

  @override
  String get translateLangName_mn => 'Mongol';

  @override
  String get translateLangName_tl => 'filipino';

  @override
  String get translateLangName_ht => 'Criollo haitiano';

  @override
  String get translateLangName_eo => 'esperanto';

  @override
  String get translateLangName_la => 'Latín';

  @override
  String get translateLangName_ku => 'Kurdo';

  @override
  String get translateLangName_ps => 'pastún';

  @override
  String get translateLangName_faAf => 'Darí';

  @override
  String get translateLangName_bs => 'Bosnio';

  @override
  String get translateLangName_mi => 'Maorí';

  @override
  String get translateLangName_sm => 'Samoano';

  @override
  String get translateLangName_haw => 'Hawaiano';

  @override
  String get translateLangName_lb => 'Lucemburgués';
}
