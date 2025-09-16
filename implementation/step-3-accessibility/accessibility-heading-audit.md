# Heading Structure Audit (Baseline)

Date: 2025-08-16
Branch: step-3-accessibility

## Objective
Identify multiple <h1> instances, skipped levels, or semantic misuse.

## Findings

### Pages with potential multiple H1s
- about/page.tsx: Uses an H1 for personal introduction inside a hero. (OK if unique per page)
- sanity-test/page.tsx: Multiple conditional H1 variants (loading/error/success). Only one rendered at a time (OK). Consider demoting to <h1> for page title only; internal test states fine.
- product detail page (`my-toys/[slug]/page.tsx`): Single H1 with product name (GOOD).

### Reusable Components
- `SectionHeader` renders <h2> and is visually large. (Keep as <h2>). Ensure order before any <h3>.
- Some cards/sections use <h2> for major subsections (OK) followed by <h3> for sub-features.

### Detected Patterns
- My Toys listing page uses <h2> for a CTA near bottom (OK—page hero likely uses an H1 inside `PageHeroSection`). Need to confirm hero component's heading level.
- FAQ page (not yet audited in detail) appears to use H2 for question sets and H3 for individual points (GOOD if consistent).

### Potential Enhancements (Updated)
1. Ensure `PageHeroSection` outputs a single H1 (DONE 2025-08-16) and subordinate sections start at H2.
2. Verify no decorative text is wrapped in heading tags purely for styling. (PENDING)
3. Add lint rule (eslint-plugin-jsx-a11y) to prevent multiple H1s (FUTURE IMPROVEMENT).

## Action Items
- [x] Inspect `PageHeroSection` implementation for heading level (updated to h1).
- [ ] Confirm FAQ hierarchy (h1 -> h2 -> h3 only).
- [ ] Add documentation note about heading usage strategy.

## Strategy Statement
Each route: exactly one <h1> describing primary purpose. Subsequent top-level sections use <h2>. Nested subsections use <h3>. Avoid skipping levels.

## Next Step
Audit FAQ page headings, then document heading usage guidelines.
