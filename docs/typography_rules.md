# UI Typography Rules

This document defines mandatory rules for using typography in UI code.
These rules apply to both human developers and AI agents (Copilot, ChatGPT, etc.).

The goal is to keep typography consistent with Figma, predictable in code,
and stable as the design system evolves.

---

## File Locations (Source of Truth)

### Design Tokens (Figma styles)
Typography styles defined from Figma are implemented in:

- lib/design_system/foundations/ds_typography.dart

This file contains raw design styles:
font families, sizes, weights, line heights, letter spacing, and base colors.

---

### Theme Mapping (Alias / Adapter Layer)
A subset of design styles is mapped to Material roles in:

- lib/design_system/theme/ds_theme_data.dart

This file acts as an adapter layer between the design system and Flutter
(Material TextTheme).

Theme mapping is intentionally partial and covers only common UI roles
(headlines, titles, body, labels).

This file must NOT be used directly in UI code.

---

### UI Usage Entry Points

UI code has two allowed ways to access typography:

1. Preferred — via BuildContext typography aliases:
   - lib/core/extensions/ds_extensions.dart

2. Fallback — directly from design tokens:
   - lib/design_system/foundations/ds_typography.dart
   (only when a style is not mapped in Theme)

---

## Architectural Model

Figma
↓
DSTypography (design tokens, raw styles)
↓
ThemeData.textTheme (aliases / UI roles)
↓
BuildContext aliases (context.<alias>)

DSTypography describes how text looks.
Theme.textTheme describes what role text plays.
context.<alias> is the preferred usage API in UI code.

---

## Usage Rules

Allowed:
- Use typography aliases via BuildContext whenever possible
  Example: Text(title, style: context.h2)
  Example: Text(name, style: context.subtitleM)

- If a required style is not exposed via context aliases
  (because it is not mapped in Theme),
  it may be used directly from DSTypography
  Example: Text(tag, style: DSTypography.subtitleLSemi)

- copyWith is allowed ONLY for:
  - color overrides
  - text decoration (underline, strike-through)

Forbidden:
- Creating ad-hoc TextStyle(...) in UI code
- Modifying typography parameters via copyWith:
  fontSize, fontWeight, lineHeight, letterSpacing, fontFamily
- Accessing Theme.of(context).textTheme directly in screens or features
- Duplicating font sizes, weights, or line heights outside of DSTypography

---

## Design System vs UI Code

Design System code
(buttons, inputs, chips, internal DS widgets):
- May use DSTypography.* directly
- May define additional variants if required by design

Screen / Feature UI code:
- Should prefer context.<alias> as the default
- May use DSTypography.* only if no alias exists
- Must not invent new typography variants

---

## Principles

- There must be one clear default way to apply typography in UI code
- Typography roles are defined by usage, not by font size
- Figma is the source of visual truth
- UI code expresses semantics, not visual guesses

---

## Summary (TL;DR)

DSTypography = design tokens (raw Figma styles)
ThemeData.textTheme = adapter / role mapping
context.<alias> = preferred way to apply text styles
DSTypography.* = allowed fallback if no alias exists
copyWith allowed only for color or decoration
No ad-hoc typography in UI code
