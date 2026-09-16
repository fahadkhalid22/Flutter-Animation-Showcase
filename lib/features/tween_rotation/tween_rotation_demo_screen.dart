import 'package:flutter/material.dart';

import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 03 — Tween Rotation.
///
/// Explicit animation: an `AnimationController` is combined with a
/// `Tween<double>` and driven with `RotationTransition` for precise
/// control over the rotation.
///
/// The interactive demo is implemented in a later phase.
class TweenRotationDemoScreen extends StatelessWidget {
  /// Creates the Tween rotation demo screen.
  const TweenRotationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'Tween Rotation',
      category: 'Explicit Animation',
      child: DemoPlaceholder(
        description:
            'Control rotation precisely with AnimationController and Tween.',
      ),
    );
  }
}
