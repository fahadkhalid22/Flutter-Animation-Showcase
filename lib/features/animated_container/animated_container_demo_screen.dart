import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 01 — AnimatedContainer.
///
/// Implicit animation: Flutter automatically animates supported visual
/// properties such as colour, size, shape and padding when the widget's
/// configuration changes with state.
class AnimatedContainerDemoScreen extends StatelessWidget {
  /// Creates the AnimatedContainer demo screen.
  const AnimatedContainerDemoScreen({super.key});

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
        demo: DemoPlaceholder(),
        howItWorks: [
          'Swap state values: call setState() with a new width, height, '
              'colour, borderRadius or padding on an AnimatedContainer.',
          'Flutter compares the old and new values and animates each '
              'animatable property between them.',
          'Set duration and curve to control speed and easing; easeInOut is '
              'the default over 200 ms.',
          'When the values return to their previous state, the animation '
              'runs in reverse automatically.',
        ],
        keyClasses: [
          (
            name: 'AnimatedContainer',
            detail:
                'A Container that animates changes to decoration, size, '
                'padding and border whenever it is rebuilt.',
          ),
          (
            name: 'ImplicitlyAnimatedWidget',
            detail:
                'Base class that owns a single AnimationController and '
                'drives every implicit animation widget.',
          ),
          (
            name: 'CurvedAnimation',
            detail:
                'Wraps the tween with an easing curve such as '
                'Curves.easeInOut.',
          ),
        ],
        whenToUse: [
          'Toggling styles, such as selected versus unselected button colours '
              'and sizes.',
          'Expandable cards, filters or settings that change size and '
              'spacing.',
          'Quick colour and size feedback for hover or focus on desktop.',
        ],
      ),
    );
  }
}
