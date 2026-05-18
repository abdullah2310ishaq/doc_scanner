import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/translate_language.dart';
import '../utils/translate_recent_languages.dart';

Future<void> showTranslateLanguageSheet(
  BuildContext context, {
  required String title,
  required String searchHint,
  required String recentLabel,
  required String emptyLabel,
  required List<TranslateLanguage> languages,
  required TranslateLanguage? selected,
  required ValueChanged<TranslateLanguage> onSelected,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (sheetContext) {
      return _TranslateLanguageSheet(
        title: title,
        searchHint: searchHint,
        recentLabel: recentLabel,
        emptyLabel: emptyLabel,
        languages: languages,
        selected: selected,
        onSelected: onSelected,
      );
    },
  );
}

class _TranslateLanguageSheet extends StatefulWidget {
  const _TranslateLanguageSheet({
    required this.title,
    required this.searchHint,
    required this.recentLabel,
    required this.emptyLabel,
    required this.languages,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final String searchHint;
  final String recentLabel;
  final String emptyLabel;
  final List<TranslateLanguage> languages;
  final TranslateLanguage? selected;
  final ValueChanged<TranslateLanguage> onSelected;

  @override
  State<_TranslateLanguageSheet> createState() => _TranslateLanguageSheetState();
}

class _TranslateLanguageSheetState extends State<_TranslateLanguageSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TranslateLanguage> get _filteredLanguages {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return widget.languages;

    return widget.languages
        .where((language) => language.name.toLowerCase().contains(query))
        .toList();
  }

  List<TranslateLanguage> get _recentLanguages {
    if (_query.trim().isNotEmpty) return const [];

    return TranslateRecentLanguages.resolve(widget.languages);
  }

  List<TranslateLanguage> get _listLanguages {
    final filtered = _filteredLanguages;
    if (_query.trim().isNotEmpty) return filtered;

    final recentCodes = _recentLanguages.map((language) => language.code).toSet();
    if (recentCodes.isEmpty) return filtered;

    return filtered
        .where((language) => !recentCodes.contains(language.code))
        .toList();
  }

  void _selectLanguage(TranslateLanguage language) {
    TranslateRecentLanguages.record(language);
    widget.onSelected(language);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final recentLanguages = _recentLanguages;
    final listLanguages = _listLanguages;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.72,
      minChildSize: 0.45,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 12, 16, 12 + bottomInset),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.tagBorder,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  hintText: widget.searchHint,
                  hintStyle: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
                  filled: true,
                  fillColor: AppColors.scaffoldBackground,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppColors.translateCardRadius),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    if (recentLanguages.isNotEmpty) ...[
                      _SectionHeader(label: widget.recentLabel),
                      ...recentLanguages.map(
                        (language) => _LanguageTile(
                          language: language,
                          isSelected: language.code == widget.selected?.code,
                          onTap: () => _selectLanguage(language),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: AppColors.translateCardBorder),
                      const SizedBox(height: 8),
                    ],
                    if (listLanguages.isEmpty && recentLanguages.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text(
                            widget.emptyLabel,
                            style: const TextStyle(color: AppColors.textSecondary),
                          ),
                        ),
                      )
                    else
                      ...listLanguages.map(
                        (language) => _LanguageTile(
                          language: language,
                          isSelected: language.code == widget.selected?.code,
                          onTap: () => _selectLanguage(language),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final TranslateLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 4),
      title: Text(
        language.name,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: AppColors.textLink, size: 22)
          : null,
    );
  }
}
