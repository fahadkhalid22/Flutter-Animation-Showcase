import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'custom_route_demo.dart';

/// Demo 05 — Custom Slide + Fade Route.
///
/// Custom navigation: a personalised route transition built with
/// `PageRouteBuilder` and driven with `SlideTransition` and
/// `FadeTransition`.
class CustomRouteDemoScreen extends StatelessWidget {
  /// Creates the custom route demo screen.
  const CustomRouteDemoScreen({super.key});

  /// Compact conceptual code for the custom route transition.
  static const String _codeExample = '''
Route<T> buildSlideFadeRoute<T>({required Widget page}) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (_, animation, secondaryAnimation) => page,
    transitionsBuilder: (_, animation, __, child) {
      final slide = Tween<Offset>(
        begin: const Offset(1, 0), // start off-screen right
        end: Offset.zero,          // slide to rest
      ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);

      return FadeTransition(
        opacity: animation,                 // fade 0 -> 1 as route advances
        child: SlideTransition(
          position: slide,                  // slide with the eased offset
          child: child,
        ),
      );
    },
  );
}
''';

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
        demo: CustomRouteDemo(),
        demonstrates: 'Custom Navigation',
        codeExample: _codeExample,
        howItWorks: [
          'Navigator.push asks the custom builder for a route; a '
              'PageRouteBuilder is returned.',
          'pageBuilder supplies the destination page; transitionsBuilder '
              'receives the route animation (0→1) and wraps the page.',
          'A Tween<Offset>(begin: Offset(1, 0), end: Offset.zero), chained '
              'with CurveTween(curves.easeOutCubic), drives the slide from '
              'the right.',
          'A FadeTransition uses the raw animation so opacity rises in sync '
              'with the slide.',
          'Popping the route plays everything in reverse — the page slides '
              'out to the right and fades away.',
        ],
        flow: [
          'Navigator.push',
          'PageRouteBuilder',
          'Route animation progress',
          'Tween<Offset>',
          'SlideTransition + FadeTransition',
        ],
        keyClasses: [
          (
            name: 'PageRouteBuilder',
            detail:
                'Lets you supply pageBuilder and transitionsBuilder to '
                'compose a fully custom route, including its animation.',
          ),
          (
            name: 'pageBuilder',
            detail:
                'Builds the destination page itself; called when the route '
                'is first displayed.',
          ),
          (
            name: 'transitionsBuilder',
            detail:
                'Wraps the page each frame with the route interactions '
                '(animation and secondaryAnimation) so you can apply any '
                'transition you like.',
          ),
          (
            name: 'Animation<double>',
            detail:
                'The route-progress value (0→1) passed to '
                'transitionsBuilder; both the slide and the fade read it.',
          ),
          (
            name: 'Tween<Offset>',
            detail:
                'Maps route progress onto an Offset — here from the right '
                'edge (Offset(1, 0)) to rest (Offset.zero).',
          ),
          (
            name: 'CurveTween',
            detail:
                'Applies an easing curve (Curves.easeOutCubic) so the slide '
                'decelerates into place rather than moving linearly.',
          ),
          (
            name: 'SlideTransition',
            detail:
                'Positions its child by an animated Offset — this is what '
                'slides the page in from the side.',
          ),
          (
            name: 'FadeTransition',
            detail:
                'Animates its child opacity with an Animation<double> — this '
                'is what fades the page in as it arrives.',
          ),
        ],
        whenToUse: [
          'Branded navigation that matches the app personality instead of the '
              'default Material transition.',
          'Screens that should enter from a side — settings panels, drawers '
              'or detail pages.',
          'Onboarding, carousels or wizards where movement direction carries '
              'meaning for the user.',
        ],
      ),
    );
  }
}
