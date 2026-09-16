import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 05 — Custom Slide + Fade Route.
///
/// Custom navigation: a personalised route transition built with
/// `PageRouteBuilder` and driven with `SlideTransition` and
/// `FadeTransition`.
class CustomRouteDemoScreen extends StatelessWidget {
  /// Creates the custom route demo screen.
  const CustomRouteDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: AppStrings.customRouteTitle,
      category: AppStrings.customRouteCategory,
      child: DemoLessonView(
        intro:
            'PageRouteBuilder lets you design your own route transition. '
            'Combined with SlideTransition and FadeTransition, you get a '
            'polished slide-in that fades in at the same time.',
        demo: DemoPlaceholder(),
        howItWorks: [
          'Return a PageRouteBuilder whenever the route is requested; give it '
              'buildPage and transitionsBuilder.',
          'transitionsBuilder receives the route animation (0→1) and the '
              'secondary animation.',
          'Build a SlideTransition whose Offset begins at Offset(1, 0) and '
              'ends at Offset.zero to slide in from the side.',
          'Wrap it in a FadeTransition so opacity rises with the slide; '
              'popping plays the whole transition in reverse.',
        ],
        keyClasses: [
          (
            name: 'PageRouteBuilder',
            detail:
                'Lets you supply buildPage and transitionsBuilder to compose '
                'a fully custom route.',
          ),
          (
            name: 'SlideTransition',
            detail: 'Moves its child by an animated Offset.',
          ),
          (
            name: 'FadeTransition',
            detail: 'Animates the child opacity with an Animation<double>.',
          ),
          (
            name: 'CurvedAnimation',
            detail:
                'Eases the slide and fade so the motion feels designed rather '
                'than linear.',
          ),
        ],
        whenToUse: [
          'Branded navigation that matches the app personality.',
          'Screens that should enter from a side, such as option panels.',
          'Onboarding or carousels where movement direction carries meaning.',
        ],
      ),
    );
  }
}
