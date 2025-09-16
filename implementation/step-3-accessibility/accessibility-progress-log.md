# Accessibility Progress Log ♿

**Purpose:** Day-by-day tracking of Step 3 accessibility enhancement tasks.

| Date | Area | Task | Status | Notes |
|------|------|------|--------|-------|
| 2025-08-16 | Landmarks | Add skip link & main landmark | ✅ | Added `.skip-link`, `<main id="main-content">` |
| 2025-08-16 | Focus | Global focus ring audit (baseline) | ⏳ | To capture after initial Lighthouse run |
| 2025-08-16 | Headings | Enforce single h1 via PageHeroSection | ✅ | Replaced SectionHeader (h2) with semantic h1 |
| 2025-08-16 | FAQ | Add ARIA & semantic accordion structure | ✅ | h3 heading + button + region pattern |
| 2025-08-16 | Keyboard | Create initial tab order audit doc | ✅ | Added `keyboard-tab-order-audit.md` with preliminary findings |
| 2025-08-16 | Keyboard | Add focus-visible styles & roles to carousel | ✅ | Carousel buttons ring + dots as tabs with aria-selected |
| 2025-08-16 | Focus Mgmt | Add focus return + semantic button for product image lightbox | ✅ | PhotoSwipe trigger now a <button>; focus restored on close |
| 2025-08-16 | Keyboard | Breadcrumb semantics & focus styles improved | ✅ | Converted to nav>ol>li + focus-visible rings |
| 2025-08-16 | Focus Mgmt | PhotoSwipe dialog semantics & focus trap added | ✅ | role=dialog, aria-modal, manual Tab loop |
| 2025-08-16 | Forms | Create forms & interactive elements audit doc | ✅ | Added `forms-interactive-elements-audit.md` with prioritized backlog |
| 2025-08-16 | Forms | Chat order form labels + error associations + message input label | ✅ | Added ids/htmlFor, aria-invalid/describedby, hidden label, send btn aria-label |
| 2025-08-16 | Forms | Contact form status live region | ✅ | Added aria-live polite role=status container for success/error feedback |
| 2025-08-16 | Forms | Chat messages live region | ✅ | Wrapped messages list in role=log aria-live=polite aria-relevant=additions |
| 2025-08-16 | Forms | Group chat address fields with fieldset/legend | ✅ | Added semantic Delivery Address grouping |
| 2025-08-16 | Keyboard | Verify home + FAQ tab sequences & update audit | ✅ | Confirmed order; flagged nested button-in-link & filter contrast follow-up |
| 2025-08-16 | Semantic | Replace nested button-in-Link for Home "View all" | ✅ | Styled Link with focus-visible ring |
| 2025-08-16 | Contrast | Start color contrast audit skeleton | ✅ | Added `color-contrast-audit.md` with risk inventory & queue |
| 2025-08-16 | Contrast | Estimate initial contrast ratios P1–P4 | ✅ | Logged failures (pastel pink text, focus ring yellow) & proposed darker tokens |
| 2025-08-16 | Contrast | Add P5–P8 contrast estimates | ✅ | Links pass; chat subtext borderline; gradient buttons pass |
| 2025-08-16 | Contrast | Tokenization Pass 1 (introduce color tokens & replace failing pink/yellow) | ✅ | Added CSS vars, swapped heading pink + focus ring usages |
| 2025-08-16 | Contrast | P4 remediation (purple on lavender) | ✅ | Added darker purple text token + updated FAQ filter buttons |
| 2025-08-16 | Contrast | P6 remediation (chat header subtext) | ✅ | Upgraded to gray-700 for sufficient contrast on gradient |
| 2025-08-16 | Theming | Introduce gradient utility classes & refactor chat components | ✅ | Added bg-accent-gradient-* utilities, replaced raw gradient hexes in ChatWidget/Order button |
| 2025-08-16 | Theming | Complete gradient refactor across site pages | ✅ | Replaced remaining page gradients with semantic utilities (contact/about/my-toys/legal) |
| 2025-08-16 | Contrast | Measured actual ratios (script) & updated audit | ✅ | Added table; need darker heading pink + link color policy |
| 2025-08-16 | Contrast | Introduce accessible heading/link token & replace strong pink spans | ✅ | Added `--color-accent-pink-heading`, updated all headings & FAQ link |
| 2025-08-16 | Contrast | Enforce link color policy & lint rule for #ff4692 | ✅ | Added ESLint restriction; replaced remaining semantic text usages with heading token |
| 2025-08-16 | Focus | Standardize focus rings (initial sweep) | ✅ | Replaced #0996cf & ring-pink-500 with var(--color-focus-ring) in ProductCard, hero CTA, product image button, contact form inputs |
| 2025-08-16 | Tooling | Add a11y contrast & scan npm scripts | ✅ | Added `a11y:contrast` & `a11y:scan` running contrast-check with enforcement mode |
| 2025-08-16 | Disabled States | Introduce accessible disabled styling utility | ✅ | Added `.is-disabled` utility + updated buttons (chat send, contact submit, base Button) to avoid low-contrast opacity-50 |
| 2025-08-16 | CI | Add GitHub Action for lint + contrast scan | ✅ | Workflow `a11y-scan.yml` runs type-check, lint, a11y:scan on pushes/PRs |
| 2025-08-16 | Focus | Add focus indicators pattern doc | ✅ | Created `focus-indicators.md` with coverage table & checklist |
| 2025-08-16 | Disabled States | Replace remaining opacity-50 on carousel buttons | ✅ | CarouselButton now uses `disabled:is-disabled`; opacity sweep complete |
| 2025-08-16 | Docs | Add Step 3 completion summary | ✅ | Created `step-3-accessibility-completion-summary.md` summarizing achievements & guardrails |
| 2025-08-16 | Plan | Update action plan checkboxes to reflect completed work | ✅ | Marked forms, focus, contrast, automation tasks as done |

## Detailed Entries

### 2025-08-16
**Change:** Added skip link and wrapped page content in `main#main-content` with `tabIndex={-1}` for programmatic focus after skip.  
**Files:** `src/app/layout.tsx`, `src/app/globals.css`  
**Benefit:** Improves keyboard navigation efficiency; assists screen reader landmark navigation.  
**Next:** Baseline Lighthouse + manual tab order audit.

### 2025-08-16
**Change:** Updated `PageHeroSection` to output `<h1>` instead of custom `SectionHeader` (h2) ensuring one primary page heading per route.  
**Files:** `src/components/hero/PageHeroSection.tsx`  
**Benefit:** Improves document outline, assists screen readers announcing correct primary title.  
**Next:** Audit remaining pages for stray additional h1 elements (none expected) then proceed to tab order mapping.

### 2025-08-16
**Change:** Refactored FAQ accordion for semantic headings and ARIA attributes (h3 > button controlling region).  
**Files:** `src/app/(site)/faq/page.tsx`  
**Benefit:** Screen readers can announce question list with proper expand/collapse state; improved focus styles and region relationships.  
**Next:** Begin keyboard tab order mapping across main pages.

---
*Append additional entries as tasks complete.*
