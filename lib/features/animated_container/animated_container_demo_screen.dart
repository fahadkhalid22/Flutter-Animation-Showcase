import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'animated_container_demo.dart';

/// Demo 01 — AnimatedContainer.
///
/// Implicit animation: Flutter automatically animates supported visual
/// properties such as colour, size, shape and padding when the widget's
/// configuration changes with state.
class AnimatedContainerDemoScreen extends StatelessWidget {
  /// Creates the AnimatedContainer demo screen.
  const AnimatedContainerDemoScreen({super.key});

  /// Compact conceptual snippet shown under 'How It Works'.
  static const String _codeExample =
      '// Swap the target values; the widget does the rest.\n'
      'setState(() => _expanded = !_expanded);\n'
      '\n'
      'AnimatedContainer(\n'
      '  duration: const Duration(milliseconds: 650), // how long\n'
      '  curve: Curves.easeInOutCubic,                // how it eases\n'
      '  width:   _expanded ? 212.0 : 120.0,\n'
      '  height:  _expanded ? 212.0 : 120.0,\n'
      '  padding: EdgeInsets.all(_expanded ? 28 : 14),\n'
      '  decoration: BoxDecoration(\n'
      '    borderRadius: BorderRadius.circular(_expanded ? 36 : 12),\n'
      '  ),\n'
      ')';

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.animatedContainerTitle,
      category: AppStrings.animatedContainerCategory,
      child: DemoLessonView(
        intro:
            'AnimatedContainer is an implicit animation. When its '
            'configuration changes, Flutter smoothly tweens every animatable '
            'property — no AnimationController required.',
        demo: AnimatedContainerDemo(),
        demonstrates: 'Implicit Animation',
        codeExample: _codeExample,
        howItWorks: [
          'AnimatedContainer automatically interpolates between the old and '
              'new values of every supported property when it is rebuilt with '
              'different values.',
          'setState() is what triggers that rebuild: it swaps the target '
              'values, and the widget compares them against its previous '
              'configuration.',
          'duration sets how long the interpolation takes. Changing values '
              'mid-flight retargets the animation smoothly from its current '
              'position.',
          'curve shapes the pacing of the motion — Curves.easeInOutCubic here '
              '— so it accelerates and settles instead of moving linearly.',
        ],
        flow: [
          'setState swaps the target values',
          'AnimatedContainer compares old vs new configuration',
          'Duration + curve shape the automatic tween',
          'Every animatable property interpolates',
        ],
        keyClasses: [
          (
            name: 'AnimatedContainer',
            detail:
                'A Container that animates changes to size, decoration, '
                'padding, alignment and margin when rebuilt.',
          ),
          (
            name: 'StatefulWidget',
            detail:
                'Holds the mutable state (the expanded flag) that the '
                'animation reacts to.',
          ),
          (
            name: 'setState',
            detail:
                'Marks the state dirty and triggers the rebuild that hands '
                'AnimatedContainer its new target values.',
          ),
          (
            name: 'Duration',
            detail:
                'How long the interpolation between the old and new values '
                'takes.',
          ),
          (
            name: 'Curve',
            detail:
                'Shapes the pacing of the interpolation, for example '
                'Curves.easeInOutCubic.',
          ),
        ],
        whenToUse: [
          'Simple transitions where values change between discrete UI states '
              'and manual frame-level animation control is unnecessary.',
          'State toggles that should feel organic, such as expanding and '
              'collapsing panels, cards or badges.',
          'Colour, padding or alignment changes that need a smooth '
              'interpolation without writing any controller code.',
          'Prototyping, where one widget gives production-quality motion '
              'for free before an explicit animation is wired up.',
        ],
      ),
    );
  }
}
