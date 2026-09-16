import 'package:flutter/material.dart';

import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 01 — AnimatedContainer.
///
/// Implicit animation: Flutter automatically animates supported visual
/// properties (color, size, shape, padding, ...) when the widget's
/// configuration changes.
///
/// The interactive demo is implemented in a later phase.
class AnimatedContainerDemoScreen extends StatelessWidget {
  /// Creates the AnimatedContainer demo screen.
  const AnimatedContainerDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'AnimatedContainer',
      category: 'Implicit Animation',
      child: DemoPlaceholder(
        description:
            'Automatically animate supported visual properties when state '
            'changes.',
      ),
    );
  }
}
