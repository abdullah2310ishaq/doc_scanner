import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/utils/l10n_extension.dart';
import '../widgets/home_feature_tags.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_card.dart';
import '../widgets/home_feature_card.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/home_recent_documents.dart';
import '../../../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          HomeHeader(
            greeting: l10n.homeGreeting('Abdullah'),
            titlePrefix: l10n.homeTitlePrefix,
            proSemanticsLabel: l10n.homeProBadge,
          ),
          const SizedBox(height: 16),
          HomeFeatureTags(
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
          const SizedBox(height: 16),
          HomeHeroCard(
            badge: l10n.homeHeroBadge,
            title: l10n.homeHeroTitle,
            subtitle: l10n.homeHeroSubtitle,
            buttonLabel: l10n.homeHeroButton,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          HomeSearchBar(hint: l10n.homeSearchHint),
          const SizedBox(height: 16),
          HomeFeatureCard(
            title: l10n.homeFeatureOcrTitle,
            subtitle: l10n.homeFeatureOcrSubtitle,
            backgroundColor: AppColors.cardOcrBg,
            iconAsset: HomeAssets.ocr,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          HomeFeatureCard(
            title: l10n.homeFeaturePdfTitle,
            subtitle: l10n.homeFeaturePdfSubtitle,
            backgroundColor: AppColors.cardPdfBg,
            iconAsset: HomeAssets.pdf,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          HomeFeatureCard(
            title: l10n.homeFeatureChatbotTitle,
            subtitle: l10n.homeFeatureChatbotSubtitle,
            backgroundColor: AppColors.cardChatbotBg,
            iconAsset: HomeAssets.aichatPng,
            onTap: () {},
          ),
          const SizedBox(height: 10),
          HomeFeatureCard(
            title: l10n.homeFeatureCropTitle,
            subtitle: l10n.homeFeatureCropSubtitle,
            backgroundColor: AppColors.cardCropBg,
            iconAsset: HomeAssets.crop,
            onTap: () {},
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
        ],
      ),
    );
  }
}
