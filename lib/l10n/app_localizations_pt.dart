// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Doc Scanner';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonShare => 'Compartilhar';

  @override
  String get commonCopy => 'Copiar';

  @override
  String get commonRetry => 'Repetir';

  @override
  String get commonClose => 'Fechar';

  @override
  String get commonDone => 'Concluir';

  @override
  String get commonLoading => 'Carregando…';

  @override
  String get commonError => 'Algo deu errado';

  @override
  String get commonTryAgain => 'Por favor, tente novamente';

  @override
  String get navHome => 'Início';

  @override
  String get navScan => 'Escanear';

  @override
  String get navDocuments => 'Documentos';

  @override
  String get navTranslate => 'Traduzir';

  @override
  String get navLive => 'Ao vivo';

  @override
  String get navSettings => 'Configurações';

  @override
  String homeGreeting(String name) {
    return 'Bom dia, $name 👋';
  }

  @override
  String get homeTitlePrefix => 'Documento IA';

  @override
  String get homeTitleHighlight => 'Scanner';

  @override
  String get homeProBadge => 'Pro';

  @override
  String get homeMenuButton => 'Abrir menu';

  @override
  String get homeTagAiPowered => 'Tecnologia de IA';

  @override
  String get homeTagFastOcr => 'OCR Rápido';

  @override
  String get homeTagSecure => 'Seguro';

  @override
  String get homeTagSmartCrop => 'Recorte Inteligente';

  @override
  String get homeHeroBadge => 'TECNOLOGIA DE IA';

  @override
  String get homeHeroTitle => 'Scanner OCR\nInteligente com IA';

  @override
  String get homeHeroSubtitle =>
      'OCR baseado em IA com reconhecimento de texto rápido e preciso em segundos.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Buscar aqui';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle => 'Escanear texto de imagem ou documentos';

  @override
  String get homeFeaturePdfTitle => 'Assistente de PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduzir e Transcrever PDF';

  @override
  String get homeFeatureChatbotTitle => 'Pergunte ao PDF';

  @override
  String get homeFeatureChatbotSubtitle => 'Enviar PDF para fazer perguntas';

  @override
  String get homeFeatureCropTitle => 'Recorte Inteligente';

  @override
  String get homeFeatureCropSubtitle =>
      'Recortar, limpar e aprimorar automaticamente';

  @override
  String get homeRecentDocuments => 'Recentes';

  @override
  String get homeSeeAll => 'Ver Tudo';

  @override
  String get homeEmptyDocuments =>
      'Nenhum documento ainda. Toque em Escanear para começar.';

  @override
  String get homeSampleDocName => 'Fatura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 de maio de 2026 • 2.4 MB';

  @override
  String get homeRecentPdfsFolder => 'PDFs';

  @override
  String get homeRecentImagesFolder => 'Imagens';

  @override
  String homeRecentFileCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
      zero: '0 arquivos',
    );
    return '$_temp0';
  }

  @override
  String homeRecentFolderMeta(int count, String size) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count arquivos',
      one: '1 arquivo',
      zero: '0 arquivos',
    );
    return '$_temp0 • $size';
  }

  @override
  String get homeRecentPdfsTitle => 'PDFs';

  @override
  String get homeRecentImagesTitle => 'Imagens';

  @override
  String get homeRecentAdded => 'Adicionados Recentes';

  @override
  String get homeRecentSelect => 'Selecionar';

  @override
  String get homeRecentSelectAll => 'Selecionar tudo';

  @override
  String get homeRecentDeselectAll => 'Desmarcar tudo';

  @override
  String get homeRecentSearchPdfs => 'Buscar seus PDFs…';

  @override
  String get homeRecentSearchImages => 'Buscar suas imagens…';

  @override
  String get homeRecentNoSearchResults =>
      'Nenhum arquivo corresponde à sua busca';

  @override
  String get homeRecentToggleFavorite => 'Favoritar';

  @override
  String get homeRecentUnfavorite => 'Desfavoritar';

  @override
  String get homeRecentFavoriteAdded => 'Adicionado aos favoritos';

  @override
  String get homeRecentFavoriteRemoved => 'Removido dos favoritos';

  @override
  String get homeRecentPdfEmptyTitle => 'Nenhum PDF recente';

  @override
  String get homeRecentPdfEmptySubtitle =>
      'Envie ou escaneie documentos para criar seu primeiro PDF';

  @override
  String get homeRecentImageEmptyTitle => 'Nenhuma imagem recente';

  @override
  String get homeRecentImageEmptySubtitle =>
      'Envie ou escaneie imagens para organizá-las aqui';

  @override
  String get homeRecentUploadPdf => 'Enviar um PDF';

  @override
  String get homeRecentUploadImages => 'Enviar Imagens';

  @override
  String get homeRecentScanDocument => 'Escanear Documento';

  @override
  String get homeRecentDeleteImageTitle => 'Excluir imagem?';

  @override
  String get homeRecentDeleteImageMessage =>
      'Tem certeza de que deseja excluir esta imagem? Esta ação não pode ser desfeita.';

  @override
  String get homeRecentDeleteImagesTitle => 'Excluir imagens?';

  @override
  String get homeRecentDeleteImagesMessage =>
      'Tem certeza de que deseja excluir as imagens selecionadas? Esta ação não pode ser desfeita.';

  @override
  String get scanTitle => 'Escanear';

  @override
  String get scanCapture => 'Capturar';

  @override
  String get scanImportGallery => 'Importar da galeria';

  @override
  String get scanImportFiles => 'Importar arquivo';

  @override
  String get scanAddPage => 'Adicionar página';

  @override
  String get scanRetake => 'Refazer';

  @override
  String get scanCrop => 'Recortar';

  @override
  String get scanEnhance => 'Aprimorar';

  @override
  String get scanDone => 'Concluir';

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
  String get scanSaving => 'Salvando digitalização…';

  @override
  String get scanSaved => 'Documento salvo';

  @override
  String get ocrTitle => 'Reconhecimento de texto';

  @override
  String get ocrRun => 'Reconhecer texto';

  @override
  String get ocrRunning => 'Lendo texto…';

  @override
  String get ocrEmpty => 'Nenhum texto encontrado nesta imagem';

  @override
  String get ocrCopySuccess => 'Texto copiado';

  @override
  String get ocrEditHint => 'Editar texto reconhecido';

  @override
  String get ocrInputMethodTitle => 'Escolher Método de Entrada';

  @override
  String get ocrInputMethodSubtitle => 'Selecione como deseja extrair o texto';

  @override
  String get ocrInputLiveCameraTitle => 'Câmera ao Vivo';

  @override
  String get ocrInputLiveCameraDescription =>
      'Capturar imagem ao vivo usando a câmera';

  @override
  String get ocrInputUploadImageTitle => 'Enviar Imagem';

  @override
  String get ocrInputUploadImageDescription => 'Enviar imagem da galeria';

  @override
  String get ocrLiveCameraTitle => 'Câmera OCR ao Vivo';

  @override
  String get ocrLiveCameraTip =>
      'Dica: Para melhores resultados, posicione o texto em uma área bem iluminada';

  @override
  String get ocrLiveCameraClose => 'Fechar câmera';

  @override
  String get ocrLiveCameraFlash => 'Alternar flash';

  @override
  String get ocrLiveCameraCapture =>
      'Capturar imagem para reconhecimento de texto';

  @override
  String get ocrLiveCameraInitializing => 'Iniciando câmera…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copiar';

  @override
  String get ocrAnalyzeTranslate => 'Traduzir';

  @override
  String get ocrAnalyzeProcessing => 'Analisando texto…';

  @override
  String get ocrAnalyzeTranslateNext => 'O tradutor será aberto a seguir';

  @override
  String get ocrNoTextTitle => 'Nenhum texto legível detectado';

  @override
  String get ocrNoTextHint => 'Tente uma imagem mais clara';

  @override
  String get ocrNoTextRetakePhoto => 'Tirar Nova Foto';

  @override
  String get ocrNoTextChooseGallery => 'Escolher da Galeria';

  @override
  String get translateTitle => 'Traduzir';

  @override
  String get translateSourceLanguage => 'De';

  @override
  String get translateTargetLanguage => 'Para';

  @override
  String get translateSwapLanguages => 'Inverter idiomas';

  @override
  String get translateButton => 'Traduzir';

  @override
  String get translateRunning => 'Traduzindo…';

  @override
  String get translatePasteHint => 'Cole ou digite o texto';

  @override
  String get translateCopyResult => 'Copiar tradução';

  @override
  String get translateResultTitle => 'Traduzir Texto';

  @override
  String get translateResultSubtitle =>
      'Traduzir o texto selecionado para qualquer idioma';

  @override
  String get translateSelectedText => 'Texto Selecionado';

  @override
  String get translateSelectedLanguage => 'Idioma Selecionado';

  @override
  String get translateSelectLanguage => 'Selecionar Idioma';

  @override
  String get translateSearchLanguage => 'Buscar idiomas';

  @override
  String get translateRecentLanguages => 'Recentes';

  @override
  String get translateNoLanguagesFound => 'Nenhum idioma encontrado';

  @override
  String get translateTranslatedText => 'Texto Traduzido';

  @override
  String get translatePlaceholder => 'A tradução aparecerá aqui…';

  @override
  String get translateSeeMore => 'Ver Mais';

  @override
  String get translateReadAloud => 'Ler em voz alta';

  @override
  String get translateSavePdf => 'Salvar como PDF';

  @override
  String get translateSavePng => 'Salvar como PNG';

  @override
  String get translateSaveComingSoon =>
      'A opção de salvar estará disponível em breve';

  @override
  String get translateDownloadOptionTitle => 'Escolher Opção de Download';

  @override
  String get translateDownloadOptionSubtitle => 'Selecione o que deseja baixar';

  @override
  String get translateDownloadSelectedTextTitle => 'Baixar texto selecionado';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Baixar apenas o texto selecionado';

  @override
  String get translateDownloadCompleteFileTitle => 'Baixar arquivo completo';

  @override
  String get translateDownloadCompleteFileDescription =>
      'Baixar o arquivo inteiro';

  @override
  String get translateDownloadTranslatedTextTitle => 'Baixar texto traduzido';

  @override
  String get translateDownloadTranslatedTextDescription =>
      'Baixar apenas o texto traduzido';

  @override
  String get translateSavePdfSuccess => 'PDF salvo com sucesso';

  @override
  String get translateSavePngSuccess => 'Imagem salva com sucesso';

  @override
  String get translateExportNeedsTranslation =>
      'Traduzir o texto antes de baixar';

  @override
  String get liveTitle => 'Tradução ao vivo';

  @override
  String get liveStart => 'Iniciar câmera';

  @override
  String get liveStop => 'Parar';

  @override
  String get liveListening => 'Ouvindo…';

  @override
  String get livePointAtText => 'Aponte a câmera para o texto';

  @override
  String get livePermissionNeeded =>
      'O acesso à câmera é necessário para a tradução ao vivo';

  @override
  String get documentsTitle => 'Meus documentos';

  @override
  String get documentRename => 'Renomear';

  @override
  String get documentDeleteConfirmTitle => 'Excluir documento?';

  @override
  String get documentDeleteConfirmMessage => 'Esta ação não pode ser desfeita.';

  @override
  String get documentDeleted => 'Documento excluído';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsLanguage => 'Idioma do app';

  @override
  String get settingsTheme => 'Tema';

  @override
  String get settingsAbout => 'Sobre';

  @override
  String get settingsPrivacy => 'Política de privacidade';

  @override
  String get settingsTerms => 'Termos e condições';

  @override
  String get settingsContactSupport => 'Contactar suporte';

  @override
  String get settingsMoreApps => 'Mais aplicativos';

  @override
  String get settingsRateApp => 'Avaliar app';

  @override
  String get settingsShareApp => 'Compartilhar app';

  @override
  String get settingsGreetingPrefix => 'Bom dia,';

  @override
  String get settingsDefaultUserName => 'Abdullah';

  @override
  String get permissionCameraTitle => 'Permissão de câmera';

  @override
  String get permissionCameraMessage =>
      'Permita o acesso à câmera para escanear documentos e usar a tradução ao vivo.';

  @override
  String get permissionStorageTitle => 'Permissão de armazenamento';

  @override
  String get permissionStorageMessage =>
      'Permita o acesso para salvar e abrir suas digitalizações.';

  @override
  String get permissionOpenSettings => 'Abrir configurações';

  @override
  String get permissionDenied => 'Permissão negada';

  @override
  String get errorCameraUnavailable =>
      'A câmera não está disponível neste dispositivo';

  @override
  String get errorFileRead => 'Não foi possível ler o arquivo';

  @override
  String get errorNetwork => 'Verifique sua conexão com a internet';

  @override
  String get errorNoInternetFeatures =>
      'Sem conexão com a internet. Alguns recursos podem não funcionar corretamente.';

  @override
  String get exitAppTitle => 'Sair do App';

  @override
  String get exitAppMessage => 'Tem certeza de que deseja sair?';

  @override
  String get exitAppConfirm => 'Sair';

  @override
  String get errorOcrFailed => 'Falha no reconhecimento de texto';

  @override
  String get errorTranslateFailed => 'Falha na tradução';

  @override
  String get errorTranslateModelDownload =>
      'Não foi possível baixar o pacote de idioma. Verifique sua conexão e tente novamente.';

  @override
  String get errorTranslateUnsupportedLanguage =>
      'Este idioma não está disponível para tradução offline.';

  @override
  String get proTitle => 'Scanner de documentos Pro';

  @override
  String get proSubtitle =>
      'Digitalizações, OCR, idiomas e tradução ao vivo ilimitados';

  @override
  String get proUpgradeButton => 'Atualizar para o Pro';

  @override
  String get proRestorePurchases => 'Restaurar compras';

  @override
  String get proFeatureLocked => 'Recurso Pro';

  @override
  String proLimitPages(int max) {
    return 'O plano gratuito permite até $max páginas por documento';
  }

  @override
  String get proLimitOcr => 'Atualize para o Pro para OCR ilimitado';

  @override
  String get proLimitTranslate => 'Atualize para o Pro para todos os idiomas';

  @override
  String get proLimitLive => 'A tradução ao vivo está disponível no Pro';

  @override
  String get proPurchaseSuccess => 'Bem-vindo ao Pro!';

  @override
  String get proPurchaseFailed => 'A compra não pôde ser concluída';

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
  String get exportImage => 'Exportar imagem';

  @override
  String get exportSuccess => 'Exportação concluída';

  @override
  String get exportFailed => 'Falha na exportação';

  @override
  String get languageSearchHint => 'Buscar idioma';

  @override
  String get languageAuto => 'Detectar idioma';

  @override
  String get chatbotTitle => 'Chatbot de IA';

  @override
  String get chatbotHistoryButton => 'Histórico do chat';

  @override
  String get chatbotBadge => 'Seu Assistente Inteligente de IA';

  @override
  String get chatbotHeadlineChat => 'Converse';

  @override
  String get chatbotHeadlineMiddle => ' com o seu ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotHeadlineSubtitle =>
      'Envie um PDF e pergunte qualquer coisa — obtenha respostas instantâneas, resumos, explicações e muito mais.';

  @override
  String get chatbotTryAsking => 'Tente perguntar';

  @override
  String get chatbotSuggestSummarize => 'Resumir este PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Pontos-chave deste PDF';

  @override
  String get chatbotSuggestExplain => 'Explicar em detalhes';

  @override
  String get chatbotSuggestTranslate => 'Traduzir este PDF';

  @override
  String get chatbotAskQuestions => 'Fazer perguntas sobre este PDF';

  @override
  String get chatbotUploadHint => 'Enviar um PDF…';

  @override
  String get chatbotSheetTitle => 'Converse com seu PDF';

  @override
  String get chatbotSheetSubtitle =>
      'Envie um PDF e pergunte qualquer coisa sobre ele';

  @override
  String get chatbotChoosePdfTitle => 'Escolher arquivo PDF';

  @override
  String get chatbotChoosePdfDescription =>
      'Procure e selecione um PDF do seu dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'Arquivos Recentes';

  @override
  String get chatbotRecentFilesDescription =>
      'Escolha entre seus arquivos recentes';

  @override
  String get errorChatbotPdfPickFailed =>
      'Não foi possível abrir o PDF selecionado';

  @override
  String get chatbotAnalyzingTitle => 'Analisando seu documento…';

  @override
  String get chatbotAnalyzingSubtitle =>
      'Por favor, aguarde enquanto lemos e\nentendemos seu PDF';

  @override
  String get chatbotStepReadingPdf => 'Lendo PDF';

  @override
  String get chatbotStepExtractingText => 'Extraindo Texto';

  @override
  String get chatbotStepUnderstandingContent => 'Entendendo o Conteúdo';

  @override
  String get chatbotStepPreparingChat => 'Preparando o Chat de IA';

  @override
  String get chatbotHistoryTitle => 'Histórico';

  @override
  String get chatbotNoConversationsTitle => 'Nenhuma conversa ainda';

  @override
  String get chatbotNoConversationsSubtitle =>
      'Envie um PDF para começar a conversar com seu assistente de IA.';

  @override
  String get chatbotUploadPdfButton => 'Enviar um PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento Pronto';

  @override
  String get chatbotDocumentReadySubtitle =>
      'Agora você pode conversar com seu PDF';

  @override
  String get chatbotCurrentSummary => 'Resumo Atual';

  @override
  String get chatbotStartChatting => 'Começar a Conversar';

  @override
  String get chatbotChatGreeting =>
      '👋🏻 Olá! Sou seu assistente de IA. Pergunte-me qualquer coisa sobre este PDF e eu te ajudarei.';

  @override
  String get chatbotChatYouCanAsk => 'Você pode me perguntar:';

  @override
  String get chatbotChatPromptSummarize => 'Resumir este documento';

  @override
  String get chatbotChatPromptHighlights =>
      'Quais são os principais destaques?';

  @override
  String get chatbotChatPromptFinancial => 'Mostrar dados financeiros';

  @override
  String get chatbotChatPromptDates => 'Extrair datas importantes';

  @override
  String get chatbotChatInputHint => 'Pergunte sobre este PDF…';

  @override
  String get chatbotDeleteTitle => 'Excluir chat?';

  @override
  String get chatbotDeleteMessage =>
      'Isso removerá o chat e o PDF do seu histórico. Esta ação não pode ser desfeita.';

  @override
  String get chatbotRenameTitle => 'Renomear PDF';

  @override
  String get chatbotRenameHint => 'Insira um nome';

  @override
  String get chatbotHistorySearchHint => 'Buscar em suas conversas…';

  @override
  String get chatbotRenameSuccess => 'Renomeado com sucesso';

  @override
  String get chatbotDeleteSuccess => 'Excluído com sucesso';

  @override
  String get chatbotEmptyConversationPreview => 'Conversa vazia…';

  @override
  String get chatbotAiThinking => 'A IA está pensando';

  @override
  String get chatbotTipsLabel => 'Dicas';

  @override
  String get chatbotSuggestSummarizeChip => 'Resumir\neste PDF';

  @override
  String get chatbotSuggestKeyPointsChip => 'Pontos-chave\ndeste PDF';

  @override
  String get chatbotSuggestExplainChip => 'Explicar\nem detalhes';

  @override
  String get chatbotSuggestTranslateChip => 'Traduzir\neste PDF';

  @override
  String get chatbotAnalyzeFailed =>
      'Não foi possível analisar este PDF. Por favor, tente novamente.';

  @override
  String get chatbotChatFailed =>
      'Não foi possível obter uma resposta. Tente novamente.';

  @override
  String get errorChatbotPdfEmpty => 'Nenhum texto encontrado neste PDF';

  @override
  String get pdfAssistantTitle => 'Assistente de PDF';

  @override
  String get pdfAssistantSheetTitle => 'Enviar PDF';

  @override
  String get pdfAssistantSheetSubtitle =>
      'Escolha como deseja adicionar seu arquivo PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Escolher arquivo PDF';

  @override
  String get pdfAssistantChoosePdfDescription =>
      'Procure e selecione um PDF do seu dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Adicionar PDF por link';

  @override
  String get pdfAssistantLinkDescription =>
      'Cole um link de PDF para enviar diretamente';

  @override
  String get pdfAssistantLinkHint => 'Colar URL do PDF';

  @override
  String get pdfAssistantLinkButton => 'Baixar PDF';

  @override
  String get pdfAssistantTranslateTo => 'Traduzir Para';

  @override
  String get pdfAssistantTranslateToOptional => 'Traduzir para (opcional)';

  @override
  String get pdfAssistantNoTranslation => 'Sem tradução';

  @override
  String get pdfAssistantExtractedPdfTitle => 'PDF extraído';

  @override
  String get pdfAssistantExtractedPdfDescription =>
      'Texto extraído das páginas do seu PDF';

  @override
  String get pdfAssistantExtractedTextOnlyTitle => 'Texto extraído';

  @override
  String get pdfAssistantStepPreparingContent => 'Preparando conteúdo…';

  @override
  String get pdfAssistantStepGeneratingPdfNeutral => 'Gerando PDF…';

  @override
  String get pdfAssistantStartProcessing => 'Iniciar Processamento';

  @override
  String get pdfAssistantNoFileSelected => 'Nenhum arquivo selecionado';

  @override
  String get pdfAssistantSelectLanguage =>
      'Por favor, selecione um idioma de destino';

  @override
  String get pdfAssistantProcessingTitle => 'Processando seu PDF…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Por favor, aguarde.';

  @override
  String get pdfAssistantStepExtracting => 'Extraindo texto…';

  @override
  String get pdfAssistantStepTranslating => 'Traduzindo conteúdo…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Gerando PDF traduzido…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizando…';

  @override
  String get pdfAssistantResultTitle => 'Resultados';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF Traduzido';

  @override
  String get pdfAssistantTranslatedPdfDescription =>
      'Layout original com sobreposição de texto traduzido';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texto traduzido extraído';

  @override
  String get pdfAssistantExtractedTextDescription =>
      'Documento de texto simples em A4';

  @override
  String get pdfAssistantActionOpen => 'Abrir';

  @override
  String get pdfAssistantActionDownload => 'Baixar';

  @override
  String get pdfAssistantDeleteTitle => 'Excluir resultados?';

  @override
  String get pdfAssistantDeleteMessage =>
      'Isso removerá os arquivos traduzidos do seu dispositivo.';

  @override
  String get pdfAssistantDownloadSuccess => 'Salvo em Downloads';

  @override
  String get pdfAssistantOpenFailed => 'Não foi possível abrir o arquivo';

  @override
  String get pdfAssistantProcessFailed => 'Não foi possível processar este PDF';

  @override
  String get errorPdfAssistantPickFailed =>
      'Não foi possível abrir o PDF seleccionado';

  @override
  String get errorPdfAssistantLinkFailed =>
      'Não foi possível baixar o PDF através deste link';

  @override
  String get errorPdfAssistantPdfEmpty => 'Nenhum texto encontrado neste PDF';

  @override
  String get pdfAssistantRemoveTitle => 'Remover PDF';

  @override
  String get pdfAssistantRemoveWarning =>
      'Isso removerá o PDF do seu dispositivo.';

  @override
  String get pdfAssistantUploadPdf => 'Enviar PDF';

  @override
  String get cancel => 'Cancelar';

  @override
  String get remove => 'Remover';

  @override
  String get commonNext => 'Avançar';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get onboardingStart => 'Comece com →';

  @override
  String get splashTagline => 'Digitalização de documentos baseada em IA';

  @override
  String get splashAdDisclaimer => 'Esta ação pode exibir um anúncio';

  @override
  String get adLoading => 'Carregando anúncio...';

  @override
  String get onboardingPage1Title => 'Digitalize texto\nem segundos';

  @override
  String get onboardingPage1Description =>
      'Capture texto de imagens com digitalização OCR rápida baseada em IA.';

  @override
  String get onboardingPage2Title => 'Assistente de PDF\nInteligente';

  @override
  String get onboardingPage2Description =>
      'Traduzir, extrair e compreender seus documentos PDF com IA.';

  @override
  String get onboardingPage3Title => 'Converse com\nseus PDFs';

  @override
  String get onboardingPage3Description =>
      'Faça perguntas, resuma documentos e obtenha respostas instantâneas da IA.';

  @override
  String get onboardingPage4Title => 'Recorte Inteligente\nem Segundos';

  @override
  String get onboardingPage4Description =>
      'Recorte automaticamente várias imagens e crie PDFs limpos instantaneamente.';

  @override
  String get settingsChooseLanguage => 'Escolher um idioma';

  @override
  String get settingsLanguageApply => 'Aplicar';

  @override
  String get commonSaving => 'Salvando…';

  @override
  String get smartCropTitle => 'Recorte inteligente';

  @override
  String get smartCropInputMethodTitle => 'Scanner de Recorte Inteligente';

  @override
  String get smartCropInputMethodSubtitle =>
      'Escolha como deseja recortar seu documento';

  @override
  String get smartCropInputLiveCameraTitle => 'Câmera ao Vivo';

  @override
  String get smartCropInputLiveCameraDescription =>
      'Scanner do Google — bordas automáticas, recorte e aprimoramento';

  @override
  String get smartCropInputUploadImageTitle => 'Enviar Imagem';

  @override
  String get smartCropInputUploadImageDescription =>
      'Enviar imagem do documento da galeria';

  @override
  String get smartCropUploadIntroHeadline =>
      'Recortar Várias Imagens\nAutomaticamente';

  @override
  String get smartCropUploadIntroSubtitle =>
      'Detecte bordas automaticamente, recorte imagens perfeitamente e crie um PDF com um único toque.';

  @override
  String get smartCropUploadIntroStepSelect => 'Selecionar várias imagens';

  @override
  String get smartCropUploadIntroStepCrop =>
      'Detectar e recortar automaticamente';

  @override
  String get smartCropUploadIntroStepPdf => 'Criar PDF instantaneamente';

  @override
  String get smartCropUploadIntroSelectImages => 'Selecionar Imagens';

  @override
  String get smartCropLiveCameraTitle => 'Câmera de Recorte Inteligente';

  @override
  String get smartCropLiveCameraTip =>
      'Documento detectado — toque para capturar';

  @override
  String get smartCropLiveCameraAlignTip =>
      'Alinhe o documento dentro dos cantos';

  @override
  String get smartCropLiveCameraClose => 'Fechar câmera';

  @override
  String get smartCropLiveCameraFlash => 'Alternar flash';

  @override
  String get smartCropLiveCameraCapture =>
      'Capturar documento para recorte inteligente';

  @override
  String get smartCropLiveCameraInitializing => 'Iniciando câmera…';

  @override
  String get smartCropCapturedTitle => 'Documento Capturado';

  @override
  String get smartCropCapturedRetake => 'Refazer última foto';

  @override
  String get smartCropCapturedAnotherPhoto => 'Adicionar outra foto';

  @override
  String get smartCropCapturedRetakeAnotherPhoto => 'Refazer outra foto';

  @override
  String get smartCropCapturedPreview => 'Visualização';

  @override
  String get smartCropPreviewTitle => 'Visualização';

  @override
  String get smartCropCapturedCrop => 'Recortar';

  @override
  String get smartCropAdjustCornersTitle => 'Ajustar cantos';

  @override
  String get smartCropAdjustCornersHint =>
      'Arraste os cantos roxos para coincidir com as bordas do documento';

  @override
  String get smartCropAdjustCornersConfirm => 'Aplicar recorte';

  @override
  String get smartCropPresetAuto => 'Detecção automática';

  @override
  String get smartCropPresetCenter => 'Página centralizada';

  @override
  String get smartCropPresetFull => 'Imagem completa';

  @override
  String get smartCropUploadIntroGoogleScanner =>
      'Google Scanner (Melhor recorte)';

  @override
  String get smartCropDetectingEdges => 'Detectando bordas do documento…';

  @override
  String get smartCropAndroidOnly =>
      'A digitalização inteligente está disponível apenas no Android.';

  @override
  String smartCropPageIndicator(int current, int total) {
    return '$current/$total';
  }

  @override
  String smartCropMaxPagesReached(int max) {
    return 'Limite máximo de $max fotos atingido';
  }

  @override
  String get smartCropProcessingCrop => 'Aplicando recorte mágico…';

  @override
  String smartCropProcessingCropMultiple(int count) {
    return 'Recortando $count documentos…';
  }

  @override
  String get smartCropCroppedTitle => 'Documento Recortado';

  @override
  String get smartCropFilterOriginal => 'Original';

  @override
  String get smartCropFilterLighten => 'Clarear';

  @override
  String get smartCropFilterMagic => 'Mágico';

  @override
  String get smartCropFilterGrayscale => 'Escala de Cinza';

  @override
  String get smartCropFilterMono => 'P&B';

  @override
  String get smartCropFilterWarm => 'Quente';

  @override
  String get smartCropActionCreatePdf => 'Criar PDF';

  @override
  String get smartCropProcessingPdf => 'Gerando documento PDF…';

  @override
  String smartCropProcessingPdfMultiple(int count) {
    return 'Gerando PDF com $count páginas…';
  }

  @override
  String get smartCropPdfSuccess => 'Documento PDF gerado com sucesso';

  @override
  String get smartCropPdfPagesLabel => 'páginas';

  @override
  String get smartCropPdfSinglePageLabel => '1 página';

  @override
  String get smartCropImageCopied => 'Copiado';

  @override
  String get smartCropDeleteImageConfirm => 'Remover esta página do documento?';

  @override
  String get smartCropDeleteCapturedPageTitle => 'Excluir página';

  @override
  String get smartCropDeleteCapturedPageMessage =>
      'Tem certeza de que deseja excluir esta página ?';

  @override
  String get smartCropDeleteDocumentTitle => 'Excluir documento?';

  @override
  String get smartCropDeleteDocumentMessage =>
      'Tem certeza de que deseja excluir este documento? Esta ação não pode ser desfeita.';

  @override
  String get smartCropDeletePdfTitle => 'Excluir PDF?';

  @override
  String get smartCropDeletePdfMessage =>
      'Tem certeza de que deseja excluir este PDF? Esta ação não pode ser desfeita.';

  @override
  String get smartCropDeletePdfConfirm =>
      'Excluir este PDF do seu dispositivo?';

  @override
  String get smartCropPdfRenamed => 'PDF renomeado';

  @override
  String get smartCropPdfFileName => 'Nome do arquivo';

  @override
  String get smartCropPdfFileSize => 'Tamanho do arquivo';

  @override
  String get smartCropViewPdf => 'Visualizar PDF';

  @override
  String get smartCropSavePdf => 'Salvar PDF';

  @override
  String get smartCropSavePdfSuccess => 'PDF salvo com sucesso';

  @override
  String get smartCropRenamePdf => 'Renomear';

  @override
  String get smartCropRenamePdfHint => 'Nome do documento';

  @override
  String get smartCropStepReadingImages => 'Lendo imagens';

  @override
  String smartCropImportReadingProgress(int done, int total) {
    return 'Lendo $done de $total…';
  }

  @override
  String smartCropImportPartialFailure(int failed, int total) {
    return '$failed de $total imagens não puderam ser importadas';
  }

  @override
  String get smartCropStepDetectingEdges => 'Detectando bordas';

  @override
  String get smartCropStepCroppingImages => 'Recortando imagens';

  @override
  String get smartCropStepGeneratingPdf => 'Gerando PDF';

  @override
  String get smartCropProcessingPdfSubtitle =>
      'Estamos organizando suas imagens recortadas\nem um PDF de alta qualidade';

  @override
  String get smartCropProcessingPdfTitle => 'Criando Seu PDF';

  @override
  String get commonUntitledDocument => 'documento';

  @override
  String get pdfAssistantDefaultFileLabel => 'PDF';

  @override
  String get pdfAssistantTapToBrowse =>
      'Toque para navegar no diretório do dispositivo';

  @override
  String get errorPdfTextLoad => 'Erro ao carregar o texto.';

  @override
  String commonProgressPercent(int percent) {
    return '$percent%';
  }

  @override
  String translateExportTranslationTitle(String language) {
    return 'Tradução: $language';
  }

  @override
  String get translateExportDocumentTranslation => 'Tradução de Documento';

  @override
  String get translateExportTranslatedBadge => 'Traduzido';

  @override
  String get translateExportVerifiedFooter =>
      'Exportação de tradução offline verificada';

  @override
  String get translateExportPdfHeader => 'Exportação de Tradução';

  @override
  String get translateExportPdfFooterLabel => 'Documento Confidencial';

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
    return '${size}B';
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
  String get translateLangName_en => 'Inglês';

  @override
  String get translateLangName_ur => 'urdu';

  @override
  String get translateLangName_hi => 'Híndi';

  @override
  String get translateLangName_ar => 'Árabe';

  @override
  String get translateLangName_es => 'Espanhol';

  @override
  String get translateLangName_fr => 'Francês';

  @override
  String get translateLangName_de => 'Alemão';

  @override
  String get translateLangName_pt => 'Português';

  @override
  String get translateLangName_ru => 'Russo';

  @override
  String get translateLangName_zh => 'Chinesês (Simplificado)';

  @override
  String get translateLangName_zhTw => 'Chinesês (Tradicional)';

  @override
  String get translateLangName_ja => 'Japonês';

  @override
  String get translateLangName_ko => 'Coreano';

  @override
  String get translateLangName_it => 'Italiano';

  @override
  String get translateLangName_tr => 'Turco';

  @override
  String get translateLangName_nl => 'Holandês';

  @override
  String get translateLangName_sv => 'Sueco';

  @override
  String get translateLangName_no => 'Noruego';

  @override
  String get translateLangName_da => 'Dinamarquês';

  @override
  String get translateLangName_fi => 'Finlandês';

  @override
  String get translateLangName_el => 'Grego';

  @override
  String get translateLangName_pl => 'Polonês';

  @override
  String get translateLangName_cs => 'Checo';

  @override
  String get translateLangName_hu => 'Húngaro';

  @override
  String get translateLangName_ro => 'Romeno';

  @override
  String get translateLangName_bg => 'Búlgaro';

  @override
  String get translateLangName_uk => 'Ucraniano';

  @override
  String get translateLangName_fa => 'Persa';

  @override
  String get translateLangName_he => 'Hebraico';

  @override
  String get translateLangName_th => 'Tailandês';

  @override
  String get translateLangName_vi => 'Vietnamita';

  @override
  String get translateLangName_id => 'Indonésio';

  @override
  String get translateLangName_ms => 'Malaio';

  @override
  String get translateLangName_bn => 'bengali';

  @override
  String get translateLangName_ta => 'Tâmil';

  @override
  String get translateLangName_te => 'Telugu';

  @override
  String get translateLangName_mr => 'Marathi';

  @override
  String get translateLangName_gu => 'Guzerate';

  @override
  String get translateLangName_kn => 'Canarim';

  @override
  String get translateLangName_ml => 'malaiala';

  @override
  String get translateLangName_pa => 'Panjabi';

  @override
  String get translateLangName_sw => 'Suaíli';

  @override
  String get translateLangName_af => 'Africâner';

  @override
  String get translateLangName_ca => 'Catalão';

  @override
  String get translateLangName_hr => 'Croata';

  @override
  String get translateLangName_sk => 'Eslovaco';

  @override
  String get translateLangName_sl => 'Esloveno';

  @override
  String get translateLangName_sr => 'Sérvio';

  @override
  String get translateLangName_lt => 'Lituano';

  @override
  String get translateLangName_lv => 'Letão';

  @override
  String get translateLangName_et => 'Estoniano';

  @override
  String get translateLangName_is => 'Islandês';

  @override
  String get translateLangName_ga => 'Irlandês';

  @override
  String get translateLangName_mt => 'Maltês';

  @override
  String get translateLangName_sq => 'Albanês';

  @override
  String get translateLangName_mk => 'Macedônio';

  @override
  String get translateLangName_be => 'Bielo-russo';

  @override
  String get translateLangName_kk => 'Cazaque';

  @override
  String get translateLangName_uz => 'Uzbeque';

  @override
  String get translateLangName_az => 'Azerbaijano';

  @override
  String get translateLangName_hy => 'Armênio';

  @override
  String get translateLangName_ka => 'Georgiano';

  @override
  String get translateLangName_lo => 'Laosiano';

  @override
  String get translateLangName_km => 'Khmer';

  @override
  String get translateLangName_my => 'Birmanês';

  @override
  String get translateLangName_ne => 'Nepalês';

  @override
  String get translateLangName_si => 'Cingalês';

  @override
  String get translateLangName_am => 'Amárico';

  @override
  String get translateLangName_ha => 'Hauçá';

  @override
  String get translateLangName_yo => 'Iorubá';

  @override
  String get translateLangName_ig => 'Ibo';

  @override
  String get translateLangName_zu => 'zulu';

  @override
  String get translateLangName_xh => 'Xhosa';

  @override
  String get translateLangName_st => 'Soto do Sul';

  @override
  String get translateLangName_sn => 'Shona';

  @override
  String get translateLangName_rw => 'Kinyarwanda';

  @override
  String get translateLangName_so => 'somali';

  @override
  String get translateLangName_mg => 'Malgaxe';

  @override
  String get translateLangName_cy => 'Galês';

  @override
  String get translateLangName_mn => 'Mongol';

  @override
  String get translateLangName_tl => 'Tagalo / Filipino';

  @override
  String get translateLangName_ht => 'Crioulo Haitiano';

  @override
  String get translateLangName_eo => 'esperanto';

  @override
  String get translateLangName_la => 'Latim';

  @override
  String get translateLangName_ku => 'Curdo';

  @override
  String get translateLangName_ps => 'pashto';

  @override
  String get translateLangName_faAf => 'Dari';

  @override
  String get translateLangName_bs => 'Bósnio';

  @override
  String get translateLangName_mi => 'maori';

  @override
  String get translateLangName_sm => 'Samoano';

  @override
  String get translateLangName_haw => 'Havaiano';

  @override
  String get translateLangName_lb => 'Luxemburguês';
}
