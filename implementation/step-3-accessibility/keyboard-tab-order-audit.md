# Keyboard Tab Order Audit

Date Started: 2025-08-16
Branch: step-3-accessibility

## Objective
Establish the current keyboard navigation sequence (Tab / Shift+Tab) across primary user flows, identify anomalies (unexpected order, skips, focus loss, hidden focus), and list remediation tasks.

## Scope Pages (Initial Pass)
- Home (`/`)
- My Toys listing (`/my-toys`)
- Product detail (`/my-toys/[slug]`)
- FAQ (`/faq`)
- About (`/about`)
- Contact (`/contact`) – pending review
- Legal pages (`/legal-information`, `/informacja-prawna`) – low priority pass

## Conventions
- Interactive element = naturally focusable semantic element (a, button, input, select, textarea) or element with `tabIndex={0}` (flag if custom).
- Order recorded as encountered by sequential Tab from top after page load (skip link first when present & visible on focus).
- Issues categorized: ORDER, MISSING_FOCUS_STYLE, NON_SEMANTIC, PROGRAMMATIC_FOCUS_NEEDED, TRAP_RISK.

## Findings

### 1. Home Page (`/`)
Sequence (confirmed 2025-08-16):
1. Skip link – OK
2. Logo link (focusable anchor) – OK
3. Primary nav links (in visual order) – OK
4. Hero primary CTA button – OK (receives focus after nav)
5. Secondary hero link (if present) – N/A (none) / otherwise would follow – OK
6. Carousel Previous button → Next button → dot/tab list items (if present on home) – OK focus-visible ring present
7. Product cards: each single focus stop at <a> wrapping card – OK
8. “View all” element currently Link containing a button – needs simplification (nested interactive) → FLAG
9. Footer / ancillary links – OK

Updated Flags:
- [x] ORDER: Nav precedes hero CTA logically.
- [x] MISSING_FOCUS_STYLE: Carousel controls ring added.
- [x] SEMANTIC: Remove nested interactive (button inside Link) for “View all” – replaced with styled Link (2025-08-16).

### 2. My Toys Listing (`/my-toys`)
Sequence (expected): Skip link → Nav → Breadcrumbs (links) → Product grid cards → Footer links.

Flags:
- [x] ORDER: Breadcrumb container – uses semantic <nav><ol><li>; order confirmed.
- [x] MISSING_FOCUS_STYLE: Breadcrumb links now include focus-visible ring.

### 3. Product Detail (`/my-toys/[slug]`)
Key Interactive Elements:
- Skip link → Nav → Breadcrumbs → Lightbox trigger (image) → Chat / Order buttons → Price breakdown interactive? → Related product cards → Back to top.

Flags:
- [x] NON_SEMANTIC: Main product image trigger converted to semantic <button> with aria-label.
- [x] PROGRAMMATIC_FOCUS_NEEDED: Focus restored to trigger after PhotoSwipe close.
- [x] TRAP_RISK: Added manual focus trap & dialog semantics to PhotoSwipe overlay (2025-08-16).

### 4. FAQ (`/faq`)
Sequence (confirmed 2025-08-16): Skip link → Nav → Page hero heading (non-focusable) → Category filter buttons (tab sequence left→right) → Accordion question toggle buttons (top→bottom) → BackToTop.

Findings:
- Filter buttons have visible ring (tailwind focus outline) but low contrast against gradient background – CONTRAST NOTE (defer to contrast phase).
- Accordion buttons: focus-visible style = default ring + slight outline shift; distinguishable from hover – OK.

Updated Flags:
- [x] ORDER: Filters appear before accordion questions.
- [x] MISSING_FOCUS_STYLE: Filters have style (contrast improvement queued).
- [x] VERIFY: Accordion button focus style distinct.

### 5. About (`/about`)
Sequence: Skip link → Nav → Top hero signifier (first interactive maybe none) → Story timeline controls (if clickable) → Links (Contact? etc) → BackToTop.

Flags:
- [ ] NON_SEMANTIC: Any div acting as a button in timeline progression.
- [ ] ORDER: Animated decorative elements should not be focusable.

### 6. Contact (`/contact`)
PENDING – form element labeling to be combined with Forms audit.

## Global / Cross-Cutting Flags
- [ ] Add automated lint rule to detect elements with onClick but missing role / semantics.
- [ ] Centralize focus ring utility (consistent colors & offset).
- [ ] Provide utility to restore focus to trigger after overlay close.

## Remediation Task Backlog (Derived)
- [ ] Refactor ProductCard root to semantic <a> (linking to detail) or <article> with inner <a> if not already.
- [ ] Normalize Carousel controls as <button aria-label="Previous"|"Next">.
- [ ] Implement focus return hook for PhotoSwipe + Chat modal.
- [ ] Ensure BackToTopButton is last in DOM or appropriately placed in order.
- [ ] Add ESLint rule (jsx-a11y/no-noninteractive-element-interactions).

## Next Steps
1. Confirm actual sequences manually (DevTools Elements + Tab walkthrough) and update placeholders (VERIFY/PENDING) to concrete status.
2. Implement highest impact semantic fixes (cards, image triggers) before styling tweaks.
3. Add progress entries to `accessibility-progress-log.md` as each remediation lands.

---
*Update this audit after each page confirmation or remediation.*
