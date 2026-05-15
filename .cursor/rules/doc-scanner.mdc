---
description: Doc Scanner — Flutter architecture, l10n, pro/free, scan/OCR/translate/live
alwaysApply: true
---

# Doc Scanner — project rules

**App:** document scanner + OCR + translator + live (camera) translate.

Write code a **1-year junior** can read: short files, plain names, no clever tricks.

---

## SOLID & naming

- One class = one job (scan UI ≠ OCR API ≠ save file).
- Extend via services/widgets; avoid giant `if (feature)` in UI.
- Screens/providers depend on abstractions (`OcrService`), not concrete APIs.
- Names: `scanPath`, `isLoading`, `isProUser` — not `sp`, `tmp2`.
- Files: `scan_screen.dart`, `ocr_service.dart`, `document_model.dart`.

---

## Folder structure

```
lib/
  main.dart, app.dart
  core/{constants,theme,utils,widgets}
  l10n/                         # generated — do not edit
  features/
    scan|ocr|translate|live_translate|subscription|settings/
      models/ services/ providers/ screens/ widgets/
```

| Layer | Does | Must NOT |
|-------|------|----------|
| **models** | Data, enums, JSON | UI, API calls |
| **services** | Camera, OCR, translate, files, permissions | widgets, setState |
| **providers** | State, call services, notifyListeners | layout, styles |
| **screens** | Scaffold, navigation, wire UI | raw HTTP, OCR parsing |
| **widgets** | Reusable UI | business rules |

New feature: model → service → provider → screen → add ARB keys first.

---

## Provider & performance

- **Provider** for app/feature state only; local UI state stays in widget.
- Logic in **services**, never in `build()`.
- `const` widgets; `Selector`/`Consumer` with narrow scope.
- No heavy work in `build()`; `ListView.builder` for lists.
- `StatelessWidget` default; colors in `AppColors`, theme in `AppTheme` only.

---

## Localization (l10n)

- English: `l10n/app_en.arb` → generated `lib/l10n/` (never edit generated).
- camelCase keys: `scanDocument`, `errorCameraPermission`.
- **No hardcoded UI text** — use `AppLocalizations.of(context)!.scanTitle`.
- New string → new ARB key first; use placeholders/plurals, don’t concat sentences.
- Later locales: copy `app_en.arb` → `app_<locale>.arb`, translate values only, run `flutter gen-l10n`.

---

## Domain: scan, OCR, translate, live

| Feature | Flow |
|---------|------|
| **Scan** | capture/import → crop/enhance → multi-page `DocumentModel` |
| **OCR** | image → text in service; progress UI; cache on model |
| **Translate** | source/target langs; swap; offline/online in service |
| **Live** | camera preview + stream translate; release camera on dispose |

- `DocumentModel`: id, pages[], title, ocrText?, langs.
- `ScanPageModel`: imagePath, order, cropRect?.
- Permissions in **service**; denied → localized dialog + open settings.
- OCR/translate: copy/share/export; don’t block UI thread.
- No API keys in source; documents on-device unless pro cloud export.

---

## Pro vs free

- `SubscriptionProvider` → `bool get isPro` (single source of truth).
- Limits in `core/constants/limits.dart` — not duplicated in widgets.
- **Free:** limited pages/OCR/languages. **Pro:** unlimited, live translate, PDF, no watermark.
- Gate in provider/service before OCR/export; UI shows lock + localized upsell, not silent fail.
- Paywall strings in ARB: `proTitle`, `proUpgradeButton`, `proLimitPages`, etc.
- use flutter_screenutils ok
---

## Errors

- Every async: loading + error UI; no silent `catch (_) {}`.
- Errors from l10n keys (`errorOcrFailed`, `errorNetwork`, etc.).
