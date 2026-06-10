import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/services/locale_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/l10n_extension.dart';
import '../../../core/widgets/l10n_text.dart';
import '../models/app_language_option.dart';
import 'language.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Flag to prevent piano clicking or multiple concurrent navigation triggers
  bool _isProcessing = false;

  /// Centralized method to handle operations safely with a debounce lock
  void _safeAction(Future<void> Function() action) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    try {
      await action();
    } catch (e) {
      debugPrint('Error executing safe action: $e');
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  /// Helper utility to parse and launch URLs safely
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $urlString';
    }
  }

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
          padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
          children: [
            Text(
              l10n.settingsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            _buildSettingsTile(
              svgAsset: 'assets/settings/language.svg',
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
                _safeAction(() async {
                  await Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => const LanguageSelectionScreen(),
                    ),
                  );
                });
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset: 'assets/settings/privacypolicy.svg',
              iconColor: const Color(0xff3F51B5),
              title: l10n.settingsPrivacy,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                _safeAction(() async {
                  await _launchURL(
                    'https://sites.google.com/view/ai-document-scanner-ocr-pdf/home',
                  );
                });
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset:
                  'assets/settings/privacypolicy.svg', // custom icons replace kar sakte hain variable path se
              iconColor: const Color(0xff43A047),
              title: l10n.settingsTerms,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                _safeAction(() async {
                  await _launchURL(
                    'https://sites.google.com/view/ai-document-scanner-ocr-pdf/terms-conditions',
                  );
                });
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset: 'assets/settings/share.svg',
              iconColor: const Color(0xffFB8C00),
              title: l10n.settingsContactSupport,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                _safeAction(() async {
                  await _launchURL(
                    'mailto:gamingtechukltd@gmail.com?subject=AI%20Document%20Scanner%20Support',
                  );
                });
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset: 'assets/settings/rate.svg',
              iconColor: const Color(0xffE53935),
              title: l10n.settingsRateApp,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                _safeAction(() async {
                  // Direct mapping template inside your store context
                  await _launchURL(
                    'https://play.google.com/store/apps/details?id=YOUR_APP_PACKAGE_ID_HERE',
                  );
                });
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              svgAsset: 'assets/settings/share.svg',
              iconColor: const Color(0xff00ACC1),
              title: l10n.settingsMoreApps,
              trailing: Icon(
                Icons.chevron_right_rounded,
                color: Colors.grey[400],
                size: 20,
              ),
              onTap: () {
                _safeAction(() async {
                  await _launchURL(
                    'https://play.google.com/store/search?q=pub:Gaming+Tech+Ltd&c=apps',
                  );
                });
              },
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String svgAsset,
    required Color iconColor,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: _isProcessing ? null : onTap,
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
              child: L10nText(
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
