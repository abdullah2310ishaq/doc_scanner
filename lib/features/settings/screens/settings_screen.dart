import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/home_assets.dart';
import '../../../core/services/locale_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../models/app_language_option.dart';
import 'language.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final localeService = context.watch<LocaleService>();
    final languageCode = localeService.getCurrentLocale().languageCode;
    final languageLabel =
        nativeNameForLanguageCode(languageCode) ?? languageCode;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // Premium Header Layout matching HomeHeader exactly
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning,',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Flexible(
                            child: Text(
                              'Abdullah',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                                height: 1.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Pro button built exactly like HomeHeader
                Semantics(
                  button: true,
                  child: InkWell(
                    onTap: () {
                      // Handle premium click action
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      HomeAssets.pro,
                      height: 33,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),

            // Settings Options List
            _buildSettingsTile(
              svgAsset:
                  'assets/settings/language.svg', // Rename to your asset name
              iconColor: const Color(0xff5C6BC0),
              title: l10n.settingsLanguage,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    languageLabel,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (_) => const LanguageSelectionScreen(),
                  ),
                );
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset:
                  'assets/settings/privacypolicy.svg', // Rename to your asset name
              iconColor: const Color(0xff3F51B5),
              title: l10n.settingsPrivacy,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                // Privacy policy path
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset: 'assets/settings/rate.svg', // Rename to your asset name
              iconColor: const Color(0xff5C6BC0),
              title: 'Rate App',
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                // Rate app path
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset:
                  'assets/settings/share.svg', // Rename to your asset name
              iconColor: const Color(0xff5C6BC0),
              title: 'Share App',
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                // Share app path
              },
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  // Helper method using custom SVGs
  Widget _buildSettingsTile({
    required String svgAsset,
    required Color iconColor,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
        child: Row(
          children: [
            SvgPicture.asset(
              svgAsset,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              placeholderBuilder: (BuildContext context) =>
                  Icon(Icons.settings_applications, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  // Made divider much cleaner, subtle, and thinner
  Widget _buildDivider() {
    return Divider(
      color: Colors.grey[100],
      height: 1,
      thickness: 0.8,
      indent: 4,
      endIndent: 4,
    );
  }
}
