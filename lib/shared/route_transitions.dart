import 'package:flutter/material.dart';

/// Builds a route that slides the page in from the right while fading it in.
///
/// Used for the custom-route demo. Pushing launches the transition and
/// popping plays it in reverse, so the effect can be replayed by navigating
/// back and launching again.
Route<T> buildSlideFadeRoute<T>({required Widget page}) {
  return PageRouteBuilder<T>(
    transitionDuration: const Duration(milliseconds: 600),
    reverseTransitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) => page,
    transitionsBuilder:
        (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,
        ) {
          // Slide the page in from the right edge with a smooth ease-out.
          final Animation<Offset> slide = Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(animation);
          return FadeTransition(
            // Keyed for the widget tests that verify both effects are active.
            key: const ValueKey<String>('custom-route-fade'),
            opacity: animation,
            child: SlideTransition(
              key: const ValueKey<String>('custom-route-slide'),
              position: slide,
              child: child,
            ),
          );
        },
  );
}
