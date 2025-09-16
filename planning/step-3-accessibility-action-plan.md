# Step 3 Accessibility Enhancements – Action Plan ♿

**Objective:** Achieve a highly accessible user experience meeting WCAG 2.1 AA fundamentals, improve Lighthouse Accessibility score (>95), and establish sustainable accessibility practices.

**Scope Version:** v1.5 → v1.6 transition (Pre-production hardening)

---

## 1. Goals & Success Metrics

| Area | Goal | Metric | Target |
|------|------|--------|--------|
| Lighthouse | Automated audit quality | Accessibility score | ≥ 95 |
| Keyboard Use | Operability | Tabbing order, no traps | 0 issues |
| Screen Reader | Semantic clarity | NVDA/VoiceOver test checklist | 100% pass |
| Focus Visibility | Perceivable focus | Contrast & visibility | All interactive elements |
| Color Contrast | Readability | WCAG contrast ratio | Normal text ≥4.5:1, large ≥3:1 |

---

## 2. Work Breakdown

### 2.1 ARIA & Semantics
- [x] Landmark layout: `header`, `nav`, `main id="main-content"`, `footer`.
- [x] Add skip link: `<a href="#main-content" class="skip-link">Skip to content</a>`.
- [x] Single `<h1>` per page; normalize heading hierarchy.
- [ ] Remove redundant `role` attributes when native semantics suffice.
- [ ] Audit all decorative images → `aria-hidden="true"` or empty alt.
- [ ] Ensure product images have descriptive `alt` (name + key attribute if relevant).

### 2.2 Forms & Interactive Elements
- [ ] Associate every input with `<label for>` or `aria-label`.
- [ ] Replace `div` click handlers with semantic `<button>` / `<a>`.
- [ ] Icon-only buttons: supply `aria-label` (e.g. “Open menu”, “Close chat”).
- [ ] Ensure disabled states communicate via `disabled` attribute (not just styling).

## File Relocated

The Step 3 Accessibility Action Plan has been moved to:

`../implementation/step-3-accessibility/step-3-accessibility-action-plan.md`

Reason: Align action plan documents with their corresponding implementation folders (mirrors Step 2 structure) and keep `/planning/` focused on cross-step or multi-phase strategy.

## Quick Links
- [Implementation Plan](../implementation/step-3-accessibility/step-3-accessibility-action-plan.md)
- [Progress Log](../implementation/step-3-accessibility/accessibility-progress-log.md)
- [Heading Audit](../implementation/step-3-accessibility/accessibility-heading-audit.md)

*This file intentionally reduced to a pointer to avoid divergence.*
- [ ] Verify focus ring contrast (≥ 3:1 against adjacent colors).
