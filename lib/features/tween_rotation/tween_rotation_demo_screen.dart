import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'tween_rotation_demo.dart';

/// Demo 03 — Tween Rotation.
///
/// Explicit animation: an `AnimationController` plus a `Tween<double>`
/// drive a `RotationTransition` for precise, controllable rotation.
class TweenRotationDemoScreen extends StatelessWidget {
  /// Creates the Tween rotation demo screen.
  const TweenRotationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.tweenRotationTitle,
      category: AppStrings.tweenRotationCategory,
      child: DemoLessonView(
        intro:
            'Explicit animation: you drive the timeline yourself. An '
            'AnimationController plus a Tween give precise control over '
            'rotation, timing and repetition.',
        demo: TweenRotationDemo(),
        howItWorks: [
          'Create an AnimationController with vsync (from '
              'SingleTickerProviderStateMixin) as the tick source.',
          'Build a Tween<double> that maps controller progress (0→1) to your '
              'angle range, for example 0 to 2π.',
          'Call controller.repeat() with a duration; a CurvedAnimation adds '
              'easing to each cycle.',
          'Wrap the child in a RotationTransition that reads the animation '
              'and applies the rotation every frame.',
        ],
        keyClasses: [
          (
            name: 'AnimationController',
            detail:
                'Simplest tick-driven animation; advances a value between '
                'lowerBound and upperBound over a Duration.',
          ),
          (
            name: 'Tween<double>',
            detail:
                'Linear interpolation between two double values, for '
                'example an angle in radians.',
          ),
          (
            name: 'RotationTransition',
            detail:
                'Animated widget that visually rotates its child based on an '
                'Animation<double>.',
          ),
          (
            name: 'SingleTickerProviderStateMixin',
            detail:
                'Provides the vsync the controller needs to tick in sync '
                'with the display.',
          ),
        ],
        whenToUse: [
          'Repeating spinners and loaders.',
          'Rotating dials, knobs or turntables bound to a value.',
          'Any transform that needs precise control, looping or reverse that '
              'implicit widgets cannot express.',
        ],
      ),
    );
  }
}
