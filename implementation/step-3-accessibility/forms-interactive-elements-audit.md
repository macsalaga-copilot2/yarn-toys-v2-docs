# Forms & Interactive Elements Audit

Date Started: 2025-08-16
Branch: step-3-accessibility

## Objective
Ensure all form controls and interactive elements are properly labeled, semantic, reachable by keyboard, have visible focus, and convey state (required, error, disabled) accessibly.

## Pages / Components in Scope
- Contact Page Form (`/contact`)
- Chat Widget Inline Inputs & Order Form
- Product Detail Action Buttons (Start Chat Order, Email Instead)
- Global Navigation (mobile toggle button accessibility pending separate review)

## Conventions / Criteria
| Criterion | Requirement |
|-----------|-------------|
| Labeling | Each input associated with `<label for>` or explicit `aria-label` / `aria-labelledby` |
| Required Fields | Indicate with visual * and programmatically via `required` attribute |
| Error Messaging | Error text adjacent, announced (uses text update – later enhancement: `aria-live`) |
| Focus Visibility | Clear ring/outline on keyboard focus-visible |
| Semantic Elements | Use `<button>` / `<a>` instead of `div` with onClick |
| Icon-only Controls | Must have accessible name (`aria-label` or hidden text) |
| Disabled State | Use `disabled` attribute not only styling |

## Initial Findings

### Contact Form
- Inputs: name, email, subject (select), message – all have `<label>` + `id` → OK.
- Required: Using `required` attribute → OK.
- Submit button: Semantic `<button type="submit">` → OK.
- Improvement: Add `aria-live="polite"` region for success/error status messages so screen readers announce them automatically.
- Improvement: Add `aria-required="true"` is optional (HTML5 required sufficient). Not needed now.

### Chat Widget Order Form
- Multiple `<label>` blocks present visually with emoji prefix; each followed by an unlabeled `<input>` (no `id` / `htmlFor` pair) – Needs improvement.
- Error messages displayed via `<p className="text-red-500 text-xs">` after input – OK visually; need `aria-describedby` linking when error present for screen reader context.
- Phone, postal code, etc – require matching `id` and `htmlFor` to preserve accessible labeling beyond proximity.
- Send message input at bottom has no `<label>`; relies on placeholder – add `aria-label="Message"` or visually hidden label.

### Product Detail Action Buttons
- Start Chat Order: Semantic button with text + emoji – OK accessible name.
- Email Instead: Anchor link with text – OK.
- Sold Out state uses `<div>` styled as button (non-interactive) – acceptable since disabled; ensure not focusable (currently not focusable) – OK.

### Navigation / Misc
- Breadcrumb links updated with focus ring – OK.
- Carousel controls updated – OK.
- Mobile nav toggle (not audited here) – add to future pass if not already labeled.

## Remediation Tasks
- [x] Chat Order Form: Add `id` to each input and corresponding `htmlFor` on labels. (2025-08-16)
- [x] Chat Order Form: When error present, add `aria-describedby` referencing error message element `id`. (2025-08-16)
- [x] Chat Input (message composer): Add visually hidden `<label>` (e.g., class="sr-only") or `aria-label="Message"`. (2025-08-16 – used hidden label)
- [x] Chat Order Form: Wrap grouped inputs in `<fieldset>` with descriptive `<legend>` (Delivery Address). (2025-08-16)
- [x] Status Messages (contact form): Add `role="status"` + `aria-live="polite"` to success/error container. (2025-08-16)
- [x] Consider `aria-live="polite"` on chat messages list for new bot messages (implemented via role="log" aria-live="polite"). (2025-08-16)

## Prioritization (P1 High → P3 Low)
| Task | Priority |
|------|----------|
| Add label associations & ids to Chat order form inputs | P1 |
| Add accessible label to chat message input | P1 |
| Add aria-live to contact form status messages | P2 |
| Add aria-describedby to error messages (chat form) | P2 |
| Fieldset/legend grouping (address block) | P3 |
| Live region for new chat messages | P3 |

## Progress Log Links
- See `accessibility-progress-log.md` for timestamped entries as fixes land.

## Next Steps
1. Implement P1 tasks (chat order form ids/labels + chat composer label).
2. Add aria-live to contact form status messages.
3. Wire aria-describedby for chat errors.
4. Re-audit for any remaining unlabeled controls.

---
*Update after each remediation.*
