import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/l10n_extension.dart';

class RenameDialog {
  RenameDialog._();

  /// Shows a rename dialog styled identically to the design image.
  /// Returns the new name string, or `null` if the user cancelled.
  static Future<String?> show({
    required BuildContext context,
    required String title,
    required String currentName,
    String? hintText,
  }) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        return _RenameDialogWidget(
          title: title,
          currentName: currentName,
          hintText: hintText,
        );
      },
    );

    return (result == null || result.isEmpty) ? null : result;
  }
}

class _RenameDialogWidget extends StatefulWidget {
  final String title;
  final String currentName;
  final String? hintText;

  const _RenameDialogWidget({
    required this.title,
    required this.currentName,
    this.hintText,
  });

  @override
  State<_RenameDialogWidget> createState() => _RenameDialogWidgetState();
}

class _RenameDialogWidgetState extends State<_RenameDialogWidget> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Soft rounded container curves
      ),
      elevation: 0,
      backgroundColor: AppColors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Left aligned title jaisa design mein hai
            children: [
              // Dialog Title (Left aligned, Bold, Dark grey)
              Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xFF2D3142),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),

              // Text Field with simple bottom line matching design input layout
              TextField(
                controller: controller,
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText ?? l10n.chatbotRenameHint,
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB0B3C1),
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB0B3C1),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons layout matching image exact spacing
              Row(
                children: [
                  // Done Button (Primary Accent)
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(controller.text.trim()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4A55FF), // Indigo/Blue hex color filter mapping
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Done', // Using fixed strings matching image design requirements
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Cancel Button (Soft Grey container background)
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(null),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE2E2E2), // Light neutral grey jaisa setup image mein hai
                          foregroundColor: const Color(0xFF2D3142),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
