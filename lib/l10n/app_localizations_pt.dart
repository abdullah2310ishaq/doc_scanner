// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Scanner de Documentos';

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
  String get commonRetry => 'Tentar novamente';

  @override
  String get commonClose => 'Fechar';

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
  String get homeTagAiPowered => 'Com IA';

  @override
  String get homeTagFastOcr => 'OCR rápido';

  @override
  String get homeTagSecure => 'Seguro';

  @override
  String get homeTagSmartCrop => 'Recorte inteligente';

  @override
  String get homeHeroBadge => 'IA POWERED';

  @override
  String get homeHeroTitle => 'Scanner OCR\nInteligente';

  @override
  String get homeHeroSubtitle =>
      'OCR com IA para reconhecimento de texto rápido e preciso em segundos.';

  @override
  String get homeHeroButton => 'Scanner OCR';

  @override
  String get homeSearchHint => 'Pesquisar aqui';

  @override
  String get homeFeatureOcrTitle => 'Scanner OCR';

  @override
  String get homeFeatureOcrSubtitle => 'Extrair texto de imagens ou documentos';

  @override
  String get homeFeaturePdfTitle => 'Assistente PDF';

  @override
  String get homeFeaturePdfSubtitle => 'Traduzir e transcrever PDFs';

  @override
  String get homeFeatureChatbotTitle => 'Chatbot IA';

  @override
  String get homeFeatureChatbotSubtitle => 'Enviar PDF e fazer perguntas';

  @override
  String get homeFeatureCropTitle => 'Recorte inteligente';

  @override
  String get homeFeatureCropSubtitle => 'Auto recorte e melhoria';

  @override
  String get homeRecentDocuments => 'Documentos recentes';

  @override
  String get homeSeeAll => 'Ver tudo';

  @override
  String get homeEmptyDocuments =>
      'Nenhum documento. Toque em Escanear para começar.';

  @override
  String get homeSampleDocName => 'Fatura_2026.pdf';

  @override
  String get homeSampleDocMeta => '10 de maio de 2026 • 2,4 MB';

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
  String get scanRetake => 'Tirar novamente';

  @override
  String get scanCrop => 'Recortar';

  @override
  String get scanEnhance => 'Melhorar';

  @override
  String get scanDone => 'Concluído';

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
  String get ocrEmpty => 'Nenhum texto encontrado';

  @override
  String get ocrCopySuccess => 'Texto copiado';

  @override
  String get ocrEditHint => 'Editar texto reconhecido';

  @override
  String get ocrInputMethodTitle => 'Escolher método de entrada';

  @override
  String get ocrInputMethodSubtitle => 'Selecione como extrair o texto';

  @override
  String get ocrInputLiveCameraTitle => 'Câmera ao vivo';

  @override
  String get ocrInputLiveCameraDescription => 'Capturar imagem com câmera';

  @override
  String get ocrInputUploadImageTitle => 'Enviar imagem';

  @override
  String get ocrInputUploadImageDescription => 'Escolher da galeria';

  @override
  String get ocrLiveCameraTitle => 'Câmera OCR ao vivo';

  @override
  String get ocrLiveCameraTip => 'Dica: boa iluminação melhora o resultado';

  @override
  String get ocrLiveCameraClose => 'Fechar câmera';

  @override
  String get ocrLiveCameraFlash => 'Alternar flash';

  @override
  String get ocrLiveCameraCapture => 'Capturar para OCR';

  @override
  String get ocrLiveCameraInitializing => 'Iniciando câmera…';

  @override
  String get ocrAnalyzeTitle => 'Scanner OCR';

  @override
  String get ocrAnalyzeCopy => 'Copiar';

  @override
  String get ocrAnalyzeTranslate => 'Traduzir';

  @override
  String get ocrAnalyzeProcessing => 'Analisando…';

  @override
  String get ocrAnalyzeTranslateNext => 'Abrindo tradução';

  @override
  String get ocrNoTextTitle => 'Nenhum texto legível';

  @override
  String get ocrNoTextHint => 'Tente uma imagem mais nítida';

  @override
  String get ocrNoTextRetakePhoto => 'Tirar foto novamente';

  @override
  String get ocrNoTextChooseGallery => 'Escolher da galeria';

  @override
  String get translateTitle => 'Traduzir';

  @override
  String get translateSourceLanguage => 'De';

  @override
  String get translateTargetLanguage => 'Para';

  @override
  String get translateSwapLanguages => 'Trocar idiomas';

  @override
  String get translateButton => 'Traduzir';

  @override
  String get translateRunning => 'Traduzindo…';

  @override
  String get translatePasteHint => 'Cole ou digite texto';

  @override
  String get translateCopyResult => 'Copiar tradução';

  @override
  String get translateResultTitle => 'Tradução';

  @override
  String get translateResultSubtitle =>
      'Traduza seu texto para qualquer idioma';

  @override
  String get translateSelectedText => 'Texto selecionado';

  @override
  String get translateSelectedLanguage => 'Idioma selecionado';

  @override
  String get translateSelectLanguage => 'Selecionar idioma';

  @override
  String get translateSearchLanguage => 'Pesquisar idioma';

  @override
  String get translateRecentLanguages => 'Recentes';

  @override
  String get translateNoLanguagesFound => 'Nenhum idioma encontrado';

  @override
  String get translateTranslatedText => 'Texto traduzido';

  @override
  String get translatePlaceholder => 'A tradução aparecerá aqui…';

  @override
  String get translateSeeMore => 'Ver mais';

  @override
  String get translateReadAloud => 'Ler em voz alta';

  @override
  String get translateSavePdf => 'Salvar PDF';

  @override
  String get translateSavePng => 'Salvar imagem';

  @override
  String get translateSaveComingSoon => 'Em breve';

  @override
  String get translateDownloadOptionTitle => 'Escolher opção de download';

  @override
  String get translateDownloadOptionSubtitle => 'Selecione o que deseja baixar';

  @override
  String get translateDownloadSelectedTextTitle => 'Baixar texto selecionado';

  @override
  String get translateDownloadSelectedTextDescription =>
      'Apenas o texto selecionado';

  @override
  String get translateDownloadCompleteFileTitle => 'Baixar arquivo completo';

  @override
  String get translateDownloadCompleteFileDescription => 'Arquivo inteiro';

  @override
  String get translateSavePdfSuccess => 'PDF salvo com sucesso';

  @override
  String get translateSavePngSuccess => 'Imagem salva com sucesso';

  @override
  String get translateExportNeedsTranslation => 'Traduza antes de baixar';

  @override
  String get liveTitle => 'Tradução ao vivo';

  @override
  String get liveStart => 'Iniciar câmera';

  @override
  String get liveStop => 'Parar';

  @override
  String get liveListening => 'Detectando…';

  @override
  String get livePointAtText => 'Aponte para o texto';

  @override
  String get livePermissionNeeded => 'Permissão da câmera necessária';

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
  String get settingsPrivacy => 'Privacidade';

  @override
  String get settingsTerms => 'Termos de uso';

  @override
  String get permissionCameraTitle => 'Permissão de câmera';

  @override
  String get permissionCameraMessage =>
      'Permita acesso à câmera para escanear documentos.';

  @override
  String get permissionStorageTitle => 'Permissão de armazenamento';

  @override
  String get permissionStorageMessage => 'Permita acesso para salvar arquivos.';

  @override
  String get permissionOpenSettings => 'Abrir configurações';

  @override
  String get permissionDenied => 'Permissão negada';

  @override
  String get errorCameraUnavailable => 'Câmera não disponível';

  @override
  String get errorFileRead => 'Não foi possível ler o arquivo';

  @override
  String get errorNetwork => 'Verifique sua conexão';

  @override
  String get errorNoInternetFeatures => 'Sem conexão com a internet';

  @override
  String get exitAppTitle => 'Sair do app';

  @override
  String get exitAppMessage => 'Deseja realmente sair?';

  @override
  String get exitAppConfirm => 'Sair';

  @override
  String get errorOcrFailed => 'Falha no OCR';

  @override
  String get errorTranslateFailed => 'Falha na tradução';

  @override
  String get errorTranslateModelDownload => 'Erro ao baixar pacote de idioma';

  @override
  String get errorTranslateUnsupportedLanguage => 'Idioma não suportado';

  @override
  String get proTitle => 'Doc Scanner Pro';

  @override
  String get proSubtitle => 'OCR e digitalizações ilimitadas';

  @override
  String get proUpgradeButton => 'Atualizar para Pro';

  @override
  String get proRestorePurchases => 'Restaurar compras';

  @override
  String get proFeatureLocked => 'Função Pro';

  @override
  String proLimitPages(int max) {
    return 'Gratuito até $max páginas';
  }

  @override
  String get proLimitOcr => 'OCR ilimitado no Pro';

  @override
  String get proLimitTranslate => 'Todos os idiomas no Pro';

  @override
  String get proLimitLive => 'Tradução ao vivo apenas no Pro';

  @override
  String get proPurchaseSuccess => 'Bem-vindo ao Pro!';

  @override
  String get proPurchaseFailed => 'Falha na compra';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get exportImage => 'Exportar imagem';

  @override
  String get exportSuccess => 'Exportação concluída';

  @override
  String get exportFailed => 'Falha na exportação';

  @override
  String get languageSearchHint => 'Pesquisar idioma';

  @override
  String get languageAuto => 'Detecção automática';

  @override
  String get chatbotTitle => 'Chatbot IA';

  @override
  String get chatbotHistoryButton => 'Histórico';

  @override
  String get chatbotBadge => 'Seu assistente IA';

  @override
  String get chatbotHeadlineChat => 'Chat';

  @override
  String get chatbotHeadlineMiddle => ' com seu ';

  @override
  String get chatbotHeadlinePdf => 'PDF';

  @override
  String get chatbotTryAsking => 'Tente perguntar';

  @override
  String get chatbotSuggestSummarize => 'Resumir PDF';

  @override
  String get chatbotSuggestKeyPoints => 'Pontos principais';

  @override
  String get chatbotSuggestExplain => 'Explicar em detalhes';

  @override
  String get chatbotSuggestTranslate => 'Traduzir PDF';

  @override
  String get chatbotUploadHint => 'Enviar PDF...';

  @override
  String get chatbotSheetTitle => 'Chat com PDF';

  @override
  String get chatbotSheetSubtitle => 'Envie um PDF e faça perguntas';

  @override
  String get chatbotChoosePdfTitle => 'Escolher PDF';

  @override
  String get chatbotChoosePdfDescription => 'Selecionar do dispositivo';

  @override
  String get chatbotRecentFilesTitle => 'Arquivos recentes';

  @override
  String get chatbotRecentFilesDescription => 'Escolher recentes';

  @override
  String get errorChatbotPdfPickFailed => 'Não foi possível abrir o PDF';

  @override
  String get chatbotAnalyzingTitle => 'Analisando documento...';

  @override
  String get chatbotAnalyzingSubtitle => 'Aguarde';

  @override
  String get chatbotStepReadingPdf => 'Lendo PDF';

  @override
  String get chatbotStepExtractingText => 'Extraindo texto';

  @override
  String get chatbotStepUnderstandingContent => 'Entendendo conteúdo';

  @override
  String get chatbotStepPreparingChat => 'Preparando chat';

  @override
  String get chatbotHistoryTitle => 'Histórico';

  @override
  String get chatbotNoConversationsTitle => 'Nenhuma conversa';

  @override
  String get chatbotNoConversationsSubtitle => 'Envie um PDF para começar';

  @override
  String get chatbotUploadPdfButton => 'Enviar PDF';

  @override
  String get chatbotDocumentReadyTitle => 'Documento pronto';

  @override
  String get chatbotDocumentReadySubtitle => 'Resumo rápido';

  @override
  String get chatbotCurrentSummary => 'Resumo';

  @override
  String get chatbotStartChatting => 'Iniciar chat';

  @override
  String get chatbotChatGreeting => '👋🏻 Olá! Pergunte algo sobre o PDF.';

  @override
  String get chatbotChatYouCanAsk => 'Você pode perguntar:';

  @override
  String get chatbotChatPromptSummarize => 'Resumir documento';

  @override
  String get chatbotChatPromptHighlights => 'Principais pontos';

  @override
  String get chatbotChatPromptFinancial => 'Dados financeiros';

  @override
  String get chatbotChatPromptDates => 'Datas importantes';

  @override
  String get chatbotChatInputHint => 'Pergunte algo...';

  @override
  String get chatbotDeleteTitle => 'Excluir chat?';

  @override
  String get chatbotDeleteMessage => 'Não pode ser desfeito.';

  @override
  String get chatbotRenameTitle => 'Renomear PDF';

  @override
  String get chatbotRenameHint => 'Digite um nome';

  @override
  String get chatbotAnalyzeFailed => 'Falha na análise';

  @override
  String get chatbotChatFailed => 'Falha na resposta';

  @override
  String get errorChatbotPdfEmpty => 'Nenhum texto encontrado';

  @override
  String get pdfAssistantTitle => 'Assistente PDF';

  @override
  String get pdfAssistantSheetTitle => 'Assistente PDF';

  @override
  String get pdfAssistantSheetSubtitle => 'Traduzir PDF';

  @override
  String get pdfAssistantChoosePdfTitle => 'Escolher PDF';

  @override
  String get pdfAssistantChoosePdfDescription => 'Selecionar do dispositivo';

  @override
  String get pdfAssistantLinkTitle => 'Adicionar link PDF';

  @override
  String get pdfAssistantLinkDescription =>
      'Cole um link de PDF para enviar diretamente';

  @override
  String get pdfAssistantLinkHint => 'Colar URL';

  @override
  String get pdfAssistantLinkButton => 'Baixar';

  @override
  String get pdfAssistantTranslateTo => 'Traduzir para';

  @override
  String get pdfAssistantStartProcessing => 'Iniciar';

  @override
  String get pdfAssistantNoFileSelected => 'Nenhum arquivo';

  @override
  String get pdfAssistantSelectLanguage => 'Escolha um idioma';

  @override
  String get pdfAssistantProcessingTitle => 'Processando…';

  @override
  String get pdfAssistantProcessingSubtitle => 'Aguarde';

  @override
  String get pdfAssistantStepExtracting => 'Extraindo…';

  @override
  String get pdfAssistantStepTranslating => 'Traduzindo…';

  @override
  String get pdfAssistantStepGeneratingPdf => 'Gerando PDF…';

  @override
  String get pdfAssistantStepFinalizing => 'Finalizando…';

  @override
  String get pdfAssistantResultTitle => 'Resultado';

  @override
  String get pdfAssistantTranslatedPdfTitle => 'PDF traduzido';

  @override
  String get pdfAssistantTranslatedPdfDescription => 'Layout original';

  @override
  String get pdfAssistantExtractedTextTitle => 'Texto extraído';

  @override
  String get pdfAssistantExtractedTextDescription => 'Documento simples';

  @override
  String get pdfAssistantActionOpen => 'Abrir';

  @override
  String get pdfAssistantActionDownload => 'Baixar';

  @override
  String get pdfAssistantDeleteTitle => 'Excluir?';

  @override
  String get pdfAssistantDeleteMessage => 'Não pode ser desfeito';

  @override
  String get pdfAssistantDownloadSuccess => 'Salvo';

  @override
  String get pdfAssistantOpenFailed => 'Não foi possível abrir';

  @override
  String get pdfAssistantProcessFailed => 'Erro ao processar';

  @override
  String get errorPdfAssistantPickFailed => 'Falha ao selecionar';

  @override
  String get errorPdfAssistantLinkFailed => 'Link inválido';

  @override
  String get errorPdfAssistantPdfEmpty => 'PDF vazio';

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
  String get commonNext => 'Próximo';

  @override
  String get commonSkip => 'Pular';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get splashTagline => 'Scanner de documentos com IA';

  @override
  String get onboardingPage1Title => 'Escaneie documentos';

  @override
  String get onboardingPage1Description =>
      'Capture recibos e notas rapidamente.';

  @override
  String get onboardingPage2Title => 'OCR e tradução';

  @override
  String get onboardingPage2Description =>
      'Extraia e traduza texto facilmente.';

  @override
  String get onboardingPage3Title => 'Salvar e exportar';

  @override
  String get onboardingPage3Description => 'Tudo em um só lugar.';

  @override
  String get settingsChooseLanguage => 'Escolher idioma';

  @override
  String get settingsLanguageApply => 'Aplicar';
}
