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

_None yet._