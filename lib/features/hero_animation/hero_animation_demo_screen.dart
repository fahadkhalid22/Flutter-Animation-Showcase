import 'package:flutter/material.dart';

import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 02 — Hero Animation.
///
/// Shared element animation: a widget is animated seamlessly between two
/// routes using a [`Hero`](https://api.flutter.dev/flutter/widgets/Hero-class.html)
/// tag identified on both screens.
///
/// The interactive demo is implemented in a later phase.
class HeroAnimationDemoScreen extends StatelessWidget {
  /// Creates the Hero animation demo screen.
  const HeroAnimationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'Hero Animation',
      category: 'Shared Element',
      child: DemoPlaceholder(
        description: 'Animate a widget seamlessly between two routes.',
      ),
    );
  }
}
