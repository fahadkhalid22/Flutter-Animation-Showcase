import 'package:flutter/material.dart';

import '../../shared/demo_placeholder.dart';
import '../../shared/demo_screen_shell.dart';

/// Demo 04 — Staggered Sequence.
///
/// Sequenced animation: four elements are animated with different start
/// intervals on one shared timeline, producing a cascading effect.
///
/// The interactive demo is implemented in a later phase.
class StaggeredAnimationDemoScreen extends StatelessWidget {
  /// Creates the staggered sequence demo screen.
  const StaggeredAnimationDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DemoScreenShell(
      title: 'Staggered Sequence',
      category: 'Sequenced Animation',
      child: DemoPlaceholder(
        description:
            'Animate four elements with different intervals on one timeline.',
      ),
    );
  }
}
