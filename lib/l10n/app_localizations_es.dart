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
  String get commonOk => 'Aceptar';

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
  String get homeTitlePrefix => 'Documento con';

  @override
  String get homeTitleHighlight => 'IA';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Abrir menú';

  @override
  String get homeTagAiPowered => 'Con IA';

  @override
  String get homeTagFastOcr => 'OCR rápido';

  @override
  String get homeTagSecure => 'Seguro';

  @override
  String get homeTagSmartCrop => 'Recorte Inteligente';

  @override
  String get homeHeroBadge => 'CON IA';

  @override
  String get homeHeroTitle => 'Escáner Inteligente\nOCR IA';

  @override
  String get homeHeroSubtitle =>
      'OCR con IA con reconocimiento de texto rápido y preciso en segundos.';

  @override
  String get homeHeroButton => 'Escáner OCR';

  @override
  String get homeSearchHint => 'Buscar aquí';

  @override
  String get homeFeatureOcrTitle => 'Escáner OCR';

  @override
  String get homeFeatureOcrSubtitle =>
      'Escanear texto de imágenes o documentos';

  @override
  String get homeFeaturePdfTitle => 'Asistente PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traducir y transcribir PDF';

  @override
  String get homeFeatureChatbotTitle => 'Chatbot IA';

  @override
  String get homeFeatureChatbotSubtitle => 'Subir PDF para hacer preguntas';

  @override
  String get homeFeatureCropTitle => 'Recorte Inteligente';

  @override
  String get homeFeatureCropSubtitle => 'Recorte automático, limpieza y mejora';

  @override
  String get homeRecentDocuments => 'Documentos recientes';

  @override
  String get homeSeeAll => 'Ver todos';

  @override
  String get homeEmptyDocuments =>
      'Aún no hay documentos. Toca Escanear para comenzar.';

  @override
  String get homeSampleDocName => 'Factura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 may. 2026 • 2.4 MB';

  @override
  String get scanTitle => 'Escanear';

  @override
  String get scanCapture => 'Capturar';

  @override
  String get scanImportGallery => 'Importar de galería';

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
  String get scanDone => 'Hecho';

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
      'Selecciona cómo quieres extraer el texto';

  @override
  String get ocrInputLiveCameraTitle => 'Cámara en vivo';

  @override
  String get ocrInputLiveCameraDescription =>
      'Capturar imagen en vivo usando la cámara';

  @override
  String get ocrInputUploadImageTitle => 'Subir imagen';

  @override
  String get ocrInputUploadImageDescription => 'Subir imagen desde la galería';

  @override
  String get ocrLiveCameraTitle => 'Cámara OCR en vivo';

  @override
  String get ocrLiveCameraTip =>
      'Consejo: Para mejores resultados, coloca el texto en un área bien iluminada';

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
  String get ocrAnalyzeTranslateNext =>
      'La traducción se abrirá a continuación';

  @override
  String get ocrNoTextTitle => 'No se detectó texto legible';

  @override
  String get ocrNoTextHint => 'Intenta con una imagen más clara';

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
      'Traduce tu texto seleccionado a cualquier idioma';

  @override
  String get translateSelectedText => 'Texto seleccionado';

  @override
  String get translateSelectedLanguage => 'Idioma seleccionado';

  @override
  String get translateSelectLanguage => 'Seleccionar idioma';

  @override
  String get translateSearchLanguage => 'Buscar idiomas';

  @override
  String get translateRecentLanguages => 'Reciente';

  @override
  String get translateNoLanguagesFound => 'No se encontraron idiomas';

  @override
  String get translateTranslatedText => 'Texto traducido';

  @override
  String get translatePlaceholder => 'La traducción aparecerá aquí..';

  @override
  String get translateSeeMore => 'Ver más';

  @override
  String get translateReadAloud => 'Leer en voz alta';

  @override
  String get translateSavePdf => 'Guardar como PDF';

  @override
  String get translateSavePng => 'Guardar como PNG';

  @override
  String get translateSaveComingSoon => 'Guardar estará disponible pronto';

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
      'Descargar el archivo completo';

  @override
  String get translateSavePdfSuccess => 'PDF guardado con éxito';

  @override
  String get translateSavePngSuccess => 'Imagen guardada con éxito';

  @override
  String get translateExportNeedsTranslation =>
      'Traduce el texto antes de descargar';

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
  String get documentDeleteConfirmMessage => 'Esto no se puede deshacer.';

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
  String get settingsTerms => 'Términos de uso';

  @override
  String get permissionCameraTitle => 'Permiso de cámara';

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
      'Sin conexión a internet. Algunas funciones pueden no operar correctamente.';

  @override
  String get exitAppTitle => 'Salir de la aplicación';

  @override
  String get exitAppMessage => '¿Estás seguro de que quieres salir?';

  @override
  String get exitAppConfirm => 'Salir';

  @override
  String get errorOcrFailed => 'Falló el reconocimiento de texto';

  @override
  String get errorTranslateFailed => 'Falló la traducción';

  @override
  String get errorTranslateModelDownload =>
      'No se pudo descargar el paquete de idioma. Comprueba tu conexión e inténtalo de nuevo.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Este idioma no está disponible para traducción sin conexión.';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle =>
      'Escaneos, OCR, idiomas y traducción en vivo ilimitados';

  @override
  String get proUpgradeButton => 'Mejorar a Pro';

  @override
  String get proRestorePurchases => 'Restaurar compras';

  @override
  String get proFeatureLocked => 'Función Pro';

  @override
  String proLimitPages(int max) {
    return 'El plan gratuito permite hasta $max páginas por documento';
  }

  @override
  String get proLimitOcr => 'Mejora a Pro para OCR ilimitado';

  @override
  String get proLimitTranslate => 'Mejora a Pro para todos los idiomas';

  @override
  String get proLimitLive => 'La traducción en vivo está disponible en Pro';

  @override
  String get proPurchaseSuccess => '¡Bienvenido a Pro!';

  @override
  String get proPurchaseFailed => 'No se pudo completar la compra';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportImage => 'Exportar imagen';

  @override
  String get exportSuccess => 'Exportación completada';

  @override
  String get exportFailed => 'Exportación fallida';

  @override
  String get languageSearchHint => 'Buscar idioma';

  @override
  String get languageAuto => 'Detectar idioma';

  @override
  String get chatbotTitle => 'Chatbot IA';

  @override
  String get chatbotHistoryButton => 'Historial de chat';

  @override
  String get chatbotBadge => 'Tu Asistente IA Inteligente';

  @override
  String get chatbotHeadlineChat => 'Chatea';

  @override
  String get chatbotHeadlineMiddle => ' con tu ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Prueba preguntando';

  @override
  String get chatbotSuggestSummarize => 'Resume este PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Puntos clave de este PDF';

  @override
  String get chatbotSuggestExplain => 'Explica en detalle';

  @override
  String get chatbotSuggestTranslate => 'Traduce este PDF';

  @override
  String get chatbotUploadHint => 'Sube un PDF...';

  @override
  String get chatbotSheetTitle => 'Chatea con tu PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Sube un PDF y pregunta lo que sea sobre él';

  @override
  String get chatbotChoosePdfTitle => 'Elegir archivo PDF';

  @override
  String get chatbotChoosePdfDescription =>
      'Busca y selecciona un PDF de tu dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'Archivos recientes';

  @override
  String get chatbotRecentFilesDescription => 'Elige de tus archivos recientes';

  @override
  String get errorChatbotPdfPickFailed =>
      'No se pudo abrir el PDF seleccionado';

  @override
  String get chatbotAnalyzingTitle => 'Analizando tu documento...';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Por favor, espera mientras leemos y\nentendemos tu PDF';

  @override
  String get chatbotStepReadingPdf => 'Leyendo PDF';

  @override
  String get chatbotStepExtractingText => 'Extrayendo texto';

  @override
  String get chatbotStepUnderstandingContent => 'Entendiendo contenido';

  @override
  String get chatbotStepPreparingChat => 'Preparando Chat IA';

  @override
  String get chatbotHistoryTitle => 'Historial';

  @override
  String get chatbotNoConversationsTitle => 'Aún no hay conversaciones';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Sube un PDF para empezar a chatear con tu asistente IA.';

  @override
  String get chatbotUploadPdfButton => 'Subir un PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento listo';

  @override
  String get chatbotDocumentReadySubtitle =>
      'Tu PDF ha sido analizado. Aquí tienes un breve resumen.';

  @override
  String get chatbotCurrentSummary => 'Resumen actual';

  @override
  String get chatbotStartChatting => 'Empezar a chatear';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 ¡Hola! Soy tu asistente IA. Pregúntame lo que sea sobre este PDF y te ayudaré.';

  @override
  String get chatbotChatYouCanAsk => 'Puedes preguntarme:';

  @override
  String get chatbotChatPromptSummarize => 'Resume este documento';

  @override
  String get chatbotChatPromptHighlights =>
      '¿Cuáles son los puntos destacados?';

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
      'Esto eliminará el chat y el PDF de tu historial. Esto no se puede deshacer.';

  @override
  String get chatbotRenameTitle => 'Renombrar PDF';

  @override
  String get chatbotRenameHint => 'Ingresa un nombre';

  @override
  String get chatbotAnalyzeFailed =>
      'No se pudo analizar este PDF. Por favor, inténtalo de nuevo.';

  @override
  String get chatbotChatFailed =>
      'No se pudo obtener una respuesta. Inténtalo de nuevo.';

  @override
  String get errorChatbotPdfEmpty => 'No se encontró texto en este PDF';

  @override
  String get pdfAssistantTitle => 'Asistente PDF';

  @override
  String get pdfAssistantSheetTitle => 'Asistente PDF';

  @override
  String get pdfAssistantSheetSubtitle => 'Traduce tu PDF a cualquier idioma';

  @override
  String get pdfAssistantChoosePdfTitle => 'Elegir archivo PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Busca y selecciona un PDF de tu dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Añadir PDF desde enlace';

  @override
  String get pdfAssistantLinkDescription =>
      'Pega un enlace de PDF para subir directamente';

  @override
  String get pdfAssistantLinkHint => 'Pegar URL del PDF';

  @override
  String get pdfAssistantLinkButton => 'Descargar PDF';

  @override
  String get pdfAssistantTranslateTo => 'Traducir a';

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
      'Diseño original con texto traducido superpuesto';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texto traducido extraído';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Documento de texto A4 simple';

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
      'No se pudo descargar el PDF de este enlace';

  @override
  String get errorPdfAssistantPdfEmpty => 'No se encontró texto en este PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Eliminar PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Esto eliminará el PDF de tu dispositivo.';

  @override
  String get pdfAssistantUploadPdf => 'Subir PDF';

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Eliminar';

  @override
  String get commonNext => 'Siguiente';

  @override
  String get commonSkip => 'Saltar';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get splashTagline => 'Escaneo de documentos con IA';

  @override
  String get onboardingPage1Title => 'Escanea cualquier documento';

  @override
  String get onboardingPage1Description =>
      'Captura recibos, notas y papeles con tu cámara en segundos.';

  @override
  String get onboardingPage2Title => 'OCR y traducción inteligente';

  @override
  String get onboardingPage2Description =>
      'Extrae texto al instante y tradúcelo a tu idioma preferido.';

  @override
  String get onboardingPage3Title => 'Organiza y exporta';

  @override
  String get onboardingPage3Description =>
      'Guarda escaneos, exporta PDFs y mantén tus documentos en un solo lugar.';

  @override
  String get settingsChooseLanguage => 'Elige un idioma';

  @override
  String get settingsLanguageApply => 'Aplicar';
}
