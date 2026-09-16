# Flutter Animation Showcase

A single cohesive Flutter application for **learning** and **showcasing** five
essential Flutter animation techniques through interactive, educational demos.

| | |
| --- | --- |
| **Assigned To** | Fahad Khalid |
| **Learning Task** | Flutter Foundations and UI Mastery |
| **Topic** | Navigation and Flutter Architecture |
| **Repository** | https://github.com/fahadkhalid22/Flutter-Animation-Showcase |

---

## The Five Required Animations

The app demonstrates and explains five animation techniques:

1. **AnimatedContainer** — _Implicit Animation_
   Automatically animates supported visual properties when state changes.
2. **Hero Animation** — _Shared Element Animation_
   Animates a widget seamlessly between two routes.
3. **Tween Rotation** — _Explicit Animation_
   Controls rotation precisely with `AnimationController` and `Tween`.
4. **Staggered Sequence** — _Sequenced Animation_
   Animates exactly four elements with different intervals on one timeline.
5. **Slide + Fade Route** — _Custom Navigation_
   Creates a custom route transition using `PageRouteBuilder`.

Every demo screen explains **what** the animation is, **how** it works, the
**Flutter APIs/classes** involved, and **why / when** it is useful.

---

## Architecture

A clean, understandable feature-first layout — no over-engineered layers,
because this is an animation-learning application.

```
lib/
├── main.dart                     # Entry point
├── app/
│   ├── app.dart                  # Root MaterialApp
│   └── routes.dart               # Central named-route registry
├── core/
│   ├── constants/                # Design tokens + copy
│   │   ├── app_colors.dart
│   │   ├── app_spacing.dart
│   │   ├── app_radius.dart
│   │   └── app_strings.dart
│   ├── theme/
│   │   └── app_theme.dart        # Dark, motion-inspired ThemeData
│   └── widgets/                  # Reusable educational widgets
│       ├── animation_showcase_card.dart
│       ├── code_example_card.dart
│       ├── showcase_header.dart
│       ├── concept_card.dart
│       └── section_title.dart
├── features/
│   ├── home/                     # Dashboard
│   ├── animated_container/
│   ├── hero_animation/
│   ├── tween_rotation/
│   ├── staggered_animation/
│   └── custom_route/
└── shared/                        # Shared screen layouts and descriptors
    ├── demo_descriptor.dart
    ├── demo_lesson_view.dart
    ├── demo_screen_shell.dart
    ├── motion_orb.dart            # Orbit-themed hero animation object
    └── route_transitions.dart     # Custom slide + fade route builder
```

### Design system

The UI is built on a curated dark palette — deep navy background with a purple
primary, electric-blue secondary and cyan accent — with a single spacing scale
(4–32 px), a shared corner-radius language, subtle gradients and soft card
shadows. Good contrast is maintained throughout for readability.

### Navigation

All screens are reached through named routes registered centrally in
`AppRoutes` (`/`, `/animated-container`, `/hero-animation`,
`/tween-rotation`, `/staggered-animation`, `/custom-route`). The dashboard
grid is responsive: a single column on phones, two columns on larger screens
and tablets.

---

## Project Tracking

- **[PROJECT_COMPLETION_LOG.md](PROJECT_COMPLETION_LOG.md)** — one verified,
  pushed commit per numbered implementation step, with commit SHAs.
- **[DEFECT_LEDGER.md](DEFECT_LEDGER.md)** — every defect found during
  development and its resolution status.

---

## Status

### Phase 1 — Foundation, Architecture, Navigation, Design System: ✅ Complete

- ✅ Flutter project initialized in place at the project root
- ✅ Git repository cloned and pushed to `origin/main`
- ✅ Central architecture + named routes exist
- ✅ Design system (palette, spacing, radius, theme) exists
- ✅ Home dashboard with the five animation cards exists
- ✅ All five demo routes work — Home → Demo → Home, no dead cards
- ✅ Responsive baseline (1-column phones, 2-column tablets)
- ✅ `flutter analyze` passes clean
- ✅ `flutter test` passes
- ✅ README, completion log and defect ledger exist

> All five animation demos are live on the dashboard and reachable via named routes.

### Phase 2 — AnimatedContainer + Explicit AnimationController/Tween: ✅ Complete

- ✅ Interactive implicit `AnimatedContainer` demo — Animate / Reset / Replay,
  animating size, gradient, corner radius, padding and alignment
- ✅ Full educational content for the implicit technique
  (What It Demonstrates / How It Works / Key Classes / When To Use / example)
- ✅ Explicit rotation demo — `AnimationController` + `Tween<double>` driving a
  `Transform.rotate`, with a polished gradient motion dial
- ✅ Interactive controls — Play / Pause / Reverse / Reset + repeat-mode toggle
  and a live Idle / Playing / Paused / Reversing status indicator
- ✅ Explicit-animation explanation — roles, `vsync`, conceptual flow diagram
  and an Implicit-vs-Explicit comparison table
- ✅ Phase 2 test + regression pass: implicit animate/reset/replay, rapid
  repeat taps, rotation play/pause/reverse/reset, leave-while-playing and
  return-and-replay all covered
- ✅ `flutter analyze` passes clean; `flutter test` passes (7 tests)

### Phase 3 — Hero + Custom Slide/Fade Route: ✅ Complete

- ✅ Interactive **Hero** source + destination demo — a shared motion orb that
  flies between routes via matching Hero tags
- ✅ Hero destination screen with arrival badge and a clear back link
- ✅ Full educational content for shared-element animation (what it is, tag
  matching, the flight lifecycle, key classes, when to use, code example,
  conceptual flow)
- ✅ Custom **Slide + Fade** route built with `PageRouteBuilder` — slides in
  from the right with `easeOutCubic` while fading to full opacity
- ✅ Custom destination screen ("Arrived via Slide + Fade") with slide/fade
  preview and replayable launch
- ✅ Full educational content for custom route transitions (8 key classes,
  flow diagram, code example, when to use)
- ✅ Phase 3 tests pass — Hero forward/reverse + tag uniqueness + rapid
  navigation, custom-route mid-flight slide & fade assertions, and a
  regression sweep of all prior demos
- ✅ `flutter analyze` passes clean; `flutter test` passes (11 tests)

### Phase 4 — Staggered Sequence + Animation Comparison: ✅ Complete

- ✅ Interactive **staggered** demo — one shared `AnimationController`, four
  items each on their own `Interval` slice of the 0→1 timeline (0–40%,
  15–55%, 30–70%, 45–85%), entering one after another with a per-item
  motion (rise, slide-left, scale-up, slide-right-with-pop)
- ✅ Live timeline bar showing each item's slice and a moving progress marker
- ✅ Play Sequence / Replay / Reverse / Reset controls
- ✅ Full educational content for sequenced animation — the controller,
  intervals, per-item curves, sequence, flow diagram and "when to use"
- ✅ All five demonstrations integrated onto the dashboard
- ✅ Flutter animation **technique comparison** sheet — implicit vs explicit,
  and a guide screen comparing every animation
- ✅ Reduce-motion support: `disableAnimations` shows the finished cascade
  instantly instead of launching motion unprompted
- ✅ `flutter analyze` passes clean; `flutter test` passes (16 tests)

### Phase 5 — Final QA, Red-Team, Test, Document: ✅ Complete

- ✅ Full red-team QA pass of every demo — lifecycle, interaction, layout,
  accessibility and usability verification; only real defects fixed
- ✅ Responsive layout hardening — no overflow on 360→768 px surfaces and at
  1.3× / 2.0× system text scale
- ✅ Accessibility pass — high-contrast chip/status text, screen-reader button
  semantics on every navigation card, live status regions, and a
  reduced-motion `Duration.zero` custom route transition
- ✅ Declared-dead `DemoPlaceholder` removed — no unused code carried forward
- ✅ Regression coverage added: dashboard renders five demos, every demo's
  initial state, and full round-trip navigation
- ✅ `flutter analyze` clean (0 issues); `flutter test` passes (36 tests);
  `git diff --check` clean on every commit
- ✅ README, completion log and defect ledger finalized and pushed

---

## Concepts Learned

The project exercises a deliberate ladder of Flutter animation techniques:

- **Implicit animation** — `AnimatedContainer` automatically interpolates
  size, gradient, radius, padding and alignment on `setState`; no controller
- **Shared-element transitions** — `Hero` flies a widget between routes by
  matching tags on the source and destination
- **Explicit animation** — an `AnimationController` + `Tween<double>` +
  `CurvedAnimation` drive a `Transform.rotate` with full play / pause /
  reverse / reset control
- **Staggered sequences** — one controller and per-item `Interval` curves
  create a cascade where every element enters at a different moment
- **Custom route transitions** — `PageRouteBuilder` with slide + fade for a
  bespoke navigation animation
- **Architecture** — a feature-first `lib/` layout with central route
  registration, reusable educational widgets, and a shared design system
  (palette, spacing, radius, theme)
- **Accessibility** — responsive layouts that survive system font scaling,
  WCAG-conscious contrast, screen-reader semantics and reduced-motion support
- **Testing** — `flutter_test` widget tests for interactive flows, layout
  overflow, lifecycle safety, reduced motion and navigation round-trips

---

## How to Run

```bash
# From the project root
flutter pub get
flutter run
```

## Testing

```bash
# Every commit is validated with the same strict gate
dart format .       # formatting is canonical
flutter analyze      # 0 issues
flutter test         # 36 tests pass
git diff --check     # no whitespace errors
```

`flutter test` runs seven suites covering every phase: interactive controls,
Hero + custom-route transitions, staggered sequencing, regression guarantees,
lifecycle safety, responsive layouts and accessibility (large text,
reduce-motion, semantics).

## Git Workflow

- One clean, verified commit per numbered implementation step: format →
  analyze → test → `git diff --check` → commit → push → record SHA
- Message convention: a scoped prefix (`feat:` / `fix:` / `docs:` / `test:` /
  `chore:`) followed by a short imperative summary
- Every commit includes a `Co-Authored-By: Claude Code` trailer, and every SHA
  is logged in [PROJECT_COMPLETION_LOG.md](PROJECT_COMPLETION_LOG.md)

---

## Author

- **Fahad Khalid** — Flutter Foundations and UI Mastery
- GitHub: [https://github.com/fahadkhalid22](https://github.com/fahadkhalid22)
- Repository: [Flutter-Animation-Showcase](https://github.com/fahadkhalid22/Flutter-Animation-Showcase)