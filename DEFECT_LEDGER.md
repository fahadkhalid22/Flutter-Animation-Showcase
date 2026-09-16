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