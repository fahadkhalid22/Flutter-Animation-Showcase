import 'package:flutter/material.dart';

import '../../core/constants/app_strings.dart';
import '../../shared/demo_lesson_view.dart';
import '../../shared/demo_screen_shell.dart';
import 'tween_rotation_demo.dart';

/// Demo 03 — Tween Rotation.
///
/// Explicit animation: an `AnimationController` plus a `Tween<double>`
/// drive a `Transform.rotate` for precise, controllable rotation (the Tween
/// is in radians, so `Transform.rotate(angle:)` pairs with it directly).
class TweenRotationDemoScreen extends StatelessWidget {
  /// Creates the Tween rotation demo screen.
  const TweenRotationDemoScreen({super.key});

  /// Compact conceptual code for the rotation pipeline.
  static const String _codeExample = '''
// 1. Controller owns the timeline.
late final AnimationController _controller = AnimationController(
  vsync: this, // keeps ticks in sync with the screen
  duration: const Duration(milliseconds: 2000),
);

// 2. Tween maps 0→1 progress onto 0→2π radians.
late final Animation<double> _rotation = Tween<double>(
  begin: 0,
  end: 2 * math.pi, // a full revolution
).animate(
  CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
);

// 3. Rebuild the target each frame.
AnimatedBuilder(
  animation: _rotation,
  builder: (context, child) =>
      Transform.rotate(angle: _rotation.value, child: child),
  child: dial,
);

// 4. Full playback control.
_controller.repeat();   // loop forever
_controller.forward();  // play once
_controller.reverse();  // rewind
_controller.stop();     // pause
_controller.reset();    // jump back to 0
''';

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
        demonstrates: 'Explicit Animation',
        codeExample: _codeExample,
        howItWorks: [
          'Create an AnimationController with vsync (from '
              'SingleTickerProviderStateMixin) — it owns the timeline and '
              'advances a value from 0.0 to 1.0 over the given Duration.',
          'Build a Tween<double> that maps that 0→1 progress onto your '
              'desired range — here 0 to 2π radians for a full revolution.',
          'Wrap the Tween in a CurvedAnimation to apply easing (for example '
              'Curves.easeInOutCubic) so the motion feels natural.',
          'An AnimatedBuilder listens to the animation and calls '
              'Transform.rotate(angle:) each frame, redrawing only the '
              'rotated subtree — not the entire widget tree.',
          'Call controller.repeat() to loop, .forward() for a single pass, '
              '.reverse() to rewind, and .stop() to pause mid-flight. The '
              'controller fires listener callbacks every frame so the UI '
              'stays in sync.',
        ],
        keyClasses: [
          (
            name: 'AnimationController',
            detail:
                'A tick-driven class that owns a double value (default '
                '0.0→1.0) and advances it over a Duration. It provides '
                'forward(), reverse(), repeat(), stop(), and reset() for '
                'full playback control.',
          ),
          (
            name: 'Tween<T>',
            detail:
                'Defines the begin→end range and knows how to lerp '
                '(interpolate) between them. A Tween<double>(begin: 0, '
                'end: 2π) maps controller progress onto radians.',
          ),
          (
            name: 'Animation<double>',
            detail:
                'The output of Tween.animate() — a read-only value that '
                'changes every frame. Widgets like AnimatedBuilder listen '
                'to it and rebuild accordingly.',
          ),
          (
            name: 'CurvedAnimation',
            detail:
                'Wraps a parent Animation and applies a Curve (e.g. '
                'easeInOutCubic) so the interpolation is non-linear — '
                'slow at the edges, fast in the middle.',
          ),
          (
            name: 'AnimatedBuilder',
            detail:
                'A rebuild-scope widget: it listens to an Animation and '
                'calls its builder whenever the value changes, but only '
                'rebuilds the subtree inside it — not the whole screen.',
          ),
          (
            name: 'Transform.rotate',
            detail:
                'Applies a rotation transform to its child. We pass the '
                'animation value as the angle in radians. Unlike '
                'RotationTransition (which expects revolutions), this '
                'accepts raw radians directly.',
          ),
          (
            name: 'SingleTickerProviderStateMixin',
            detail:
                'Provides the vsync Ticker that the AnimationController '
                'needs to tick in sync with the display refresh rate. '
                'Essential — without vsync the controller cannot animate.',
          ),
        ],
        comparison: [
          (
            aspect: 'Driver',
            implicit: 'setState() rebuilds',
            explicit: 'Controller ticks',
          ),
          (
            aspect: 'Control',
            implicit: 'Change values',
            explicit: 'forward / stop / reverse',
          ),
          (aspect: 'Looping', implicit: 'No replay', explicit: 'repeat()'),
          (
            aspect: 'Curve',
            implicit: 'curve parameter',
            explicit: 'CurvedAnimation',
          ),
          (
            aspect: 'Use for',
            implicit: 'Simple tweens',
            explicit: 'Precise, choreographed',
          ),
        ],
        whenToUse: [
          'Any animation that must play, pause, reverse, or loop on demand '
              '— implicit widgets cannot express this level of control.',
          'Complex interpolation: spring physics, elastic easing, or custom '
              'Curves applied to arbitrary value ranges.',
          'Chaining or staggering multiple animations with precise timing '
              '(for example, sequence-based choreography).',
          'Scroll-driven or gesture-driven animations where the controller '
              'value is linked to user input rather than a fixed Duration.',
        ],
      ),
    );
  }
}
