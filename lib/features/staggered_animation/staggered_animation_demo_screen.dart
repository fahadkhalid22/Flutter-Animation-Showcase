import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'staggered_animation_demo.dart';

/// Demo 04 — Staggered Sequence.
///
/// Sequenced animation: four elements are animated with different start
/// intervals on one shared timeline, producing a cascading effect.
class StaggeredAnimationDemoScreen extends StatelessWidget {
  /// Creates the staggered sequence demo screen.
  const StaggeredAnimationDemoScreen({super.key});

  /// Compact conceptual code: a shared controller, four interval slices,
  /// each driving one item through a CurvedAnimation.
  static const String _codeExample = '''
/// One timeline, four slices (0% — 100%):
///
/// 0%                                   100%
///  Item 1 ████████████
///  Item 2     ████████████
///  Item 3          ████████████
///  Item 4               ████████████

_controller = AnimationController(
  vsync: this,
  duration: const Duration(milliseconds: 2600),
);

// Item 1 starts immediately; Item 4 waits until 45%.
final item1 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Interval(0.00, 0.40, curve: Curves.easeOutCubic),
  ),
);
final item4 = Tween<double>(begin: 0, end: 1).animate(
  CurvedAnimation(
    parent: _controller,
    curve: Interval(0.45, 0.85, curve: Curves.easeOutBack),
  ),
);

_controller.forward(); // the whole cascade plays off one clock
''';

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.staggeredAnimationTitle,
      category: AppStrings.staggeredAnimationCategory,
      child: DemoLessonView(
        intro:
            'A staggered animation shares one controller across several '
            'widgets, each starting on its own Interval. The result is the '
            'four items moving in sequence on a single timeline.',
        demo: StaggeredAnimationDemo(),
        demonstrates: 'Staggered Sequence',
        codeExample: _codeExample,
        howItWorks: [
          'A staggered animation uses ONE shared AnimationController while '
              'different animations occupy different time intervals.',
          'Each item gets its own Interval sliced out of the shared 0→1 '
              'timeline (here 0.00–0.40, 0.15–0.55, 0.30–0.70, 0.45–0.85).',
          'An Interval not only delays an item — it confines that item '
              'to its slice, so it finishes while later items are still '
              'entering.',
          'Each item is built from the controller through a CurvedAnimation '
              'and a Tween, then attached to a Fade / Slide / Scale '
              'transition.',
          'Running the controller once plays the whole cascade in order; '
              'Replay, Reverse and Reset reuse the very same clock.',
        ],
        flow: [
          'AnimationController',
          'Four Intervals (0.00–0.40, 0.15–0.55, 0.30–0.70, 0.45–0.85)',
          'CurvedAnimation × 4',
          'Tween × 4',
          'Fade + Slide + Scale on items 1–4',
          'Cascade',
        ],
        keyClasses: [
          (
            name: 'AnimationController',
            detail:
                'The single shared timeline whose progress (0→1) drives '
                'every item. Owns the duration and plays / reverses / '
                'resets the whole sequence.',
          ),
          (
            name: 'Interval',
            detail:
                'Selects a sub-range of the controller for one item, giving '
                'it a start point and an end point on the shared timeline.',
          ),
          (
            name: 'CurvedAnimation',
            detail:
                'Applies per-item easing inside its interval, e.g. '
                'easeOutCubic for most items and easeOutBack for a pop.',
          ),
          (
            name: 'Tween',
            detail:
                'Maps interval progress onto a value range — here 0→1, but '
                'the same idea maps to offsets, scales or colors.',
          ),
          (
            name: 'FadeTransition',
            detail:
                'Animates opacity: each item fades in as its interval '
                'starts.',
          ),
          (
            name: 'SlideTransition',
            detail:
                'Animates position by an Offset, giving each item its own '
                'slide direction on entry.',
          ),
          (
            name: 'ScaleTransition',
            detail:
                'Animates scale, so items can grow (or pop) into their '
                'final size.',
          ),
        ],
        whenToUse: [
          'Onboarding and feature tours, where screens reveal one step at a '
              'time.',
          'Dashboard entrance, letting cards appear in a deliberate, calm '
              'order.',
          'Lists and feeds, where rows slide in one after another as they '
              'load.',
          'Feature reveals and announcements that direct attention '
              'sequentially.',
          'Sequential storytelling — content that should be read, and '
              'therefore animated, in a fixed order.',
        ],
      ),
    );
  }
}
