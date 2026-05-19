import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Assuming you use this for your custom SVGs
import '../../../core/utils/l10n_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Header Section: Greeting & Pro Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning,',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Text(
                          'Angrew Heubru',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text('👋', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
                // Pro Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff7C4DFF), // Purple accent color
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/home/pro.png', width: 20, height: 20),
                      SizedBox(width: 6),
                      Text(
                        'Pro',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Settings Options List
            _buildSettingsTile(
              icon: Icons
                  .language_rounded, // Replace with SvgPicture.asset('assets/language.svg')
              iconColor: const Color(0xff5C6BC0),
              title: 'Language',
              trailing: Text(
                'English',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
              onTap: () {
                // Handle Language Selection
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              icon: Icons
                  .verified_user_rounded, // Replace with SvgPicture.asset('assets/privacy.svg')
              iconColor: const Color(0xff3F51B5),
              title: 'Privacy Policy',
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black87,
              ),
              onTap: () {
                // Handle Privacy Policy Tap
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              icon: Icons
                  .star_rounded, // Replace with SvgPicture.asset('assets/rate.svg')
              iconColor: const Color(0xff5C6BC0),
              title: 'Rate App',
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black87,
              ),
              onTap: () {
                // Handle Rate App Tap
              },
            ),
            _buildDivider(),

            _buildSettingsTile(
              icon: Icons
                  .share_rounded, // Replace with SvgPicture.asset('assets/share.svg')
              iconColor: const Color(0xff5C6BC0),
              title: 'Share App',
              trailing: const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black87,
              ),
              onTap: () {
                // Handle Share App Tap
              },
            ),
            _buildDivider(),
          ],
        ),
      ),
    );
  }

  // Helper method to build consistent tiles
  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 26,
            ), // Swap this with your SvgPicture.asset when ready
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  // Thin custom divider to match the design style
  Widget _buildDivider() {
    return Divider(color: Colors.grey[200], height: 1, thickness: 1);
  }
}
