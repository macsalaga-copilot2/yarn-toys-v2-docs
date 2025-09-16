# Focus Indicators Standard

Date: 2025-08-16
Scope: Step 3 Accessibility

## Purpose
Provide a consistent, WCAG-compliant visible focus style across all interactive elements (links, buttons, inputs, custom widgets) to support keyboard and assistive tech users.

## WCAG Reference
- 2.4.7 Focus Visible (AA)
- 1.4.11 Non-text Contrast (focus indicators ≥3:1 against adjacent colors)

## Design Token
- `--color-focus-ring`: currently `var(--color-accent-purple-mid)` (#854aa6) with ≥5.9:1 on white.

## Standard Styles
1. Global fallback: `*:focus-visible { outline: 2px solid var(--color-focus-ring); outline-offset: 2px; }`
2. Component-specific (Tailwind): `focus-visible:ring-2 focus-visible:ring-[var(--color-focus-ring)] focus-visible:ring-offset-2` for elements needing ring layering.
3. Utility: `.focus-ring-accent` (applies outline) — use where Tailwind ring utilities are not available or for non-Tailwind elements.

## DO
- Ensure every interactive element reachable by keyboard shows the purple ring.
- Include `min-h-[44px]` on touch targets (consistency with Step 2 mobile optimizations).
- Maintain sufficient spacing so the 2px outline is not clipped.

## DO NOT
- Reintroduce hard-coded focus colors (e.g., #0996cf, #ffcb41).
- Remove focus outline without a replacement of equal or better visibility.

## Implementation Coverage (Current)
| Category | Components / Files | Status |
|----------|--------------------|--------|
| Navigation | `MainNav` links, mobile menu trigger | Unified via ring classes |
| Cards / Product | `ProductCard` link wrapper | Uses ring token |
| Carousel | Nav buttons & dots | Token-based ring |
| Forms (Contact) | Inputs, select, textarea | Ring token applied |
| Chat Widget | Input field + order form fields | Ring token applied |
| Breadcrumbs | Previous/next controls + links | Ring token applied |
| Skip Link | Custom outline + token accent | Updated |
| Buttons (Generic) | `components/ui/button.tsx` | Uses token (forward ref) |
| Image Viewer Trigger | Product image button | Ring token applied |
| Remaining Audit | Dialog close buttons, any legacy components | Pending quick sweep |

## Regression Prevention
- ESLint disallows deprecated hex codes.
- CI job (`a11y-scan.yml`) runs contrast + lint.
- Future: optional unit test to mount critical interactive components and snapshot classNames for ring utilities.

## Future Enhancements (Optional)
- Add high-contrast theme mapping `--color-focus-ring` to system accent in dark mode.
- Provide `.focus-ring-inset` variant for tight layouts.

---
Maintainer Checklist for New Components:
1. Does it receive keyboard focus naturally (button/link/input) or via `tabIndex` if custom?  
2. Does it show the standard ring at first focus?  
3. If suppressed (e.g., `focus:outline-none`), are ring utilities or `.focus-ring-accent` added back?  
4. Any visually hidden focusable elements? Provide visible focus style when revealed.  
