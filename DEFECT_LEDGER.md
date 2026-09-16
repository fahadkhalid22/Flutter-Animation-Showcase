# Defect Ledger

**Project:** Flutter Animation Showcase
**Assignee:** Fahad Khalid

A running ledger of defects found during development, with the status of each
one. This file exists so no known issue is silently carried forward.

## How to update

- Each defect gets a monotonically increasing ID (`DEF-001`, `DEF-002`, …).
- Record the defect, the phase/step where it was found, the fix, and how it
  was verified (analyze / test / diff).
- Once a defect is resolved, mark it `RESOLVED`, but keep the historical row.
  The ledger is append-only except for the status column.

## Open defects

_None._

---

## Resolved defects

### DEF-002 — Horizontal flow diagram pill overflowed on the custom-route screen

- **Phase / step:** Phase 3, Step 6 (custom-route educational content).
- **Summary:** The `FlowDiagram` rendered each step as a pill inside a
  horizontal `Wrap`. On a 400 px phone surface the "SlideTransition +
  FadeTransition" pill (a single wrap child) was wider than the line and
  overflowed by 76 px, failing the "every demo card opens its screen" test.
- **Fix:** Rebuilt `FlowDiagram` as a vertical pipeline — full-width numbered
  pills joined by downward arrows. Long steps wrap naturally instead of
  overflowing, and the layout matches the assignment's conceptual flow
  (`Source Hero ↓ Navigator.push ↓ ...`).
- **Verified:** `flutter analyze` clean; `flutter test` (7 tests, both
  phone-sized surfaces) passes.
- **Status:** RESOLVED (commit `b60aa3c`).

### DEF-001 — Demo screen header row overflowed on narrow surfaces

- **Phase / step:** Phase 1, Step 5 (demo screen shells).
- **Summary:** On a 400 px wide phone surface, the demo screen header
  (`Row` in `DemoScreenShell`) overflowed by ~0.8 px because the category
  badge could not shrink and the title/badge consumed the full width.
- **Fix:** Wrapped the category badge in a `Flexible` and added
  `maxLines: 1` + `TextOverflow.ellipsis` so the badge adapts to any width.
- **Verified:** `flutter analyze` clean; `flutter test` (all 5 routes,
  phone-sized and default surfaces) passes.
- **Status:** RESOLVED (commit `b47800d`).

### DEF-008 — Declared-dead `DemoPlaceholder` carried forward after Phase 1

- **Phase / step:** Phase 5, Step 6 (static code-quality pass).
- **Summary:** `DemoPlaceholder` (Phase-1 demo-stage stand-in) was defined but
  never imported anywhere once every demo became real, so it was dead code
  with a stale "Interactive animation comes in Phase 2" caption.
- **Fix:** Deleted `lib/shared/demo_placeholder.dart` and removed it from the
  README folder tree; replaced the stale README note with
  "All five animation demos are live…".
- **Verified:** `flutter analyze` clean (0 issues); `flutter test` (36 tests)
  passes.
- **Status:** RESOLVED (commit `61f1fdd`).

### DEF-007 — Custom slide+fade route ignored the reduce-motion preference

- **Phase / step:** Phase 5, Step 4 (accessibility pass).
- **Summary:** `buildSlideFadeRoute` always ran its 600 ms slide-and-fade
  transition even when the platform requested reduced motion.
- **Fix:** Parameterised the route with a `duration` (default 600 ms) and the
  custom-route demo passes `Duration.zero` when
  `MediaQuery.disableAnimationsOf` is true.
- **Verified:** a11y regression test asserts the destination screen appears
  within ~24 ms under `FakeAccessibilityFeatures(disableAnimations: true)`.
- **Status:** RESOLVED (commit `d9ac23f`).

### DEF-006 — Chip / index text had low contrast on tinted backgrounds

- **Phase / step:** Phase 5, Step 4 (accessibility pass).
- **Summary:** Category-chip and index-badge text used `AppColors.primary`
  against a semi-transparent tinted chip, giving only ~2.9:1 contrast
  (below the 4.5:1 WCAG AA threshold for small text).
- **Fix:** Added a high-contrast `AppColors.chipLabel` token (~7:1 against
  the effective tinted chip background) and used it for chip labels and
  index badges.
- **Verified:** `flutter analyze` clean; a11y test suite passes.
- **Status:** RESOLVED (commit `d9ac23f`).

### DEF-005 — "Complete" status badge clipped when system fonts scaled up

- **Phase / step:** Phase 5, Step 4 (accessibility pass).
- **Summary:** At 1.3× system text scale the `_CompleteBadge` pill (~197 px
  wide) was wider than the card's 192 px column on a 320 px surface, so the
  label was clipped.
- **Fix:** Wrapped the badge label in a `Flexible` (inside the pill's `Row`
  with `mainAxisSize.min` and `textAlign.center`) so it wraps instead of
  clipping.
- **Verified:** a11y regression test asserts no layout overflow at 1.3× and
  2.0× text scale.
- **Status:** RESOLVED (commit `d9ac23f`).

### DEF-004 — Animation card title row overflowed at 1.3× system text

- **Phase / step:** Phase 5, Step 4 (accessibility pass).
- **Summary:** The card title row (number + category + "Complete" badge) was a
  fixed `Row` inside a ~192 px column and overflowed ~12 px at 1.3× text
  scale on a 320 px surface.
- **Fix:** Replaced the fixed `Row` with a `Wrap` (`spacing: sm,
  runSpacing: xs`) so the number, category and badge reflow onto extra lines.
- **Verified:** a11y regression test asserts no layout overflow at 1.3× and
  2.0× text scale.
- **Status:** RESOLVED (commit `d9ac23f`).

### DEF-003 — Dashboard header badge overflowed at 1.3× system text

- **Phase / step:** Phase 5, Step 4 (accessibility pass).
- **Summary:** The header badge row (icon + "5 Interactive Demos") measured
  ~326 px at 1.3× text scale but only ~294 px was available at 360 px width,
  overflowing the row by 32 px.
- **Fix:** Wrapped the badge text in a `Flexible` so it wraps to a second
  line (with `textAlign.center`) instead of overflowing.
- **Verified:** a11y regression test asserts no layout overflow at 1.3× and
  2.0× text scale.
- **Status:** RESOLVED (commit `d9ac23f`).