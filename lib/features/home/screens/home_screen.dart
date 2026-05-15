import 'package:flutter/material.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/utils/l10n_extension.dart';
import '../widgets/home_feature_tags.dart';
import '../widgets/home_header.dart';
import '../widgets/home_hero_card.dart';

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
        ],
      ),
    );
  }
}
