import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../chatbot/screens/upload_new_pdf.dart';
import '../../pdf_assistant/widgets/pdf_assistant_source_sheet.dart';
import '../../ocr/ocr_flow.dart';
import '../../ocr/screens/live_ocr_camera_screen.dart';
import '../../ocr/widgets/ocr_input_method_sheet.dart';
import '../../smartcrop/smart_crop_flow.dart';
import '../../smartcrop/widgets/smart_crop_input_sheet.dart';
import '../widgets/home_drawer.dart';
import '../widgets/home_feature_card.dart';
import '../widgets/home_feature_tags.dart';
import '../widgets/home_header_delegate.dart';
import '../widgets/home_hero_card.dart';
import '../widgets/home_recent_documents.dart';
import '../widgets/home_search_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onDrawerDestination});

  final ValueChanged<HomeDrawerDestination>? onDrawerDestination;

  void _openOcrInputSheet(BuildContext context) {
    showOcrInputMethodSheet(
      context,
      onLiveCamera: () => LiveOcrCameraScreen.open(context),
      onUploadImage: () => OcrFlow.pickImageAndAnalyze(context),
    );
  }

  void _openSmartCropInputSheet(BuildContext context) {
    showSmartCropInputSheet(
      context,
      onLiveCamera: () => SmartCropFlow.startLiveCamera(context),
      onUploadImage: () => SmartCropFlow.pickFromGallery(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      // drawer: HomeDrawer(
      //   appTitle: l10n.appTitle,
      //   homeLabel: l10n.navHome,
      //   scanLabel: l10n.navScan,
      //   documentsLabel: l10n.navDocuments,
      //   translateLabel: l10n.navTranslate,
      //   liveLabel: l10n.navLive,
      //   settingsLabel: l10n.navSettings,
      //   proTitle: l10n.proTitle,
      //   onDestinationSelected: onDrawerDestination,
      // ),
      body: Builder(
        builder: (scaffoldContext) {
          return SafeArea(
            bottom: false,
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: HomeHeaderSliverDelegate(
                    greeting: l10n.homeGreeting('Abdullah'),
                    titlePrefix: l10n.homeTitlePrefix,
                    proSemanticsLabel: l10n.homeProBadge,
                    menuSemanticsLabel: l10n.homeMenuButton,
                    onMenuTap: () => Scaffold.of(scaffoldContext).openDrawer(),
                    tags: HomeFeatureTags(
                      tags: [
                        HomeFeatureTag(
                          label: l10n.homeTagAiPowered,
                          iconAsset: HomeAssets.sparkles,
                        ),
                        HomeFeatureTag(
                          label: l10n.homeTagFastOcr,
                          iconAsset: HomeAssets.ocr,
                        ),
                        HomeFeatureTag(
                          label: l10n.homeTagSecure,
                          iconAsset: HomeAssets.secure,
                        ),
                        HomeFeatureTag(
                          label: l10n.homeTagSmartCrop,
                          iconAsset: HomeAssets.crop,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      HomeHeroCard(
                        badge: l10n.homeHeroBadge,
                        title: l10n.homeHeroTitle,
                        subtitle: l10n.homeHeroSubtitle,
                        buttonLabel: l10n.homeHeroButton,
                        onPressed: () => _openOcrInputSheet(scaffoldContext),
                      ),
                      const SizedBox(height: 16),
                      HomeSearchBar(hint: l10n.homeSearchHint),
                      const SizedBox(height: 16),
                      HomeFeatureCard(
                        title: l10n.homeFeatureOcrTitle,
                        subtitle: l10n.homeFeatureOcrSubtitle,
                        backgroundColor: AppColors.cardOcrBg,
                        iconAsset: HomeAssets.ocr,
                        onTap: () => _openOcrInputSheet(scaffoldContext),
                      ),
                      const SizedBox(height: 10),
                      HomeFeatureCard(
                        title: l10n.homeFeaturePdfTitle,
                        subtitle: l10n.homeFeaturePdfSubtitle,
                        backgroundColor: AppColors.cardPdfBg,
                        iconAsset: HomeAssets.pdf,
                        onTap: () =>
                            showPdfAssistantSourceSheet(scaffoldContext),
                      ),
                      const SizedBox(height: 10),
                      HomeFeatureCard(
                        title: l10n.homeFeatureChatbotTitle,
                        subtitle: l10n.homeFeatureChatbotSubtitle,
                        backgroundColor: AppColors.cardChatbotBg,
                        iconAsset: HomeAssets.aichatPng,
                        onTap: () => UploadNewPdfScreen.open(scaffoldContext),
                      ),
                      const SizedBox(height: 10),
                      HomeFeatureCard(
                        title: l10n.homeFeatureCropTitle,
                        subtitle: l10n.homeFeatureCropSubtitle,
                        backgroundColor: AppColors.cardCropBg,
                        iconAsset: HomeAssets.crop,
                        onTap: () => _openSmartCropInputSheet(scaffoldContext),
                      ),
                      const SizedBox(height: 20),
                      HomeRecentDocuments(
                        title: l10n.homeRecentDocuments,
                        seeAllLabel: l10n.homeSeeAll,
                        documents: [
                          HomeDocumentItem(
                            name: l10n.homeSampleDocName,
                            meta: l10n.homeSampleDocMeta,
                          ),
                          HomeDocumentItem(
                            name: l10n.homeSampleDocName,
                            meta: l10n.homeSampleDocMeta,
                          ),
                        ],
                        onSeeAll: () {},
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
