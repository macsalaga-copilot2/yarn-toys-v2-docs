# Step 3 Accessibility Enhancements – Action Plan ♿

Moved from `docs/planning/` to dedicated implementation folder for consistency with Step 2 structure.

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
- [ ] Remove redundant `role` attributes when native semantics suffice. (TO DO)
- [ ] Audit all decorative images → `aria-hidden="true"` or empty alt. (TO DO)
- [ ] Ensure product images have descriptive `alt` (name + key attribute if relevant). (TO DO)

### 2.2 Forms & Interactive Elements
- [x] Associate every input with `<label for>` or `aria-label` (contact form + chat order form verified).
- [x] Replace `div` click handlers with semantic `<button>` / `<a>` (carousel, mobile menu trigger, image viewer trigger use buttons/links).
- [x] Icon-only buttons: supply `aria-label` (menu open/close, send message, image close, carousel navigation).
- [x] Ensure disabled states communicate via `disabled` attribute (not just styling) – replaced opacity pattern with `.is-disabled` + native `disabled`.
	- [x] Initial audit document created (`forms-interactive-elements-audit.md`) 2025-08-16.

### 2.3 Keyboard Navigation
- [x] End‑to‑end tab order audit (initial document) – verification follow-up pending.
- [x] Ensure `focus-visible` styles (outline or ring) present & high contrast (token + global rule + doc).
- [x] Add `Esc` handling for: mobile menu (implemented), lightbox (PhotoSwipe built-in). (Chat widget: TO VERIFY)
- [ ] Provide shortcut: `/` focuses search (if search added later – defer).

### 2.4 Focus Management
- [x] Trap focus: PhotoSwipe internal, mobile menu via shadcn `Sheet` (verified); chat widget pending verification.
- [ ] Restore focus to triggering control after modal/menu close (TO DO for menu/chat where applicable).
- [x] Prevent background scroll while overlays are active (mobile menu sets body overflow hidden).

### 2.5 Color & Contrast
- [x] Run automated contrast scan (script + CI).
- [x] Adjust Tailwind classes where ratio fails (purple text, heading tokens, focus ring, chat subtext).
- [x] Verify focus ring contrast (≥ 3:1) – measured 5.95:1.

### 2.6 Screen Reader Testing
- [ ] NVDA (Windows) or Orca (Linux) test script.
- [ ] VoiceOver (Mac) navigation pass.
- [ ] Validate announcement order: Page title → Breadcrumbs → Product heading → Price → Description → Image.
- [ ] Ensure no duplicated announcements.

### 2.7 Automation & Regression Prevention
- [x] Add `a11y:scan` script for contrast + forbidden color enforcement.
- [x] GitHub Action `a11y-scan.yml` for CI gating (lint + scan).
- [ ] Add Lighthouse / axe automated audit script (stretch).

---

## 3. Implementation Order (Lean Sequence)
1. Landmarks & skip link
2. Heading structure normalization
3. Replace non-semantic interactive elements
4. Focus styles & keyboard traversal audit
5. Modal / menu focus trap & restoration
6. Contrast adjustments
7. Screen reader verification & alt text refinements
8. (Stretch) Automated audit script

---

## 4. Risks & Mitigations
| Risk | Impact | Mitigation |
|------|--------|------------|
| Over-application of ARIA | Confusion | Use native semantics first |
| Hidden focus styles via CSS resets | Keyboard lockout | Enforce global `:focus-visible` ring |
| Visual regressions after contrast changes | UI inconsistency | Incremental PRs with before/after screenshots |
| Modal focus leakage | Accessibility failure | Centralized focus trap utility |

---

## 5. Acceptance Checklist
- [ ] Skip link appears on first Tab and works.
- [ ] Only one `<h1>` per page.
- [ ] All buttons reachable & have visible focus.
- [ ] No keyboard traps; Shift+Tab works symmetrically.
- [ ] Screen reader announces logical structure.
- [ ] All actionable icons have accessible names.
- [ ] Color contrast passes WCAG 2.1 AA.
- [ ] Focus returns to trigger after closing overlays.
- [ ] Lighthouse Accessibility ≥ 95 (document score screenshot).

---

## 6. Documentation Outputs
- Update `project-progress-tracker.md` with Step 3 start.
- Add audit findings section (appendix) once baseline audit complete.
- Store contrast adjustment mapping (component → change) for traceability.

---

## 7. Post-Step Follow Up (Prep for SEO Step 5)
- Ensure heading structure supports semantic SEO.
- Confirm image alt texts ready for potential structured data integration.
- Foundation in place for metadata & schema rollout.

---

**Status:** IN PROGRESS (Core semantics started; heading + landmarks done)

**Next Action:** Keyboard tab order audit.

---

*Prepared: August 16, 2025 (relocated to implementation folder)*
