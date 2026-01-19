# FLUTTER PROJECT INSTRUCTIONS

You are an expert Senior Flutter Developer. 
When generating code for this project, you must strictly adhere to the following Design System and Architecture rules.

---

## 0. DOCUMENTATION & ARCHITECTURE
For deep context, domain logic, and specs, start here:
- **Master Doc Index:** `docs/readme.md` (Contains links to Architecture, Domain, Data specs).
- **UI Rules (Critical):** `docs/typography_rules.md` (Read this before generating any UI).

---

## 1. TYPOGRAPHY SYSTEM (CRITICAL)

**Source of Truth:**
- Tokens: `lib/design_system/foundations/ds_typography.dart`
- Aliases: `lib/design_system/ds_extensions.dart`

**✅ ALLOWED Usage:**
ALWAYS use `BuildContext` extensions. Never hardcode styles.

- **Headlines (Noah):** `context.h1`, `context.h2`, `context.h3`
- **Titles (Montserrat Bold):** `context.titleLarge` (14px), `context.titleMedium` (13px), `context.titleSmall` (13px Semi)
- **Body (Montserrat Medium):** `context.bodyLarge`, `context.bodyMedium` (Default), `context.bodySmall`
- **Labels:** `context.labelLarge` (Buttons), `context.labelMedium`

**❌ STRICTLY FORBIDDEN:**
- NEVER use `TextStyle(...)` directly in UI widgets.
- NEVER use `Theme.of(context).textTheme...` (too verbose).
- NEVER modify `fontSize` or `fontWeight` via `.copyWith()`.

**Allowed overrides:**
`style: context.h2?.copyWith(color: DSColors.error)`

---

## 2. COLORS

- **Source of Truth:** `lib/design_system/foundations/ds_colors.dart`
- **Usage:** Use `DSColors.primary`, `DSColors.background`, etc.
- **Forbidden:** `Colors.red`, `Colors.blue`, `Colors.black`.

---

## 3. IMPORTS & STRUCTURE

- Use relative imports for files within the same feature.
- Use package imports for Core and Design System.
- **Extensions:** Always import `package:music_app/design_system/ds_extensions.dart` to access typography shortcuts.

---

## 4. CODE STYLE

- Prefer `StatelessWidget` over `StatefulWidget`.
- Use `const` constructors wherever possible.
- Separate complex UI into smaller, named widgets (private `_WidgetName` is okay).