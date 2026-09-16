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
    ├── demo_placeholder.dart
    └── demo_screen_shell.dart
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

> The interactive animation areas on each demo screen are currently
> professional placeholders (`DemoPlaceholder`). The five full animations are
> implemented in a later phase and will replace these stages.

### Phase 2+ — Pending

Not started. Later phases implement the five interactive animations and the
final requirements. This document does not claim those are complete.

---

## Getting Started

```bash
# From the project root
flutter pub get
flutter run

# Validation (used for every commit)
dart format .
flutter analyze
flutter test
```