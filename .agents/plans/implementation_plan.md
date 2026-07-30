# 🎯 Implementation Plan: Strict Mix-First Styling & Typed Assets Enforcement

This plan refactors all UI routes and widgets to strictly enforce Mix 2.0 stylers, remove raw `SizedBox`/`Column`/`Row` widgets, and eliminate string-based image assets.

---

## ⚠️ User Review Required

> [!IMPORTANT]
> - `SizedBox` is completely removed and replaced with `BoxStyler().height(...)()` or `BoxStyler().width(...)()`.
> - Layout containers (`Column` / `Row`) are completely replaced with `FlexBoxStyler().column(...)` / `FlexBoxStyler().row(...)`.
> - Image assets are strictly accessed via FlutterGen `Assets.source.assets...`.
> - All dimensions and layouts are specified via Mix `Styler` objects instead of direct widget constructor parameters.

---

## 🛠 Proposed Changes

### 1. `lib/routes/route_01_onboarding_welcome.dart`
#### [MODIFY] [route_01_onboarding_welcome.dart](file:///e:/litscroll/litscroll/lib/routes/route_01_onboarding_welcome.dart)
- Replace `Column` with `FlexBoxStyler().column()`.
- Replace all `SizedBox(height: ...)` with `BoxStyler().height(...)()`.
- Replace `Image.asset('source/assets/onboarding/logoonboarding.png', ...)` with `Assets.source.assets.onboarding.logoonboarding.image(...)`.
- Replace `Image.asset('source/assets/onboarding/Groupslide.png', ...)` with `Assets.source.assets.onboarding.groupslide.image(...)`.
- Wrap text width wrappers (`SizedBox(width: 312)`) in `Box(style: BoxStyler().width(312))`.
- Replace `Icon` widget with `StyledIcon` + `IconStyler`.

### 2. `lib/routes/route_02_onboarding_information.dart`
#### [MODIFY] [route_02_onboarding_information.dart](file:///e:/litscroll/litscroll/lib/routes/route_02_onboarding_information.dart)
- Ensure all FlutterGen typed asset instances (`route02Assets.scroll`, `.compass`, `.heart`, `.book`) are used without direct property overrides where `Styler` applies.

---

## 🧪 Verification Plan

### Automated Verification
- Run `flutter analyze` via `run_command` to ensure zero compilation or linter errors.

### Manual Verification
- Verify code readability, proper Mix token resolution, and build correctness.
