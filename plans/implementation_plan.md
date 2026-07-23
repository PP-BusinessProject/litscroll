# 🚀 Implementation Plan (Skill: IMPLEMENT)

Implementation plan for **LitScroll Onboarding Screen** based on Figma specification, project architecture guidelines, and the `/implement` engineering skill.

---

## 🎯 Overview & Technical Boundaries (Seams)

### 1. Figma Specifications:
- **Logo & App Title:** Logo asset (`Assets.source.assets.logo`) + `LitScroll`.
- **Central Area:** Hero Illustration / Decorative Book Card + `Swipe to explore` badge.
- **Main Headline:** `Discover Literature in Immersive Passages`.
- **Description Body:** `Scroll through beautifully formatted book passages like short-form content. Each passage is 1-2 pages of immersive reading.`
- **Call-To-Action Button (CTA):** `Start Reading` (with `hover`, `press` micro-animations and `go_router` navigation).
- **Footer Text:** `Curated passages from timeless literature`.

---

## 🛠 Implementation Phases

### 🔹 Phase 1: Localization (Slang i18n)
1. Update [source/i18n/en-US.yaml](file:///e:/litscroll/litscroll/source/i18n/en-US.yaml) with `a01_onboarding_welcome` key:
   ```yaml
   onboarding:
     a01_onboarding_welcome:
       app_name: "LitScroll"
       swipe_to_explore: "Swipe to explore"
       title_line1: "Discover Literature in"
       title_line2: "Immersive Passages"
       description: "Scroll through beautifully formatted book passages like short-form content. Each passage is 1-2 pages of immersive reading."
       start_reading: "Start Reading"
       footer: "Curated passages from timeless literature"
   ```

---

### 🔹 Phase 2: Styling (Mix Design System)
1. Add reusable onboarding styles in [lib/styles/glass.dart](file:///e:/litscroll/litscroll/lib/styles/glass.dart):
   * `onboardingBadgeStyle(BuildContext context)` — Badge container styling.
   * `onboardingPrimaryButtonStyle(BuildContext context)` — Primary CTA button with `onHovered` and `onPressed` states.

---

### 🔹 Phase 3: Screen & Layout Implementation
1. Re-implement [lib/routes/route_01_onboarding_welcome.dart](file:///e:/litscroll/litscroll/lib/routes/route_01_onboarding_welcome.dart):
   * Wrap screen in `futuristicBackground(context)` + `SafeArea` + `SingleChildScrollView`.
   * Use `FlexBoxStyler().column().spacing($Spaces.lg())` for vertical alignment.
   * Display logo via `Assets.source.assets.logo.image()`.
   * Place `Swipe to explore` badge, headlines, and description.
   * Configure `PressableBox` for `Start Reading` button with `Routes.onboardingInformation.go(router)`.
   * Add footer note `Curated passages from timeless literature`.

---

### 🔹 Phase 4: Verification & Linting
1. Run linter check: `flutter analyze`.
