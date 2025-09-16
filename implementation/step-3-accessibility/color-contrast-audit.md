# Color Contrast Audit

Date Started: 2025-08-16
Branch: step-3-accessibility

## Objective
Identify foreground/background color pairs that fail or are at risk of failing WCAG 2.1 AA contrast requirements (4.5:1 normal text, 3:1 large text UI components & focus indicators), and produce minimal token adjustments.

## Method
1. Inventory hard-coded hex values and key Tailwind utility colors used with light backgrounds.
2. Manually sample representative components per color.
3. Use a contrast checker (WebAIM or axe DevTools) for each pair.
4. Log results, propose adjustments (darken text, adjust ring, add solid bg behind gradient text, etc.).

## Key Color Tokens / Hexes Found (grep pass)
- Accent Pink Light: `#fab3de`
- Accent Purple Light: `#e5dbf5`
- Accent Pink Strong: `#ff4692`
- Accent Purple Mid: `#854aa6`
- Accent Highlight Yellow: `#ffcb41`
- Neutral Text Dark: `#1f2937` (Tailwind gray-800)
- Neutral Text Mid: `text-gray-700` / `text-gray-600`
- Neutral Borders: `#cdbaeb` / `#e5dbf5` / `border-gray-300`

## Risk Zones
| Area | Foreground | Background | Risk | Notes |
|------|------------|------------|------|-------|
| Gradient buttons (pink→lavender) text | `text-gray-800` | gradient `#fab3de`→`#e5dbf5` | Medium | Likely ≥4.5 but verify both ends (contrast may dip on light edge) |
| Light purple text on white (`#854aa6`) | `#854aa6` | `#ffffff` | Low | Usually passes (estimate >5:1) verify |
| Light pink text (`#fab3de`) on white | `#fab3de` | `#ffffff` | High | Pastel likely <3:1 for normal text; currently used in ALL CAPS headings (large) – ensure large text ≥3:1 or switch to stronger shade |
| Focus ring yellow | `#ffcb41` ring vs white/bg | Medium | Need 3:1 against adjacent color for component focus indicator clarity |
| Filter buttons inactive (purple text on `#e5dbf5`) | `#854aa6` | `#e5dbf5` | Medium | Estimate maybe near 3:1 threshold; verify |
| Accordion icon purple | `#854aa6` | white | Low | Likely OK |
| Chat header text | `text-gray-800` | gradient `#fab3de`→`#e5dbf5` | Medium | Test darkest + lightest stops |
| Pink link (`#ff4692`) normal on white | `#ff4692` | white | Low | Should pass; verify exact ratio |
| Disabled opacity states | text with `opacity-50` | assorted backgrounds | High | Could drop below 3:1; ensure essential text not solely via low contrast |

## Initial Measurement Queue
| Pair ID | Foreground | Background | Context / Selector | Large Text? | Required Ratio | Measured | Status | Action |
|---------|------------|------------|--------------------|-------------|----------------|----------|--------|--------|
| P1 | #fab3de | #ffffff | Hero heading segment “CREATIONS” | Yes (≥24px) | 3:1 | ~2.6:1 (est) | FAIL (Large) | Darken text token for pastel segment (e.g., #f08ac9 ≈3.2:1) |
| P2 | #fab3de | #ffffff | Smaller inline accent uses (if any) | No | 4.5:1 | ~2.6:1 (est) | FAIL | Do not use pastel for normal text; swap to #ff4692 or #854aa6 |
| P3 | #ffcb41 | White | Focus ring around carousel dots | N/A (UI outline) | 3:1 | ~2.1:1 (est) | FAIL | Change ring to #854aa6 (≈6.4:1) or #ff4692 (≈4.9:1) |
| P4 | #854aa6 | #e5dbf5 | FAQ inactive filter button text | No | 4.5:1 | ~4.0:1 (est) | BORDERLINE | Either darken text (#733b95 ≈4.7:1) or darken bg (#d7c9ef) |
| P4.1 | #733b95 | #e5dbf5 | Updated FAQ inactive filter button text (tokenized) | No | 4.5:1 | ~4.7:1 (est) | PASS (after token) | Implemented via `--color-accent-purple-text` |
| P5 | #ff4692 | White | Link text default | No | 4.5:1 | ~4.9:1 (est) | PASS | No change needed (ensure visited state keeps ≥4.5:1) |
| P6 | Gray-600 (#4b5563) | Gradient avg (~#f0c9e7) | Chat header subtext | No | 4.5:1 | ~4.1:1 (est) | BORDERLINE | Bump to gray-700 (#374151) for ≥5.5:1 |
| P6.1 | Gray-700 (#374151) | Gradient avg (~#f0c9e7) | Updated chat header subtext | No | 4.5:1 | ~5.5:1 (est) | PASS (after change) | Switched class to text-gray-700 |
| P7 | Gray-800 (#1f2937) | #fab3de | Gradient button extreme left | No | 4.5:1 | ~5.2:1 (est) | PASS | None |
| P8 | Gray-800 (#1f2937) | #e5dbf5 | Gradient button extreme right | No | 4.5:1 | ~6.0:1 (est) | PASS | None |

## Measured Contrast (Script Output 2025-08-16)
| Pair | Foreground | Background | Ratio | Status |
|------|------------|------------|-------|--------|
| P1.1 | #f08ac9 | #ffffff | 2.29:1 | FAIL (Large) |
| P1.2 | #d02690 | #ffffff | 4.81:1 | PASS |
| P2 | #fab3de | #ffffff | 1.67:1 | FAIL |
| P3 | #854aa6 | #ffffff | 5.95:1 | PASS (UI Ring) |
| P4.1 | #733b95 | #e5dbf5 | 5.66:1 | PASS |
| P5 | #ff4692 | #ffffff | 3.21:1 | PASS (Large only) |
| P6.1 | #374151 | #f0c9e7 | 6.98:1 | PASS |
| P7 | #1f2937 | #fab3de | 8.78:1 | PASS |
| P8 | #1f2937 | #e5dbf5 | 11.03:1 | PASS |

### Interpretation & Required Adjustments
- P1.1 REMEDIATED: Introduced `--color-accent-pink-heading: #d02690` (4.81:1 on white) replacing prior pastel/darkened variants in all heading segments and large accent spans.
- P2 remains legacy pastel (`--color-accent-pink-raw`) strictly decorative (gradients, backgrounds). Linted against direct text use (normal or large) except where explicitly styled as non-text decoration.
- P5 POLICY: `#ff4692` (magenta strong) measured 3.21:1 and is now restricted to decorative large gradient participation only; not used for standalone body or inline links. Default accessible link color now `var(--color-accent-pink-heading)` (≥4.5) with hover shift to purple mid for clear affordance.
- All remaining measured pairs pass; focus ring standardized at ≈5.95:1 ensuring visible keyboard focus.
- Added P1.2 confirming new accessible heading/link token passes (4.81:1). P1.1 retained historically to show remediation delta.

## Proposed Adjustment Strategy (Updated)
1. (Done) Measure baseline & identify failures.
2. (Done) Replace failing focus ring + borderline purple on lavender + chat subtext.
3. (Done) Introduce accessible heading/link token `--color-accent-pink-heading`.
4. (Next) Refactor any remaining inline `#ff4692` used for semantic text to tokens (in progress; majority replaced) and add lint rule if necessary.
5. (Next) Add automated script test to assert no forbidden hexes appear in JSX except within gradients.

### Implementation Log (Tokenization Pass 1 & 2)
- Added CSS variables in `globals.css` for legacy raw colors and new accessible tokens:
	- `--color-accent-pink-raw` (gradients only) and derived `--color-accent-pink-text` (deprecated for headings after second pass).
	- `--color-focus-ring` unified to accessible purple (`#854aa6`).
	- `--color-accent-magenta-strong` retained for potential large decorative use (NOT for normal text links).
	- `--color-accent-pink-heading` introduced as accessible 4.5+ ratio token for headings & inline links.
	- `--color-accent-link` alias currently pointing to heading token (future theming hook).
- Replaced hard-coded `#fab3de` heading text with `var(--color-accent-pink-text)` across hero/about/my-toys pages (large text only) then upgraded all such usages to `var(--color-accent-pink-heading)` after measurement showed need for ≥4.5:1.
- Replaced carousel yellow focus ring & dot active color with tokens (`--color-focus-ring` and purple mid background) removing failing yellow.
- Updated carousel navigation button hover & focus ring colors to use accessible tokens instead of failing yellow.
- Added darker purple text token `--color-accent-purple-text` and applied to FAQ inactive filter buttons (P4 remediation: borderline → pass).
- Introduced semantic gradient utility classes (`bg-accent-gradient-tr/br/r`) and refactored across chat + all major pages (contact/about/my-toys/legal).
- Pass 2: Replaced remaining strong pink heading spans (`#ff4692`) with accessible heading token; updated FAQ inline link to accessible token + focus styles.

## Next Steps (Forward Plan)
1. (Done) Add lint rule forbidding `#ff4692` in semantic text (retained only for decorative gradient contexts).
2. (Done) Add P1.2 measurement row confirming accessible heading/link token ratio.
3. (Done) Implement script `--scan` mode + npm scripts (`a11y:contrast`, `a11y:scan`) for CI enforcement of forbidden hex usage (ignoring token definition lines).
4. (In Progress -> Mostly Done) Standardize focus indicators: replaced ad hoc `#0996cf` / `ring-pink-500` with `var(--color-focus-ring)` in ProductCard, navigation CTA, product image trigger, and contact form controls. Remaining audit: sweep any other components (dialogs, secondary buttons) for stray focus ring classes.
5. (Planned) Extend focus ring utility: consider adding a `.focus-ring-accent` class usage across codebase to reduce duplication of `focus-visible:ring-[var(--color-focus-ring)]` where Tailwind arbitrary values are used.
6. (Planned) Disabled / opacity state audit: catalog all `opacity-50` (or similar) uses on interactive controls; ensure alternative affordances (cursor, aria-disabled, outline, pattern fill) while maintaining ≥3:1 text contrast.
7. (Planned) Add CI step (GitHub Action or local pre-push hook) invoking `npm run a11y:scan` and `npm run lint` to block regressions.
8. (Planned) Document disabled state policy & focus indicator coverage summary (new section in this audit or separate `focus-indicators.md`).

### Disabled / Opacity State Preliminary Audit (Baseline Extract)
Instances of `disabled:opacity-50` identified in: ChatWidget action buttons, primary contact form submit button, generic `button` component, carousel navigation, and gradient action buttons. Risk: text contrast may fall below 3:1 if base color contrast is marginal. Next pass will:
1. Replace blanket opacity reduction with combination of: maintaining text color, reducing saturation/background lightness minimally, adding `aria-disabled` where appropriate.
2. Ensure disabled state still achieves ≥3:1 (non-essential decorative icons may fall below if accompanied by accessible text).
3. Add utility `.is-disabled` pattern (pointer-events-none, reduced box-shadow, grayscale filter) avoiding heavy opacity cuts.
4. Update progress log upon remediation and include measurement samples if any borderline pairs emerge.

---
*Update as measurements are captured.*
