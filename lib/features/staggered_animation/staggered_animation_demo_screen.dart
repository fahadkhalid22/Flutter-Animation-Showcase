import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 04 — Staggered Sequence.
///
/// Sequenced animation: four elements are animated with different start
/// intervals on one shared timeline, producing a cascading effect.
class StaggeredAnimationDemoScreen extends StatelessWidget {
  /// Creates the staggered sequence demo screen.
  const StaggeredAnimationDemoScreen({super.key});

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
        demo: DemoPlaceholder(),
        howItWorks: [
          'Create one AnimationController that covers the whole sequence.',
          'Give each of the four items an Interval sliced out of that timeline '
              '(for example 0.0–0.35, 0.25–0.6, 0.5–0.85, 0.7–1.0).',
          'Drive each item with an Animation built from the controller through '
              'a CurvedAnimation and Tween.',
          'Attach the animations to AnimatedBuilder subtrees; running the '
              'controller plays the sequence.',
        ],
        keyClasses: [
          (
            name: 'AnimationController',
            detail: 'A single timeline shared by all staggered children.',
          ),
          (
            name: 'Interval',
            detail:
                'Selects a sub-range of the controller for one child, creating '
                'its start delay.',
          ),
          (
            name: 'CurvedAnimation',
            detail:
                'Applies per-item easing such as easeOutBack inside each '
                'interval.',
          ),
          (
            name: 'AnimatedBuilder',
            detail: 'Rebuilds a subtree whenever one of the animations ticks.',
          ),
        ],
        whenToUse: [
          'List items sliding and fading in one after another on screen load.',
          'Toolbars, menus or card content revealed sequentially.',
          'Multi-step checkouts or onboarding where steps advance in order.',
        ],
      ),
    );
  }
}
