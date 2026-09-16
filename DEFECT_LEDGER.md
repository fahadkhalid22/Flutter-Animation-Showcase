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