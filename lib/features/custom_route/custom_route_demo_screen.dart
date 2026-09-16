import 'package:flutter/material.dart';

import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 05 — Custom Slide + Fade Route.
///
/// Custom navigation: a personalised route transition built with
/// `PageRouteBuilder` and the `SlideTransition` / `FadeTransition` widgets.
///
/// The interactive demo is implemented in a later phase.
class CustomRouteDemoScreen extends StatelessWidget {
  /// Creates the custom route demo screen.
  const CustomRouteDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'Slide + Fade Route',
      category: 'Custom Navigation',
      child: DemoPlaceholder(
        description: 'Create a custom route transition using PageRouteBuilder.',
      ),
    );
  }
}
